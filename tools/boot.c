/* c6xboot: run Zoom MS firmware (main OS AIS image + flash parts from the
   same folder) in the system model.

   usage: c6xboot DIR/129_main_OS.bin [options]
     -s SEC              emulated seconds to run (default 5)
     -press MS:PIN[:DUR[:LVL]]   drive input PIN to LVL (default 0, active low) at MS for DUR ms (default 120)
     -in MS:PIN:LVL      set input PIN to LVL at MS
     -turn MS:PA:PB:N    quadrature encoder on pins PA/PB, N steps (sign = direction)
     -snap MS:FILE.png   LCD snapshot at MS
     -lcd FILE.png       final LCD snapshot (default lcd.png)
     -sine HZ AMP        input signal (main input: AXR5, first slot)
     -sine2 HZ AMP       second input (any other RX serializer: AXR4 = the MS-70CDR's R jack ADC)
     -out FILE.wav       captured output (default out.wav)
     -gpio BANKPAIR HEX  override input register value of a bank pair
     -t CYC [-tl N]      instruction trace from cycle CYC (trace.txt)
     -usb                attach a USB host: enumerates the pedal (usb.txt), MIDI log midi.txt
     -usbwav FILE        capture UAC isochronous IN to WAV (implies -usb)
     -sysex MS:HEX       send a MIDI/SysEx message at MS (implies -usb), e.g. 4000:F07E000601F7
     -midifile FILE      lines "MS HEX..." to send at MS, or "w HEX..." to send after the
                         pedal answered the previous message (# comments)
     -saveflash FILE     write the 4 MB flash image at the end
     -usbout FILE        inject raw host->device bytes into bulk OUT endpoint (implies -usb)
     -nocache            no cache/SDRAM stalls (every access 1 cycle, as before)
     -cachelog           log every cache stall to cache_log.txt (cycle, PC, type, address)
     -cachepen P1:P2:P3:P4   override L1D->L2SRAM, L1D->L2cache, L2 fill, uncached stall cycles
     -flashfast          flash program / erase take no time (default: typical chip times)
     -emif MHZ           SDRAM clock instead of the one from PLL0 / CFGCHIP3 (stock 133.3)
     -adc N              battery ADC reading 0..255 (default 0xF0 = external power)
     -lcdlog             log each LCD page select (page 0 = frame start) with time, PC, B3 (lcdlog.txt)
     -led                log LED (GPIO 0) changes with time and PC (led.txt)
     -dma                log EDMA transfers to dma_log.txt
     -spi                log SPI0 words, device and SCK to spi_log.txt
     -spilimit LCD:FLASH warn when actual SPI0 SCK exceeds these MHz (0 = off)
     -loadflash FILE     load a saved 4 MB flash image before the run
     -gpiolog            log all GPIO pin changes to gpio_log.txt
     -prof T1:T2         PC histogram only in this time window (seconds)
     -call ADDR          log every entry into ADDR: cycle, PC, return address, A4/B4
     -audioload          measure cycles in the L2 ZDL audio dispatcher (after 3 s)
     -watch ADDR:VAL     log (and stop) when the 32-bit word at ADDR equals VAL
     -mmiohist           summarize mmio.txt by register address (use with -m)
     -regtrace FILE      log every register write: cycle, reg, old->new, PC (regtrace file)
     -brtrace FILE       log every branch: cycle, from, to, kind (imm/irp/nrp)
     -regrecord FILE     record register writes to file (like -regtrace, separate stream)
     -regreplay FILE     replay recorded register writes for debugging
     -spi1fast           SPI1 words instant (old model; default now models shift time)
     -adclog             log SPI1 SPIDAT1/0 writes and GPIO42 ADC CS edges
                         with time, PC, raw value (adc_trace.log)
     -m                  log MMIO writes (mmio.txt)    -w LO HI  log MMIO reads in range
     -ww LO HI CYC       log RAM writes in range from cycle CYC (ww.txt)
     -p ADDR             probe: print A4/B4/A6/B6/B3 at packet ADDR (probe.txt)
     -b ADDR             stop at packet ADDR
     -dump ADDR LEN      hex dump at the end
     -stack ADDR         set B15 at AIS JumpClose (e.g. C00F7000 for DU6 bootmini)
     -cachejump          invalidate L1D/L2/L1P at AIS JumpClose (real bootmini start)
     -bootflash          load AIS from the assembled flash at 0x40000 (host-side BIN/136 path)
     -hwclose            hardware-close start: require SPIFMT writes, model boot-ROM residue
     -romrepaint MS      synthetic boot-logo repaint period for -hwclose (diagnostic only)
     -bootlog            log bootmini checkpoints and FWIMG copy writes to boot_log.txt
     -q                  short report */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../sys.h"

static double g_cyc_per_ms = 300000.0;   /* set by -mhz */
#define MS(x) ((uint64_t)((x) * g_cyc_per_ms))

typedef struct { uint32_t pc; uint32_t n; } hot;

static uint32_t brks[16];
static int nbrks;
static FILE *probef, *wwf;
static uint64_t ww_from;
static int g_cachepen[4] = { -1, -1, -1, -1 };  /* -cachepen overrides: 1D->2SRAM, 1D->2C, L2 fill, uncached */
static FILE *callf;                       /* -call */
static FILE *bootlogf;                    /* -bootlog */
static uint32_t g_calls[16]; static int g_ncalls;
static uint64_t g_prof_from, g_prof_to;   /* -prof window, CPU cycles */
static double g_prof_sec0, g_prof_sec1;   /* as entered, for reporting */
static uint64_t g_prof_samples;
static uint32_t g_watch_addr, g_watch_val; static int g_watch_on, g_watch_hit;
static int g_mmiohist;
static const char *g_loadflash;
static int g_oc_warned;

