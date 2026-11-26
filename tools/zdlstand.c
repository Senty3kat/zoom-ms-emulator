/* c6xzdl: run a ZDL effect's audio function on the emulated C674x with the
   same ctx/params/arena setup as fxlab/tools/zdl_host.c, block by block.

   usage: c6xzdl EFFECT.ZDL in.wav out.f32 [ui1 .. ui9] [options]
     --stwtrace F[,ADDR:LEN]  trace STW writes into the chain buffer (default 11F04100:40)
     --text-base HEX   load ZDL text at HEX (default C0400000; 11E00000 = L1P SRAM)
     --func NAME       audio function (default: the Fx_* symbol)
     --wav FILE        also write a 24-bit stereo WAV
     --off-at S / --on-at S / --at S K=UI   same as zdl_host
     --max-blocks N    stop after N blocks
     --cache MODE      memory timing: l1cold (default: L1P/L1D emptied before every block,
                       as when other effects run in between), warm, cold (L2 too), off
   out.f32 = raw float32, interleaved L R (the chain buffer after each call).
   Prints DSP cycles per 8-sample block (min / avg / max) and the share of the
   block budget (300 MHz / 44.1 kHz * 8 = 54422 cycles). */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../cpu.h"
#include "../cache.h"
#include "../zdl.h"
#include "../ais.h"
#include "../elf.h"

#define TEXT_BASE   0xC0400000u
#define CONST_BASE  0xC0500000u
#define RET_TRAP    0xC0010000u
#define UNDEF_TRAP  0xC0011000u
#define CTX_ADDR    (0x11F03000u + 212u)     /* slot 1, as on the pedal */
#define PARAMS_ADDR 0x11F04000u
#define CHAIN_ADDR  0x11F04100u
#define MAGIC_ADDR  0x11F04200u
#define TABLE_ADDR  0xC00EE430u
#define ARENA_BYTES 705600u
#define ARENA0      0xC022D000u
#define ARENA_SPAN  0xAC440u
#define STACK_TOP   0x1183FFF0u

static int g_zdl_pen[4] = { -1, -1, -1, -1 };  /* --cachepen overrides */

typedef struct { double t; int knob; float ui; } ev_t;

/* Optional firmware-call probe: c6xzdl alone has no OS, so calls to firmware
   addresses would never return. With --probe-fx we trap them, log the actual
   ABI arguments and emulate a return. Default behaviour is unchanged. */
typedef struct { uint32_t pc, a4, b4, a6, b6, a8, b3, a3; uint64_t block; } probe_t;
static probe_t probe_log[4096];
static int nprobe = 0;
static int probe_on = 0;
static int fw_stubs = 0;
/* the emulator compares breakpoints with the 32-byte fetch packet address */
#define BP_ALIGN(a) ((a) & ~31u)

/* Minimal firmware stand-ins so a ZDL can call FX_SET_PARAM etc. in c6xzdl
   without the OS. BNOP B3 returns; the descriptor stub returns A4=0xC05F0000
   (max=100 at +12). Words taken from cl6x disassembly of these stubs. */
static const uint32_t stub_void[] = { 0x008c6362u, 0, 0, 0, 0, 0, 0, 0 };
static const uint32_t stub_desc[] = { 0x008c6362u, 0x0200a358u, 0x02602fe8u, 0, 0, 0, 0, 0 };
static double pedal_t[64];
static uint32_t pedal_v[64];
static int npedal = 0;
static uint32_t pedal_init = 0xFFFFFFFFu;
static const uint32_t DESC_ADDR = 0xC05F0000u;   /* synthetic FX_PARAM_DESC */

static const struct { uint32_t addr; const char *name; } probe_addrs[] = {
    { 0xC00BB600u, "FX_SET_PARAM" },
    { 0xC00B056Cu, "FX_PARAM_DESC" },
    { 0xC00C7EE0u, "SEM_PEND" },
    { 0xC00D6B00u, "SEM_POST" },
    { 0xC00ACD84u, "UI_REFRESH" },
    { 0xC00CBF40u, "EVENT_POST" },
};
#define NPROBE ((int)(sizeof(probe_addrs) / sizeof(probe_addrs[0])))

