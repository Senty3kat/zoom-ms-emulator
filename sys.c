/* Zoom MS pedal system model (C6745 / OMAP-L137 DSP side). Peripheral
   behaviour is added only as far as the firmware needs it; every MMIO
   access is counted so unmodelled polling shows up in the report. */
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "sys.h"
#include "ais.h"

#define R(off) s->mmio[((off) - MMIO_BASE) >> 2]

static mmio_stat *stat_for(c6x_sys *s, uint32_t addr)
{
    uint32_t h = (addr >> 2) * 2654435761u >> 20;  /* 12 bits */
    for (int i = 0; i < 4096; i++) {
        mmio_stat *m = &s->stats[(h + i) & 4095];
        if (m->addr == addr) return m;
        if (m->addr == 0) { m->addr = addr; s->nstats++; return m; }
    }
    return &s->stats[0];
}

double sys_wall(c6x_sys *s);   /* forward: event log needs emulated wall time */

/* ---------------- interrupt controller ---------------- */
static int intsel(c6x_sys *s, int n) { return (s->intmux[(n - 4) / 4] >> (8 * ((n - 4) % 4))) & 0x7F; }

static void intc_update(c6x_sys *s)
{
    for (int n = 4; n <= 15; n++) {
        int e = intsel(s, n);
        int on;
        if (e < 4) on = (s->evtflag[e] & ~s->evtmask[e]) != 0;
        else on = 0;  /* direct events are edge-delivered in sys_event */
        if (on) cpu_raise_irq(&s->cpu, n);
    }
}

static void sys_event(c6x_sys *s, int e)
{
    if (s->evf)
        fprintf(s->evf, "%10llu %9.3f ms ev=%d pc=%08X\n",
                (unsigned long long)cpu_now(&s->cpu), sys_wall(s) * 1000.0, e,
                s->cpu.cr[CR_PCE1]);
    s->evtflag[e >> 5] |= 1u << (e & 31);
    for (int n = 4; n <= 15; n++)
        if (intsel(s, n) == e) cpu_raise_irq(&s->cpu, n);
    intc_update(s);
}

void sys_raise_event(c6x_sys *s, int e) { sys_event(s, e); }

/* ---------------- EDMA3 ---------------- */
#define EDMA_CC 0x01C00000u
#define PARAM(n) (EDMA_CC + 0x4000u + 32u * (n))

static void edma_irq_eval(c6x_sys *s)
{
    if (s->edma.ipr & s->edma.ier) sys_event(s, 8);   /* EDMA3_CC0_INT1 (DSP region) */
}

static void edma_copy(c6x_sys *s, uint32_t dst, uint32_t src, uint32_t n)
{
    cache_dma_write(&s->cache, dst, n);
    if (!((dst | src | n) & 3)) {
        for (uint32_t i = 0; i < n; i += 4) mem_wr(&s->mem, dst + i, 4, mem_rd(&s->mem, src + i, 4));
    } else {
        for (uint32_t i = 0; i < n; i++) mem_wr(&s->mem, dst + i, 1, mem_rd(&s->mem, src + i, 1));
    }
}

static void edma_trigger(c6x_sys *s, int ch);

/* service one synchronization event on PaRAM set `ch` */
static void edma_transfer(c6x_sys *s, int ch)
{
    uint32_t p = PARAM(ch);
    uint32_t opt = R(p), src = R(p + 4), abcnt = R(p + 8), dst = R(p + 12);
    uint32_t bidx = R(p + 16), lnk = R(p + 20), cidx = R(p + 24), ccnt = R(p + 28) & 0xFFFF;
    uint32_t acnt = abcnt & 0xFFFF, bcnt = abcnt >> 16;
    int16_t sbidx = (int16_t)bidx, dbidx = (int16_t)(bidx >> 16);
    int16_t scidx = (int16_t)cidx, dcidx = (int16_t)(cidx >> 16);
    int final;
    if (s->dmalf)
        fprintf(s->dmalf, "%10llu ch=%u opt=%08X src=%08X dst=%08X acnt=%u bcnt=%u ccnt=%u\n",
                (unsigned long long)cpu_now(&s->cpu), ch, opt, src, dst, acnt, bcnt, ccnt);
    s->edma.events++;
    if (!acnt || !bcnt || !ccnt) {           /* null / exhausted set */
        s->edma.errors++;
        s->edma.emr |= 1u << ch;
        return;
    }
    if (opt & 4) {                           /* AB-synchronized: one frame per event */
        for (uint32_t b = 0; b < bcnt; b++)
            edma_copy(s, dst + (uint32_t)(dbidx * (int)b), src + (uint32_t)(sbidx * (int)b), acnt);
        src += (uint32_t)scidx; dst += (uint32_t)dcidx;
        ccnt--;
        final = ccnt == 0;
    } else {                                 /* A-synchronized: one array per event */
        edma_copy(s, dst, src, acnt);
        if (bcnt > 1) { src += (uint32_t)sbidx; dst += (uint32_t)dbidx; bcnt--; final = 0; }
        else {
            src += (uint32_t)scidx; dst += (uint32_t)dcidx;
            bcnt = lnk >> 16; ccnt--;
            final = ccnt == 0;
        }
    }
    s->edma.transfers++;
    uint32_t tcc = (opt >> 12) & 0x3F;
    if (final) {
        uint16_t link = (uint16_t)lnk;
        if (link != 0xFFFF) {
            uint32_t from = EDMA_CC + link;
            for (int i = 0; i < 8; i++) R(p + 4 * i) = R(from + 4 * i);
        } else {
            for (int i = 0; i < 8; i++) R(p + 4 * i) = 0;
            R(p + 20) = 0xFFFF;
        }
        if (opt & (1u << 20)) { s->edma.ipr |= 1u << tcc; edma_irq_eval(s); }
        if (opt & (1u << 22)) edma_trigger(s, (int)tcc);
    } else {
        if (!(opt & 8)) {                    /* STATIC=0: write back updated counters */
            R(p + 4) = src; R(p + 12) = dst;
            R(p + 8) = (bcnt << 16) | acnt;
            R(p + 28) = ccnt;
        }
        if (opt & (1u << 21)) { s->edma.ipr |= 1u << tcc; edma_irq_eval(s); }
        if (opt & (1u << 23)) edma_trigger(s, (int)tcc);
    }
}

static void edma_trigger(c6x_sys *s, int ch)
{
    if (ch < 0 || ch > 31) return;
    edma_transfer(s, ch);
}

/* peripheral synchronization event on DMA channel ch */
static void edma_event(c6x_sys *s, int ch)
{
    if (s->edma.eer & (1u << ch)) edma_transfer(s, ch);
    else s->edma.er |= 1u << ch;
}

static uint32_t edma_reg_read(c6x_sys *s, uint32_t off)
{
    switch (off) {
    case 0x00: return s->edma.er;
    case 0x20: return s->edma.eer;
    case 0x38: return s->edma.ser;
    case 0x50: return s->edma.ier;
    case 0x68: return s->edma.ipr;
    default: return 0;
    }
}

static void edma_reg_write(c6x_sys *s, uint32_t off, uint32_t v)
{
    switch (off) {
    case 0x08: s->edma.er &= ~v; break;                 /* ECR */
    case 0x10: for (int b = 0; b < 32; b++) if (v & (1u << b)) edma_trigger(s, b); break; /* ESR */
    case 0x18: for (int b = 0; b < 32; b++) if (v & (1u << b)) edma_trigger(s, b); break; /* CER (chain) */
    case 0x28: s->edma.eer &= ~v; break;                /* EECR */
    case 0x30: s->edma.eer |= v; break;                 /* EESR */
    case 0x40: s->edma.ser &= ~v; break;                /* SECR */
    case 0x58: s->edma.ier &= ~v; break;                /* IECR */
    case 0x60: s->edma.ier |= v; edma_irq_eval(s); break; /* IESR */
    case 0x70: s->edma.ipr &= ~v; break;                /* ICR */
    case 0x78: edma_irq_eval(s); break;                 /* IEVAL */
    }
}

/* ---------------- McASP0 ---------------- */
#define ASP 0x01D00000u

static void asp_update_rate(c6x_sys *s)
{
    /* I2S, 2 slots per frame, 44.1 kHz from the 11.2896 MHz crystal */
    s->asp.cyc_per_slot = (double)s->cpu_hz / (44100.0 * 2);
}

static int16_t asp_input_sample(c6x_sys *s, int ch)
{
    if (s->asp.in && s->asp.nin) {
        int16_t v = s->asp.in[s->asp.inpos % s->asp.nin];
        s->asp.inpos++;
        return v;
    }
    if (s->asp.gen_amp > 0 && ch == 0) {
        double t = (double)s->asp.gen_n++ / 44100.0;
        double x = s->asp.gen_amp * sin(2 * 3.14159265358979 * s->asp.gen_freq * t);
        return (int16_t)(x * 32767);
    }
    return 0;
}

static void asp_slot(c6x_sys *s)
{
    int ch = s->asp.slot & 1;
    s->asp.slot++;
    if (s->asp.xrun) {
        if (!s->asp.xdata) {
            int16_t v = (int16_t)(s->asp.xbuf >> 16);   /* 32-bit slot, MSB-aligned 24-bit data */
            if (s->asp.nout < s->asp.capout) s->asp.out[s->asp.nout++] = v;
        } else {
            s->asp.underruns++;
            R(ASP + 0xC0) |= 1;                          /* XUNDRN */
            if (s->asp.nout < s->asp.capout) s->asp.out[s->asp.nout++] = 0;
        }
        s->asp.xdata = 1;
        edma_event(s, 1);                                /* AXEVT */
    }
    if (s->asp.rrun) {
        if (s->asp.rdata) { s->asp.overruns++; R(ASP + 0x80) |= 1; }
        /* Every RX serializer delivers its own word. AXR5 is the main input (-sine, the
           input file); any other RX serializer (AXR4, the 70CDR's second ADC) gets -sine2. */
        int16_t main_in = asp_input_sample(s, ch);
        s->asp.rq_n = 0;
        for (int k = 0; k < 16; k++) {
            if ((R(ASP + 0x180 + 4 * k) & 3) != 2) continue;          /* SRCTLn: 2 = receive */
            int16_t v = main_in;
            if (k != 5) {
                v = 0;
                if (s->asp.gen2_amp > 0 && ch == 0) {
                    double t = (double)s->asp.gen2_n++ / 44100.0;
                    v = (int16_t)(32767 * s->asp.gen2_amp * sin(2 * 3.14159265358979 * s->asp.gen2_freq * t));
                }
            }
            s->asp.rq_ser[s->asp.rq_n] = k;
            s->asp.rq[s->asp.rq_n++] = (uint32_t)(int32_t)v << 16;
        }
        if (!s->asp.rq_n) { s->asp.rq_ser[0] = 5; s->asp.rq[0] = (uint32_t)(int32_t)main_in << 16; s->asp.rq_n = 1; }
        s->asp.rq_pos = 0;
        s->asp.rbuf = s->asp.rq[0];
        s->asp.rdata = 1;
        edma_event(s, 0);                                /* AREVT */
    }
}

