/* C674x cache timing model (tags only). Geometry from SPRUG82 / C674x megamodule:
   L1P 32 KB direct mapped, 32-byte lines; L1D up to 32 KB, 2-way LRU, 64-byte lines,
   read-allocate, write-back; L2 up to 256 KB, 4-way, 128-byte lines, write-back.
   Penalties are approximate (see README); the EMIF ones are derived from the SDRAM setup
   that the boot image programs (16-bit SDR, CL3). */
#include "cache.h"
#include <string.h>

enum { R_INTERNAL, R_L1D_SRAM, R_L2_SRAM, R_EXT_CACHED, R_EXT_UNCACHED, R_MMIO };

#define L2_BASE 0x11800000u
#define L1D_BASE 0x11F00000u
#define L1P_BASE 0x11E00000u

static void set_l1p(c6x_cache *k, uint32_t mode);
static void set_l1d(c6x_cache *k, uint32_t mode);
static void set_l2(c6x_cache *k, uint32_t mode);

void cache_init(c6x_cache *k, double cpu_mhz, double emif_mhz)
{
    memset(k, 0, sizeof *k);
    k->last_fetch = 1;
    k->p_l1p_l2 = 8;
    k->p_l1d_l2sram = 10;
    k->p_l1d_l2c = 12;
    k->p_mmio = 20;
    cache_set_clocks(k, cpu_mhz, emif_mhz, 3, 3, 3);
    k->l2_size = 256 * 1024;
    /* reset state: L1P and L1D all cache, L2 all SRAM, nothing external cacheable */
    set_l1p(k, 7);
    set_l1d(k, 7);
    set_l2(k, 0);
}

void cache_set_clocks(c6x_cache *k, double cpu_mhz, double emif_mhz, int t_rcd, int t_cl, int t_rp)
{
    double r = cpu_mhz / emif_mhz;           /* CPU clocks per EMIF clock */
    k->cpu_mhz = cpu_mhz;
    k->emif_mhz = emif_mhz;
    k->t_rcd = t_rcd;
    k->t_cl = t_cl;
    k->t_rp = t_rp;
    /* 128-byte line on a 16-bit bus: tRCD + CL + 64 beats + precharge, plus ~20 CPU
       clocks through the switch fabric and L2 controller */
    k->p_l2_fill = (int)((t_rcd + t_cl + 64 + t_rp - 1) * r + 20 + 0.5);
    k->p_l2_wb = (int)((t_rcd + 64 + t_rp + 1) * r + 10 + 0.5);
    k->p_uncached = (int)((t_rcd + t_cl + 2 + t_rp - 1) * r + 20 + 0.5);
}

static uint32_t mode_size(uint32_t mode, uint32_t max)
{
    static const uint32_t kb[8] = { 0, 4, 8, 16, 32, 32, 32, 32 };
    uint32_t s = kb[mode & 7] * 1024;
    return s > max ? max : s;
}

static void set_l1p(c6x_cache *k, uint32_t mode)
{
    k->l1p_lines = mode_size(mode, 32 * 1024) / L1P_LINE;
    memset(k->l1p_tag, 0, sizeof k->l1p_tag);
    k->last_fetch = 1;
}

static void set_l1d(c6x_cache *k, uint32_t mode)
{
    uint32_t sz = mode_size(mode, 32 * 1024);
    k->l1d_sets = sz / (2 * L1D_LINE);
    k->l1d_sram_end = L1D_BASE + 32 * 1024 - sz;
    memset(k->l1d_tag, 0, sizeof k->l1d_tag);
    memset(k->l1d_dirty, 0, sizeof k->l1d_dirty);
}

static void set_l2(c6x_cache *k, uint32_t mode)
{
    static const uint32_t kb[8] = { 0, 32, 64, 128, 256, 256, 256, 256 };
    uint32_t sz = kb[mode & 7] * 1024;
    if (sz > k->l2_size) sz = k->l2_size;
    k->l2_sets = sz / (4 * L2_LINE);
    k->l2_sram_end = L2_BASE + k->l2_size - sz;
    memset(k->l2_tag, 0, sizeof k->l2_tag);
    memset(k->l2_dirty, 0, sizeof k->l2_dirty);
}