/* -audioload: cycle-accurate cost of the L2 ZDL dispatcher calls */
typedef struct { uint32_t addr; uint64_t calls, cycles; } audiorec;
static int g_audioload;
static c6x_sys *g_sys;
static uint64_t g_audio_t0 = ~0ULL, g_audio_idle0;
static uint64_t g_audio_start, g_audio_idle_start;
static uint64_t g_audio_busy, g_audio_calls;
static uint32_t g_audio_target;
static int g_audio_active;
static audiorec g_arec[64]; static int g_narec;

static void on_ww(c6x_sys *s, uint32_t addr, int size, uint32_t val)
{
    if (cpu_now(&s->cpu) < ww_from) return;
    fprintf(wwf, "%10llu pc=%08X W%d %08X = %08X\n", (unsigned long long)cpu_now(&s->cpu), s->cpu.cr[CR_PCE1], size, addr, val);
}

static void on_bp(c6x_cpu *c, uint32_t addr)
{
    int audio_addr = 0;
    if (g_audioload) {
        if (addr == 0x1181BE28u) {
            audio_addr = 1;
            if (!g_audio_active && c->cycle >= g_audio_t0) {
                g_audio_active = 1;
                g_audio_start = c->cycle;
                g_audio_idle_start = g_sys ? g_sys->idle_cycles : 0;
                g_audio_target = c->r[1][4];
            }
        } else if (addr == 0x1181BE26u) {
            audio_addr = 1;
            if (g_audio_active) {
                uint64_t d = c->cycle - g_audio_start;
                uint64_t di = g_sys ? (g_sys->idle_cycles > g_audio_idle_start ? g_sys->idle_cycles - g_audio_idle_start : 0) : 0;
                if (di > d) di = d;
                uint64_t busy = d - di;
                g_audio_busy += busy;
                g_audio_calls++;
                int k = 0;
                while (k < g_narec && g_arec[k].addr != g_audio_target) k++;
                if (k == g_narec && g_narec < 64) { g_arec[k].addr = g_audio_target; g_narec++; }
                if (k < g_narec) { g_arec[k].calls++; g_arec[k].cycles += busy; }
                g_audio_active = 0;
            }
        }
    }
    for (int i = 0; i < g_ncalls; i++)
        if (g_calls[i] == addr) {
            fprintf(callf, "%10llu call %08X pc=%08X ret=%08X A4=%08X B4=%08X\n",
                    (unsigned long long)c->cycle, addr, c->cr[CR_PCE1], c->r[1][3], c->r[0][4], c->r[1][4]);
            return;   /* a call probe never stops the run */
        }
    for (int i = 0; i < nbrks; i++) if (brks[i] == addr) { c->bp_hit = 1; return; }
    if (audio_addr) return;
    fprintf(probef ? probef : stdout, "%10llu probe %08X A4=%08X B4=%08X A6=%08X B6=%08X B3=%08X A1=%08X A2=%08X\n",
            (unsigned long long)c->cycle, addr, c->r[0][4], c->r[1][4], c->r[0][6], c->r[1][6], c->r[1][3], c->r[0][1], c->r[0][2]);
}

/* -mmiohist: summarize mmio.txt (written by -m) by register address */
static void mmio_hist(void)
{
    FILE *f = fopen("mmio.txt", "r");
    if (!f) { printf("mmiohist: no mmio.txt (add -m)\n"); return; }
    struct { uint32_t addr, rd, wr; } tab[4096];
    int n = 0;
    char line[256];
    while (fgets(line, sizeof line, f)) {
        char *eq = strstr(line, " = ");
        if (!eq || eq <= line) continue;
        char *p = eq - 1;
        while (p > line && *p != ' ') p--;
        uint32_t a = (uint32_t)strtoul(p + 1, NULL, 16);
        int is_rd = strstr(line, " R ") || strstr(line, " R%");
        int idx = -1;
        for (int i = 0; i < n; i++) if (tab[i].addr == a) { idx = i; break; }
        if (idx < 0 && n < 4096) { idx = n++; tab[idx].addr = a; tab[idx].rd = tab[idx].wr = 0; }
        if (idx >= 0) { if (is_rd) tab[idx].rd++; else tab[idx].wr++; }
    }
    fclose(f);
    uint64_t total = 0;
    for (int i = 0; i < n; i++) total += tab[i].rd + (uint64_t)tab[i].wr;
    printf("mmiohist: %d distinct addresses, %llu total accesses\n", n, (unsigned long long)total);
    for (int k = 0; k < 20; k++) {
        int best = -1;
        for (int i = 0; i < n; i++)
            if (best < 0 || (tab[i].rd + tab[i].wr) > (tab[best].rd + tab[best].wr)) best = i;
        if (best < 0 || !(tab[best].rd + tab[best].wr)) break;
        printf("  %08X reads=%u writes=%u\n", tab[best].addr, tab[best].rd, tab[best].wr);
        tab[best].rd = tab[best].wr = 0;
    }
}

static struct { uint64_t at; char file[256]; } snaps[64];
static int nsnaps;
static uint64_t g_total;