static void asp_gblctl(c6x_sys *s, uint32_t oldx)
{
    uint32_t x = R(ASP + 0xA0), r = R(ASP + 0x60);
    if ((x & (1u << 10)) && !(oldx & (1u << 10))) {   /* XSRCLR: XBUF empty, request data */
        s->asp.xdata = 1;
        edma_event(s, 1);
    }
    int xr = (x & (1u << 12)) && (x & (1u << 11));
    int rr = (r & (1u << 4)) && (r & (1u << 3));
    if ((xr || rr) && !s->asp.xrun && !s->asp.rrun) {
        asp_update_rate(s);
        s->asp.next_slot = cpu_now(&s->cpu) + (uint64_t)s->asp.cyc_per_slot;
        s->asp.frac = 0;
    }
    s->asp.xrun = xr;
    s->asp.rrun = rr;
}

static void asp_sync(c6x_sys *s)
{
    static int busy;
    if (busy || (!s->asp.xrun && !s->asp.rrun)) return;
    busy = 1;
    while (cpu_now(&s->cpu) >= s->asp.next_slot) {
        s->asp.frac += s->asp.cyc_per_slot;
        uint64_t whole = (uint64_t)s->asp.frac;
        s->asp.frac -= (double)whole;
        s->asp.next_slot += whole;
        asp_slot(s);
    }
    busy = 0;
}

/* ---------------- timers ---------------- */
static uint32_t tmr_base(int i) { return i ? 0x01C21000u : 0x01C20000u; }

static void tmr_sync(c6x_sys *s, int i)
{
    uint64_t now = cpu_now(&s->cpu);
    uint64_t dt = now - s->tmr[i].last_update;
    uint64_t ticks = dt * s->timer_hz / s->cpu_hz;
    if (!ticks) return;
    s->tmr[i].last_update += ticks * s->cpu_hz / s->timer_hz;
    uint32_t tgcr = s->tmr[i].tgcr, tcr = s->tmr[i].tcr;
    int mode = (tgcr >> 2) & 3;
    int en12 = (tcr >> 6) & 3, en34 = (tcr >> 22) & 3;
    if (mode == 0 || mode == 3) { /* 64-bit (or chained) */
        if (en12 && (tgcr & 1)) {
            uint64_t cnt = ((uint64_t)s->tmr[i].tim34 << 32) | s->tmr[i].tim12;
            uint64_t prd = ((uint64_t)s->tmr[i].prd34 << 32) | s->tmr[i].prd12;
            cnt += ticks;
            if (prd && cnt >= prd) {
                cnt = (en12 == 1) ? prd : cnt % (prd + 1);
                sys_event(s, i ? 40 : 4);
                if (en12 == 1) s->tmr[i].tcr &= ~(3u << 6);
            }
            s->tmr[i].tim12 = (uint32_t)cnt; s->tmr[i].tim34 = (uint32_t)(cnt >> 32);
        }
    } else { /* dual 32-bit unchained */
        if (en12 && (tgcr & 1)) {
            uint64_t cnt = (uint64_t)s->tmr[i].tim12 + ticks;
            uint32_t prd = s->tmr[i].prd12;
            if (prd && cnt >= prd) {
                cnt = (en12 == 1) ? prd : cnt % ((uint64_t)prd + 1);
                sys_event(s, i ? 40 : 4);
                if (en12 == 1) s->tmr[i].tcr &= ~(3u << 6);
            }
            s->tmr[i].tim12 = (uint32_t)cnt;
        }
        if (en34 && (tgcr & 2)) {
            uint32_t psc = ((tgcr >> 8) & 15) + 1;
            uint64_t cnt = (uint64_t)s->tmr[i].tim34 + ticks / psc;
            uint32_t prd = s->tmr[i].prd34;
            if (prd && cnt >= prd) {
                cnt = (en34 == 1) ? prd : cnt % ((uint64_t)prd + 1);
                sys_event(s, i ? 48 : 64);
                if (en34 == 1) s->tmr[i].tcr &= ~(3u << 22);
            }
            s->tmr[i].tim34 = (uint32_t)cnt;
        }
    }
}

static uint64_t tmr_next_event(c6x_sys *s, int i)
{
    uint32_t tgcr = s->tmr[i].tgcr, tcr = s->tmr[i].tcr;
    int mode = (tgcr >> 2) & 3;
    uint64_t best = ~0ULL;
    uint64_t per = s->cpu_hz / s->timer_hz + 1;
    if (((tcr >> 6) & 3) && (tgcr & 1)) {
        uint64_t left;
        if (mode == 0 || mode == 3) {
            uint64_t cnt = ((uint64_t)s->tmr[i].tim34 << 32) | s->tmr[i].tim12;
            uint64_t prd = ((uint64_t)s->tmr[i].prd34 << 32) | s->tmr[i].prd12;
            left = prd > cnt ? prd - cnt : 1;
        } else {
            left = s->tmr[i].prd12 > s->tmr[i].tim12 ? s->tmr[i].prd12 - s->tmr[i].tim12 : 1;
        }
        uint64_t c = s->tmr[i].last_update + left * per;
        if (c < best) best = c;
    }
    if (mode == 1 && ((tcr >> 22) & 3) && (tgcr & 2)) {
        uint32_t psc = ((tgcr >> 8) & 15) + 1;
        uint64_t left = s->tmr[i].prd34 > s->tmr[i].tim34 ? s->tmr[i].prd34 - s->tmr[i].tim34 : 1;
        uint64_t c = s->tmr[i].last_update + left * per * psc;
        if (c < best) best = c;
    }
    return best;
}

static void sys_schedule(c6x_sys *s)
{
    uint64_t n = cpu_now(&s->cpu) + 100000;
    for (int i = 0; i < 2; i++) { uint64_t t = tmr_next_event(s, i); if (t < n) n = t; }
    if ((s->asp.xrun || s->asp.rrun) && s->asp.next_slot < n) n = s->asp.next_slot;
    if (s->ninq && s->inq[0].at < n) n = s->inq[0].at;
    if (s->usb.enabled && usb_next_event(s) < n) n = usb_next_event(s);
    if (s->hwclose && s->hw_residual && s->hw_rom_repaint_ms > 0 && s->hw_next_repaint < n)
        n = s->hw_next_repaint;
    if (n <= cpu_now(&s->cpu)) n = cpu_now(&s->cpu) + 1;
    s->next_event = n;
}

static uint32_t tmr_read(c6x_sys *s, int i, uint32_t off)
{
    tmr_sync(s, i);
    switch (off) {
    case 0x10: return s->tmr[i].tim12;
    case 0x14: return s->tmr[i].tim34;
    case 0x18: return s->tmr[i].prd12;
    case 0x1C: return s->tmr[i].prd34;
    case 0x20: return s->tmr[i].tcr;
    case 0x24: return s->tmr[i].tgcr;
    default: return R(tmr_base(i) + off);
    }
}

static void tmr_write(c6x_sys *s, int i, uint32_t off, uint32_t v)
{
    tmr_sync(s, i);
    switch (off) {
    case 0x10: s->tmr[i].tim12 = v; break;
    case 0x14: s->tmr[i].tim34 = v; break;
    case 0x18: s->tmr[i].prd12 = v; break;
    case 0x1C: s->tmr[i].prd34 = v; break;
    case 0x20: s->tmr[i].tcr = v; s->tmr[i].last_update = cpu_now(&s->cpu); break;
    case 0x24: s->tmr[i].tgcr = v; s->tmr[i].last_update = cpu_now(&s->cpu); break;
    default: R(tmr_base(i) + off) = v; break;
    }
    sys_schedule(s);
}

/* ---------------- LCD (ST7565) ---------------- */
static void lcd_byte(c6x_sys *s, uint8_t b, int data)
{
    if (s->spi_nlast < 64) s->spi_last[s->spi_nlast++] = b;
    if (data) {
        uint32_t col = (s->lcd_col_hi << 4) | s->lcd_col_lo;
        if (col < 132) s->lcd_vram[s->lcd_page & 7][col] = b;
        if (s->lcd_frame_data < 128) {
            if (!s->lcd_frame_data) memset(s->boot_cp_row, b, sizeof s->boot_cp_row);
            else if (s->boot_cp_row[s->lcd_frame_data] != b) s->boot_cp_row[s->lcd_frame_data] = 0;
        }
        col++;
        s->lcd_col_hi = (col >> 4) & 15; s->lcd_col_lo = col & 15;
        s->lcd_data++;
        s->lcd_frame_data++;
        return;
    }
    s->lcd_cmds++;
    if (s->lcd_contrast_pending) { s->lcd_contrast = b & 63; s->lcd_contrast_pending = 0; return; }
    if (s->lcdf && (b & 0xF8) == 0xB0)
        fprintf(s->lcdf, "%9.3f ms page %u pc=%08X B3=%08X prev=%u\n", sys_wall(s) * 1000.0, b & 7, s->cpu.cr[CR_PCE1], s->cpu.r[1][3], s->lcd_frame_data);
    if ((b & 0xF8) == 0xB0) {
        uint8_t v = s->boot_cp_row[0];
        int uniform = s->lcd_frame_data >= 128 && v != 0;
        for (int i = 1; i < 128; i++) if (s->boot_cp_row[i] != v) uniform = 0;
        s->boot_cp_pages = uniform ? s->boot_cp_pages + 1 : 0;
        if (uniform && (b & 7) == 0) {
            int cp = v == 0xAA ? 9 : v == 0x55 ? 10 : s->boot_cp + 1;
            if (cp > 10) cp = 10;
            s->boot_cp = cp;
            s->boot_cp_pc = (int)s->cpu.cr[CR_PCE1];
            if (s->bootlogf) fprintf(s->bootlogf, "%9.3f ms bootmini checkpoint %d (row %02X pc=%08X)\n",
                                     sys_wall(s) * 1000.0, cp, v, s->boot_cp_pc);
        }
        s->lcd_frame_data = 0;
    }
    if ((b & 0xF0) == 0xB0) s->lcd_page = b & 15;
    else if ((b & 0xF0) == 0x10) s->lcd_col_hi = b & 15;
    else if ((b & 0xF0) == 0x00) s->lcd_col_lo = b & 15;
    else if (b == 0x81) s->lcd_contrast_pending = 1;
}

static int gpio_bit(c6x_sys *s, int pin) { return (s->gpio_out[pin >> 5] >> (pin & 31)) & 1; }