void cache_set_firmware_defaults(c6x_cache *k)
{
    /* what the Zoom OS programs at boot: L2CFG=3, L1PCFG=4, L1DCFG=3, MAR192 (SDRAM) */
    set_l2(k, 3);
    set_l1p(k, 4);
    set_l1d(k, 3);
    k->mar[0xC0] = 1;
}

static int region(c6x_cache *k, uint32_t a)
{
    if ((a >> 24) == 0x00) a |= 0x11000000u;                              /* local aliases of L2/L1P/L1D */
    if (a >= 0x11000000u && a < 0x12000000u && (a < L2_BASE || a >= L2_BASE + k->l2_size)
        && (a >> 20) != 0x11E && (a >> 20) != 0x11F) return R_INTERNAL;  /* DSP ROM etc. */
    if (a >= L1D_BASE && a < L1D_BASE + 0x8000u) return a < k->l1d_sram_end ? R_L1D_SRAM : R_INTERNAL;
    if (a >= L1P_BASE && a < L1P_BASE + 0x8000u) return R_INTERNAL;
    if (a >= L2_BASE && a < L2_BASE + k->l2_size) return R_L2_SRAM;
    if (a >= 0x01800000u && a < 0x01900000u) return R_INTERNAL;           /* megamodule */
    if (a < 0x02000000u || (a >> 28) == 0xB) return R_MMIO;              /* peripherals, EMIFB regs */
    if (a >= 0xC0000000u && a < 0xE0000000u) {
        a = 0xC0000000u | (a & 0x00FFFFFFu);                              /* MAR of the mirror base */
        return k->mar[a >> 24] ? R_EXT_CACHED : R_EXT_UNCACHED;
    }
    return k->mar[a >> 24] ? R_EXT_CACHED : R_EXT_UNCACHED;
}

/* L2 cache lookup for an external address; returns stall */
static uint32_t l2_access(c6x_cache *k, uint32_t a, int wr)
{
    k->n_l2++;
    if (!k->l2_sets) {                       /* no L2 cache: L1 fills straight from SDRAM */
        k->n_l2_miss++;
        return (uint32_t)(k->p_l2_fill * 6 / 10);
    }
    uint32_t line = a & ~(uint32_t)(L2_LINE - 1);
    uint32_t set = (line / L2_LINE) % k->l2_sets, w, hit = 4;
    for (w = 0; w < 4; w++)
        if (k->l2_tag[set][w] == (line | 1)) { hit = w; break; }
    uint32_t stall = 0;
    if (hit == 4) {
        k->n_l2_miss++;
        uint32_t oldest = 0;
        for (w = 1; w < 4; w++)
            if (k->l2_age[set][w] > k->l2_age[set][oldest]) oldest = w;
        if (k->l2_dirty[set][oldest] && (k->l2_tag[set][oldest] & 1)) { k->n_l2_wb++; stall += (uint32_t)k->p_l2_wb; }
        k->l2_tag[set][oldest] = line | 1;
        k->l2_dirty[set][oldest] = 0;
        stall += (uint32_t)k->p_l2_fill;
        hit = oldest;
    }
    for (w = 0; w < 4; w++)
        if (k->l2_age[set][w] < 255) k->l2_age[set][w]++;
    k->l2_age[set][hit] = 0;
    if (wr) k->l2_dirty[set][hit] = 1;
    return stall;
}

