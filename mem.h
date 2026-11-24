/* Memory map for the C6745/OMAP-L137 DSP side of a Zoom MS pedal. */
#ifndef C6X_MEM_H
#define C6X_MEM_H
#include <stdint.h>
#include <stddef.h>

#define MEM_PAGE_BITS 12
#define MEM_PAGES (1u << (32 - MEM_PAGE_BITS))

struct c6x_sys;

typedef uint32_t (*mmio_read_fn)(struct c6x_sys *s, uint32_t addr, int size);
typedef void (*mmio_write_fn)(struct c6x_sys *s, uint32_t addr, int size, uint32_t val);

typedef struct {
    const char *name;
    uint32_t base, size;
    uint8_t *data;       /* NULL for MMIO */
    uint32_t alias;      /* second base address (0 = none) */
} mem_region;

/* per-page code tracking at 256-byte granularity: a write to a block that
   holds decoded code bumps its generation (decode cache entries go stale) */
typedef struct {
    uint16_t code_mask;
    uint32_t gen[16];
} page_meta;

typedef struct c6x_mem {
    uint8_t **page;       /* MEM_PAGES host pointers (RAM) or NULL (MMIO/unmapped) */
    page_meta **meta;     /* MEM_PAGES, shared between aliases */
    mem_region regions[16];
    int nregions;
    mmio_read_fn mmio_read;
    mmio_write_fn mmio_write;
    struct c6x_sys *sys;
    uint32_t unmapped_reads, unmapped_writes;
    uint32_t wwatch_lo, wwatch_hi;  /* RAM write watch range */
    void (*on_wwatch)(struct c6x_sys *s, uint32_t addr, int size, uint32_t val);
} c6x_mem;

void mem_init(c6x_mem *m);
void mem_free(c6x_mem *m);
uint8_t *mem_add_ram(c6x_mem *m, const char *name, uint32_t base, uint32_t size, uint32_t alias);
int mem_load(c6x_mem *m, uint32_t addr, const void *data, uint32_t len);
int mem_read_block(c6x_mem *m, uint32_t addr, void *out, uint32_t len);
void mem_mirror(c6x_mem *m, uint32_t src, uint32_t size, uint32_t dst, uint32_t span);

static inline uint8_t *mem_ptr(c6x_mem *m, uint32_t addr)
{
    uint8_t *p = m->page[addr >> MEM_PAGE_BITS];
    return p ? p + (addr & ((1u << MEM_PAGE_BITS) - 1)) : NULL;
}

static inline void mem_code_touch(c6x_mem *m, uint32_t addr)
{
    page_meta *pm = m->meta[addr >> MEM_PAGE_BITS];
    if (pm) {
        uint16_t bit = (uint16_t)(1u << ((addr >> 8) & 15));
        if (pm->code_mask & bit) { pm->code_mask &= ~bit; pm->gen[(addr >> 8) & 15]++; }
    }
}

uint32_t mem_rd(c6x_mem *m, uint32_t addr, int size);
void mem_wr(c6x_mem *m, uint32_t addr, int size, uint32_t val);

#endif