/* ---------------- serial NOR flash (MX25L3233F) ---------------- */
static uint8_t flash_byte(c6x_sys *s, uint8_t b)
{
    uint8_t out = 0xFF;
    int n = s->fl_n++;
    if (s->fl_status & 1 && cpu_now(&s->cpu) >= s->fl_busy_until)
        s->fl_status &= ~1;                        /* program / erase finished */
    if (n == 0 && (s->fl_status & 1) && b != 0x05) {
        s->fl_cmd = 0;                             /* busy: only RDSR is answered */
        return out;
    }
    if (n == 0) {
        s->fl_cmd = b;
        s->fl_addr = 0;
        s->fl_log_cmd = b;
        s->fl_log_have = 0;
        switch (b) {
        case 0x06:                                 /* WREN; optional write-protect fault */
            if (!(s->flash_fault & 1)) s->fl_status |= 2;
            else s->flash_fault_events++;
            break;
        case 0x04: s->fl_status &= ~2; break;      /* WRDI */
        case 0xC7: case 0x60:                      /* chip erase */
            if (s->fl_status & 2) {
                memset(s->flash, 0xFF, s->flash_size); s->fl_erases++; s->fl_status &= ~2;
                if (s->flashlogf)
                    fprintf(s->flashlogf, "%10llu fl_addr=------ fl_cmd=%02X fl_writes=%u erase=whole-chip\n",
                            (unsigned long long)cpu_now(&s->cpu), b, s->fl_writes);
            }
            break;
        }
        return out;
    }
    switch (s->fl_cmd) {
    case 0x05:                                    /* RDSR; WIP may be stuck by fault */
        if (s->flash_fault & 2) return s->fl_status | 1;
        return s->fl_status;
    case 0x9F: { static const uint8_t id[3] = { 0xC2, 0x20, 0x16 }; return id[(n - 1) % 3]; }
    case 0x90: case 0xAB: return (n >= 4) ? ((n & 1) ? 0x15 : 0xC2) : 0xFF;
    case 0x03: case 0x0B:                          /* READ / FAST READ */
        if (n <= 3) { s->fl_addr = (s->fl_addr << 8) | b; return out; }
        if (s->fl_cmd == 0x0B && n == 4) return out;
        out = s->flash[s->fl_addr % s->flash_size];
        if ((s->flash_fault & 8) && n >= 5) {        /* long read fails after address/dummy */
            out = 0xFF;
            s->flash_fault_events++;
        }
        s->fl_addr++;
        s->fl_reads++;
        return out;
    case 0x02:                                     /* page program */
        if (n <= 3) {
            s->fl_addr = (s->fl_addr << 8) | b;
            if (n == 3) s->fl_log_have = 1;
            return out;
        }
        if (s->fl_status & 2) {
            uint32_t a = (s->fl_addr & ~0xFFu) | ((s->fl_addr + (uint32_t)(n - 4)) & 0xFF);
            s->flash[a % s->flash_size] &= b;
            s->fl_writes++;
            if (s->flashlogf && (s->fl_log_have || (a & 0xFFFFu) == 0))
                fprintf(s->flashlogf, "%10llu fl_addr=%06X fl_cmd=%02X fl_writes=%u write=%08X\n",
                        (unsigned long long)cpu_now(&s->cpu), a, s->fl_log_cmd, s->fl_writes, b);
        }
        return out;
    case 0x20: case 0x52: case 0xD8:               /* sector / block erase */
        if (n <= 3) {
            s->fl_addr = (s->fl_addr << 8) | b;
            if (n == 3) s->fl_log_have = 1;
            if (n == 3 && (s->fl_status & 2)) {
                uint32_t sz = s->fl_cmd == 0x20 ? 0x1000 : s->fl_cmd == 0x52 ? 0x8000 : 0x10000;
                uint32_t a = (s->fl_addr & ~(sz - 1)) % s->flash_size;
                memset(s->flash + a, 0xFF, sz);
                s->fl_erases++;
                if (s->flashlogf)
                    fprintf(s->flashlogf, "%10llu fl_addr=%06X fl_cmd=%02X fl_writes=%u erase=%06X..%06X\n",
                            (unsigned long long)cpu_now(&s->cpu), a, s->fl_log_cmd, s->fl_writes,
                            a, a + sz - 1);
            }
        }
        return out;
    case 0x01: return out;                         /* WRSR */
    default: return out;
    }
}

static void flash_end(c6x_sys *s)
{
    if (s->fl_n && (s->fl_cmd == 0x02 || s->fl_cmd == 0x20 || s->fl_cmd == 0x52 || s->fl_cmd == 0xD8 ||
                    s->fl_cmd == 0xC7 || s->fl_cmd == 0x60 || s->fl_cmd == 0x01))
    {
        /* program / erase time, then WIP clears and WEL with it. Erase measured on an MS-60B
           (USB capture of Zoom's 2.10 updater: 0xB0000 in 64 KB blocks 9.53 s = 0.87 s each,
           3 sectors of 4 KB 0.88 s = 0.29 s each); 32 KB and chip erase scaled from those;
           page 0.6 ms and status write 10 ms are typical MX25L32xx values, not measured. */
        double ms = s->fl_cmd == 0x02 ? 0.6 : s->fl_cmd == 0x20 ? 290 : s->fl_cmd == 0x52 ? 580 :
                    s->fl_cmd == 0xD8 ? 870 : s->fl_cmd == 0x01 ? 10 : 55000;
        uint64_t t = s->fl_instant || !(s->fl_status & 2) ? 0 : (uint64_t)(ms * s->cpu_hz / 1000.0);
        s->fl_status &= ~2;                        /* without WEL the chip ignored it */
        if (t) {
            s->fl_status |= 1;
            s->fl_busy_until = cpu_now(&s->cpu) + t;
            s->fl_busy += t;
        }
    }
    s->fl_n = 0;
    s->fl_active = 0;
}

/* one SPI0 word written to SPIDAT0/1 */
static void spi0_xfer(c6x_sys *s, uint32_t dat1)
{
    uint8_t b = (uint8_t)dat1, rx = 0xFF;
    int lcd_sel = s->lcd_cs_pin >= 0 && gpio_bit(s, s->lcd_cs_pin) == 0;
    /* The flash CS pin is muxed: PINMUX7[31:28] = 1 is SPI0_SCS0 (flash on the bus), 8 is
       GPIO (the OS's LCD driver switches to 8 for every LCD byte and back to 1 for flash);
       0 is the reset value the bootloader reads flash with. */
    uint32_t cs_mux = R(0x01C1413C) >> 28;
    int flash_sel = cs_mux == 0 || cs_mux == 1;
    if (s->muxstrict && lcd_sel && cs_mux != 8) {
        s->mux_lcd_drop++;
        if (s->muxhalt && !s->cpu.halted) {
            s->cpu.halted = 1;
            snprintf(s->cpu.err, sizeof s->cpu.err,
                     "SPI0 LCD write with PINMUX7 CS mux=%u (expected 8 for GPIO/LCD)", cs_mux);
        }
    } else if (s->muxstrict && s->flash && flash_sel && cs_mux == 8) {
        s->mux_flash_drop++;
    } else if (lcd_sel) {
        int dc = s->lcd_dc_pin >= 0 ? gpio_bit(s, s->lcd_dc_pin) : 1;
        lcd_byte(s, b, dc);
    } else if (s->flash && flash_sel) {
        s->fl_active = 1;
        rx = flash_byte(s, b);
        if (!(dat1 & (1u << 28))) flash_end(s);   /* CSHOLD=0: CS released after this word */
    }
    s->spibuf = rx;
    s->spi_rx_valid = 1;
    if ((s->flash_fault & 4) && s->fl_active) {     /* SPIBUF never becomes ready for flash */
        s->spi_rx_valid = 0;
        s->spi_done = UINT64_MAX;
        s->flash_fault_events++;
    }
    if ((s->flash_fault & 16) && s->muxstrict && s->flash && flash_sel && cs_mux == 8) {
        s->mux_flash_drop++;
        s->flash_fault_events++;
        if (s->muxhalt && !s->cpu.halted) {
            s->cpu.halted = 1;
            snprintf(s->cpu.err, sizeof s->cpu.err,
                     "SPI0 FLASH write with PINMUX7 CS mux=8 (expected 0 or 1)");
        }
    }
    /* Shift time: CHARLEN bits at SYSCLK2 / (PRESCALE + 1), SYSCLK2 = core / 2 (fixed ratio),
       plus WDELAY + 2 SPI clocks between words. The data moves at once; SPIBUF says RXEMPTY
       and TXFULL until then, so polling drivers take the real time (LCD 1 MHz, flash 50 MHz). */
    {
        uint32_t fmt = R(0x01C41050 + 4 * ((dat1 >> 24) & 3));
        uint64_t bits = (fmt & 0x1F) ? (fmt & 0x1F) : 16, ps = ((fmt >> 8) & 0xFF) + 1;
        uint64_t dur = (bits + ((fmt >> 24) & 0x3F) + 2) * ps * 2, now = cpu_now(&s->cpu);
        double sck_mhz = s->cpu_hz / 2.0 / (double)ps / 1e6;
        if (s->hwclose && s->hw_pending_irq && !s->hw_irq_seen) {
            s->hw_pending_irq = 0;
            if (s->cpu.cache) s->cpu.cache->hw_pending_irq = 1;
            s->cpu.halted = 1;
            fprintf(stderr, "HWclose: native IRQ residue after JumpClose, DINT missing\n");
        }
        if (s->hwclose && lcd_sel && !s->hw_spifmt0_written) {
            s->hw_lcd_failed = 1;
            if (s->cpu.cache) s->cpu.cache->hw_lcd_failed = 1;
            s->cpu.halted = 1;
            fprintf(stderr, "HWclose: LCD start failed, SPIFMT0 not written after JumpClose\n");
        } else if (s->hwclose && flash_sel && !s->hw_spifmt1_written) {
            s->hw_lcd_failed = 1;
            if (s->cpu.cache) s->cpu.cache->hw_lcd_failed = 1;
            s->cpu.halted = 1;
            fprintf(stderr, "HWclose: flash start failed, SPIFMT1 not written after JumpClose\n");
        } else if (s->hwclose && lcd_sel && sck_mhz > s->hw_lcd_max_mhz) {
            s->hw_lcd_failed = 1;
            if (s->cpu.cache) s->cpu.cache->hw_lcd_failed = 1;
            s->cpu.halted = 1;
            fprintf(stderr, "HWclose: LCD start failed, SPIFMT0 too fast (SCK %.2f MHz > %.2f)\n",
                    sck_mhz, s->hw_lcd_max_mhz);
        }
        if (s->hwclose && s->hw_residual && lcd_sel) {
            s->hw_residual_cycles += dur / 4;
        }
        s->spi_start = s->spi_done > now ? s->spi_done : now;
        s->spi_done = s->spi_start + dur;
        s->spi_busy += dur;
        if (!s->spi_limit_warned && ((flash_sel && s->spi_flash_max > 0 && sck_mhz > s->spi_flash_max) ||
                                     (lcd_sel && s->spi_lcd_max > 0 && sck_mhz > s->spi_lcd_max))) {
            s->spi_limit_warned = 1;
            fprintf(stderr, "WARN: SPI0 SCK %.2f MHz above the configured limit (LCD %.2f, flash %.2f MHz)\n",
                    sck_mhz, s->spi_lcd_max, s->spi_flash_max);
        }
        if (s->spilf)
            fprintf(s->spilf, "%10llu pc=%08X dat1=%08X rx=%02X %s fmt=%08X sck=%.3fMHz cs=%s\n",
                    (unsigned long long)now, s->cpu.cr[CR_PCE1], dat1, rx,
                    lcd_sel ? "LCD" : (flash_sel ? "FLASH" : "none"), fmt,
                    s->cpu_hz / 2.0 / (double)ps / 1e6,
                    lcd_sel ? "lcd" : (flash_sel ? "flash" : "-"));
    }
}