static const char *probe_name(uint32_t pc)
{
    for (int i = 0; i < NPROBE; i++)
        if (BP_ALIGN(probe_addrs[i].addr) == BP_ALIGN(pc)) return probe_addrs[i].name;
    return NULL;
}

static void arm_bp(c6x_cpu *c)
{
    c->nbp = 0;
    c->bp[c->nbp++] = RET_TRAP;
    c->bp[c->nbp++] = UNDEF_TRAP;
    if (probe_on) for (int i = 0; i < NPROBE; i++) c->bp[c->nbp++] = BP_ALIGN(probe_addrs[i].addr);
}

static float *read_wav(const char *path, int *ch, long *frames, int *fs)
{
    uint32_t len;
    uint8_t *d = read_file(path, &len);
    if (!d || len < 44 || memcmp(d, "RIFF", 4)) return NULL;
    uint32_t pos = 12, fmt = 1, bits = 16;
    *ch = 1; *fs = 44100;
    while (pos + 8 <= len) {
        uint32_t sz = d[pos + 4] | (d[pos + 5] << 8) | (d[pos + 6] << 16) | ((uint32_t)d[pos + 7] << 24);
        const uint8_t *c = d + pos + 8;
        if (!memcmp(d + pos, "fmt ", 4)) {
            fmt = c[0] | (c[1] << 8); *ch = c[2] | (c[3] << 8);
            *fs = c[4] | (c[5] << 8) | (c[6] << 16) | (c[7] << 24); bits = c[14] | (c[15] << 8);
            if (fmt == 0xFFFE && sz >= 26) fmt = c[24] | (c[25] << 8);
        } else if (!memcmp(d + pos, "data", 4)) {
            uint32_t bps = bits / 8;
            long n = (long)(sz / (bps * *ch));
            float *o = malloc(sizeof(float) * n * *ch);
            for (long i = 0; i < n * *ch; i++) {
                const uint8_t *p = c + i * bps;
                float v;
                if (fmt == 3 && bits == 32) memcpy(&v, p, 4);
                else if (bits == 16) v = (int16_t)(p[0] | (p[1] << 8)) / 32768.0f;
                else if (bits == 24) v = (float)((int)((p[0] << 8) | (p[1] << 16) | ((unsigned)p[2] << 24)) >> 8) / 8388608.0f;
                else v = (float)(int32_t)(p[0] | (p[1] << 8) | (p[2] << 16) | ((uint32_t)p[3] << 24)) / 2147483648.0f;
                o[i] = v;
            }
            *frames = n;
            free(d);
            return o;
        }
        pos += 8 + sz + (sz & 1);
    }
    free(d);
    return NULL;
}

static void write_wav24(const char *path, const float *x, long frames)
{
    FILE *f = fopen(path, "wb");
    if (!f) return;
    uint32_t bytes = (uint32_t)(frames * 2 * 3);
    uint8_t h[44] = { 'R', 'I', 'F', 'F' };
    uint32_t v = 36 + bytes; memcpy(h + 4, &v, 4);
    memcpy(h + 8, "WAVEfmt ", 8); v = 16; memcpy(h + 16, &v, 4);
    uint16_t w = 1; memcpy(h + 20, &w, 2); w = 2; memcpy(h + 22, &w, 2);
    v = 44100; memcpy(h + 24, &v, 4); v = 44100 * 6; memcpy(h + 28, &v, 4);
    w = 6; memcpy(h + 32, &w, 2); w = 24; memcpy(h + 34, &w, 2);
    memcpy(h + 36, "data", 4); memcpy(h + 40, &bytes, 4);
    fwrite(h, 1, 44, f);
    for (long i = 0; i < frames * 2; i++) {
        float s = x[i];
        if (s > 1) s = 1;
        if (s < -1) s = -1;
        int32_t q = (int32_t)(s * 8388607.0f);
        uint8_t b[3] = { (uint8_t)q, (uint8_t)(q >> 8), (uint8_t)(q >> 16) };
        fwrite(b, 1, 3, f);
    }
    fclose(f);
}