/* -wav: a PCM WAV (16 or 24 bit, first channel) as the main input, looped; replaces -sine */
static int load_input_wav(c6x_sys *s, const char *path)
{
    FILE *f = fopen(path, "rb");
    if (!f) return -1;
    uint8_t h[12], ck[8];
    int ch = 0, bits = 0, ok = 0;
    if (fread(h, 1, 12, f) != 12 || memcmp(h, "RIFF", 4) || memcmp(h + 8, "WAVE", 4)) { fclose(f); return -1; }
    while (fread(ck, 1, 8, f) == 8) {
        uint32_t n = ck[4] | ck[5] << 8 | ck[6] << 16 | (uint32_t)ck[7] << 24;
        if (!memcmp(ck, "fmt ", 4)) {
            uint8_t fm[16];
            if (n < 16 || fread(fm, 1, 16, f) != 16) break;
            ch = fm[2] | fm[3] << 8;
            bits = fm[14] | fm[15] << 8;
            fseek(f, (long)(n - 16 + (n & 1)), SEEK_CUR);
        } else if (!memcmp(ck, "data", 4) && ch && (bits == 16 || bits == 24)) {
            uint32_t bps = bits / 8, frames = n / (bps * ch);
            uint8_t *raw = malloc(n);
            int16_t *in = calloc((size_t)frames * 2, sizeof *in);   /* interleaved: slot 0 = main input */
            if (raw && in && fread(raw, 1, n, f) == n) {
                for (uint32_t k = 0; k < frames; k++)
                    in[2 * k] = (int16_t)(raw[(size_t)k * bps * ch + bps - 2] | raw[(size_t)k * bps * ch + bps - 1] << 8);
                s->asp.in = in;
                s->asp.nin = frames * 2;
                ok = 1;
            }
            free(raw);
            break;
        } else fseek(f, (long)(n + (n & 1)), SEEK_CUR);
    }
    fclose(f);
    return ok ? 0 : -1;
}

/* the firmware changed the core clock: later snapshots and the end keep their wall time */
static void on_clock(c6x_sys *s, uint64_t now, double r)
{
    for (int k = 0; k < nsnaps; k++)
        if (snaps[k].at > now) snaps[k].at = now + (uint64_t)((snaps[k].at - now) * r);
    if (g_total > now) g_total = now + (uint64_t)((g_total - now) * r);
    g_cyc_per_ms *= r;
    fprintf(stderr, "%.3f s: core clock %.1f -> %.1f MHz\n", sys_wall(s), s->cpu_hz / 1e6, s->cpu_hz * r / 1e6);
    if (!g_oc_warned && s->cpu_hz * r > 375e6) {
        g_oc_warned = 1;
        /* Higher core clocks are usable when the LCD/flash dividers are adjusted
           (LCD 1.00 MHz, flash 40.8 MHz at 408 MHz). Older failures at 384/408 MHz
           were caused by the original dividers, not by the core itself. */
        fprintf(stderr, "note: core %.0f MHz, SPI0/SYSCLK2 electrical limits are not modeled; "
                        "current CFW uses safe dividers\n", s->cpu_hz * r / 1e6);
    }
}

