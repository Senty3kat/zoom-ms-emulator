/* USB0 (OMAP-L137 / C6745): TI wrapper, MUSBMHDRC core in peripheral mode, CPPI 4.1 DMA
   with queue manager, and a scripted full-speed host.

   Register map (offsets from 0x01E00000):
     0x000  wrapper: CTRLR 04, MODE 10, INTSRCR 20, INTSETR 24, INTCLRR 28, INTMSKR 2C,
            INTMSKSETR 30, INTMSKCLRR 34, INTMASKEDR 38, EOIR 3C
            INTSRCR bits: 0-4 Tx EP0-4, 8-12 Rx EP0-4, 16-23 MUSB INTRUSB, 24 DRVVBUS
     0x400  MUSB core (FADDR, POWER, INTRTX/RX(E), INTRUSB(E), FRAME, INDEX, indexed EP regs
            at 0x410, FIFOs at 0x420 + 4*ep, DEVCTL 0x460, EP regs at 0x500 + 16*ep)
     0x1000 CPPI DMA: TDFDQ 0x1004; channel n at 0x1800 + 0x20n: TXGCR +0, RXGCR +8,
            RXHPCRA +0xC, RXHPCRB +0x10. Channel n serves endpoint n + 1.
     0x4000 queue manager: PEND 0x4090 + 4i; queue q: push/pop at 0x600C + 16q (CTRLD),
            count at 0x7000 + 16q (QSTATA). Tx submit queues 16 + 2n (+1), Tx/Rx
            completion queues come from TXGCR/descriptor and RXGCR.
   Host packet descriptor (32 bytes): w0 [31:27]=16 type, [21:0] packet length;
   w1 [31:27] source port (= endpoint); w2 [19] zero-length, [11:0] return queue;
   w3 [21:0] buffer length; w4 buffer pointer; w5 next; w6 original length;
   w7 original buffer pointer.
   The USB interrupt (DSP event 19) is (INTSRCR & INTMSKR) != 0 or a completion queue
   (24..27) not empty; it is re-raised on EOIR while still active. */
#include <stdlib.h>
#include <string.h>
#include "sys.h"
#include "usb.h"

#define USB_EVENT 19
#define FS_MPS0 64

enum { H_WAIT_CONNECT, H_RESET, H_ENUM, H_RUN };
enum { CT_IDLE, CT_SETUP, CT_DIN, CT_DOUT, CT_STATUS, CT_STALL };

static uint64_t us(c6x_sys *s, double t) { return (uint64_t)(t * (double)s->cpu_hz / 1e6); }

static void ulog(c6x_sys *s, const char *fmt, ...) __attribute__((format(printf, 2, 3)));
#include <stdarg.h>
static void ulog(c6x_sys *s, const char *fmt, ...)
{
    c6x_usb *u = &s->usb;
    if (!u->log) return;
    va_list ap;
    va_start(ap, fmt);
    fprintf(u->log, "%9.3f ms  ", (double)cpu_now(&s->cpu) * 1000.0 / (double)s->cpu_hz);
    vfprintf(u->log, fmt, ap);
    fputc('\n', u->log);
    va_end(ap);
    fflush(u->log);
}

static void hexdump(c6x_sys *s, const char *what, const uint8_t *d, int n)
{
    c6x_usb *u = &s->usb;
    if (!u->log) return;
    char line[4096];
    int k = snprintf(line, sizeof line, "%s (%d):", what, n);
    for (int i = 0; i < n && k < (int)sizeof line - 4; i++) k += snprintf(line + k, sizeof line - k, " %02X", d[i]);
    ulog(s, "%s", line);
}

/* ---------------- interrupts ---------------- */
static int q_nonempty(c6x_usb *u, int q) { return q >= 0 && q < USB_NQ && u->q[q].n > 0; }

static void irq_eval(c6x_sys *s, int force)
{
    c6x_usb *u = &s->usb;
    int line = (u->intsrc & u->intmsk) != 0;
    for (int q = 24; q <= 27; q++) line |= q_nonempty(u, q);
    if (line && (!u->line || force)) sys_raise_event(s, USB_EVENT);
    u->line = line;
}

static void core_tx_int(c6x_sys *s, int ep)
{
    c6x_usb *u = &s->usb;
    u->intrtx |= (uint16_t)(1u << ep);
    if (u->intrtxe & (1u << ep)) u->intsrc |= 1u << ep;
    irq_eval(s, 0);
}

static void core_rx_int(c6x_sys *s, int ep)
{
    c6x_usb *u = &s->usb;
    u->intrrx |= (uint16_t)(1u << ep);
    if (u->intrrxe & (1u << ep)) u->intsrc |= 1u << (8 + ep);
    irq_eval(s, 0);
}

static void host_iso_in(c6x_sys *s);

static void core_usb_int(c6x_sys *s, int bit)
{
    c6x_usb *u = &s->usb;
    u->intrusb |= (uint8_t)(1u << bit);
    if (u->intrusbe & (1u << bit)) u->intsrc |= 1u << (16 + bit);
    irq_eval(s, 0);
}

/* ---------------- queue manager ---------------- */
static void q_push(c6x_sys *s, int q, uint32_t v)
{
    c6x_usb *u = &s->usb;
    if (q < 0 || q >= USB_NQ) return;
    usb_queue *Q = &u->q[q];
    if (Q->n >= USB_QDEPTH) { ulog(s, "queue %d overflow", q); return; }
    Q->ring[(Q->head + Q->n) % USB_QDEPTH] = v;
    Q->n++;
    if (q >= 24 && q <= 27) irq_eval(s, 0);
}

static uint32_t q_pop(c6x_sys *s, int q)
{
    c6x_usb *u = &s->usb;
    if (q < 0 || q >= USB_NQ || !u->q[q].n) return 0;
    usb_queue *Q = &u->q[q];
    uint32_t v = Q->ring[Q->head];
    Q->head = (Q->head + 1) % USB_QDEPTH;
    Q->n--;
    if (q >= 24 && q <= 27) irq_eval(s, 0);
    return v;
}

static uint32_t dreg(c6x_usb *u, uint32_t off) { return u->dma[(off - 0x1000) >> 2]; }
static uint32_t txgcr(c6x_usb *u, int ch) { return dreg(u, 0x1800 + 0x20 * ch); }
static uint32_t rxgcr(c6x_usb *u, int ch) { return dreg(u, 0x1808 + 0x20 * ch); }
static uint32_t rxhpcra(c6x_usb *u, int ch) { return dreg(u, 0x180C + 0x20 * ch); }