/* L1D access for L2 SRAM or cached external memory; returns stall */
static uint32_t l1d_access(c6x_cache *k, uint32_t a, int wr, int ext)
{
    k->n_l1d++;
    uint32_t line = a & ~(uint32_t)(L1D_LINE - 1);
    if (!k->l1d_sets) {
        if (wr) return ext ? l2_access(k, a, 1) : 0;
        k->n_l1d_miss++;
        return ext ? (uint32_t)k->p_l1d_l2c + l2_access(k, a, 0) : (uint32_t)k->p_l1d_l2sram;
    }
    uint32_t set = (line / L1D_LINE) % k->l1d_sets;
    for (int w = 0; w < 2; w++) {
        if (k->l1d_tag[set][w] == (line | 1)) {
            k->l1d_lru[set] = (uint8_t)(1 - w);
            if (wr) k->l1d_dirty[set][w] = 1;
            return 0;
        }
    }
    k->n_l1d_miss++;
    if (wr)                                   /* write miss: no allocate, goes to L2 via the write buffer */
        return ext ? l2_access(k, a, 1) : 0;
    uint32_t stall = 0;
    int v = k->l1d_lru[set];
    if (k->l1d_dirty[set][v] && (k->l1d_tag[set][v] & 1)) {
        uint32_t va = k->l1d_tag[set][v] & ~1u;
        if (region(k, va) == R_EXT_CACHED) stall += l2_access(k, va, 1);   /* victim buffer -> L2 */
    }
    k->l1d_tag[set][v] = line | 1;
    k->l1d_dirty[set][v] = 0;
    k->l1d_lru[set] = (uint8_t)(1 - v);
    stall += ext ? (uint32_t)k->p_l1d_l2c + l2_access(k, a, 0) : (uint32_t)k->p_l1d_l2sram;
    return stall;
}

/* -cachelog: one line per access that actually stalled */
static void clog(c6x_cache *k, const char *kind, uint32_t a, uint32_t stall)
{
    if (!k->logf || !stall) return;
    if (k->log_from && k->cycle < k->log_from) return;
    if (k->log_to && k->cycle > k->log_to) return;
    fprintf(k->logf, "%12llu pc=%08X %-18s 0x%08X stall=%u\n",
            (unsigned long long)k->cycle, k->pc, kind, a, stall);
}

uint32_t cache_read(c6x_cache *k, uint32_t a, int size)
{
    (void)size;
    uint32_t s;
    int r = region(k, a);
    switch (r) {
    case R_L2_SRAM: s = l1d_access(k, a, 0, 0); break;
    case R_EXT_CACHED: s = l1d_access(k, a, 0, 1); break;
    case R_EXT_UNCACHED: s = (uint32_t)k->p_uncached; break;
    case R_MMIO: k->n_mmio++; s = (uint32_t)k->p_mmio; break;
    default: s = 0; break;
    }
    if (s) {
        const char *kind = r == R_MMIO ? "MMIO_READ" :
                           r == R_EXT_UNCACHED ? "UNCACHED_READ" :
                           r == R_L2_SRAM ? "L1D_MISS_L2SRAM" :
                           (s > (uint32_t)k->p_l1d_l2c ? "L2_FILL_SDRAM" : "L1D_MISS_L2HIT");
        clog(k, kind, a, s);
    }
    k->stall += s;
    return s;
}

uint32_t cache_write(c6x_cache *k, uint32_t a, int size)
{
    (void)size;
    uint32_t s = 0;
    switch (region(k, a)) {
    case R_L2_SRAM: s = l1d_access(k, a, 1, 0); break;
    case R_EXT_CACHED: s = l1d_access(k, a, 1, 1); break;
    default: break;                           /* uncached / MMIO writes are posted */
    }
    if (s) clog(k, region(k, a) == R_EXT_CACHED ? "L2_FILL_WRITE" : "L1D_MISS_WRITE", a, s);
    k->stall += s;
    return s;
}

uint32_t cache_fetch(c6x_cache *k, uint32_t a)
{
    uint32_t line = a & ~(uint32_t)(L1P_LINE - 1);
    if (line == k->last_fetch) return 0;
    k->last_fetch = line;
    int r = region(k, a);
    if (r == R_EXT_UNCACHED) { k->stall += (uint32_t)k->p_uncached * 2; return (uint32_t)k->p_uncached * 2; }
    if (r != R_L2_SRAM && r != R_EXT_CACHED) return 0;
    k->n_l1p++;
    uint32_t s = 0;
    if (k->l1p_lines) {
        uint32_t idx = (line / L1P_LINE) % k->l1p_lines;
        if (k->l1p_tag[idx] == (line | 1)) return 0;
        k->l1p_tag[idx] = line | 1;
    }
    k->n_l1p_miss++;
    s = (uint32_t)k->p_l1p_l2 + (r == R_EXT_CACHED ? l2_access(k, a, 0) : 0);
    clog(k, r == R_EXT_CACHED ? "L1P_MISS_EXT" : "L1P_MISS_L2SRAM", a, s);
    k->stall += s;
    return s;
}