/* ---------------- MMIO dispatch ---------------- */
static uint32_t mmio_read(c6x_sys *s, uint32_t addr, int size)
{
    uint32_t a = addr & ~3u, v;
    if (a >= 0xB0000000u && a < 0xB0000040u) {          /* EMIFB SDRAM controller */
        stat_for(s, a)->reads++;
        return s->emifb[(a >> 2) & 15];
    }
    if (addr < MMIO_BASE || addr >= MMIO_BASE + MMIO_SIZE) {
        mmio_stat *m = stat_for(s, a);
        m->reads++;
        return 0;
    }
    mmio_stat *m = stat_for(s, a);
    m->reads++;
    if (a >= 0x01800000 && a < 0x01800200) {           /* DSP INTC */
        uint32_t off = a - 0x01800000;
        if (off < 0x10) v = s->evtflag[off >> 2];
        else if (off >= 0x80 && off < 0x90) v = s->evtmask[(off - 0x80) >> 2];
        else if (off >= 0xA0 && off < 0xB0) v = s->evtflag[(off - 0xA0) >> 2] & ~s->evtmask[(off - 0xA0) >> 2];
        else if (off >= 0x104 && off < 0x110) v = s->intmux[(off - 0x104) >> 2];
        else v = R(a);
    } else if (a >= 0x01844000 && a < 0x01846000) {    /* cache ops: word counts / triggers complete at once */
        v = 0;
    } else if (a >= 0x01E00000 && a < 0x01E10000 && s->usb.enabled) {   /* USB0 with a host */
        v = usb_read(s, addr, size);
        m->last = v;
        if (s->logf && a >= s->watch_lo && a < s->watch_hi)
            fprintf(s->logf, "%10llu pc=%08X R%d %08X = %08X\n", (unsigned long long)cpu_now(&s->cpu), s->cpu.cr[CR_PCE1], size, addr, v);
        return v;
    } else if (a >= 0x01E00000 && a < 0x01E10000) {    /* USB0 OTG wrapper + MUSBMHDRC: no host attached */
        uint32_t off = a - 0x01E00000;
        if (off == 0x04) v = R(a) & ~1u;                 /* CTRLR.RESET self-clears */
        else v = R(a);
    } else if (a == 0x01C14184) {                        /* CFGCHIP2: USB0 PHY clock good */
        v = R(a) | (1u << 17);
    } else if (a >= 0x01C11000 && a < 0x01C12000) {    /* PLL0 */
        if (a == 0x01C1113C) v = 0;                      /* PLLSTAT: GOSTAT=0 */
        else v = R(a);
    } else if ((a >= 0x01C10000 && a < 0x01C11000) || (a >= 0x01E27000 && a < 0x01E28000)) { /* PSC */
        uint32_t base = a & ~0xFFFu, off = a - base;
        if (off == 0x128) v = 0;                         /* PTSTAT */
        else if (off >= 0x200 && off < 0x208) v = 0x301; /* PDSTAT: on */
        else if (off >= 0x800 && off < 0x880) v = (R(base + 0xA00 + (off - 0x800)) & 0x1F) | 0x1E00;
        else v = R(a);
    } else if (a >= 0x01C20000 && a < 0x01C22000) {    /* TIMER64P0/1 */
        v = tmr_read(s, (a >> 12) & 1, a & 0xFFF);
    } else if (a >= 0x01E26000 && a < 0x01E27000) {    /* GPIO */
        uint32_t off = a - 0x01E26000;
        if (off >= 0x10 && ((off - 0x10) % 0x28) == 0x10) {   /* IN_DATA */
            int k = (off - 0x10) / 0x28;
            uint32_t dir = R(0x01E26010 + k * 0x28);
            v = (s->gpio_in[k] & dir) | (s->gpio_out[k] & ~dir);
        } else if (off >= 0x10 && ((off - 0x10) % 0x28 == 0x04 || (off - 0x10) % 0x28 == 0x08 || (off - 0x10) % 0x28 == 0x0C)) {
            v = s->gpio_out[(off - 0x10) / 0x28];        /* OUT_DATA; SET/CLR_DATA read back OUT_DATA */
        } else if (off >= 0x10 && ((off - 0x10) % 0x28) == 0x24) {
            v = s->gpio_intstat[(off - 0x10) / 0x28];
        } else if (off >= 0x10 && ((off - 0x10) % 0x28) == 0x14) {
            v = s->gpio_ris[(off - 0x10) / 0x28];
        } else if (off >= 0x10 && ((off - 0x10) % 0x28) == 0x1C) {
            v = s->gpio_fal[(off - 0x10) / 0x28];
        } else v = R(a);
    } else if (a >= 0x01C01000 && a < 0x01C04000) {    /* EDMA3 global + shadow regions */
        uint32_t off = (a < 0x01C02000) ? a - 0x01C01000 : (a - 0x01C02000) & 0x1FF;
        v = edma_reg_read(s, off);
    } else if ((a >= 0x01D00000 && a < 0x01D01000) || (a >= 0x01D02000 && a < 0x01D03000)) { /* McASP0 */
        asp_sync(s);
        uint32_t off = a - 0x01D00000;
        if (a >= 0x01D02000) {                          /* data port: serializers in order */
            v = s->asp.rq[s->asp.rq_pos < s->asp.rq_n ? s->asp.rq_pos : s->asp.rq_n - 1];
            if (++s->asp.rq_pos >= s->asp.rq_n) s->asp.rdata = 0;
        }
        else if (off == 0x44) v = (R(0x01D00060) & 0x1F) | (R(0x01D000A0) & 0x1F00);   /* GBLCTL mirrors R/X */
        else if (off == 0x60) v = (R(0x01D00060) & 0x1F) | (R(0x01D000A0) & 0x1F00);
        else if (off == 0xA0) v = (R(0x01D00060) & 0x1F) | (R(0x01D000A0) & 0x1F00);
        else if (off == 0xC0) v = (R(a) & ~0x20u) | (s->asp.xdata ? 0x20 : 0);       /* XSTAT */
        else if (off == 0x80) v = (R(a) & ~0x20u) | (s->asp.rdata ? 0x20 : 0);       /* RSTAT */
        else if (off >= 0x280 && off < 0x2C0) {        /* RBUFn: that serializer's word */
            int n = (off - 0x280) / 4;
            v = 0;
            for (int k = 0; k < s->asp.rq_n; k++) if (s->asp.rq_ser[k] == n) v = s->asp.rq[k];
            if (s->asp.rq_n && n == s->asp.rq_ser[s->asp.rq_n - 1]) s->asp.rdata = 0;
        }
        else if (off >= 0x200 && off < 0x240) v = s->asp.xbuf;
        else v = R(a);
    } else if (a >= 0x01E12000 && a < 0x01E13000) {    /* SPI1: battery ADC */
        uint32_t off = a - 0x01E12000;
        uint64_t now = cpu_now(&s->cpu);
        int rx = s->spi1_rx_valid && (!s->spi1_timing || now >= s->spi1_done);
        int txfull = s->spi1_timing && s->spi1_start > now;
        if (off == 0x10) v = (R(a) & ~0x300u) | (txfull ? 0 : 1u << 9) | (rx ? 1u << 8 : 0);
        else if (off == 0x40) {
            v = (s->spi1_buf & 0xFFFF) | (rx ? 0 : 1u << 31) | (txfull ? 1u << 29 : 0);
            if (rx) s->spi1_rx_valid = 0;
        }
        else v = R(a);
    } else if (a >= 0x01C41000 && a < 0x01C42000) {    /* SPI0 */
        uint32_t off = a - 0x01C41000;
        uint64_t now = cpu_now(&s->cpu);
        int rx = s->spi_rx_valid && now >= s->spi_done, txfull = s->spi_start > now;
        if (off == 0x10) v = (R(a) & ~0x300u) | (txfull ? 0 : 1u << 9) | (rx ? 1u << 8 : 0); /* SPIFLG */
        else if (off == 0x40) {                                         /* SPIBUF */
            v = (s->spibuf & 0xFFFF) | (rx ? 0 : 1u << 31) | (txfull ? 1u << 29 : 0);
            if (rx) s->spi_rx_valid = 0;
        }
        else v = R(a);
    } else {
        v = R(a);
    }
    m->last = v;
    if (s->logf && a >= s->watch_lo && a < s->watch_hi)
        fprintf(s->logf, "%10llu pc=%08X R %08X = %08X\n", (unsigned long long)cpu_now(&s->cpu), s->cpu.cr[CR_PCE1], a, v);
    if (size == 1) return (v >> (8 * (addr & 3))) & 0xFF;
    if (size == 2) return (v >> (8 * (addr & 2))) & 0xFFFF;
    return v;
}