static uint32_t rd32(c6x_sys *s, uint32_t a) { return mem_rd(&s->mem, a, 4); }
static void wr32(c6x_sys *s, uint32_t a, uint32_t v) { mem_wr(&s->mem, a, 4, v); }

/* ---------------- endpoints ---------------- */
static void ep_reset(c6x_usb *u)
{
    for (int i = 0; i < USB_NEP; i++) {
        usb_ep *e = &u->ep[i];
        e->txcsr = e->rxcsr = e->count = 0;
        e->rxn = e->rxpos = e->txn = 0;
        e->tx_desc = e->tx_len = e->tx_off = 0;
    }
}

static int csr0_dataend;     /* DATAEND written together with the last TXPKTRDY / SERV_RXPKTRDY */

static void csr0_write(c6x_sys *s, uint16_t v, uint16_t mask)
{
    c6x_usb *u = &s->usb;
    usb_ep *e = &u->ep[0];
    uint16_t w = v & mask;
    if (w & (1u << 8)) { e->txn = 0; e->rxn = e->rxpos = 0; e->txcsr &= (uint16_t)~3u; }   /* FLUSHFIFO */
    if ((mask & 4) && !(v & 4)) e->txcsr &= (uint16_t)~4u;                                   /* SENTSTALL w0c */
    if (w & (1u << 7)) e->txcsr &= (uint16_t)~(1u << 4);                                     /* SERV_SETUPEND */
    if (w & 8) csr0_dataend = 1;
    if (w & (1u << 6)) {                                                                     /* SERV_RXPKTRDY */
        e->txcsr &= (uint16_t)~1u;
        e->rxn = e->rxpos = 0;
        if (u->ctl_phase == CT_SETUP) {
            int wlen = u->setup[6] | (u->setup[7] << 8);
            if (u->setup[0] & 0x80) u->ctl_phase = wlen ? CT_DIN : CT_STATUS;
            else u->ctl_phase = wlen ? CT_DOUT : CT_STATUS;
        } else if (u->ctl_phase == CT_DOUT) {
            if (u->ctl_out_sent) { u->ctl_phase = CT_STATUS; u->ctl_out_sent = 0; }
        }
    }
    if (w & 2) e->txcsr |= 2;                                                                /* TXPKTRDY */
    if (w & (1u << 5)) { u->ctl_phase = CT_STALL; }                                          /* SENDSTALL */
}

static void txcsr_write(c6x_sys *s, int ep, uint16_t v, uint16_t mask)
{
    usb_ep *e = &s->usb.ep[ep];
    uint16_t keep = (uint16_t)(0xFF00u | (1u << 4));      /* high byte + SENDSTALL are plain storage */
    e->txcsr = (uint16_t)((e->txcsr & ~(mask & keep)) | (v & mask & keep));
    if ((mask & 4) && !(v & 4)) e->txcsr &= (uint16_t)~4u;
    if ((mask & 0x20) && !(v & 0x20)) e->txcsr &= (uint16_t)~0x20u;
    if (v & mask & 8) { e->txn = 0; e->txcsr &= (uint16_t)~3u; }
    if (v & mask & 1) e->txcsr |= 1;
}

static void rxcsr_write(c6x_sys *s, int ep, uint16_t v, uint16_t mask)
{
    usb_ep *e = &s->usb.ep[ep];
    uint16_t keep = (uint16_t)(0xFF00u | (1u << 5));
    e->rxcsr = (uint16_t)((e->rxcsr & ~(mask & keep)) | (v & mask & keep));
    if ((mask & 1) && !(v & 1)) { e->rxcsr &= (uint16_t)~3u; e->rxn = e->rxpos = 0; }   /* packet consumed */
    if ((mask & 4) && !(v & 4)) e->rxcsr &= (uint16_t)~4u;
    if ((mask & 0x40) && !(v & 0x40)) e->rxcsr &= (uint16_t)~0x40u;
    if (v & mask & 0x10) { e->rxn = e->rxpos = 0; e->rxcsr &= (uint16_t)~3u; }
}

/* endpoint register block: o = 0..15 within the block */
static uint8_t epreg_rd8(c6x_usb *u, int ep, int o)
{
    usb_ep *e = &u->ep[ep];
    uint16_t v16;
    switch (o & ~1) {
    case 0: v16 = e->txmaxp; break;
    case 2: v16 = e->txcsr; if (ep && e->txn) v16 |= 2; break;
    case 4: v16 = e->rxmaxp; break;
    case 6: v16 = e->rxcsr; break;
    case 8: v16 = (uint16_t)(e->rxn - e->rxpos); break;
    case 0xA: return o & 1 ? e->txinterval : e->txtype;
    case 0xC: return o & 1 ? e->rxinterval : e->rxtype;
    case 0xE: return o & 1 ? (ep ? (e->fifosize ? e->fifosize : 0x66) : 0x5C) : 0;   /* FIFOSIZE / CONFIGDATA */
    default: v16 = 0;
    }
    return (uint8_t)(o & 1 ? v16 >> 8 : v16);
}

static void epreg_wr(c6x_sys *s, int ep, int o, uint16_t v, uint16_t mask)
{
    usb_ep *e = &s->usb.ep[ep];
    switch (o & ~1) {
    case 0: e->txmaxp = (uint16_t)((e->txmaxp & ~mask) | (v & mask)); break;
    case 2: if (ep == 0) csr0_write(s, v, mask); else txcsr_write(s, ep, v, mask); break;
    case 4: e->rxmaxp = (uint16_t)((e->rxmaxp & ~mask) | (v & mask)); break;
    case 6: if (ep) rxcsr_write(s, ep, v, mask); break;
    case 0xA: if (mask & 0xFF) e->txtype = (uint8_t)v; if (mask & 0xFF00) e->txinterval = (uint8_t)(v >> 8); break;
    case 0xC: if (mask & 0xFF) e->rxtype = (uint8_t)v; if (mask & 0xFF00) e->rxinterval = (uint8_t)(v >> 8); break;
    case 0xE: if (mask & 0xFF) e->fifosize = (uint8_t)v; break;   /* FIFOSZ */
    default: break;
    }
}