int main(int argc, char **argv)
{
    if (argc < 2) { fprintf(stderr, "usage: c6xboot DIR/129_main_OS.bin [options]  (see source header; -adclog = trace ADC SPI1 polls)\n"); return 1; }
    c6x_sys *s = sys_create();
    g_sys = s;
    uint32_t jump_stack = 0;
    int jump_cache = 0, boot_flash = 0, hwclose = 0;
    double rom_repaint = 0;
    if (sys_load_ais(s, argv[1])) { fprintf(stderr, "load failed: %s\n", argv[1]); return 1; }
    /* DSP clock: from the image's PLL setup, -mhz overrides */
    for (int i = 2; i + 1 < argc; i++)
        if (!strcmp(argv[i], "-mhz")) s->cpu_hz = (uint32_t)(atof(argv[i + 1]) * 1e6);
        else if (!strcmp(argv[i], "-emif")) s->emif_force = atof(argv[i + 1]);
    sys_update_clocks(s);
    g_cyc_per_ms = s->cpu_hz / 1000.0;
    fprintf(stderr, "DSP clock %.1f MHz\n", s->cpu_hz / 1e6);
    sys_sdram_check(s, stderr);
    {
        char dir[512];
        snprintf(dir, sizeof dir, "%s", argv[1]);
        char *sl = strrchr(dir, '/'), *bs = strrchr(dir, '\\');
        if (bs > sl) sl = bs;
        if (sl) *sl = 0; else strcpy(dir, ".");
        if (sys_load_flash_parts(s, dir)) fprintf(stderr, "warning: flash image incomplete\n");
    }
    double secs = 5;
    uint64_t trace_from = ~0ULL, trace_len = 2000000;
    const char *lcd = "lcd.png", *wav = "out.wav";
    int quiet = 0;
    for (int i = 2; i < argc; i++) {
        const char *a = argv[i];
        if (!strcmp(a, "-s") && i + 1 < argc) secs = atof(argv[++i]);
        else if (!strcmp(a, "-stack") && i + 1 < argc) jump_stack = (uint32_t)strtoull(argv[++i], NULL, 0);
        else if (!strcmp(a, "-cachejump")) jump_cache = 1;
        else if (!strcmp(a, "-bootflash")) boot_flash = 1;
        else if (!strcmp(a, "-hwclose")) hwclose = 1;
        else if (!strcmp(a, "-romrepaint") && i + 1 < argc) rom_repaint = atof(argv[++i]);
        else if (!strcmp(a, "-bootlog")) bootlogf = fopen("boot_log.txt", "w");
        else if (!strcmp(a, "-t") && i + 1 < argc) trace_from = strtoull(argv[++i], NULL, 0);
        else if (!strcmp(a, "-tl") && i + 1 < argc) trace_len = strtoull(argv[++i], NULL, 0);
        else if (!strcmp(a, "-m")) s->logf = fopen("mmio.txt", "w");
        else if (!strcmp(a, "-led")) s->ledf = fopen("led.txt", "w");
        else if (!strcmp(a, "-lcdlog")) s->lcdf = fopen("lcdlog.txt", "w");
        else if (!strcmp(a, "-adclog")) s->adcf = fopen("adc_trace.log", "w");
        else if (!strcmp(a, "-evlog")) s->evf = fopen("ev_trace.log", "w");
        else if (!strcmp(a, "-q")) quiet = 1;
        else if (!strcmp(a, "-w") && i + 2 < argc) {
            s->watch_lo = (uint32_t)strtoul(argv[++i], NULL, 16);
            s->watch_hi = (uint32_t)strtoul(argv[++i], NULL, 16);
            if (!s->logf) s->logf = fopen("mmio.txt", "w");
        } else if (!strcmp(a, "-ww") && i + 3 < argc) {
            s->mem.wwatch_lo = (uint32_t)strtoul(argv[++i], NULL, 16);
            s->mem.wwatch_hi = (uint32_t)strtoul(argv[++i], NULL, 16);
            ww_from = strtoull(argv[++i], NULL, 0);
            s->mem.on_wwatch = on_ww;
            wwf = fopen("ww.txt", "w");
        } else if (!strcmp(a, "-b") && i + 1 < argc) {
            brks[nbrks++] = s->cpu.bp[s->cpu.nbp++] = (uint32_t)strtoul(argv[++i], NULL, 16);
        } else if (!strcmp(a, "-p") && i + 1 < argc) {
            s->cpu.bp[s->cpu.nbp++] = (uint32_t)strtoul(argv[++i], NULL, 16);
            if (!probef) probef = fopen("probe.txt", "w");
        } else if (!strcmp(a, "-lcd") && i + 1 < argc) lcd = argv[++i];
        else if (!strcmp(a, "-out") && i + 1 < argc) wav = argv[++i];
        else if (!strcmp(a, "-wav") && i + 1 < argc) {
            if (load_input_wav(s, argv[++i])) { fprintf(stderr, "cannot read %s (PCM 16/24 bit)\n", argv[i]); return 1; }
        } else if (!strcmp(a, "-sine2") && i + 2 < argc) {
            s->asp.gen2_freq = atof(argv[++i]);
            s->asp.gen2_amp = atof(argv[++i]);
        } else if (!strcmp(a, "-sine") && i + 2 < argc) {
            s->asp.gen_freq = atof(argv[++i]);
            s->asp.gen_amp = atof(argv[++i]);
        } else if (!strcmp(a, "-usb")) {
            usb_init(s);
        } else if (!strcmp(a, "-usbwav") && i + 1 < argc) {
            if (!s->usb.enabled) usb_init(s);
            if (usb_iso_wav_open(s, argv[++i])) { fprintf(stderr, "cannot open %s for UAC WAV\n", argv[i]); return 1; }
        } else if (!strcmp(a, "-sysex") && i + 1 < argc) {
            double t; char *colon = strchr(argv[++i], ':');
            if (!s->usb.enabled) usb_init(s);
            if (colon && sscanf(argv[i], "%lf", &t) == 1) usb_queue_sysex(s, MS(t), colon + 1, 0);
        } else if (!strcmp(a, "-usbout") && i + 1 < argc) {
            FILE *uf = fopen(argv[++i], "rb");
            if (!s->usb.enabled) usb_init(s);
            if (!uf) { fprintf(stderr, "cannot open %s\n", argv[i]); return 1; }
            uint8_t buf[1024]; size_t got;
            while ((got = fread(buf, 1, sizeof buf, uf)) > 0) {
                c6x_usb *u = &s->usb;
                if (u->nout >= u->outcap) {
                    int cap = u->outcap ? 2 * u->outcap : 256;
                    usb_msg *n = realloc(u->out, (size_t)cap * sizeof *n);
                    if (!n) { fprintf(stderr, "usbout: oom\n"); fclose(uf); return 1; }
                    u->out = n; u->outcap = cap;
                }
                usb_msg *m = &u->out[u->nout++];
                m->len = 0; m->at = 0; m->wait = 0;
                for (size_t k = 0; k < got && m->len < (int)sizeof m->data; k++)
                    m->data[m->len++] = buf[k];
            }
            fclose(uf);
        } else if (!strcmp(a, "-midifile") && i + 1 < argc) {
            FILE *mf = fopen(argv[++i], "r");
            char line[8192];
            if (!s->usb.enabled) usb_init(s);
            if (!mf) { fprintf(stderr, "cannot open %s\n", argv[i]); return 1; }
            double tlast = 0;
            while (fgets(line, sizeof line, mf)) {
                double t; int n = 0;
                if (line[0] == '#') continue;
                if (line[0] == 'w' || line[0] == 'W') {
                    if (usb_queue_sysex(s, MS(tlast), line + 1, 1)) fprintf(stderr, "midifile: message not queued: %.40s\n", line);
                    continue;
                }
                if (sscanf(line, "%lf%n", &t, &n) != 1) continue;
                usb_queue_sysex(s, MS(t), line + n, 0);
                tlast = t;
            }
            fclose(mf);
        } else if (!strcmp(a, "-loadflash") && i + 1 < argc) {
            g_loadflash = argv[++i];
        } else if (!strcmp(a, "-flashfast")) {
            s->fl_instant = 1;
        } else if (!strcmp(a, "-spi1fast")) {
            s->spi1_timing = 0;
        } else if (!strcmp(a, "-nocache")) {
            s->cpu.cache = NULL;
        } else if (!strcmp(a, "-cachelog")) {
            if (s->cpu.cache) {
                s->cpu.cache->logf = fopen("cache_log.txt", "w");
                /* optional -cachelog 1.0:2.0 = log only this wall-time window (seconds) */
                if (i + 1 < argc && strchr(argv[i + 1], ':')) {
                    double t0 = 0, t1 = 0;
                    if (sscanf(argv[++i], "%lf:%lf", &t0, &t1) == 2) {
                        s->cpu.cache->log_from = (uint64_t)(t0 * g_cyc_per_ms * 1000.0);
                        s->cpu.cache->log_to = (uint64_t)(t1 * g_cyc_per_ms * 1000.0);
                    }
                }
            }
        } else if (!strcmp(a, "-gpiolog")) {
            s->gpiolf = fopen("gpio_log.txt", "w");
        } else if (!strcmp(a, "-dma")) {
            s->dmalf = fopen("dma_log.txt", "w");
        } else if (!strcmp(a, "-spi")) {
            s->spilf = fopen("spi_log.txt", "w");
        } else if (!strcmp(a, "-spilimit") && i + 1 < argc) {
            double lcd = 0, flash = 0;
            if (sscanf(argv[++i], "%lf:%lf", &lcd, &flash) == 2) {
                s->spi_lcd_max = lcd; s->spi_flash_max = flash;
            }
        } else if (!strcmp(a, "-call") && i + 1 < argc && g_ncalls < 16) {
            g_calls[g_ncalls++] = (uint32_t)strtoul(argv[++i], NULL, 16);
            if (!callf) callf = fopen("call_log.txt", "w");
        } else if (!strcmp(a, "-audioload")) {
            g_audioload = 1;
            if (s->cpu.nbp + 2 <= 16) {
                s->cpu.bp[s->cpu.nbp++] = 0x1181BE28u;
                s->cpu.bp[s->cpu.nbp++] = 0x1181BE26u;
            } else fprintf(stderr, "-audioload: no free breakpoint slots\n");
        } else if (!strcmp(a, "-prof") && i + 1 < argc) {
            double t0 = 0, t1 = 0;
            if (sscanf(argv[++i], "%lf:%lf", &t0, &t1) == 2) {
                g_prof_from = (uint64_t)(t0 * g_cyc_per_ms * 1000.0);
                g_prof_to = (uint64_t)(t1 * g_cyc_per_ms * 1000.0);
                g_prof_sec0 = t0; g_prof_sec1 = t1;
            }
        } else if (!strcmp(a, "-watch") && i + 1 < argc) {
            if (sscanf(argv[++i], "%x:%x", &g_watch_addr, &g_watch_val) == 2) g_watch_on = 1;
        } else if (!strcmp(a, "-mmiohist")) {
           g_mmiohist = 1;
        } else if (!strcmp(a, "-regtrace") && i + 1 < argc) {
            s->cpu.regtrace = 1;
            s->cpu.regtracef = fopen(argv[++i], "w");
            if (!s->cpu.regtracef) { fprintf(stderr, "cannot open %s\n", argv[i]); return 1; }
        } else if (!strcmp(a, "-brtrace") && i + 1 < argc) {
            s->cpu.brtrace = 1;
            s->cpu.brtracef = fopen(argv[++i], "w");
            if (!s->cpu.brtracef) { fprintf(stderr, "cannot open %s\n", argv[i]); return 1; }
        } else if (!strcmp(a, "-regrecord") && i + 1 < argc) {
            s->cpu.regrecord = 1;
            s->cpu.regrecordf = fopen(argv[++i], "w");
            if (!s->cpu.regrecordf) { fprintf(stderr, "cannot open %s\n", argv[i]); return 1; }
        } else if (!strcmp(a, "-regreplay") && i + 1 < argc) {
            s->cpu.regreplay = 1;
            s->cpu.regreplayf = fopen(argv[++i], "r");
            if (!s->cpu.regreplayf) { fprintf(stderr, "cannot open %s\n", argv[i]); return 1; }
        } else if (!strcmp(a, "-cachepen") && i + 1 < argc) {
            char spec[128]; snprintf(spec, sizeof spec, "%s", argv[++i]);
            int n = sscanf(spec, "%d:%d:%d:%d", &g_cachepen[0], &g_cachepen[1], &g_cachepen[2], &g_cachepen[3]);
            if (n != 4) { fprintf(stderr, "-cachepen needs P1:P2:P3:P4\n"); return 1; }
        } else if (!strcmp(a, "-emif") && i + 1 < argc) {
            i++;                                    /* read above, before the run */
        } else if (!strcmp(a, "-adc") && i + 1 < argc) {
            s->adc_value = (uint32_t)strtoul(argv[++i], NULL, 0);
        } else if (!strcmp(a, "-gpio") && i + 2 < argc) {
            int k = atoi(argv[++i]);
            s->gpio_in[k] = (uint32_t)strtoul(argv[++i], NULL, 16);
        } else if (!strcmp(a, "-in") && i + 1 < argc) {
            double t; int pin, lvl;
            if (sscanf(argv[++i], "%lf:%d:%d", &t, &pin, &lvl) == 3) sys_schedule_input(s, MS(t), pin, lvl);
        } else if (!strcmp(a, "-press") && i + 1 < argc) {
            double t, dur = 120; int pin, lvl = 0;   /* keys and footswitch are active low */
            int n = sscanf(argv[++i], "%lf:%d:%lf:%d", &t, &pin, &dur, &lvl);
            if (n >= 2) { sys_schedule_input(s, MS(t), pin, lvl); sys_schedule_input(s, MS(t + dur), pin, !lvl); }
        } else if (!strcmp(a, "-turn") && i + 1 < argc) {
            double t; int pa, pb, steps;
            if (sscanf(argv[++i], "%lf:%d:%d:%d", &t, &pa, &pb, &steps) == 4) {
                /* One step = one detent = half a quadrature cycle: the pedal's encoders rest
                   at 11 or 00 (pin dump at rest). From the pins' current levels, + moves A
                   first then B, - moves B first; 2 ms per edge. Levels are tracked across
                   -turn options, so consecutive turns continue where the last one ended. */
                static int lvl[256], known[256];
                if (pa < 0 || pa > 255 || pb < 0 || pb > 255) continue;
                for (int p = 0; p < 2; p++) {
                    int pin = p ? pb : pa;
                    if (!known[pin]) { lvl[pin] = (s->gpio_in[pin / 32] >> (pin % 32)) & 1; known[pin] = 1; }
                }
                int n = steps < 0 ? -steps : steps;
                int first = steps < 0 ? pb : pa, second = steps < 0 ? pa : pb;
                for (int k = 0; k < n; k++) {
                    lvl[first] ^= 1;
                    sys_schedule_input(s, MS(t + 4.0 * k), first, lvl[first]);
                    lvl[second] ^= 1;
                    sys_schedule_input(s, MS(t + 4.0 * k + 2.0), second, lvl[second]);
                }
            }
        } else if (!strcmp(a, "-snap") && i + 1 < argc && nsnaps < 64) {
            double t; char f[256];
            if (sscanf(argv[++i], "%lf:%255s", &t, f) == 2) { snaps[nsnaps].at = MS(t); strcpy(snaps[nsnaps].file, f); nsnaps++; }
        } else if (!strcmp(a, "-dump")) i += 2;
        else if (!strcmp(a, "-fb") || !strcmp(a, "-mhz") || !strcmp(a, "-saveflash")) i += 1;
        else if (a[0] == '-') { fprintf(stderr, "unknown option %s\n", a); return 1; }
        else secs = atof(a) / 300.0;  /* legacy: Mcycles */
    }
    if (bootlogf) s->bootlogf = bootlogf;
    sys_set_hwclose(s, hwclose, rom_repaint);
    sys_set_jump_stack(s, jump_stack);
    sys_set_jump_cache(s, jump_cache);
    sys_hwclose_jump_reset(s);
    if (rom_repaint > 0) s->hw_rom_repaint_ms = rom_repaint;
    if (hwclose && s->cpu.cache) {
        s->cpu.cache->hw_lcd_failed = s->hw_lcd_failed;
        s->cpu.cache->hw_pending_irq = s->hw_pending_irq;
        s->cpu.cache->hw_irq_seen = s->hw_irq_seen;
        s->cpu.cache->hw_spifmt0_written = s->hw_spifmt0_written;
        s->cpu.cache->hw_spifmt1_written = s->hw_spifmt1_written;
        s->cpu.cache->hw_edma_seen = s->hw_edma_seen;
        s->cpu.cache->hw_mcasp_seen = s->hw_mcasp_seen;
        s->cpu.cache->hw_usb_seen = s->hw_usb_seen;
        s->cpu.cache->hw_residual = s->hw_residual;
        s->cpu.cache->hw_repaints = s->hw_repaints;
        s->cpu.cache->hw_residual_cycles = s->hw_residual_cycles;
    }
    if (s->cpu.cache) {
        if (g_cachepen[0] >= 0) s->cpu.cache->p_l1d_l2sram = g_cachepen[0];
        if (g_cachepen[1] >= 0) s->cpu.cache->p_l1d_l2c = g_cachepen[1];
        if (g_cachepen[2] >= 0) s->cpu.cache->p_l2_fill = g_cachepen[2];
        if (g_cachepen[3] >= 0) s->cpu.cache->p_uncached = g_cachepen[3];
        if (g_cachepen[0] >= 0 || g_cachepen[1] >= 0 || g_cachepen[2] >= 0 || g_cachepen[3] >= 0)
            fprintf(stderr, "cache penalties: 1D2SRAM=%d 1D2C=%d L2FILL=%d UNCACHED=%d\n",
                    s->cpu.cache->p_l1d_l2sram, s->cpu.cache->p_l1d_l2c,
                    s->cpu.cache->p_l2_fill, s->cpu.cache->p_uncached);
    }
    if (g_loadflash) {
        FILE *ff = fopen(g_loadflash, "rb");
        if (!ff) { fprintf(stderr, "loadflash: cannot open %s\n", g_loadflash); return 1; }
        size_t got = fread(s->flash, 1, s->flash_size, ff);
        fclose(ff);
        fprintf(stderr, "loadflash: %s (%zu bytes)\n", g_loadflash, got);
    }
    if (boot_flash) {
        uint32_t flen = 0;
        if (sys_load_ais_from_flash(s, 0x40000, 0xB0000, &flen))
        { fprintf(stderr, "bootflash: no valid AIS at flash 0x40000\n"); return 1; }
        cpu_reset(&s->cpu, s->boot_info_flash.entry);
        sys_set_jump_stack(s, jump_stack);
        sys_set_jump_cache(s, jump_cache);
        fprintf(stderr, "bootflash: parsed AIS from flash 0x40000 (%u bytes), entry 0x%08X, %d section(s)\n",
                flen, s->boot_info_flash.entry, s->boot_info_flash.nsections);
    }
    for (int i = 0; i < g_ncalls; i++) s->cpu.bp[s->cpu.nbp++] = g_calls[i];
    s->cpu.on_bp = on_bp;
    s->on_clock = on_clock;
    g_total = MS(secs * 1000);
    static hot hist[1 << 16];
    uint64_t win_c0 = 0, win_i0 = 0, win_samples = 0, win_idle = 0;
    uint64_t step = 997;
    while (cpu_now(&s->cpu) < g_total && !s->cpu.halted && !s->cpu.bp_hit) {
        if (cpu_now(&s->cpu) >= trace_from && !s->cpu.trace) { s->cpu.trace = 2; s->cpu.tracef = fopen("trace.txt", "w"); }
        if (s->cpu.trace && cpu_now(&s->cpu) >= trace_from + trace_len) { s->cpu.trace = 0; fclose(s->cpu.tracef); s->cpu.tracef = NULL; trace_from = ~0ULL; }
        for (int k = 0; k < nsnaps; k++)
            if (snaps[k].at && cpu_now(&s->cpu) >= snaps[k].at) { sys_lcd_dump_png(s, snaps[k].file, 3); snaps[k].at = 0; }
        if (!win_c0 && cpu_now(&s->cpu) >= MS(3000)) {
            win_c0 = cpu_now(&s->cpu); win_i0 = s->idle_cycles;
            if (g_audioload) { g_audio_t0 = win_c0; g_audio_idle0 = s->idle_cycles; }
        }
        uint64_t n = sys_run(s, step);
        uint32_t pc = s->cpu.pc;
        if (win_c0) {   /* load estimate: PC samples outside the OS idle paths (IDLE, scheduler poll) */
            int idle = pc == 0x1181A8C4u || (pc >= 0xC00D2D82u && pc < 0xC00D2D9Cu) || (pc >= 0xC00E0780u && pc < 0xC00E07E0u);
            win_samples++; win_idle += idle;
        }
        if (g_watch_on && !g_watch_hit && mem_rd(&s->mem, g_watch_addr, 4) == g_watch_val) {
            g_watch_hit = 1;
            printf("watch hit at %llu: [%08X] = %08X pc=%08X\n",
                   (unsigned long long)cpu_now(&s->cpu), g_watch_addr, g_watch_val, pc);
            if (callf) fprintf(callf, "watch hit at %llu\n", (unsigned long long)cpu_now(&s->cpu));
        }
        hot *h = &hist[(pc >> 1) & 0xFFFF];
        if (!g_prof_from || (cpu_now(&s->cpu) >= g_prof_from && cpu_now(&s->cpu) <= g_prof_to)) {
            if (h->pc != pc) { h->pc = pc; h->n = 0; }
            h->n++;
            g_prof_samples++;
        }
        if (n == 0) break;
    }
    c6x_cpu *c = &s->cpu;
    printf("time=%.3fs cycles=%llu (stall %llu) packets=%llu insns=%llu pc=%08X idle=%d halted=%d bp=%d\n",
           sys_wall(s), (unsigned long long)cpu_now(c), (unsigned long long)c->stall_total,
           (unsigned long long)c->packets, (unsigned long long)c->insns, c->pc, c->idle, c->halted, c->bp_hit);
    if (c->cache) cache_report(c->cache, stdout);
    usb_report(s, stdout);
    usb_iso_wav_close(s);
    if (c->err[0]) printf("ERROR: %s\n", c->err);
    if (!quiet) {
        cpu_dump(c, stdout);
        hot top[20] = { 0 };
        for (int i = 0; i < (1 << 16); i++)
            for (int k = 0; k < 20; k++)
                if (hist[i].n > top[k].n) { memmove(&top[k + 1], &top[k], (19 - k) * sizeof(hot)); top[k] = hist[i]; break; }
        printf("hot PCs:\n");
        for (int k = 0; k < 20 && top[k].n; k++) printf("  %08X  %u\n", top[k].pc, top[k].n);
        sys_report_mmio(s, stdout);
    }
    printf("LCD: cmds=%u data=%u contrast=%u  LED(GPIO0)=%u\n", s->lcd_cmds, s->lcd_data, s->lcd_contrast, s->gpio_out[0] & 1);
    if (bootlogf) {
        fprintf(bootlogf, "bootmini: last checkpoint=%d pc=%08X, FWIMG copy %u bytes from %08X to %08X\n",
                s->boot_cp, s->boot_cp_pc, s->boot_copy_bytes, s->boot_copy_first, s->boot_copy_last);
        printf("BOOTMINI: last checkpoint=%d, FWIMG copy %u bytes %08X..%08X -> boot_log.txt\n",
               s->boot_cp, s->boot_copy_bytes, s->boot_copy_first, s->boot_copy_last);
    }
    printf("FLASH: reads=%u writes=%u erases=%u\n", s->fl_reads, s->fl_writes, s->fl_erases);
    printf("SPI0: shifting %.1f ms of %.1f ms; flash program/erase %.1f ms\n", s->spi_busy * 1000.0 / s->cpu_hz,
           cpu_now(&s->cpu) * 1000.0 / s->cpu_hz, s->fl_busy * 1000.0 / s->cpu_hz);
    printf("EDMA: events=%u transfers=%u errors=%u\n", s->edma.events, s->edma.transfers, s->edma.errors);
    printf("AUDIO: frames=%u underruns=%u overruns=%u\n", s->asp.nout / 2, s->asp.underruns, s->asp.overruns);
    if (win_samples)
        printf("DSP load after 3 s: %.1f%% (PC samples outside the OS idle paths; stock 3.10 addresses)\n",
               100.0 * (double)(win_samples - win_idle) / (double)win_samples);
    if (win_c0 && cpu_now(c) > win_c0) {
        uint64_t total = cpu_now(c) - win_c0;
        uint64_t idle = s->idle_cycles > win_i0 ? s->idle_cycles - win_i0 : 0;
        if (idle > total) idle = total;
        printf("DSP load after 3 s: %.1f%% (IDLE cycles; firmware-independent)\n",
               100.0 * (double)(total - idle) / (double)total);
    }
    if (g_audioload && g_audio_t0 != ~0ULL && cpu_now(c) > g_audio_t0) {
        uint64_t total = cpu_now(c) - g_audio_t0;
        uint64_t idle = s->idle_cycles > g_audio_idle0 ? s->idle_cycles - g_audio_idle0 : 0;
        if (idle > total) idle = total;
        uint64_t busy = total - idle;
        printf("AUDIO load after 3 s: %.1f%% of non-idle cycles (%llu calls, %.1f cycles/call)\n",
               busy ? 100.0 * (double)g_audio_busy / (double)busy : 0.0,
               (unsigned long long)g_audio_calls,
               g_audio_calls ? (double)g_audio_busy / (double)g_audio_calls : 0.0);
        for (int i = 0; i < g_narec; i++)
            for (int j = i + 1; j < g_narec; j++)
                if (g_arec[j].cycles > g_arec[i].cycles) {
                    audiorec t = g_arec[i]; g_arec[i] = g_arec[j]; g_arec[j] = t;
                }
        for (int i = 0; i < g_narec && i < 8; i++)
            if (g_arec[i].calls)
                printf("  %08X  %6.1f%%  %llu calls  %.1f cycles/call\n",
                       g_arec[i].addr,
                       busy ? 100.0 * (double)g_arec[i].cycles / (double)busy : 0.0,
                       (unsigned long long)g_arec[i].calls,
                       (double)g_arec[i].cycles / (double)g_arec[i].calls);
    }
    for (int i = 2; i + 1 < argc; i++)
        if (!strcmp(argv[i], "-saveflash")) {
            FILE *ff = fopen(argv[i + 1], "wb");
            if (ff) { fwrite(s->flash, 1, s->flash_size, ff); fclose(ff); }
        }
    sys_lcd_dump_png(s, lcd, 3);
    sys_write_wav(s, wav);
    for (int i = 2; i < argc; i++) {
        if (!strcmp(argv[i], "-fb") && i + 1 < argc) {   /* 1024 B, 8 pages x 128 columns, bit 0 = top pixel */
            FILE *f = fopen(argv[i + 1], "wb");
            if (f) { for (int p = 0; p < 8; p++) fwrite(s->lcd_vram[p] + 4, 1, 128, f); fclose(f); }
        }
    }
    for (int i = 2; i < argc; i++) {
        if (!strcmp(argv[i], "-dump") && i + 2 < argc) {
            uint32_t a = (uint32_t)strtoul(argv[i + 1], NULL, 16), n = (uint32_t)strtoul(argv[i + 2], NULL, 0);
            for (uint32_t k = 0; k < n; k += 4) {
                if ((k & 31) == 0) printf("%s%08X:", k ? "\n" : "", a + k);
                printf(" %08X", mem_rd(&s->mem, a + k, 4));
            }
            printf("\n");
        }
    }
    usb_iso_wav_close(s);
    if (g_mmiohist) mmio_hist();
    if (g_prof_from) printf("profile window: %.3f..%.3f s (%llu samples)\n",
                            g_prof_sec0, g_prof_sec1, (unsigned long long)g_prof_samples);
    if (callf) fclose(callf);
    if (s->gpiolf) fclose(s->gpiolf);
    if (s->dmalf) fclose(s->dmalf);
    if (s->spilf) fclose(s->spilf);
    if (s->logf) fclose(s->logf);
    if (s->evf) fclose(s->evf);
    if (s->adcf) fclose(s->adcf);
    if (s->cpu.regtracef) fclose(s->cpu.regtracef);
    if (s->cpu.brtracef) fclose(s->cpu.brtracef);
    if (s->cpu.regrecordf) fclose(s->cpu.regrecordf);
    if (s->cpu.regreplayf) fclose(s->cpu.regreplayf);
    if (wwf) fclose(wwf);
    if (probef) fclose(probef);
    if (s->cpu.cache && s->cpu.cache->logf) fclose(s->cpu.cache->logf);
    if (c->tracef) fclose(c->tracef);
    return c->halted ? 2 : 0;
}