static void mmio_write(c6x_sys *s, uint32_t addr, int size, uint32_t val)
{
    uint32_t a = addr & ~3u;
    mmio_stat *m = stat_for(s, a);
    m->writes++;
    m->last = val;
    if (a >= 0xB0000000u && a < 0xB0000040u) {          /* EMIFB SDRAM controller */
        s->emifb[(a >> 2) & 15] = val;
        sys_update_clocks(s);
        return;
    }
    if (addr < MMIO_BASE || addr >= MMIO_BASE + MMIO_SIZE) return;
    if (addr == 0x01C14184u) s->usb.usb0_vbussense = (int)((val >> 16) & 1u);
    /* Safe USB PHY prerequisite decode. None of these checks is fatal: stock
       70CDR 2.10 enumerates on the pedal with CFGCHIP2=0x00025032. */
    if (s->usbphy_logf) {
        const char *tag = NULL;
        if (addr == 0x01C14038u) {
            tag = "KICK0R";
            if (val == 0x83E70B13u) s->usbphy_kick0 = 1;
        } else if (addr == 0x01C1403Cu) {
            tag = "KICK1R";
            if (val == 0x95A4F1E0u) s->usbphy_kick1 = 1;
        } else if (addr == 0x01C14144u) tag = "PINMUX9";
        else if (addr == 0x01C14184u) {
            tag = "CFGCHIP2";
            s->usbphy_cfgchip2 = 1;
        } else if (addr == 0x01E27A04u) {
            tag = "PSC1_MDCTL1";
            if ((val & 3u) == 3u) s->usbphy_psc_on = 1;
        } else if (addr == 0x01E27120u) tag = "PSC1_PTCMD";
        else if (addr == 0x01E27128u) tag = "PSC1_PTSTAT";
        else if (addr == 0x01E27804u) tag = "PSC1_PDSTAT";
        else if (addr == 0x01E00460u) tag = "USB_DEVCTL";
        if (tag)
            fprintf(s->usbphy_logf, "%10llu pc=%08X %s %08X = %08X\n",
                    (unsigned long long)cpu_now(&s->cpu), s->cpu.cr[CR_PCE1], tag, addr, val);
        if (s->usbphy_strict) {
            if (addr == 0x01C14144u && (!s->usbphy_kick0 || !s->usbphy_kick1))
                fprintf(s->usbphy_logf, "%10llu WARN PINMUX9 before KICK0R/KICK1R\n",
                        (unsigned long long)cpu_now(&s->cpu));
            if (addr == 0x01C14184u && (!s->usbphy_kick0 || !s->usbphy_kick1))
                fprintf(s->usbphy_logf, "%10llu WARN CFGCHIP2 before KICK0R/KICK1R\n",
                        (unsigned long long)cpu_now(&s->cpu));
            if (addr == 0x01E27A04u && (!s->usbphy_kick0 || !s->usbphy_kick1))
                fprintf(s->usbphy_logf, "%10llu WARN PSC1_MDCTL1 before KICK0R/KICK1R\n",
                        (unsigned long long)cpu_now(&s->cpu));
            if (addr == 0x01E27120u && !s->usbphy_psc_on)
                fprintf(s->usbphy_logf, "%10llu WARN PSC1_PTCMD before MDCTL1 NEXT=ON\n",
                        (unsigned long long)cpu_now(&s->cpu));
        }
    }
    if (addr >= 0x01E00000 && addr < 0x01E10000 && s->usb.enabled) {
        if (addr == 0x01E00401u && !(val & 0x40u)) { s->hw_usb_seen = 1; if (s->cpu.cache) s->cpu.cache->hw_usb_seen = 1; }
        if (s->logf) fprintf(s->logf, "%10llu pc=%08X W%d %08X = %08X\n", (unsigned long long)cpu_now(&s->cpu), s->cpu.cr[CR_PCE1], size, addr, val);
        usb_write(s, addr, size, val);
        return;
    }
    if (size != 4) {
        uint32_t old = R(a);
        uint32_t sh = 8 * (addr & 3), mask = (size == 1 ? 0xFFu : 0xFFFFu) << sh;
        val = (old & ~mask) | ((val << sh) & mask);
    }
    if (s->logf) fprintf(s->logf, "%10llu pc=%08X W %08X = %08X\n", (unsigned long long)cpu_now(&s->cpu), s->cpu.cr[CR_PCE1], a, val);
    if (a >= 0x01840000 && a < 0x01849000) {
        cache_cfg_write(&s->cache, a, val);
        mem_stale_on_invalidate(&s->mem, a, val);
    }
    if (a >= 0x01800000 && a < 0x01800200) {
        uint32_t off = a - 0x01800000;
        if (off >= 0x20 && off < 0x30) { for (int b = 0; b < 32; b++) if (val & (1u << b)) sys_event(s, (int)((off - 0x20) / 4 * 32 + b)); }
        else if (off >= 0x40 && off < 0x50) s->evtflag[(off - 0x40) >> 2] &= ~val;
        else if (off >= 0x80 && off < 0x90) s->evtmask[(off - 0x80) >> 2] = val;
        else if (off >= 0x104 && off < 0x110) s->intmux[(off - 0x104) >> 2] = val;
        if (off >= 0x40 && off < 0x50 && val & 0xFFF0u) s->hw_irq_seen = 1;
        R(a) = val;
        intc_update(s);
        return;
    }
    if (a >= 0x01C20000 && a < 0x01C22000) { tmr_write(s, (a >> 12) & 1, a & 0xFFF, val); return; }
    if (a >= 0x01C01000 && a < 0x01C04000) {
        uint32_t off = (a < 0x01C02000) ? a - 0x01C01000 : (a - 0x01C02000) & 0x1FF;
        R(a) = val;
        if (a == 0x01C01028u && val == 0xFFFFFFFFu) { s->hw_edma_seen = 1; if (s->cpu.cache) s->cpu.cache->hw_edma_seen = 1; }
        if (a == 0x01C0102Cu && val == 0xFFFFFFFFu) { s->hw_edma_seen = 1; if (s->cpu.cache) s->cpu.cache->hw_edma_seen = 1; }
        edma_reg_write(s, off, val);
        return;
    }
    if ((a >= 0x01D00000 && a < 0x01D01000) || (a >= 0x01D02000 && a < 0x01D03000)) {
        asp_sync(s);
        if (a == 0x01D00044u && val == 0) { s->hw_mcasp_seen = 1; if (s->cpu.cache) s->cpu.cache->hw_mcasp_seen = 1; }
        uint32_t off = a - 0x01D00000;
        if (a >= 0x01D02000 || (off >= 0x200 && off < 0x240)) { s->asp.xbuf = val; s->asp.xdata = 0; R(a) = val; return; }
        if (off == 0xC0 || off == 0x80) { R(a) &= ~val; return; }     /* status: write 1 to clear */
        uint32_t oldx = R(ASP + 0xA0);
        if (off == 0x44) { R(ASP + 0x60) = val & 0x1F; R(ASP + 0xA0) = val & 0x1F00; }
        else if (off == 0x60) R(ASP + 0x60) = val & 0x1F;
        else if (off == 0xA0) R(ASP + 0xA0) = val & 0x1F00;
        else R(a) = val;
        if (off == 0x44 || off == 0x60 || off == 0xA0) { asp_gblctl(s, oldx); sys_schedule(s); }
        return;
    }
    if (a >= 0x01E26000 && a < 0x01E27000) {
        uint32_t off = a - 0x01E26000;
        if (off >= 0x10) {
            int k = (off - 0x10) / 0x28, r = (off - 0x10) % 0x28;
            if (k < 5) {
                uint32_t before = s->gpio_out[1], led = s->gpio_out[0] & 1;
                uint32_t ob = s->gpio_out[k], ib = s->gpio_in[k];
                if (r == 0x04) s->gpio_out[k] = val;
                else if (r == 0x08) s->gpio_out[k] |= val;
                else if (r == 0x0C) s->gpio_out[k] &= ~val;
                else if (r == 0x14) s->gpio_ris[k] |= val;
                else if (r == 0x18) s->gpio_ris[k] &= ~val;
                else if (r == 0x1C) s->gpio_fal[k] |= val;
                else if (r == 0x20) s->gpio_fal[k] &= ~val;
                else if (r == 0x24) { s->gpio_intstat[k] &= ~val; R(a) = s->gpio_intstat[k]; return; }
                if (s->gpiolf && (ob != s->gpio_out[k] || ib != s->gpio_in[k])) {
                    uint32_t ch = ob ^ s->gpio_out[k];
                    fprintf(s->gpiolf, "%10llu pc=%08X OUT bank%d %08X->%08X changed=%08X\n",
                            (unsigned long long)cpu_now(&s->cpu), s->cpu.cr[CR_PCE1], k,
                            ob, s->gpio_out[k], ch);
                    for (int p = 0; p < 32; p++) if (ch & (1u << p))
                        fprintf(s->gpiolf, "   pin %d -> %u\n", k * 32 + p, (s->gpio_out[k] >> p) & 1u);
                }
                if ((before ^ s->gpio_out[1]) & (1u << 10)) {
                    s->spi1_idx = 0;   /* ADC CS (GPIO 42) edge */
                    if (s->adcf)
                        fprintf(s->adcf, "%9.3f ms pc=%08X GPIO42_EDGE val=%u\n",
                                sys_wall(s) * 1000.0, s->cpu.cr[CR_PCE1],
                                (s->gpio_out[1] >> 10) & 1);
                }
                if (s->ledf && k == 0 && led != (s->gpio_out[0] & 1))
                    fprintf(s->ledf, "%9.3f ms pc=%08X LED %u\n", sys_wall(s) * 1000.0, s->cpu.cr[CR_PCE1], s->gpio_out[0] & 1);
            }
        }
        R(a) = val;
        return;
    }
    if (a >= 0x01E12000 && a < 0x01E13000) {
        uint32_t off = a - 0x01E12000;
        R(a) = val;
        if (off == 0x3C || off == 0x38) {
            uint8_t v8 = s->spi1_idx == 0 ? (uint8_t)(s->adc_value >> 3) : (uint8_t)((s->adc_value & 7) << 5);
            s->spi1_idx = (s->spi1_idx + 1) & 1;
            s->spi1_buf = v8;
            s->spi1_rx_valid = 1;
            if (s->spi1_timing) {
                /* Same model as SPI0: CHARLEN bits at SYSCLK2/(PRESCALE+1),
                   WDELAY + 2 SPI clocks between words. SYSCLK2 = core/2. */
                uint32_t fmt = R(0x01E12050);
                uint64_t bits = (fmt & 0x1F) ? (fmt & 0x1F) : 8;
                uint64_t ps = ((fmt >> 8) & 0xFF) + 1;
                uint64_t dur = (bits + ((fmt >> 24) & 0x3F) + 2) * ps * 2;
                uint64_t now = cpu_now(&s->cpu);
                s->spi1_start = s->spi1_done > now ? s->spi1_done : now;
                s->spi1_done = s->spi1_start + dur;
            }
            s->adc_reads++;
            if (s->adcf) {
                fprintf(s->adcf, "%9.3f ms pc=%08X off=%02X val=%08X n=%u cs=%u\n",
                        sys_wall(s) * 1000.0, s->cpu.cr[CR_PCE1], off, val,
                        s->adc_reads, (s->gpio_out[1] >> 10) & 1);
                /* B14 (DP) at this moment + absolute address of B14[114..115] */
                uint32_t b14 = s->cpu.r[1][14];
                fprintf(s->adcf, "        B14=%08X  batt_byte@%08X expr_slot@%08X\n",
                        b14, b14 + 114 * 4, b14 + 115 * 4);
            }
        }
        return;
    }
    if (a >= 0x01C41000 && a < 0x01C42000) {
        uint32_t off = a - 0x01C41000;
        R(a) = val;
        if (a == 0x01C41050u) {
            s->hw_spifmt0_written = 1;
            if (s->cpu.cache) s->cpu.cache->hw_spifmt0_written = 1;
        }
        if (a == 0x01C41054u) {
            s->hw_spifmt1_written = 1;
            if (s->cpu.cache) s->cpu.cache->hw_spifmt1_written = 1;
        }
        if (off == 0x3C) spi0_xfer(s, val);
        else if (off == 0x38) spi0_xfer(s, (R(0x01C4103C) & 0xFFFF0000u) | (val & 0xFFFF));
        return;
    }
    R(a) = val;
    if ((a >= 0x01C11100 && a < 0x01C11170) || a == 0x01C14188)   /* PLL0, CFGCHIP3 */
        sys_update_clocks(s);
}