/* ---- block and global coherence operations ---- */
enum { OP_WB = 1, OP_INV = 2 };

static uint32_t l1d_range(c6x_cache *k, uint32_t lo, uint32_t hi, int op)
{
    uint32_t stall = 0;
    for (uint32_t s = 0; s < k->l1d_sets; s++)
        for (int w = 0; w < 2; w++) {
            uint32_t t = k->l1d_tag[s][w];
            if (!(t & 1)) continue;
            uint32_t a = t & ~1u;
            if (a + L1D_LINE <= lo || a >= hi) continue;
            if ((op & OP_WB) && k->l1d_dirty[s][w]) {
                if (region(k, a) == R_EXT_CACHED) stall += l2_access(k, a, 1) + 2;
                k->l1d_dirty[s][w] = 0;
            }
            if (op & OP_INV) { k->l1d_tag[s][w] = 0; k->l1d_dirty[s][w] = 0; }
        }
    return stall;
}

static uint32_t l2_range(c6x_cache *k, uint32_t lo, uint32_t hi, int op)
{
    uint32_t stall = 0;
    for (uint32_t s = 0; s < k->l2_sets; s++)
        for (int w = 0; w < 4; w++) {
            uint32_t t = k->l2_tag[s][w];
            if (!(t & 1)) continue;
            uint32_t a = t & ~1u;
            if (a + L2_LINE <= lo || a >= hi) continue;
            if ((op & OP_WB) && k->l2_dirty[s][w]) { k->n_l2_wb++; stall += (uint32_t)k->p_l2_wb; k->l2_dirty[s][w] = 0; }
            if (op & OP_INV) { k->l2_tag[s][w] = 0; k->l2_dirty[s][w] = 0; }
        }
    return stall;
}

static void l1p_range(c6x_cache *k, uint32_t lo, uint32_t hi)
{
    for (uint32_t i = 0; i < k->l1p_lines; i++) {
        uint32_t a = k->l1p_tag[i] & ~1u;
        if ((k->l1p_tag[i] & 1) && a + L1P_LINE > lo && a < hi) k->l1p_tag[i] = 0;
    }
    k->last_fetch = 1;
}

void cache_invalidate_all(c6x_cache *k)
{
    if (!k) return;
    l1d_range(k, 0, ~0u, OP_WB | OP_INV);
    l2_range(k, 0, ~0u, OP_WB | OP_INV);
    l1p_range(k, 0, ~0u);
}

void cache_cfg_write(c6x_cache *k, uint32_t addr, uint32_t v)
{
    static uint32_t bar[0x50 / 4];
    uint32_t off;
    if (addr == 0x01840000u) { set_l2(k, v); return; }
    if (addr == 0x01840020u) { set_l1p(k, v); return; }
    if (addr == 0x01840040u) { set_l1d(k, v); return; }
    if (addr >= 0x01848000u && addr < 0x01848400u) { k->mar[(addr - 0x01848000u) >> 2] = (uint8_t)(v & 1); return; }
    uint32_t st = 0;
    if (addr >= 0x01844000u && addr < 0x01844050u) {
        off = addr - 0x01844000u;
        if (!(off & 4)) { bar[off >> 2] = v; return; }          /* xxBAR */
        uint32_t lo = bar[(off - 4) >> 2], hi = lo + v * 4;      /* xxWC: word count starts the op */
        switch (off) {
        case 0x04: st = l1d_range(k, lo, hi, OP_WB) + l2_range(k, lo, hi, OP_WB); break;               /* L2WB */
        case 0x14: st = l1d_range(k, lo, hi, OP_WB | OP_INV) + l2_range(k, lo, hi, OP_WB | OP_INV); break; /* L2WBINV */
        case 0x1C: l1p_range(k, lo, hi); st = l1d_range(k, lo, hi, OP_INV) + l2_range(k, lo, hi, OP_INV); break; /* L2INV */
        case 0x24: l1p_range(k, lo, hi); break;                                                       /* L1PINV */
        case 0x34: st = l1d_range(k, lo, hi, OP_WB | OP_INV); break;                                  /* L1DWBINV */
        case 0x44: st = l1d_range(k, lo, hi, OP_WB); break;                                           /* L1DWB */
        case 0x4C: st = l1d_range(k, lo, hi, OP_INV); break;                                          /* L1DINV */
        }
        st += (v * 4 + L2_LINE - 1) / L2_LINE;                   /* walking the range */
    } else if (addr >= 0x01845000u && addr < 0x01845050u && (v & 1)) {
        switch (addr - 0x01845000u) {
        case 0x00: st = l1d_range(k, 0, ~0u, OP_WB) + l2_range(k, 0, ~0u, OP_WB); break;
        case 0x04: st = l1d_range(k, 0, ~0u, OP_WB | OP_INV) + l2_range(k, 0, ~0u, OP_WB | OP_INV); break;
        case 0x08: l1p_range(k, 0, ~0u); st = l1d_range(k, 0, ~0u, OP_INV) + l2_range(k, 0, ~0u, OP_INV); break;
        case 0x28: l1p_range(k, 0, ~0u); break;
        case 0x40: st = l1d_range(k, 0, ~0u, OP_WB); break;
        case 0x44: st = l1d_range(k, 0, ~0u, OP_WB | OP_INV); break;
        case 0x48: st = l1d_range(k, 0, ~0u, OP_INV); break;
        }
    }
    k->stall += st;
}