static void wf(c6x_mem *m, uint32_t a, float v) { uint32_t u; memcpy(&u, &v, 4); mem_wr(m, a, 4, u); }
static float rf(c6x_mem *m, uint32_t a) { uint32_t u = mem_rd(m, a, 4); float v; memcpy(&v, &u, 4); return v; }

int main(int argc, char **argv)
{
    if (argc < 4) { fprintf(stderr, "usage: c6xzdl EFFECT.ZDL in.wav out.f32 [ui1..ui9] [--text-base HEX] [--func N] [--wav F] [--stwtrace F[,ADDR:LEN]] [--off-at S] [--on-at S] [--at S K=UI] [--probe-fx] [--pedal N] [--pedal-at T=N]\n"); return 1; }
    const char *func = NULL, *wavout = NULL, *symname = NULL, *stwtrace = NULL;
    int list_syms = 0;
    double off_at = -1, on_at = -1;
    ev_t ev[64];
    int nev = 0, nk = 0;
    float ui[9] = { 0 };
    long max_blocks = -1;
    const char *cmode = "l1cold";
    uint32_t text_base = TEXT_BASE;
    uint32_t dump_addr = 0, dump_bytes = 0;   /* --dump ADDR:BYTES : hex-dump RAM after the run */
    for (int a = 4; a < argc; a++) {
        if (!strcmp(argv[a], "--func") && a + 1 < argc) func = argv[++a];
        else if (!strcmp(argv[a], "--stwtrace") && a + 1 < argc) stwtrace = argv[++a];
        else if (!strcmp(argv[a], "--wav") && a + 1 < argc) wavout = argv[++a];
        else if (!strcmp(argv[a], "--off-at") && a + 1 < argc) off_at = atof(argv[++a]);
        else if (!strcmp(argv[a], "--on-at") && a + 1 < argc) on_at = atof(argv[++a]);
        else if (!strcmp(argv[a], "--max-blocks") && a + 1 < argc) max_blocks = atol(argv[++a]);
        else if (!strcmp(argv[a], "--cache") && a + 1 < argc) cmode = argv[++a];
        else if (!strcmp(argv[a], "--text-base") && a + 1 < argc) text_base = (uint32_t)strtoul(argv[++a], NULL, 16);
        else if (!strcmp(argv[a], "--cachepen") && a + 1 < argc) {
            if (sscanf(argv[++a], "%d:%d:%d:%d", &g_zdl_pen[0], &g_zdl_pen[1], &g_zdl_pen[2], &g_zdl_pen[3]) != 4) {
                fprintf(stderr, "--cachepen needs P1:P2:P3:P4\n"); return 1;
            }
        }
        else if (!strcmp(argv[a], "--probe-fx")) probe_on = 1;
        else if (!strcmp(argv[a], "--fw-stubs")) fw_stubs = 1;
        else if (!strcmp(argv[a], "--sym") && a + 1 < argc) symname = argv[++a];
        else if (!strcmp(argv[a], "--syms")) list_syms = 1;
        else if (!strcmp(argv[a], "--pedal") && a + 1 < argc) pedal_init = (uint32_t)strtoul(argv[++a], NULL, 0);
        else if (!strcmp(argv[a], "--pedal-at") && a + 2 < argc && npedal < 64) {
            const char *eq = strchr(argv[a + 2], '=');
            pedal_t[npedal] = atof(argv[a + 1]);
            pedal_v[npedal] = (uint32_t)strtoul(eq ? eq + 1 : argv[a + 2], NULL, 0);
            npedal++; a += 2;
        }
        else if (!strcmp(argv[a], "--dump") && a + 1 < argc) {
            const char *cp = strchr(argv[++a], ':');
            dump_addr = (uint32_t)strtoul(argv[a], NULL, 16);
            dump_bytes = cp ? (uint32_t)strtoul(cp + 1, NULL, 0) : 40;
        }
        else if (!strcmp(argv[a], "--at") && a + 2 < argc && nev < 64) {
            ev[nev].t = atof(argv[a + 1]);
            ev[nev].knob = atoi(argv[a + 2]);
            const char *eq = strchr(argv[a + 2], '=');
            ev[nev].ui = (float)atof(eq ? eq + 1 : "0");
            nev++; a += 2;
        } else if (nk < 9) ui[nk++] = (float)atof(argv[a]);
    }

    c6x_mem m;
    mem_init(&m);
    mem_add_ram(&m, "L2", 0x11800000, 256 * 1024, 0x00800000);
    mem_add_ram(&m, "L1P", 0x11E00000, 32 * 1024, 0x00E00000);
    mem_add_ram(&m, "L1D", 0x11F00000, 32 * 1024, 0x00F00000);
    mem_add_ram(&m, "SDRAM", 0xC0000000, 64 * 1024 * 1024, 0);
    static c6x_cpu c;
    cpu_init(&c, &m);
    cpu_reset(&c, 0);
    if (stwtrace && !cpu_stwtrace_open(&c, stwtrace)) return 1;
    static c6x_cache kc;
    cache_init(&kc, 300, 150);
    cache_set_firmware_defaults(&kc);
    if (g_zdl_pen[0] >= 0) kc.p_l1d_l2sram = g_zdl_pen[0];
    if (g_zdl_pen[1] >= 0) kc.p_l1d_l2c = g_zdl_pen[1];
    if (g_zdl_pen[2] >= 0) kc.p_l2_fill = g_zdl_pen[2];
    if (g_zdl_pen[3] >= 0) kc.p_uncached = g_zdl_pen[3];
    if (strcmp(cmode, "off")) c.cache = &kc;
    if (text_base >= 0x11E00000u && text_base < 0x11E08000u) {
        cache_cfg_write(&kc, 0x01840020u, 0);   /* L1PCFG=0: all 32 KB L1P is SRAM, no cache */
        fprintf(stderr, "L1P SRAM mode: code at %08X, L1PCFG=0\n", text_base);
    }

    uint32_t zlen;
    uint8_t *zd = read_file(argv[1], &zlen);
    if (!zd) { perror(argv[1]); return 1; }
    uint32_t entry = 0;
    if (zlen > 4 && !memcmp(zd, "\x7f" "ELF", 4)) {
        /* TI-linked executable (effect C + stubs): segments are already relocated */
        elf_info ei;
        if (elf_load(&m, zd, zlen, &ei)) { fprintf(stderr, "ELF load failed\n"); return 1; }
        const char *want = func;
        for (int i = 0; !want && i < ei.nsyms; i++) {
            const char *nm = ei.syms[i].name;
            size_t l = strlen(nm);
            if (!strncmp(nm, "Fx_", 3) && !(l > 5 && !strcmp(nm + l - 5, "_init")) && !(l > 4 && !strcmp(nm + l - 4, "_onf")) &&
                !(l > 5 && !strcmp(nm + l - 5, "_edit")) && !strstr(nm, "_Coe")) want = nm;
        }
        if (!want || elf_sym_addr(&ei, want, &entry)) { fprintf(stderr, "audio function not found in ELF\n"); return 1; }
        fprintf(stderr, "ELF %s: func %s @ %08X\n", argv[1], want, entry);
    } else {
        zdl_info z;
        int r = zdl_load(&m, zd, zlen, text_base, CONST_BASE, UNDEF_TRAP, &z);
        if (r) { fprintf(stderr, "ZDL load failed (%d)\n", r); return 1; }
        if (text_base >= 0x11E00000u && text_base < 0x11E08000u && text_base + z.text_size > 0x11E08000u) {
            fprintf(stderr, "ZDL text %u B does not fit L1P SRAM at %08X\n", z.text_size, text_base);
            return 1;
        }
        const zdl_sym *fs = func ? zdl_find(&z, func) : zdl_audio_func(&z);
        if (!fs) { fprintf(stderr, "audio function not found\n"); return 1; }
        entry = zdl_map(&z, fs->value);
        fprintf(stderr, "ZDL %s: text %u B, const %u B, %d relocs (%d unsupported), func %s @ %08X\n",
                argv[1], z.text_size, z.const_size, z.nrel, z.nrel_bad, fs->name, entry);
        for (int i = 0; i < z.nundef; i++) fprintf(stderr, "  undefined symbol -> trap: %s\n", z.undefined[i]);
        if (list_syms) for (int i = 0; i < z.nsyms; i++)
            fprintf(stderr, "SYMLIST %s %08X -> %08X\n", z.syms[i].name, z.syms[i].value, zdl_map(&z, z.syms[i].value));
        if (symname) {
            const zdl_sym *s = zdl_find(&z, symname);
            fprintf(stderr, "SYM %s value=%08X mapped=%08X\n", symname,
                    s ? s->value : 0u, s ? zdl_map(&z, s->value) : 0u);
        }
    }

    /* return trap: a run of NOPs, the breakpoint is its first packet */
    for (uint32_t a = RET_TRAP; a < RET_TRAP + 0x400; a += 4) mem_wr(&m, a, 4, 0);
    for (uint32_t a = UNDEF_TRAP; a < UNDEF_TRAP + 0x100; a += 4) mem_wr(&m, a, 4, 0);
    if (probe_on) {
        /* synthetic handles/words and a descriptor with max=100 at +12 */
        mem_wr(&m, 0xC00EFEBCu, 4, 0xC00FF000u);  /* semaphore handle */
        mem_wr(&m, 0xC00EFA08u, 4, 0xC00FF004u);  /* UI event word */
        mem_wr(&m, DESC_ADDR + 12, 4, 100u);
    }
    if (fw_stubs) {
        for (unsigned k = 0; k < sizeof(stub_desc) / 4; k++)
            mem_wr(&m, 0xC00B056Cu + 4 * k, 4, stub_desc[k]);
        const uint32_t void_addrs[] = { 0xC00BB600u, 0xC00C7EE0u, 0xC00D6B00u,
                                        0xC00ACD84u, 0xC00CBF40u };
        for (unsigned j = 0; j < sizeof(void_addrs) / 4; j++)
            for (unsigned k = 0; k < sizeof(stub_void) / 4; k++)
                mem_wr(&m, void_addrs[j] + 4 * k, 4, stub_void[k]);
        mem_wr(&m, DESC_ADDR + 12, 4, 100u);
        mem_wr(&m, 0xC00EFEBCu, 4, 0xC00FF000u);
        mem_wr(&m, 0xC00EFA08u, 4, 0xC00FF004u);
    }
    if (pedal_init != 0xFFFFFFFFu) mem_wr(&m, 0xC00EF7BBu, 1, pedal_init);
    arm_bp(&c);

    /* ctx and friends, as zdl_host.c */
    uint32_t arena_own = ARENA0 + ARENA_SPAN * 1, arena_sf = ARENA0;
    for (int i = 0; i < 6; i++) {
        mem_wr(&m, TABLE_ADDR + 12 * i + 0, 4, ARENA0 + ARENA_SPAN * i);
        mem_wr(&m, TABLE_ADDR + 12 * i + 4, 4, ARENA0 + ARENA_SPAN * i + ARENA_BYTES);
        mem_wr(&m, TABLE_ADDR + 12 * i + 8, 4, ARENA_BYTES);
    }
    (void)arena_own; (void)arena_sf;
    mem_wr(&m, MAGIC_ADDR + 0, 4, 0x1234);          /* magicA */
    mem_wr(&m, MAGIC_ADDR + 4, 4, 0);               /* magicB */
    mem_wr(&m, MAGIC_ADDR + 8, 4, MAGIC_ADDR + 4);  /* magicDstPtr = &magicB */
    for (int i = 0; i < 16; i++) mem_wr(&m, CTX_ADDR + 4 * i, 4, 0);
    mem_wr(&m, CTX_ADDR + 0, 4, 1);
    mem_wr(&m, CTX_ADDR + 4, 4, PARAMS_ADDR);
    mem_wr(&m, CTX_ADDR + 12, 4, TABLE_ADDR + 12);
    mem_wr(&m, CTX_ADDR + 16, 4, CHAIN_ADDR);
    mem_wr(&m, CTX_ADDR + 20, 4, CHAIN_ADDR);
    mem_wr(&m, CTX_ADDR + 44, 4, MAGIC_ADDR + 8);
    mem_wr(&m, CTX_ADDR + 48, 4, MAGIC_ADDR + 0);
    for (int i = 0; i < 32; i++) wf(&m, PARAMS_ADDR + 4 * i, 0.0f);
    wf(&m, PARAMS_ADDR, 1.0f);
    for (int k = 0; k < nk; k++) wf(&m, PARAMS_ADDR + 4 * (5 + k), ui[k] * 0.01f);

    int ch, fsr;
    long n;
    float *in = read_wav(argv[2], &ch, &n, &fsr);
    if (!in) { fprintf(stderr, "cannot read %s\n", argv[2]); return 1; }
    float *out = calloc((size_t)n * 2, sizeof(float));
    uint64_t cmin = ~0ULL, cmax = 0, csum = 0, nblk = 0;
    for (long pos = 0; pos + 8 <= n; pos += 8) {
        double t = (double)pos / fsr;
        if (off_at >= 0 && t >= off_at) { wf(&m, PARAMS_ADDR, 0.0f); off_at = -1; }
        if (on_at >= 0 && t >= on_at) { wf(&m, PARAMS_ADDR, 1.0f); on_at = -1; }
        for (int e = 0; e < npedal; e++)
            if (pedal_t[e] >= 0 && t >= pedal_t[e]) { mem_wr(&m, 0xC00EF7BBu, 1, pedal_v[e]); pedal_t[e] = -1; }
        for (int e = 0; e < nev; e++)
            if (ev[e].t >= 0 && t >= ev[e].t) { wf(&m, PARAMS_ADDR + 4 * (4 + ev[e].knob), ev[e].ui * 0.01f); ev[e].t = -1; }
        for (int i = 0; i < 8; i++) {
            wf(&m, CHAIN_ADDR + 4 * i, in[(pos + i) * ch]);
            wf(&m, CHAIN_ADDR + 32 + 4 * i, in[(pos + i) * ch + (ch > 1)]);
        }
        c.r[0][4] = CTX_ADDR;
        c.r[1][3] = RET_TRAP;
        c.r[1][15] = STACK_TOP;
        c.pc = entry;
        c.nop_left = 0;
        if (c.cache && strcmp(cmode, "warm")) {
            cache_cfg_write(&kc, 0x01845028u, 1);                 /* L1PINV */
            cache_cfg_write(&kc, 0x01845044u, 1);                 /* L1DWBINV */
            if (!strcmp(cmode, "cold")) cache_cfg_write(&kc, 0x01845004u, 1);   /* L2WBINV */
        }
        uint64_t c0 = cpu_now(&c);
        for (;;) {
            cpu_run(&c, 50000000);
            if (c.halted || !c.bp_hit) break;
            const char *nm = probe_on ? probe_name(c.pc) : NULL;
            if (!nm) break;
            if (nprobe < (int)(sizeof(probe_log) / sizeof(probe_log[0]))) {
                probe_log[nprobe].pc = c.pc;
                probe_log[nprobe].a4 = c.r[0][4];
                probe_log[nprobe].b4 = c.r[1][4];
                probe_log[nprobe].a6 = c.r[0][6];
                probe_log[nprobe].b6 = c.r[1][6];
                probe_log[nprobe].a8 = c.r[0][8];
                probe_log[nprobe].b3 = c.r[1][3];
                probe_log[nprobe].a3 = c.r[0][3];
                probe_log[nprobe].block = (uint64_t)(pos / 8);
                nprobe++;
            }
            uint32_t ret = c.r[1][3] & ~3u;   /* ADDKPC return address (B3) */
            if (!(ret >= 0xC0400000u && ret < 0xC0600000u)) ret = c.r[0][3] & ~3u;
            if (!strcmp(nm, "FX_PARAM_DESC")) c.r[0][4] = DESC_ADDR;
            c.pc = ret;
            c.nop_left = 0;
            c.cur_next = 0;
            c.bp_hit = 0;
            arm_bp(&c);
        }
        if (c.halted) { fprintf(stderr, "CPU halted at block %ld: %s\n", pos / 8, c.err); break; }
        if (!c.bp_hit) { fprintf(stderr, "block %ld did not return within 50M cycles (pc=%08X)\n", pos / 8, c.pc); break; }
        if (c.pc == UNDEF_TRAP + 0 || (c.r[1][3] == RET_TRAP && c.pc != RET_TRAP && c.pc >= UNDEF_TRAP && c.pc < UNDEF_TRAP + 0x100)) {
            fprintf(stderr, "block %ld called an undefined symbol\n", pos / 8);
            break;
        }
        uint64_t cyc = cpu_now(&c) - c0;
        /* drain the pipeline on the NOP run (stores/writes of the last packets) */
        c.bp_hit = 0;
        arm_bp(&c);
        cpu_run(&c, 16);
        if (cyc < cmin) cmin = cyc;
        if (cyc > cmax) cmax = cyc;
        csum += cyc;
        nblk++;
        for (int i = 0; i < 8; i++) {
            out[(pos + i) * 2] = rf(&m, CHAIN_ADDR + 4 * i);
            out[(pos + i) * 2 + 1] = rf(&m, CHAIN_ADDR + 32 + 4 * i);
        }
        if (getenv("ARENA_DUMP") && (long)nblk <= atol(getenv("ARENA_DUMP"))) {
            static FILE *fa;
            if (!fa) fa = fopen("arena_emu.bin", "wb");
            static uint8_t buf[65536];
            mem_read_block(&m, ARENA0 + ARENA_SPAN * 1, buf, sizeof buf);
            fwrite(buf, 1, sizeof buf, fa);
            if ((long)nblk >= atol(getenv("ARENA_DUMP"))) fclose(fa);
        }
        if (max_blocks > 0 && (long)nblk >= max_blocks) break;
    }
    FILE *f = fopen(argv[3], "wb");
    if (f) { fwrite(out, sizeof(float), (size_t)nblk * 16, f); fclose(f); }
    if (wavout) write_wav24(wavout, out, (long)nblk * 8);
    if (nblk) {
        double avg = (double)csum / nblk;
        printf("blocks=%llu cycles/block min=%llu avg=%.0f max=%llu  load avg=%.1f%% max=%.1f%% of 54422\n",
               (unsigned long long)nblk, (unsigned long long)cmin, avg, (unsigned long long)cmax,
               100.0 * avg / 54422.0, 100.0 * cmax / 54422.0);
    }
    if (c.cache) { printf("cache mode %s; ", cmode); cache_report(&kc, stdout); }
    if (c.unimpl_count) printf("WARNING: %u unimplemented instructions executed\n", c.unimpl_count);
    if (probe_on) {
        printf("PROBE calls=%d\n", nprobe);
        for (int i = 0; i < nprobe; i++)
            printf("PROBE %-13s block=%llu A4=%u B4=%u A6=%d B6=%u A8=%u pc=%08X B3=%08X A3=%08X\n",
                   probe_name(probe_log[i].pc), (unsigned long long)probe_log[i].block,
                   probe_log[i].a4, probe_log[i].b4, (int)probe_log[i].a6,
                   probe_log[i].b6, probe_log[i].a8, probe_log[i].pc,
                   probe_log[i].b3, probe_log[i].a3);
    }
    if (dump_addr && dump_bytes) {
        printf("DUMP %08X:%u\n", dump_addr, dump_bytes);
        for (uint32_t k = 0; k < dump_bytes; k += 4)
            printf("%s%08X: %08X", (k & 31) == 0 ? "\n" : "", dump_addr + k, mem_rd(&m, dump_addr + k, 4));
        printf("\n");
    }
    if (c.stwtracef) {
        printf("STWTRACE writes=%llu range=%08X..%08X\n", (unsigned long long)c.stw_writes,
               c.stw_base, c.stw_end - 1);
        fclose(c.stwtracef);
        c.stwtracef = NULL;
    }
    return 0;
}