/* ---------------- setup ---------------- */
c6x_sys *sys_create(void)
{
    c6x_sys *s = calloc(1, sizeof *s);
    mem_init(&s->mem);
    mem_add_ram(&s->mem, "L2", 0x11800000, 256 * 1024, 0x00800000);
    mem_add_ram(&s->mem, "L1P", 0x11E00000, 32 * 1024, 0x00E00000);
    mem_add_ram(&s->mem, "L1D", 0x11F00000, 32 * 1024, 0x00F00000);
    mem_add_ram(&s->mem, "SHRAM", 0x80000000, 128 * 1024, 0);
    mem_add_ram(&s->mem, "SDRAM", 0xC0000000, 8 * 1024 * 1024, 0);
    mem_mirror(&s->mem, 0xC0000000, 8 * 1024 * 1024, 0xC0800000, 0x1F800000);
    mem_add_ram(&s->mem, "DSPROM", 0x11700000, 1024 * 1024, 0);
    s->mmio = calloc(MMIO_SIZE / 4, 4);
    s->mem.mmio_read = mmio_read;
    s->mem.mmio_write = mmio_write;
    s->mem.sys = s;
    cpu_init(&s->cpu, &s->mem);
    s->cpu.sys = s;
    cache_init(&s->cache, 300, 150);   /* EMIFB clock assumed SYSCLK/2; scales with the PLL */
    s->cpu.cache = &s->cache;
    s->cpu_hz = 300000000;
    s->hw_lcd_max_mhz = 25.0;    /* provisional bracket: hardware works at 2.02, hangs at 68 MHz */
    s->timer_hz = 24000000;
    s->lcd_dc_pin = 37;
    s->lcd_cs_pin = 91;
    s->adc_value = 0xF0;   /* battery ADC: fresh batteries / adapter */
    s->spi1_timing = 1;    /* model SPI1 word shift time by default */
    s->usb.vbus_level = 3;                /* default: VBusValid on the cable */
    s->usb.vbus_sense_model = 0;          /* optional fault model, disabled by default */
    s->usb.usb0_vbussense = 1;            /* until the firmware writes CFGCHIP2 */
    s->flash_size = 4 * 1024 * 1024;
    s->flash = malloc(s->flash_size);
    s->asp.capout = 44100 * 2 * 60;
    s->asp.out = malloc(s->asp.capout * sizeof(int16_t));
    memset(s->flash, 0xFF, s->flash_size);
    /* typical GPIO idle levels with fresh batteries */
    for (int k = 0; k < 5; k++) R(0x01E26010 + k * 0x28) = 0xFFFFFFFFu;   /* GPIO DIR reset: all inputs */
    s->gpio_in[0] = 0xEB0600F1u;   /* IN01 at rest on the pedal: keys 4-7, 24, 25, 27 high = released */
    s->gpio_in[1] = 274802495u;
    s->gpio_in[2] = 0xFFFFFFFFu;   /* buttons are active low: nothing pressed */
    s->gpio_in[3] = 0xFFFFFFFFu;
    s->gpio_in[4] = 0xFFFFFFFFu;
    /* golden PLL/PSC state from the live pedal */
    R(0x01C11110) = 0x18; R(0x01C11114) = 0x8000; R(0x01C11100) = 0x49; R(0x01C11128) = 0x8001;
    R(0x01C14000) = 0x4E840102;
    return s;
}

/* Clock commands of an AIS image: ROM function 5 = PLL0 (arg0 = PLLM<<24 | POSTDIV<<16 |
   PLLDIV3<<8 | PLLDIV5, stock 0x18010202 [inferred, fits the live dump]), Set CFGCHIP3, ROM
   function 2 = EMIFB SDCR, SDTIMR, SDTIMR2, SDRCR (stock 0001C620 10913208 30080006 0000081F). */
static void ais_clocks(c6x_sys *s, const ais_info *info)
{
    for (int k = 0; k < info->nfn; k++)
        if (info->fn[k][0] == 5 && info->fn[k][1] >= 1) {
            uint32_t a0 = info->fn[k][2];
            R(0x01C11110) = a0 >> 24;
            R(0x01C11128) = 0x8000 | ((a0 >> 16) & 0xFF);
            R(0x01C11120) = 0x8000 | ((a0 >> 8) & 0xFF);
            R(0x01C11164) = 0x8000 | (a0 & 0xFF);
        } else if (info->fn[k][0] == 2 && info->fn[k][1] >= 4) {
            s->emifb[0x08 >> 2] = info->fn[k][2];
            s->emifb[0x10 >> 2] = info->fn[k][3];
            s->emifb[0x14 >> 2] = info->fn[k][4];
            s->emifb[0x0C >> 2] = info->fn[k][5];
        }
    for (int i = 0; i < info->nsets; i++) {
        uint32_t type = info->sets[i][0], addr = info->sets[i][1], data = info->sets[i][2];
        int size = (type & 3) == 0 ? 1 : (type & 3) == 1 ? 2 : 4;
        mem_wr(&s->mem, addr, size, data);
    }
}

/* Load an AIS image as the pedal would run it. The ROM boots Zoom's bootloader (BIN/136)
   and executes its clock commands; the bootloader then loads the OS (BIN/129) itself and
   only knows SectionLoad, SectionFill and JumpClose (0xC03E5AEC): the OS image's own PLL /
   CFGCHIP3 / EMIFB commands are skipped. So a main OS started directly takes the clocks of
   136_bootloader.bin next to it (sections of both are loaded, bootloader first). */
int sys_load_ais(c6x_sys *s, const char *path)
{
    uint32_t len;
    ais_info info, boot;
    int have_boot = 0;
    const char *base = strrchr(path, '/'), *bs = strrchr(path, '\\');
    if (bs > base) base = bs;
    base = base ? base + 1 : path;
    if (!strcmp(base, "129_main_OS.bin")) {
        char bp[1024];
        snprintf(bp, sizeof bp, "%.*s136_bootloader.bin", (int)(base - path), path);
        uint8_t *bd = read_file(bp, &len);
        if (bd) {
            have_boot = ais_load(&s->mem, bd, len, &boot, 0) == 0;
            free(bd);
        }
    }
    uint8_t *d = read_file(path, &len);
    if (!d) return -1;
    int r = ais_load(&s->mem, d, len, &info, 0);
    free(d);
    if (r) return r;
    ais_clocks(s, have_boot ? &boot : &info);
    {
        double vco, core, emif;
        sys_clock_rates(s, &vco, &core, &emif);
        s->cpu_hz = (uint32_t)(core * 1e6 + 0.5);
    }
    sys_update_clocks(s);
    cpu_reset(&s->cpu, info.entry);
    return 0;
}

/* Take the AIS image from the already assembled flash instead of a separate
   file. This is the host-side model of "BIN/136 reads BIN/129 from SPI flash":
   same AIS parser, but no direct file shortcut. */
int sys_load_ais_from_flash(c6x_sys *s, uint32_t off, uint32_t maxlen, uint32_t *len_out)
{
    if (!s->flash || off >= s->flash_size) return -1;
    if (maxlen > s->flash_size - off) maxlen = s->flash_size - off;
    if (len_out) *len_out = maxlen;
    return ais_load(&s->mem, s->flash + off, maxlen, &s->boot_info_flash, 0);
}

/* AIS JumpClose enters with whatever B15 the boot ROM happened to leave. The
   model resets registers to zero, which hides a missing stack setup in CFW.
   -stack lets a test provide the real stack pointer from the image linker. */
void sys_set_jump_stack(c6x_sys *s, uint32_t b15)
{
    if (b15) s->cpu.r[1][15] = b15;
}

/* AIS SectionLoad changes memory while the cache model keeps its old tags.
   Real bootmini invalidates L1D/L2/L1P before calling C. -cachejump applies the
   same operation at the model entry so stale lines cannot hide that dependency. */
void sys_bootlog_write(c6x_sys *s, uint32_t addr, int size, uint32_t val)
{
    if (!s->bootlogf) return;
    uint32_t pc = s->cpu.cr[CR_PCE1];
    if (pc < 0xC00F0000u || pc >= 0xC00F7000u) return;   /* bootmini code only */
    if (addr < 0xC0000000u || addr >= 0xC00F0000u) return; /* firmware copy range */
    if (!s->boot_copy_bytes) s->boot_copy_first = addr;
    s->boot_copy_last = addr;
    s->boot_copy_bytes += (uint32_t)size;
    if ((s->boot_copy_bytes & 0x3Fu) < (uint32_t)size)
        fprintf(s->bootlogf, "%9.3f ms FWIMG copy %08X size=%d pc=%08X val=%08X\n",
                sys_wall(s) * 1000.0, addr, size, pc, val);
}

void sys_set_jump_cache(c6x_sys *s, int invalidate)
{
    if (invalidate) { cache_invalidate_all(&s->cache); mem_stale_clear(&s->mem); }
}

static void hwclose_dint(c6x_cpu *c)
{
    c6x_sys *s = c->sys;
    s->hw_irq_seen = 1;
    if (s->cpu.cache) s->cpu.cache->hw_irq_seen = 1;
}

void sys_set_hwclose(c6x_sys *s, int enable, double rom_repaint_ms)
{
    s->hwclose = enable;
    s->hw_rom_repaint_ms = rom_repaint_ms;
    s->cpu.on_dint = enable ? hwclose_dint : NULL;
    s->cache.hw_lcd_failed = s->hw_lcd_failed;
    s->cache.hw_pending_irq = s->hw_pending_irq;
    s->cache.hw_irq_seen = s->hw_irq_seen;
    s->cache.hw_spifmt0_written = s->hw_spifmt0_written;
    s->cache.hw_spifmt1_written = s->hw_spifmt1_written;
    s->cache.hw_edma_seen = s->hw_edma_seen;
    s->cache.hw_mcasp_seen = s->hw_mcasp_seen;
    s->cache.hw_usb_seen = s->hw_usb_seen;
    s->cache.hw_residual = s->hw_residual;
    s->cache.hw_repaints = s->hw_repaints;
    s->cache.hw_residual_cycles = s->hw_residual_cycles;
}