/* MUSB core byte read, c = offset from 0x400 */
static uint8_t core_rd8(c6x_sys *s, uint32_t c)
{
    c6x_usb *u = &s->usb;
    uint8_t v;
    switch (c) {
    case 0x00: return u->faddr;
    case 0x01: return u->power;
    case 0x02: v = (uint8_t)u->intrtx; u->intrtx &= 0xFF00; return v;
    case 0x03: v = (uint8_t)(u->intrtx >> 8); u->intrtx &= 0x00FF; return v;
    case 0x04: v = (uint8_t)u->intrrx; u->intrrx &= 0xFF00; return v;
    case 0x05: v = (uint8_t)(u->intrrx >> 8); u->intrrx &= 0x00FF; return v;
    case 0x06: return (uint8_t)u->intrtxe;
    case 0x07: return (uint8_t)(u->intrtxe >> 8);
    case 0x08: return (uint8_t)u->intrrxe;
    case 0x09: return (uint8_t)(u->intrrxe >> 8);
    case 0x0A: v = u->intrusb; u->intrusb = 0; return v;
    case 0x0B: return u->intrusbe;
    case 0x0C: return (uint8_t)u->frame;
    case 0x0D: return (uint8_t)(u->frame >> 8);
    case 0x0E: return u->index;
    case 0x0F: return u->testmode;
    case 0x60: return u->vbus_fault ? (uint8_t)(u->devctl & ~1u) : u->devctl;
    }
    if (c >= 0x10 && c < 0x20) return u->index < USB_NEP ? epreg_rd8(u, u->index, (int)(c - 0x10)) : 0;
    if (c >= 0x100 && c < 0x100 + 16 * USB_NEP) return epreg_rd8(u, (int)((c - 0x100) >> 4), (int)(c & 15));
    return c < sizeof u->core_misc ? u->core_misc[c] : 0;
}

static void core_wr(c6x_sys *s, uint32_t c, int size, uint32_t v)
{
    c6x_usb *u = &s->usb;
    /* 16-bit register pairs are handled as one write so CSR side effects see both bytes */
    for (int i = 0; i < size;) {
        uint32_t o = c + (uint32_t)i;
        uint8_t b = (uint8_t)(v >> (8 * i));
        int pair = (o >= 0x10 && o < 0x1A) || (o >= 0x100 && o < 0x100 + 16 * USB_NEP && (o & 15) < 0xA);
        if (pair) {
            int ep = o < 0x20 ? u->index : (int)((o - 0x100) >> 4);
            int r = (int)((o < 0x20 ? o - 0x10 : o & 15));
            uint16_t mask = (uint16_t)((r & 1) ? 0xFF00 : 0x00FF), val = (uint16_t)((r & 1) ? b << 8 : b);
            int n = 1;
            if (!(r & 1) && i + 1 < size) { mask = 0xFFFF; val = (uint16_t)(v >> (8 * i)); n = 2; }
            if (ep < USB_NEP) epreg_wr(s, ep, r & ~1, val, mask);
            i += n;
            continue;
        }
        switch (o) {
        case 0x00: u->faddr = b & 0x7F; ulog(s, "FADDR <- %d", u->faddr); break;
        case 0x01:
            /* Stock 70CDR 2.10 writes POWER=0x40 at PC C00A2E60 and enumerates
               on the pedal. Use that as the model ground truth: 0x40 attaches. */
            if ((b ^ u->power) & 0x40) ulog(s, "POWER.SOFTCONN %s", (b & 0x40) ? "on" : "off");
            if ((b ^ u->power) & 0x80) ulog(s, "POWER.ISOUPDATE %s", (b & 0x80) ? "on" : "off");
            u->power = b;
            break;
        case 0x06: u->intrtxe = (uint16_t)((u->intrtxe & 0xFF00) | b); break;
        case 0x07: u->intrtxe = (uint16_t)((u->intrtxe & 0x00FF) | (b << 8)); break;
        case 0x08: u->intrrxe = (uint16_t)((u->intrrxe & 0xFF00) | b); break;
        case 0x09: u->intrrxe = (uint16_t)((u->intrrxe & 0x00FF) | (b << 8)); break;
        case 0x0B: u->intrusbe = b; break;
        case 0x0E: u->index = b & 15; break;
        case 0x0F: u->testmode = b; break;
        case 0x02: case 0x03: case 0x04: case 0x05: case 0x0A: case 0x0C: case 0x0D: break;   /* read-only */
        default: if (o < sizeof u->core_misc) u->core_misc[o] = b; break;
        }
        i++;
    }
}

/* FIFO access: size bytes at once */
static uint32_t fifo_rd(c6x_sys *s, int ep, int size)
{
    usb_ep *e = &s->usb.ep[ep];
    uint32_t v = 0;
    for (int i = 0; i < size; i++) {
        uint8_t b = e->rxpos < e->rxn ? e->rx[e->rxpos++] : 0;
        v |= (uint32_t)b << (8 * i);
    }
    return v;
}

static void fifo_wr(c6x_sys *s, int ep, int size, uint32_t v)
{
    usb_ep *e = &s->usb.ep[ep];
    for (int i = 0; i < size; i++)
        if (e->txn < USB_FIFO) e->tx[e->txn++] = (uint8_t)(v >> (8 * i));
}

