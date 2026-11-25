/* C674x megamodule cache timing model: L1P, L1D, L2 tags only (data stays coherent
   in c6x_mem). Returns stall cycles per access; see README "Кэш и SDRAM". */
#ifndef C6X_CACHE_H
#define C6X_CACHE_H
#include <stdint.h>
#include <stdio.h>

#define L1P_LINE 32
#define L1D_LINE 64
#define L2_LINE 128
#define L1P_MAXLINES 1024           /* 32 KB direct mapped */
#define L1D_MAXSETS 256             /* 32 KB, 2 ways */
#define L2_MAXSETS 512              /* 256 KB, 4 ways */

typedef struct c6x_cache {
    /* configuration (L1PCFG / L1DCFG / L2CFG / MAR) */
    uint32_t l1p_lines, l1d_sets, l2_sets;      /* 0 = cache off */
    uint32_t l1d_sram_end, l2_sram_end;         /* L1D SRAM 0x11F00000.., L2 SRAM 0x11800000.. */
    uint32_t l2_size;
    uint8_t mar[256];                           /* cacheable 16 MB regions */

    uint32_t l1p_tag[L1P_MAXLINES];             /* line address | 1 = valid */
    uint32_t l1d_tag[L1D_MAXSETS][2];
    uint8_t l1d_dirty[L1D_MAXSETS][2], l1d_lru[L1D_MAXSETS];
    uint32_t l2_tag[L2_MAXSETS][4];
    uint8_t l2_dirty[L2_MAXSETS][4], l2_age[L2_MAXSETS][4];
    uint32_t last_fetch;                        /* last L1P line looked up */

    /* stall cycles (CPU clocks) */
    int p_l1p_l2;          /* L1P miss served by L2 (SRAM or cache hit) */
    int p_l1d_l2sram;      /* L1D read miss served by L2 SRAM */
    int p_l1d_l2c;         /* L1D read miss, L2 cache hit */
    int p_l2_fill;         /* L2 line fill from SDRAM */
    int p_l2_wb;           /* dirty L2 victim written to SDRAM */
    int p_uncached;        /* single uncached SDRAM read */
    int p_mmio;            /* peripheral register read */
    double cpu_mhz, emif_mhz;
    int t_rcd, t_cl, t_rp;  /* SDRAM clocks: ACTIVATE->READ, CAS latency, PRECHARGE */

    uint64_t n_l1p, n_l1p_miss, n_l1d, n_l1d_miss, n_l2, n_l2_miss, n_l2_wb, n_mmio, stall;
    uint64_t n_dma_snoop;        /* EDMA writes that hit a line currently in L1D */

    /* diagnostics (-cachelog): current PC / CPU cycle set by the caller */
    FILE *logf;
    uint64_t log_from, log_to;   /* CPU-cycle window for -cachelog FROM:TO (0 = all) */
    uint32_t pc;
    uint64_t cycle;
} c6x_cache;

void cache_init(c6x_cache *k, double cpu_mhz, double emif_mhz);
/* new clocks / SDRAM timings (from PLL0, CFGCHIP3, EMIFB); keeps the cache contents */
void cache_set_clocks(c6x_cache *k, double cpu_mhz, double emif_mhz, int t_rcd, int t_cl, int t_rp);
void cache_set_firmware_defaults(c6x_cache *k);   /* MS-50G/60B/70CDR boot config */
void cache_cfg_write(c6x_cache *k, uint32_t addr, uint32_t val);   /* 0x0184xxxx */
void cache_invalidate_all(c6x_cache *k);   /* L1DWBINV + L2WBINV + L1PINV, without changing config */
uint32_t cache_fetch(c6x_cache *k, uint32_t addr);
uint32_t cache_read(c6x_cache *k, uint32_t addr, int size);
uint32_t cache_write(c6x_cache *k, uint32_t addr, int size);
void cache_dma_write(c6x_cache *k, uint32_t addr, uint32_t n);    /* L1D snoop of L2 SRAM */
void cache_report(c6x_cache *k, FILE *f);

#endif