void sys_hwclose_jump_reset(c6x_sys *s)
{
    s->hw_lcd_failed = 0;
    s->hw_spifmt0_written = s->hw_spifmt1_written = 0;
    s->hw_edma_seen = s->hw_mcasp_seen = s->hw_usb_seen = 0;
    s->hw_irq_seen = 0;
    if (s->hwclose && !s->hw_irq_seen) {
        s->hw_pending_irq = 1;         /* synthetic native IRQ residue after JumpClose */
        s->cpu.cr[CR_IER] |= 1u << 1;  /* NMIE */
        s->cpu.cr[CR_IFR] |= 1u << 4;  /* INT4 */
        s->cpu.cr[CR_TSR] |= TSR_GIE;
    } else s->hw_pending_irq = 0;
    s->hw_residual = 1;
    s->hw_residual_cycles = 0;
    s->hw_repaints = 0;
    s->hw_next_repaint = cpu_now(&s->cpu) + (uint64_t)(s->hw_rom_repaint_ms * 1000.0 * (s->cpu_hz / 1e6));
    s->cache.hw_lcd_failed = s->hw_lcd_failed;
    s->cache.hw_pending_irq = s->hw_pending_irq;
    s->cache.hw_irq_seen = s->hw_irq_seen;
    s->cache.hw_spifmt0_written = s->hw_spifmt0_written;
    s->cache.hw_spifmt1_written = s->hw_spifmt1_written;
    s->cache.hw_edma_seen = s->hw_edma_seen;
    s->cache.hw_mcasp_seen = s->hw_mcasp_seen;
    s->cache.hw_usb_seen = s->hw_usb_seen;
    s->cache.hw_residual = s->hw_residual;
    s->cache.hw_repaints = s->hw_repaints;
    s->cache.hw_residual_cycles = s->hw_residual_cycles;
}

/* ---------------- clocks and SDRAM ---------------- */
/* PLL0 as in the DA830 / OMAP-L137 family (Linux da830 clock tree, da8xx-cfgchip):
   VCO = 24 MHz x (PLLM+1) / (PREDIV+1), allowed 300..600 MHz; PLLOUT = VCO / (POSTDIV+1);
   SYSCLKn = PLLOUT / (PLLDIVn+1), the core runs on SYSCLK1. EMIFB (SDRAM) takes VCO / 4.5
   when CFGCHIP3 bit 0 (EMB_CLKSRC) and bit 2 (DIV45PENA) are set, else SYSCLK5.
   Stock 50G / 60B / 70CDR: PLLM 24, POSTDIV 1, CFGCHIP3 5 -> VCO 600, core 300,
   SDRAM 133.3 MHz (confirmed by the refresh count, FINDINGS.md). */
static double pll_div(uint32_t reg) { return (reg & 0x8000) ? (reg & 0x1F) + 1 : 1; }

void sys_clock_rates(c6x_sys *s, double *vco, double *core, double *emif)
{
    double v = 24.0 * ((R(0x01C11110) & 0x1F) + 1) / pll_div(R(0x01C11114));
    double out = v / pll_div(R(0x01C11128));
    if (!(R(0x01C11100) & 1))                   /* PLLCTL.PLLEN = 0: bypass, everything runs on OSCIN */
        v = out = 24.0;
    uint32_t c3 = R(0x01C14188);
    *vco = v;
    *core = out / pll_div(R(0x01C11118));
    *emif = s->emif_force > 0 ? s->emif_force
          : (c3 & 5) == 5 ? v / 4.5 : out / pll_div(R(0x01C11164));
}

/* SDTIMR fields (DDR2/mDDR-style controller; fits the stock value at 133 MHz) */
typedef struct { int cl, rfc, rp, rcd, wr, ras, rc, rrd; uint32_t refresh; } sdram_t;
static sdram_t sdram_timings(c6x_sys *s)
{
    uint32_t cr = s->emifb[0x08 >> 2], t = s->emifb[0x10 >> 2];
    sdram_t d;
    d.cl = (cr >> 9) & 7;
    d.rfc = ((t >> 25) & 0x7F) + 1;
    d.rp = ((t >> 22) & 7) + 1;
    d.rcd = ((t >> 19) & 7) + 1;
    d.wr = ((t >> 16) & 7) + 1;
    d.ras = ((t >> 11) & 0x1F) + 1;
    d.rc = ((t >> 6) & 0x1F) + 1;
    d.rrd = ((t >> 3) & 7) + 1;
    d.refresh = s->emifb[0x0C >> 2] & 0xFFFF;
    return d;
}

/* The core clock changed at run time (the firmware put PLL0 in bypass or relocked it).
   Cycles already run keep their old length; timers are brought up to now first, and every
   event scheduled later (inputs, USB messages, the runner's snapshots and end) moves to the
   new rate, so it still happens at the same wall time. */
static void tmr_sync(c6x_sys *s, int i);
static void asp_update_rate(c6x_sys *s);
double sys_wall(c6x_sys *s)
{
    return s->wall_s + (double)(cpu_now(&s->cpu) - s->wall_cyc) / s->cpu_hz;
}

static void sys_set_cpu_hz(c6x_sys *s, uint32_t hz)
{
    uint64_t now = cpu_now(&s->cpu);
    double r = (double)hz / s->cpu_hz;
    if (hz == s->cpu_hz || !hz) return;
    tmr_sync(s, 0);
    tmr_sync(s, 1);
    /* Timer bookkeeping is kept in core cycles.  After the rate change every
       future cycle count must keep the same wall time as before, otherwise
       the next timer IRQ (and with it the UI tick) lands at the wrong moment. */
    for (int i = 0; i < 2; i++) {
        if (s->tmr[i].last_update > now)
            s->tmr[i].last_update = now + (uint64_t)((s->tmr[i].last_update - now) * r);
        if (s->tmr[i].next_irq12 > now)
            s->tmr[i].next_irq12 = now + (uint64_t)((s->tmr[i].next_irq12 - now) * r);
        if (s->tmr[i].next_irq34 > now)
            s->tmr[i].next_irq34 = now + (uint64_t)((s->tmr[i].next_irq34 - now) * r);
    }
    for (int i = 0; i < s->ninq; i++)
        if (s->inq[i].at > now) s->inq[i].at = now + (uint64_t)((s->inq[i].at - now) * r);
    for (int i = s->usb.outpos; i < s->usb.nout; i++)
        if (s->usb.out[i].at > now) s->usb.out[i].at = now + (uint64_t)((s->usb.out[i].at - now) * r);
    s->wall_s = sys_wall(s);
    s->wall_cyc = now;
    if (s->on_clock) s->on_clock(s, now, r);
    s->cpu_hz = hz;
    asp_update_rate(s);
    s->clock_changes++;
}

void sys_update_clocks(c6x_sys *s)
{
    double vco, core, emif;
    sdram_t d = sdram_timings(s);
    sys_clock_rates(s, &vco, &core, &emif);
    if (cpu_now(&s->cpu) > 0)                   /* at load time the caller sets cpu_hz */
        sys_set_cpu_hz(s, (uint32_t)(core * 1e6 + 0.5));
    if (!s->emifb[0x10 >> 2]) d.rcd = d.cl = d.rp = 3;   /* not programmed yet */
    cache_set_clocks(&s->cache, s->cpu_hz / 1e6, emif, d.rcd, d.cl ? d.cl : 3, d.rp);
}

/* Etron EM638165TS-7G (4M x 16 SDR, 4096 rows): -7 = 143 MHz at CL3. Minimums are the
   usual ones for that speed grade (tRC 63, tRAS 42, tRCD 21, tRP 21, tRRD 14, tWR 14 ns,
   64 ms / 4096 rows); Etron's own sheet not checked yet. */
int sys_sdram_check(c6x_sys *s, FILE *f)
{
    double vco, core, emif, ns;
    int warn = 0;
    sdram_t d = sdram_timings(s);
    sys_clock_rates(s, &vco, &core, &emif);
    ns = 1000.0 / emif;
    fprintf(f, "CLOCKS: VCO %.1f MHz, core %.1f MHz, SDRAM %.1f MHz (%s)\n", vco, core, emif,
            s->emif_force > 0 ? "-emif" : (R(0x01C14188) & 5) == 5 ? "VCO/4.5" : "SYSCLK5");
    if (vco < 300 || vco > 600) { fprintf(f, "  WARN: VCO outside 300..600 MHz\n"); warn++; }
    if (core > 375.5) { fprintf(f, "  WARN: core above 375 MHz (C6745 top speed grade)\n"); warn++; }
    if (emif > 143.0) { fprintf(f, "  WARN: SDRAM above 143 MHz (EM638165TS-7G at CL3)\n"); warn++; }
    if (!s->emifb[0x10 >> 2]) { fprintf(f, "  SDRAM timings not programmed\n"); return warn; }
    fprintf(f, "SDRAM: CL%d tRCD %.1f tRP %.1f tRC %.1f tRAS %.1f tRFC %.1f tWR %.1f tRRD %.1f ns, refresh %.2f us\n",
            d.cl, d.rcd * ns, d.rp * ns, d.rc * ns, d.ras * ns, d.rfc * ns, d.wr * ns, d.rrd * ns, d.refresh * ns / 1000);
    struct { const char *n; int clk; double min; } c[] = {
        { "tRCD", d.rcd, 21 }, { "tRP", d.rp, 21 }, { "tRC", d.rc, 63 }, { "tRAS", d.ras, 42 },
        { "tRFC", d.rfc, 63 }, { "tWR", d.wr, 14 }, { "tRRD", d.rrd, 14 },
    };
    for (unsigned i = 0; i < sizeof c / sizeof c[0]; i++)
        if (c[i].clk * ns < c[i].min - 0.05) {
            fprintf(f, "  WARN: %s %d clocks = %.1f ns < %.0f ns\n", c[i].n, c[i].clk, c[i].clk * ns, c[i].min);
            warn++;
        }
    if (d.refresh * ns / 1000 > 15.63) {
        fprintf(f, "  WARN: refresh every %.2f us > 15.6 us (64 ms / 4096 rows)\n", d.refresh * ns / 1000);
        warn++;
    }
    if (d.cl == 2 && emif > 100) { fprintf(f, "  WARN: CL2 above 100 MHz\n"); warn++; }
    return warn;
}

/* ---------------- inputs ---------------- */
/* DSP event for GPIO bank b interrupt.  Bank 1 = event 41 (the firmware maps
   it to INT8 and enables only BINTEN bit 1); others are not used by 3.10. */
static int gpio_bank_event(int bank) { return bank == 1 ? 41 : -1; }

void sys_gpio_input(c6x_sys *s, int pin, int val)
{
    int k = pin >> 5, b = pin & 31;
    if (k >= 5) return;
    uint32_t bit = 1u << b, old = s->gpio_in[k] & bit;
    if (val) s->gpio_in[k] |= bit; else s->gpio_in[k] &= ~bit;
    uint32_t now = s->gpio_in[k] & bit;
    if (old == now) return;
    if (s->gpiolf)
        fprintf(s->gpiolf, "%10llu pc=%08X IN  pin %d -> %u\n",
                (unsigned long long)cpu_now(&s->cpu), s->cpu.cr[CR_PCE1], pin, val ? 1u : 0u);
    int edge = (now && (s->gpio_ris[k] & bit)) || (!now && (s->gpio_fal[k] & bit));
    if (!edge) return;
    s->gpio_intstat[k] |= bit;
    int bank = pin >> 4;
    uint32_t binten = R(0x01E26008);
    int ev = gpio_bank_event(bank);
    if ((binten & (1u << bank)) && ev >= 0) sys_event(s, ev);
}