/* ---------------- register interface ---------------- */
uint32_t usb_read(c6x_sys *s, uint32_t addr, int size)
{
    c6x_usb *u = &s->usb;
    uint32_t off = addr - 0x01E00000u, v = 0;
    if (off < 0x400) {
        switch (off & ~3u) {
        case 0x00: v = 0x4EA11003; break;                 /* REVID */
        case 0x04: v = u->ctrlr; break;
        case 0x08: v = 1; break;                          /* STATR: DRVVBUS */
        case 0x10: v = u->mode; break;
        case 0x20: v = u->intsrc; break;
        case 0x2C: v = u->intmsk; break;
        case 0x38: v = u->intsrc & u->intmsk; break;
        default: v = 0; break;
        }
    } else if (off < 0x1000) {
        uint32_t c = off - 0x400;
        if (c >= 0x20 && c < 0x20 + 4 * USB_NEP) return fifo_rd(s, (int)((c - 0x20) >> 2), size);
        for (int i = 0; i < size; i++) v |= (uint32_t)core_rd8(s, c + (uint32_t)i) << (8 * i);
        return v;
    } else if (off < 0x2000) {
        v = u->dma[((off & ~3u) - 0x1000) >> 2];
    } else if (off >= 0x4090 && off < 0x4098) {
        int base = (int)((off - 0x4090) >> 2) * 32;
        for (int k = 0; k < 32; k++) if (q_nonempty(u, base + k)) v |= 1u << k;
    } else if (off >= 0x6000 && off < 0x6000 + 16 * USB_NQ) {
        int q = (int)((off - 0x6000) >> 4);
        if ((off & 15) == 0xC) v = q_pop(s, q);
    } else if (off >= 0x7000 && off < 0x7000 + 16 * USB_NQ) {
        int q = (int)((off - 0x7000) >> 4);
        if ((off & 15) == 0) v = u->q[q].n;
    }
    if (size == 1) return (v >> (8 * (off & 3))) & 0xFF;
    if (size == 2) return (v >> (8 * (off & 2))) & 0xFFFF;
    return v;
}

void usb_write(c6x_sys *s, uint32_t addr, int size, uint32_t val)
{
    c6x_usb *u = &s->usb;
    uint32_t off = addr - 0x01E00000u;
    if (off >= 0x400 && off < 0x1000) {
        uint32_t c = off - 0x400;
        if (c >= 0x20 && c < 0x20 + 4 * USB_NEP) { fifo_wr(s, (int)((c - 0x20) >> 2), size, val); return; }
        core_wr(s, c, size, val);
        irq_eval(s, 0);
        return;
    }
    if (size != 4) {   /* other blocks are 32-bit registers */
        uint32_t sh = 8 * (off & 3);
        val <<= sh;
        off &= ~3u;
    }
    if (off < 0x400) {
        switch (off) {
        case 0x04:
            u->ctrlr = val & ~1u;
            if (val & 1) { ep_reset(u); u->intsrc = 0; u->intrtx = u->intrrx = 0; u->intrusb = 0; }
            break;
        case 0x10: u->mode = val; break;
        case 0x24: u->intsrc |= val; break;
        case 0x28: u->intsrc &= ~val; break;
        case 0x2C: u->intmsk = val; break;
        case 0x30: u->intmsk |= val; break;
        case 0x34: u->intmsk &= ~val; break;
        case 0x3C: irq_eval(s, 1); return;                  /* EOIR: re-raise if still pending */
        default: break;
        }
        irq_eval(s, 0);
    } else if (off < 0x2000) {
        u->dma[(off - 0x1000) >> 2] = val;
        if (off >= 0x1800 && off < 0x1880 && (off & 0x1F) <= 0x08 && (val & 0x80000000u))
            ulog(s, "CPPI %s channel %d enabled: %08X", (off & 8) ? "Rx" : "Tx", (int)((off - 0x1800) >> 5), val);
    } else if (off >= 0x6000 && off < 0x6000 + 16 * USB_NQ) {
        if ((off & 15) == 0xC) q_push(s, (int)((off - 0x6000) >> 4), val);
    }
}

/* ---------------- CPPI data movement ---------------- */
/* host OUT packet to endpoint ep: 1 = accepted, 0 = NAK */
static int dev_rx_packet(c6x_sys *s, int ep, const uint8_t *d, int n)
{
    c6x_usb *u = &s->usb;
    usb_ep *e = &u->ep[ep];
    int ch = ep - 1;
    if (ch >= 0 && ch < 4 && (rxgcr(u, ch) & 0x80000000u)) {
        int fdq = (int)(rxhpcra(u, ch) & 0x3FFF) & 0xFFF;
        uint32_t dv = q_pop(s, fdq);
        if (!dv) return 0;                                   /* starved: NAK, retry later */
        uint32_t da = dv & ~31u;
        uint32_t buf = rd32(s, da + 28), blen = rd32(s, da + 24) & 0x3FFFFF;
        int m = n < (int)blen ? n : (int)blen;
        for (int i = 0; i < m; i++) mem_wr(&s->mem, buf + (uint32_t)i, 1, d[i]);
        cache_dma_write(&s->cache, buf, (uint32_t)m);
        wr32(s, da + 0, (16u << 27) | (uint32_t)m);
        wr32(s, da + 4, ((uint32_t)ep << 27) | ((uint32_t)ch << 21) | (rd32(s, da + 4) & 0xFFFF));
        uint32_t w2 = rd32(s, da + 8) & ~(1u << 19);
        if (!m) w2 |= 1u << 19;
        wr32(s, da + 8, w2);
        wr32(s, da + 12, (rd32(s, da + 12) & ~0x3FFFFFu) | (uint32_t)m);
        wr32(s, da + 16, buf);
        q_push(s, (int)(rxgcr(u, ch) & 0xFFF), dv);
        return 1;
    }
    if (e->rxcsr & 1) return 0;                              /* PIO: previous packet not read */
    memcpy(e->rx, d, (size_t)n);
    e->rxn = (uint32_t)n;
    e->rxpos = 0;
    e->rxcsr |= 1;
    core_rx_int(s, ep);
    return 1;
}

/* host IN token on endpoint ep: returns bytes (0..mps) or -1 for NAK */
static int dev_tx_packet(c6x_sys *s, int ep, uint8_t *d, int mps)
{
    c6x_usb *u = &s->usb;
    usb_ep *e = &u->ep[ep];
    int ch = ep - 1;
    if (!e->tx_desc && ch >= 0 && ch < 4 && (txgcr(u, ch) & 0x80000000u)) {
        uint32_t dv = q_pop(s, 16 + 2 * ch);
        if (!dv) dv = q_pop(s, 17 + 2 * ch);
        if (dv) {
            e->tx_desc = dv;
            e->tx_len = rd32(s, (dv & ~31u)) & 0x3FFFFF;
            e->tx_off = 0;
        }
    }
    if (e->tx_desc) {
        uint32_t da = e->tx_desc & ~31u;
        int n = (int)(e->tx_len - e->tx_off);
        if (n > mps) n = mps;
        /* walk the buffer chain (w3 length, w4 pointer, w5 next) */
        uint32_t off = e->tx_off, cur = da;
        for (int i = 0; i < n; i++) {
            uint32_t o = off + (uint32_t)i, c2 = cur, base = 0;
            while (c2) {
                uint32_t bl = rd32(s, c2 + 12) & 0x3FFFFF;
                if (o < base + bl) break;
                base += bl;
                c2 = rd32(s, c2 + 20) & ~31u;
            }
            d[i] = c2 ? (uint8_t)mem_rd(&s->mem, rd32(s, c2 + 16) + (o - base), 1) : 0;
        }
        e->tx_off += (uint32_t)n;
        if (e->tx_off >= e->tx_len) {
            uint32_t rq = rd32(s, da + 8) & 0xFFF;
            if (!rq) rq = txgcr(u, ch) & 0xFFF;
            uint32_t dv = e->tx_desc;
            e->tx_desc = 0;
            q_push(s, (int)rq, dv);
        }
        return n;
    }
    if (e->txcsr & 1) {
        int n = (int)e->txn > mps ? mps : (int)e->txn;
        memcpy(d, e->tx, (size_t)n);
        e->txn = 0;
        e->txcsr &= (uint16_t)~3u;
        core_tx_int(s, ep);
        return n;
    }
    return -1;
}