void cache_dma_write(c6x_cache *k, uint32_t a, uint32_t n)
{
    /* EDMA writes into L2 SRAM are snooped: the L1D copy is invalidated.
       Count those events: without a real data shadow this is where stale
       data could appear on hardware if the firmware forgot to invalidate. */
    if (region(k, a) == R_L2_SRAM && k->l1d_sets) {
        uint32_t line = a & ~(uint32_t)(L1D_LINE - 1);
        uint32_t set = (line / L1D_LINE) % k->l1d_sets;
        for (int w = 0; w < 2; w++)
            if (k->l1d_tag[set][w] == (line | 1)) {
                k->n_dma_snoop++;
                if (k->logf) fprintf(k->logf, "%12llu pc=%08X DMA_SNOOP 0x%08X L1D set=%u way=%d\n",
                                     (unsigned long long)k->cycle, k->pc, a, set, w);
                break;
            }
        l1d_range(k, a, a + n, OP_INV);
    }
}

void cache_report(c6x_cache *k, FILE *f)
{
    fprintf(f, "CACHE: L1P %llu/%llu miss, L1D %llu/%llu miss, L2 %llu/%llu miss, %llu writebacks, MMIO reads %llu, stall %llu cycles\n",
            (unsigned long long)k->n_l1p_miss, (unsigned long long)k->n_l1p,
            (unsigned long long)k->n_l1d_miss, (unsigned long long)k->n_l1d,
            (unsigned long long)k->n_l2_miss, (unsigned long long)k->n_l2,
            (unsigned long long)k->n_l2_wb, (unsigned long long)k->n_mmio, (unsigned long long)k->stall);
    fprintf(f, "CACHE: EDMA writes hitting cached L1D lines: %llu\n", (unsigned long long)k->n_dma_snoop);
    if (k->hw_lcd_failed || k->hw_spifmt0_written || k->hw_spifmt1_written ||
        k->hw_edma_seen || k->hw_mcasp_seen || k->hw_usb_seen || k->hw_repaints ||
        k->hw_residual_cycles)
        fprintf(f, "HWclose: lcd_failed=%d spifmt0=%d spifmt1=%d quiesce=%d/%d/%d residual=%d repaints=%u residual_cycles=%llu\n",
                k->hw_lcd_failed, k->hw_spifmt0_written, k->hw_spifmt1_written,
                k->hw_edma_seen, k->hw_mcasp_seen, k->hw_usb_seen,
                k->hw_residual, k->hw_repaints, (unsigned long long)k->hw_residual_cycles);
    fprintf(f, "  penalties: L1P<-L2 %d, L1D<-L2SRAM %d, L1D<-L2$ %d, SDRAM line %d, writeback %d, uncached %d, MMIO %d\n",
            k->p_l1p_l2, k->p_l1d_l2sram, k->p_l1d_l2c, k->p_l2_fill, k->p_l2_wb, k->p_uncached, k->p_mmio);
}