void sys_schedule_input(c6x_sys *s, uint64_t at, int pin, int val)
{
    if (s->ninq >= 4096) return;
    int i = s->ninq++;
    while (i > 0 && s->inq[i - 1].at > at) { s->inq[i] = s->inq[i - 1]; i--; }
    s->inq[i].at = at; s->inq[i].pin = pin; s->inq[i].val = val;
}

static void inputs_sync(c6x_sys *s)
{
    int done = 0;
    while (done < s->ninq && s->inq[done].at <= cpu_now(&s->cpu)) {
        sys_gpio_input(s, s->inq[done].pin, s->inq[done].val);
        done++;
    }
    if (done) {
        memmove(s->inq, s->inq + done, (s->ninq - done) * sizeof s->inq[0]);
        s->ninq -= done;
    }
}

/* assemble the 4 MB flash from updater parts: boot @0, main @0x40000,
   file system @0xF0000, preset/logo @0x3FD000 */
int sys_load_flash_parts(c6x_sys *s, const char *dir)
{
    static const struct { const char *name; uint32_t off; } parts[] = {
        { "136_bootloader.bin", 0x000000 }, { "129_main_OS.bin", 0x040000 },
        { "137_file_system.bin", 0x0F0000 }, { "133_data_133.bin", 0x3FD000 },
    };
    int ok = 0;
    for (unsigned i = 0; i < sizeof parts / sizeof parts[0]; i++) {
        char path[512];
        snprintf(path, sizeof path, "%s/%s", dir, parts[i].name);
        uint32_t len;
        uint8_t *d = read_file(path, &len);
        if (!d) { fprintf(stderr, "flash: missing %s\n", path); continue; }
        if (parts[i].off + len > s->flash_size) len = s->flash_size - parts[i].off;
        memcpy(s->flash + parts[i].off, d, len);
        free(d);
        ok++;
    }
    return ok == 4 ? 0 : -1;
}

uint64_t sys_run(c6x_sys *s, uint64_t cycles)
{
    c6x_cpu *c = &s->cpu;
    uint64_t start = cpu_now(c), end = start + cycles;
    c->bp_hit = 0;
    if (!s->next_event) sys_schedule(s);
    while (cpu_now(c) < end && !c->halted && !c->bp_hit) {
        uint64_t now = cpu_now(c);
        if (now >= s->next_event) {
            tmr_sync(s, 0); tmr_sync(s, 1);
            asp_sync(s);
            inputs_sync(s);
            usb_sync(s);
            if (s->hwclose && s->hw_residual && s->hw_rom_repaint_ms > 0 && now >= s->hw_next_repaint) {
                /* Synthetic boot-ROM logo repaint: same page/data pattern as the ZOOM logo. */
                for (int p = 0; p < 8; p++) {
                    memset(s->lcd_vram[p], 0xFF, sizeof s->lcd_vram[p]);
                    s->lcd_cmds += 3;
                }
                s->hw_repaints++;
                if (s->cpu.cache) s->cpu.cache->hw_repaints = s->hw_repaints;
                s->hw_next_repaint = now + (uint64_t)(s->hw_rom_repaint_ms * 1000.0 * (s->cpu_hz / 1e6));
            }
            if (s->hwclose && s->hw_edma_seen && s->hw_mcasp_seen && s->hw_usb_seen) {
                s->hw_residual = 0;
                if (s->cpu.cache) s->cpu.cache->hw_residual = 0;
            }
            sys_schedule(s);
        }
        if (c->idle && !(c->cr[CR_IFR] & c->cr[CR_IER] & ~1u)) {
            uint64_t t = s->next_event < end ? s->next_event : end;
            if (t > now) { s->idle_cycles += t - now; c->cycle += t - now; }
            continue;
        }
        int was_idle = c->idle;
        uint64_t c0 = now;
        cpu_step(c);
        if (was_idle) s->idle_cycles += cpu_now(c) - c0;
    }
    return cpu_now(c) - start;
}

static int cmp_stat(const void *a, const void *b)
{
    const mmio_stat *x = a, *y = b;
    uint32_t tx = x->reads + x->writes, ty = y->reads + y->writes;
    return tx < ty ? 1 : tx > ty ? -1 : 0;
}

void sys_report_mmio(c6x_sys *s, FILE *f)
{
    mmio_stat *tmp = malloc(sizeof s->stats);
    memcpy(tmp, s->stats, sizeof s->stats);
    qsort(tmp, 4096, sizeof *tmp, cmp_stat);
    fprintf(f, "MMIO accesses (%d addresses):\n", s->nstats);
    for (int i = 0; i < 60 && tmp[i].addr; i++)
        fprintf(f, "  %08X  R%-9u W%-9u last=%08X\n", tmp[i].addr, tmp[i].reads, tmp[i].writes, tmp[i].last);
    free(tmp);
}

int sys_write_wav(c6x_sys *s, const char *path)
{
    FILE *f = fopen(path, "wb");
    if (!f) return -1;
    uint32_t n = s->asp.nout & ~1u, bytes = n * 2;
    uint8_t h[44];
    memcpy(h, "RIFF", 4); uint32_t v = 36 + bytes; memcpy(h + 4, &v, 4);
    memcpy(h + 8, "WAVEfmt ", 8); v = 16; memcpy(h + 16, &v, 4);
    uint16_t w = 1; memcpy(h + 20, &w, 2); w = 2; memcpy(h + 22, &w, 2);
    v = 44100; memcpy(h + 24, &v, 4); v = 44100 * 4; memcpy(h + 28, &v, 4);
    w = 4; memcpy(h + 32, &w, 2); w = 16; memcpy(h + 34, &w, 2);
    memcpy(h + 36, "data", 4); memcpy(h + 40, &bytes, 4);
    fwrite(h, 1, 44, f);
    /* The first word of each I2S frame is the RIGHT channel: a custom firmware that puts its data in
       fxBuf[i] (the effect's left), came out of the pedals' L jack in every recording
       (MS-70CDR and MS-60B, sync polarity of L-R positive) but in slot 0 of this model's
       capture as the negative. So the pairs are swapped into WAV order L, R here. */
    for (uint32_t i = 0; i + 1 < n; i += 2) {
        int16_t lr[2] = { s->asp.out[i + 1], s->asp.out[i] };
        fwrite(lr, 2, 2, f);
    }
    fclose(f);
    return 0;
}

/* PNG (grayscale, scaled, stored deflate blocks) of the LCD */
static uint32_t crc_tab[256];
static uint32_t crc32_upd(uint32_t c, const uint8_t *b, size_t n)
{
    if (!crc_tab[1]) for (uint32_t i = 0; i < 256; i++) { uint32_t x = i; for (int k = 0; k < 8; k++) x = (x & 1) ? 0xEDB88320u ^ (x >> 1) : x >> 1; crc_tab[i] = x; }
    c = ~c;
    for (size_t i = 0; i < n; i++) c = crc_tab[(c ^ b[i]) & 0xFF] ^ (c >> 8);
    return ~c;
}
static void be32(uint8_t *p, uint32_t v) { p[0] = (uint8_t)(v >> 24); p[1] = (uint8_t)(v >> 16); p[2] = (uint8_t)(v >> 8); p[3] = (uint8_t)v; }
static void png_chunk(FILE *f, const char *type, const uint8_t *d, uint32_t n)
{
    uint8_t h[8];
    be32(h, n); memcpy(h + 4, type, 4);
    fwrite(h, 1, 8, f);
    if (n) fwrite(d, 1, n, f);
    uint32_t c = crc32_upd(0, (const uint8_t *)type, 4);
    c = crc32_upd(c, d, n);
    be32(h, c);
    fwrite(h, 1, 4, f);
}

int sys_lcd_dump_png(c6x_sys *s, const char *path, int scale)
{
    int w = 128 * scale, h = 64 * scale;
    uint32_t rawlen = (uint32_t)(h * (w + 1));
    uint8_t *raw = malloc(rawlen);
    for (int y = 0; y < h; y++) {
        raw[y * (w + 1)] = 0;
        for (int x = 0; x < w; x++) {
            uint8_t b = s->lcd_vram[(y / scale) >> 3][4 + x / scale];   /* glass shows controller columns 4..131 */
            raw[y * (w + 1) + 1 + x] = ((b >> ((y / scale) & 7)) & 1) ? 0 : 255;
        }
    }
    uint32_t nblk = (rawlen + 65534) / 65535;
    uint8_t *z = malloc(2 + rawlen + nblk * 5 + 4);
    uint32_t zp = 0, a1 = 1, a2 = 0;
    z[zp++] = 0x78; z[zp++] = 0x01;
    for (uint32_t off = 0; off < rawlen; off += 65535) {
        uint32_t n = rawlen - off > 65535 ? 65535 : rawlen - off;
        z[zp++] = off + n >= rawlen;
        z[zp++] = (uint8_t)n; z[zp++] = (uint8_t)(n >> 8);
        z[zp++] = (uint8_t)~n; z[zp++] = (uint8_t)(~n >> 8);
        memcpy(z + zp, raw + off, n); zp += n;
    }
    for (uint32_t i = 0; i < rawlen; i++) { a1 = (a1 + raw[i]) % 65521; a2 = (a2 + a1) % 65521; }
    be32(z + zp, (a2 << 16) | a1); zp += 4;
    FILE *f = fopen(path, "wb");
    if (!f) { free(raw); free(z); return -1; }
    fwrite("\x89PNG\r\n\x1a\n", 1, 8, f);
    uint8_t ihdr[13];
    be32(ihdr, (uint32_t)w); be32(ihdr + 4, (uint32_t)h);
    ihdr[8] = 8; ihdr[9] = 0; ihdr[10] = 0; ihdr[11] = 0; ihdr[12] = 0;
    png_chunk(f, "IHDR", ihdr, 13);
    png_chunk(f, "IDAT", z, zp);
    png_chunk(f, "IEND", NULL, 0);
    fclose(f);
    free(raw); free(z);
    return 0;
}

void sys_lcd_dump_pgm(c6x_sys *s, const char *path)
{
    FILE *f = fopen(path, "wb");
    if (!f) return;
    fprintf(f, "P5\n128 64\n255\n");
    for (int y = 0; y < 64; y++)
        for (int x = 0; x < 128; x++) {
            uint8_t b = s->lcd_vram[y >> 3][4 + x];
            fputc((b >> (y & 7)) & 1 ? 0 : 255, f);
        }
    fclose(f);
}