/* ---------------- host: control transfers ---------------- */
static void host_setup(c6x_sys *s, const uint8_t setup[8])
{
    c6x_usb *u = &s->usb;
    usb_ep *e = &u->ep[0];
    memcpy(u->setup, setup, 8);
    memcpy(e->rx, setup, 8);
    e->rxn = 8;
    e->rxpos = 0;
    e->txn = 0;
    e->txcsr = 1;                       /* RXPKTRDY */
    csr0_dataend = 0;
    u->ctl_len = 0;
    u->ctl_out_len = u->ctl_out_sent = 0;
    u->ctl_phase = CT_SETUP;
    u->ctl_deadline = cpu_now(&s->cpu) + us(s, 500000);
    hexdump(s, "SETUP", setup, 8);
    core_tx_int(s, 0);
}

static void host_setup_out(c6x_sys *s, const uint8_t setup[8], const uint8_t *data, int len)
{
    c6x_usb *u = &s->usb;
    host_setup(s, setup);
    if (len > (int)sizeof u->ctl_out) len = (int)sizeof u->ctl_out;
    u->ctl_out_len = len;
    if (len > 0) memcpy(u->ctl_out, data, (size_t)len);
}

/* advance the current control transfer; returns 1 when it finished (ok or not) */
static int host_ctl_step(c6x_sys *s, int *ok)
{
    c6x_usb *u = &s->usb;
    usb_ep *e = &u->ep[0];
    int wlen = u->setup[6] | (u->setup[7] << 8);
    *ok = 0;
    if (cpu_now(&s->cpu) > u->ctl_deadline) { ulog(s, "control transfer timeout (phase %d)", u->ctl_phase); u->ctl_phase = CT_IDLE; return 1; }
    switch (u->ctl_phase) {
    case CT_STALL:
        e->txcsr |= 4;                  /* SENTSTALL */
        e->txcsr &= (uint16_t)~2u;
        ulog(s, "  STALL");
        core_tx_int(s, 0);
        u->ctl_phase = CT_IDLE;
        return 1;
    case CT_DIN:
        if (e->txcsr & 2) {
            int n = (int)e->txn;
            if (u->ctl_len + n > (int)sizeof u->ctl_buf) n = (int)sizeof u->ctl_buf - u->ctl_len;
            memcpy(u->ctl_buf + u->ctl_len, e->tx, (size_t)n);
            u->ctl_len += n;
            e->txn = 0;
            e->txcsr &= (uint16_t)~2u;
            if (csr0_dataend || n < FS_MPS0 || u->ctl_len >= wlen) {   /* last packet + status OUT */
                csr0_dataend = 0;
                core_tx_int(s, 0);
                hexdump(s, "  IN data", u->ctl_buf, u->ctl_len);
                u->ctl_phase = CT_IDLE;
                *ok = 1;
                return 1;
            }
            core_tx_int(s, 0);
        }
        return 0;
    case CT_STATUS:
        if (csr0_dataend) {             /* status IN (zero-length) done */
            csr0_dataend = 0;
            core_tx_int(s, 0);
            ulog(s, "  status ok");
            u->ctl_phase = CT_IDLE;
            *ok = 1;
            return 1;
        }
        return 0;
    case CT_DOUT:
        if (!u->ctl_out_sent) {
            int n = u->ctl_out_len;
            if (n > FS_MPS0) n = FS_MPS0;
            memcpy(e->rx, u->ctl_out, (size_t)n);
            e->rxn = (uint32_t)n;
            e->rxpos = 0;
            u->ctl_out_sent = 1;
            e->txcsr |= 1;                      /* RXPKTRDY on EP0 */
            core_tx_int(s, 0);
            ulog(s, "  OUT data stage offered, waiting for firmware SERV_RXPKTRDY");
            hexdump(s, " OUT data", u->ctl_out, n);
            return 0;
        }
        if (u->ctl_phase == CT_STATUS && csr0_dataend) { /* SERV_RXPKTRDY seen + status IN */
            csr0_dataend = 0;
            core_tx_int(s, 0);
            u->ctl_out_sent = 0;
            ulog(s, "  OUT data consumed by firmware, status ok");
            u->ctl_phase = CT_IDLE;
            *ok = 1;
            return 1;
        }
        return 0;
    default:
        return 0;
    }
}

/* enumeration script; returns 1 when there is nothing more to do */
static void host_enum(c6x_sys *s)
{
    c6x_usb *u = &s->usb;
    static const uint8_t get_dev64[8] = { 0x80, 6, 0, 1, 0, 0, 64, 0 };
    static const uint8_t set_addr[8] = { 0x00, 5, 7, 0, 0, 0, 0, 0 };
    static const uint8_t get_dev18[8] = { 0x80, 6, 0, 1, 0, 0, 18, 0 };
    static const uint8_t get_cfg9[8] = { 0x80, 6, 0, 2, 0, 0, 9, 0 };
    static const uint8_t get_str0[8] = { 0x80, 6, 0, 3, 0, 0, 255, 0 };
    static const uint8_t set_cfg[8] = { 0x00, 9, 1, 0, 0, 0, 0, 0 };
    static const uint8_t set_iface[8] = { 0x00, 0x0B, 1, 0, 1, 0, 0, 0 };
    static const uint8_t get_cur_freq[8] = { 0xA1, 0x81, 0x00, 0x01, 0x01, 0x01, 0x03, 0x00 };
    static const uint8_t set_cur_freq[8] = { 0x21, 0x01, 0x00, 0x01, 0x01, 0x01, 0x03, 0x00 };
    static const uint8_t freq44100[3] = { 0x44, 0xAC, 0x00 };
    uint8_t req[8];
    int ok;

    if (u->ctl_phase != CT_IDLE) {
        if (!host_ctl_step(s, &ok)) return;
        switch (u->ctl_step) {
        case 1: if (ok) memcpy(u->devdesc, u->ctl_buf, u->ctl_len < 18 ? (size_t)u->ctl_len : 18); break;
        case 2: if (ok) { u->addr = 7; ulog(s, "address 7"); } break;
        case 3:
            if (ok && u->ctl_len >= 18) {
                memcpy(u->devdesc, u->ctl_buf, 18);
                ulog(s, "device: USB %X.%02X class %02X VID %04X PID %04X bcdDevice %04X ep0 %d, %d config(s)",
                     u->devdesc[3], u->devdesc[2], u->devdesc[4], u->devdesc[8] | (u->devdesc[9] << 8),
                     u->devdesc[10] | (u->devdesc[11] << 8), u->devdesc[12] | (u->devdesc[13] << 8), u->devdesc[7], u->devdesc[17]);
            }
            break;
        case 4: if (ok && u->ctl_len >= 4) u->cfglen = u->ctl_buf[2] | (u->ctl_buf[3] << 8); break;
        case 5:
            if (ok) {
                memcpy(u->cfgdesc, u->ctl_buf, (size_t)u->ctl_len);
                u->cfglen = u->ctl_len;
                int iface = -1, alt = -1;
                for (int i = 0; i + 1 < u->cfglen && u->cfgdesc[i]; i += u->cfgdesc[i]) {
                    const uint8_t *dsc = u->cfgdesc + i;
                    if (dsc[1] == 4) {
                        iface = dsc[2]; alt = dsc[3];
                        ulog(s, "interface %d alt %d class %02X/%02X, %d endpoint(s)", iface, alt, dsc[5], dsc[6], dsc[4]);
                    }
                    if (dsc[1] == 5) {
                        int a = dsc[2], mps = dsc[4] | (dsc[5] << 8), type = dsc[3] & 3;
                        const char *kind = type == 1 ? "isochronous" : type == 2 ? "bulk" : type == 3 ? "interrupt" : "control";
                        ulog(s, "endpoint %02X %s, max packet %d", a, kind, mps);
                        if (type == 2) {
                            if (a & 0x80) { u->ep_in = a & 15; u->mps_in = mps; }
                            else { u->ep_out = a & 15; u->mps_out = mps; }
                        } else if (type == 1 && (a & 0x80)) {
                            u->iso_ep = a & 15;
                            u->iso_mps = mps;
                            u->iso_interval = dsc[6] ? dsc[6] : 1;
                            u->iso_alt = alt < 0 ? 1 : alt;
                            ulog(s, "  UAC iso IN ep %d, %d B, interval %d, alt %d", u->iso_ep, u->iso_mps, u->iso_interval, u->iso_alt);
                        }
                    }
                }
            }
            break;
        case 6:
            if (ok && u->ctl_len >= 4) {
                int lang = u->ctl_buf[2] | (u->ctl_buf[3] << 8);
                ulog(s, "language %04X", lang);
            }
            break;
        case 7: case 8: case 9:
            if (ok) {
                char str[128];
                int k = 0;
                for (int i = 2; i + 1 < u->ctl_len && k < 127; i += 2) str[k++] = (char)u->ctl_buf[i];
                str[k] = 0;
                ulog(s, "string %d: \"%s\"", u->setup[2], str);
            }
            break;
        case 10:
            if (ok) {
                u->configured = 1;
                ulog(s, "configured: bulk OUT ep %d (%d B), bulk IN ep %d (%d B)", u->ep_out, u->mps_out, u->ep_in, u->mps_in);
                fprintf(stderr, "USB: enumerated VID %04X PID %04X, configured\n",
                        u->devdesc[8] | (u->devdesc[9] << 8), u->devdesc[10] | (u->devdesc[11] << 8));
                if (u->iso_ep) {
                    u->ctl_step = 11;
                    host_setup(s, set_iface);
                    return;
                }
            }
            break;
        case 11:
            if (ok) {
                u->iso_enabled = 1;
                ulog(s, "SET_INTERFACE iface 1 alt %d -> UAC streaming on", u->iso_alt);
                if (u->iso_ep) { u->ctl_step = 12; host_setup(s, get_cur_freq); return; }
            }
            break;
        case 12:
            if (ok) {
                if (u->ctl_len >= 3)
                    ulog(s, "GET_CUR sampling frequency: %02X %02X %02X", u->ctl_buf[0], u->ctl_buf[1], u->ctl_buf[2]);
                else
                    ulog(s, "GET_CUR sampling frequency: status ok, no data from firmware");
                u->ctl_step = 13;
                host_setup_out(s, set_cur_freq, freq44100, 3);
                return;
            }
            break;
        case 13:
            if (ok) ulog(s, "SET_CUR sampling frequency 44100 accepted");
            break;
        }
        u->ctl_wait = 1;
        u->next_tick = cpu_now(&s->cpu) + us(s, 2000);
        return;
    }
    if (u->configured) { u->state = H_RUN; return; }
    switch (++u->ctl_step) {
    case 1: host_setup(s, get_dev64); break;
    case 2: host_setup(s, set_addr); break;
    case 3: host_setup(s, get_dev18); break;
    case 4: host_setup(s, get_cfg9); break;
    case 5:
        memcpy(req, get_cfg9, 8);
        req[6] = (uint8_t)(u->cfglen ? u->cfglen : 9);
        req[7] = (uint8_t)((u->cfglen ? u->cfglen : 9) >> 8);
        host_setup(s, req);
        break;
    case 6: host_setup(s, get_str0); break;
    case 7: case 8: case 9: {
        int idx = u->devdesc[14 + (u->ctl_step - 7)];
        if (!idx) { host_enum(s); return; }
        memcpy(req, get_str0, 8);
        req[2] = (uint8_t)idx;
        req[4] = 0x09; req[5] = 0x04;
        host_setup(s, req);
        break;
    }
    case 10: host_setup(s, set_cfg); break;
    default:
        ulog(s, "enumeration failed");
        u->state = H_RUN;
        break;
    }
}

/* ---------------- host: MIDI ---------------- */
static void midi_out_queue(c6x_usb *u, const uint8_t *m, int n)
{
    /* USB-MIDI 1.0 event packets, cable 0 */
    if (n && m[0] == 0xF0) {
        int i = 0;
        while (n - i > 3) {
            uint8_t p[4] = { 0x04, m[i], m[i + 1], m[i + 2] };
            memcpy(u->outbuf + u->outbuf_n, p, 4); u->outbuf_n += 4; i += 3;
        }
        int r = n - i;
        uint8_t p[4] = { (uint8_t)(0x04 + r), 0, 0, 0 };
        for (int k = 0; k < r; k++) p[1 + k] = m[i + k];
        memcpy(u->outbuf + u->outbuf_n, p, 4); u->outbuf_n += 4;
    } else if (n) {
        uint8_t p[4] = { (uint8_t)(m[0] >> 4), m[0], n > 1 ? m[1] : 0, n > 2 ? m[2] : 0 };
        memcpy(u->outbuf + u->outbuf_n, p, 4); u->outbuf_n += 4;
    }
}

static void midi_in_msg(c6x_sys *s, const uint8_t *m, int n)
{
    c6x_usb *u = &s->usb;
    double t = (double)cpu_now(&s->cpu) * 1000.0 / (double)s->cpu_hz;
    char line[8192];
    int k = snprintf(line, sizeof line, "%9.3f ms  <-", t);
    for (int i = 0; i < n && k < (int)sizeof line - 4; i++) k += snprintf(line + k, sizeof line - k, " %02X", m[i]);
    u->nin++;
    if (u->midilog) { fprintf(u->midilog, "%s\n", line); fflush(u->midilog); }
    if (n > 32) snprintf(line + 14 + 3 * 32, 32, " ... (%d B)", n);   /* console: short form */
    printf("MIDI %s\n", line);
}

static void midi_in_bytes(c6x_sys *s, const uint8_t *d, int n)
{
    c6x_usb *u = &s->usb;
    static const int cin_len[16] = { 0, 0, 2, 3, 3, 1, 2, 3, 3, 3, 3, 3, 2, 2, 3, 1 };
    for (int i = 0; i + 4 <= n; i += 4) {
        uint8_t cin = d[i] & 15;
        if (d[i] == 0 && d[i + 1] == 0) continue;            /* padding */
        int len = cin_len[cin];
        if (cin == 4) {
            for (int k = 1; k <= 3; k++) if (u->sysex_n < (int)sizeof u->sysex) u->sysex[u->sysex_n++] = d[i + k];
        } else if (cin >= 5 && cin <= 7 && (u->sysex_n || d[i + 1] == 0xF0)) {
            for (int k = 1; k <= len; k++) if (u->sysex_n < (int)sizeof u->sysex) u->sysex[u->sysex_n++] = d[i + k];
            midi_in_msg(s, u->sysex, u->sysex_n);
            u->sysex_n = 0;
        } else if (len) {
            midi_in_msg(s, d + i + 1, len);
        }
    }
}

static void host_run(c6x_sys *s)
{
    c6x_usb *u = &s->usb;
    uint64_t now = cpu_now(&s->cpu);
    /* due messages -> USB-MIDI bytes */
    while (u->outpos < u->nout && u->out[u->outpos].at <= now && u->outbuf_n + 4 * u->out[u->outpos].len / 3 + 8 < (int)sizeof u->outbuf) {
        usb_msg *m = &u->out[u->outpos];
        if (m->wait && u->awaiting) {
            if (u->nin > u->wait_nin) u->awaiting = 0;
            else if (now > u->wait_deadline) { ulog(s, "no answer within 30 s, sending the next message anyway"); u->awaiting = 0; }
            else break;
        }
        u->outpos++;
        if (u->outpos < u->nout && u->out[u->outpos].wait) {
            u->awaiting = 1;
            u->wait_nin = u->nin;
            u->wait_deadline = now + us(s, 30000000);   /* Zoom's updater waits > 9.5 s for an erase */
        }
        char line[8192];
        int k = snprintf(line, sizeof line, "%9.3f ms  ->", (double)now * 1000.0 / (double)s->cpu_hz);
        for (int i = 0; i < m->len && k < (int)sizeof line - 4; i++) k += snprintf(line + k, sizeof line - k, " %02X", m->data[i]);
        if (u->midilog) { fprintf(u->midilog, "%s\n", line); fflush(u->midilog); }
        printf("MIDI %s\n", line);
        midi_out_queue(u, m->data, m->len);
    }
    /* bulk OUT: one packet per tick */
    if (u->outbuf_n && u->ep_out) {
        int n = u->outbuf_n > u->mps_out ? u->mps_out : u->outbuf_n;
        n &= ~3;
        if (dev_rx_packet(s, u->ep_out, u->outbuf, n)) {
            memmove(u->outbuf, u->outbuf + n, (size_t)(u->outbuf_n - n));
            u->outbuf_n -= n;
        }
    }
    /* bulk IN poll */
    if (u->ep_in) {
        uint8_t d[512];
        for (int k = 0; k < 4; k++) {
            int n = dev_tx_packet(s, u->ep_in, d, u->mps_in ? u->mps_in : 64);
            if (n < 0) break;
            midi_in_bytes(s, d, n);
            if (n < (u->mps_in ? u->mps_in : 64)) break;
        }
    }
}

/* ---------------- host scheduler ---------------- */
void usb_sync(c6x_sys *s)
{
    c6x_usb *u = &s->usb;
    if (!u->enabled) return;
    uint64_t now = cpu_now(&s->cpu);
    if (u->state != H_WAIT_CONNECT && u->state != H_RESET && now >= u->next_sof) {
        u->frame = (uint16_t)((u->frame + 1) & 0x7FF);
        core_usb_int(s, 3);                                  /* SOF */
        u->next_sof += us(s, 1000);
        if (u->next_sof <= now) u->next_sof = now + us(s, 1000);
        if (u->iso_enabled && u->iso_ep) u->iso_at = now + us(s, 500);
    }
    if (now < u->next_tick) return;
    u->next_tick = now + us(s, 50);
    switch (u->state) {
    case H_WAIT_CONNECT:
        if (u->vbus_fault) break;                 /* no VBUS: firmware may poll DEVCTL, but SESSION=0 */
        /* Stock 70CDR 2.10 attaches with POWER=0x40; hardware is ground truth. */
        if (u->power & 0x40) {
            if (!u->connect_at) { u->connect_at = now + us(s, 100000); ulog(s, "device attached (SOFTCONN)"); }
            else if (now >= u->connect_at) {
                ulog(s, "bus reset");
                u->faddr = 0;
                ep_reset(u);
                core_usb_int(s, 2);                          /* RESET */
                u->state = H_RESET;
                u->connect_at = now + us(s, 20000);
            }
        }
        break;
    case H_RESET:
        if (now >= u->connect_at) { u->state = H_ENUM; u->next_sof = now; }
        break;
    case H_ENUM:
        host_enum(s);
        break;
    case H_RUN:
        if (u->iso_enabled && u->iso_ep && u->iso_at && now >= u->iso_at) {
            host_iso_in(s);
            u->iso_at = now + us(s, 1000 * (u->iso_interval > 0 ? u->iso_interval : 1));
        }
        host_run(s);
        break;
    }
}

uint64_t usb_next_event(c6x_sys *s)
{
    c6x_usb *u = &s->usb;
    if (!u->enabled) return ~0ULL;
    uint64_t t = u->next_tick;
    if (u->state != H_WAIT_CONNECT && u->state != H_RESET && u->next_sof < t) t = u->next_sof;
    return t;
}

int usb_queue_sysex(c6x_sys *s, uint64_t at, const char *hex, int wait)
{
    c6x_usb *u = &s->usb;
    if (u->nout >= u->outcap) {
        int cap = u->outcap ? 2 * u->outcap : 256;
        usb_msg *n = realloc(u->out, (size_t)cap * sizeof *n);
        if (!n) return -1;
        u->out = n;
        u->outcap = cap;
    }
    usb_msg *m = &u->out[u->nout];
    m->len = 0;
    m->at = at;
    m->wait = wait;
    for (const char *p = hex; *p;) {
        while (*p && !((*p >= '0' && *p <= '9') || (*p >= 'a' && *p <= 'f') || (*p >= 'A' && *p <= 'F'))) p++;
        if (!p[0] || !p[1]) break;
        char b[3] = { p[0], p[1], 0 };
        if (m->len < (int)sizeof m->data) m->data[m->len++] = (uint8_t)strtoul(b, NULL, 16);
        p += 2;
    }
    if (!m->len) return -1;
    /* keep the list sorted by time */
    int i = u->nout++;
    while (i > 0 && u->out[i - 1].at > u->out[i].at) { usb_msg t = u->out[i]; u->out[i] = u->out[i - 1]; u->out[i - 1] = t; i--; }
    return 0;
}

void usb_init(c6x_sys *s)
{
    c6x_usb *u = &s->usb;
    u->enabled = 1;
    u->devctl = 0x99;          /* B-device, VBUS valid, session */
    if (u->vbus_fault) u->devctl &= ~1u;          /* DEVCTL.SESSION=0 */
    u->state = H_WAIT_CONNECT;
    u->next_tick = 0;
    if (!u->log) u->log = fopen("usb.txt", "w");
    if (!u->midilog) u->midilog = fopen("midi.txt", "w");
}

/* UAC1 isochronous IN capture: 44.1 kHz, 16-bit stereo WAV on the host side */
static void wav_le32(FILE *f, uint32_t v) { fwrite(&v, 4, 1, f); }

int usb_iso_wav_open(c6x_sys *s, const char *path)
{
    FILE *f = fopen(path, "wb");
    if (!f) return -1;
    static const uint8_t hdr[44] = {
        'R','I','F','F', 0,0,0,0, 'W','A','V','E', 'f','m','t',' ',
        16,0,0,0, 1,0, 2,0, 0x44,0xAC,0,0, 0x10,0xB1,0x02,0, 4,0, 16,0,
        'd','a','t','a', 0,0,0,0
    };
    fwrite(hdr, 1, sizeof hdr, f);
    s->usb.iso_wav = f;
    s->usb.iso_packets = s->usb.iso_bytes = s->usb.iso_underruns = 0;
    return 0;
}

void usb_iso_wav_close(c6x_sys *s)
{
    FILE *f = s->usb.iso_wav;
    if (!f) return;
    fseek(f, 4, SEEK_SET); wav_le32(f, 36u + s->usb.iso_bytes);
    fseek(f, 40, SEEK_SET); wav_le32(f, s->usb.iso_bytes);
    fclose(f);
    s->usb.iso_wav = NULL;
}

static void host_iso_in(c6x_sys *s)
{
    c6x_usb *u = &s->usb;
    uint8_t d[1024];
    int n = dev_tx_packet(s, u->iso_ep, d, u->iso_mps);
    if (n < 0) {
        n = u->iso_mps;
        memset(d, 0, (size_t)n);
        u->iso_underruns++;
    } else if (n < u->iso_mps) {
        memset(d + n, 0, (size_t)(u->iso_mps - n));
        n = u->iso_mps;
    }
    if (u->iso_wav && n > 0) fwrite(d, 1, (size_t)n, u->iso_wav);
    u->iso_packets++;
    u->iso_bytes += (uint32_t)n;
}

void usb_report(c6x_sys *s, FILE *f)
{
    c6x_usb *u = &s->usb;
    if (!u->enabled) return;
    static const char *st[] = { "waiting for VBUS/SESSION or SOFTCONN", "bus reset", "enumerating", "running" };
    fprintf(f, "USB: %s, %s, MIDI sent %d/%d, received %d message(s)\n", st[u->state],
            u->configured ? "configured" : "not configured", u->outpos, u->nout, u->nin);
    if (u->iso_ep || u->iso_packets)
        fprintf(f, "UAC iso IN: ep %02X, MPS %d, alt %d, streaming %d, packets %u, bytes %u, underruns %u\n",
                (unsigned)(0x80u | (uint32_t)u->iso_ep), u->iso_mps, u->iso_alt, u->iso_enabled,
                (unsigned)u->iso_packets, (unsigned)u->iso_bytes, (unsigned)u->iso_underruns);
}
