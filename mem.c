#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "mem.h"
#include "sys.h"

static void bootlog_hook(struct c6x_sys *s, uint32_t addr, int size, uint32_t val)
{
    sys_bootlog_write(s, addr, size, val);
}

/* Snapshot the region on the first write after -staleicode. Real memory keeps the
   new bytes; instruction fetch keeps the old bytes until an L1P/L2 invalidate. */
static void stale_touch(c6x_mem *m, uint32_t addr, uint32_t len)
{
    for (int r = 0; r < m->stale_n; r++) {
        if (!m->stale_snap[r] || !m->stale_armed[r]) continue;
        if (addr + len <= m->stale_lo[r] || addr >= m->stale_hi[r]) continue;
        uint32_t span = m->stale_hi[r] - m->stale_lo[r];
        for (uint32_t i = 0; i < span; i++) {
            uint8_t *p = mem_ptr(m, m->stale_lo[r] + i);
            m->stale_snap[r][i] = p ? *p : 0;
        }
        m->stale_armed[r] = 0;
        m->stale_active[r] = 1;
    }
}

void mem_stale_region(c6x_mem *m, uint32_t lo, uint32_t len)
{
    if (!len || m->stale_n >= STALE_MAX) return;
    int r = m->stale_n++;
    free(m->stale_snap[r]);
    m->stale_lo[r] = lo;
    m->stale_hi[r] = lo + len;
    m->stale_snap[r] = calloc(len, 1);
    m->stale_armed[r] = 1;
    m->stale_active[r] = 0;
    m->stale_fetches[r] = 0;
}

void mem_stale_clear(c6x_mem *m)
{
    for (int r = 0; r < m->stale_n; r++) {
        if (!m->stale_snap[r]) continue;
        m->stale_active[r] = 0;
        m->stale_armed[r] = 1;   /* a later overwrite can arm it again */
    }
}

void mem_stale_on_invalidate(c6x_mem *m, uint32_t addr, uint32_t val)
{
    if (!m->stale_n) return;
    if (addr == 0x01840020u || addr == 0x01845004u || addr == 0x01845008u ||
        addr == 0x01845028u || addr == 0x0184401Cu || addr == 0x01844024u) {
        (void)val;
        mem_stale_clear(m);
    }
}

void mem_init(c6x_mem *m)
{
    memset(m, 0, sizeof *m);
    m->page = calloc(MEM_PAGES, sizeof(uint8_t *));
    m->meta = calloc(MEM_PAGES, sizeof(page_meta *));
}

void mem_free(c6x_mem *m)
{
    for (int r = 0; r < m->stale_n; r++) free(m->stale_snap[r]);
    for (int i = 0; i < m->nregions; i++) free(m->regions[i].data);
    for (uint32_t i = 0; i < MEM_PAGES; i++) {
        /* metas are shared by aliases: free only the canonical mapping */
        (void)i;
    }
    free(m->page);
    free(m->meta);
}

static void map(c6x_mem *m, uint32_t base, uint32_t size, uint8_t *data, page_meta *meta)
{
    for (uint32_t off = 0, i = 0; off < size; off += 1u << MEM_PAGE_BITS, i++) {
        m->page[(base + off) >> MEM_PAGE_BITS] = data + off;
        m->meta[(base + off) >> MEM_PAGE_BITS] = meta + i;
    }
}

uint8_t *mem_add_ram(c6x_mem *m, const char *name, uint32_t base, uint32_t size, uint32_t alias)
{
    mem_region *r = &m->regions[m->nregions++];
    r->name = name; r->base = base; r->size = size; r->alias = alias;
    r->data = calloc(1, size);
    page_meta *meta = calloc((size >> MEM_PAGE_BITS) + 1, sizeof(page_meta));
    map(m, base, size, r->data, meta);
    if (alias) map(m, alias, size, r->data, meta);
    return r->data;
}

int mem_load(c6x_mem *m, uint32_t addr, const void *data, uint32_t len)
{
    const uint8_t *d = data;
    stale_touch(m, addr, len);
    for (uint32_t i = 0; i < len; i++) {
        uint8_t *p = mem_ptr(m, addr + i);
        if (!p) return -1;
        *p = d[i];
        mem_code_touch(m, addr + i);
    }
    return 0;
}

int mem_read_block(c6x_mem *m, uint32_t addr, void *out, uint32_t len)
{
    uint8_t *o = out;
    for (uint32_t i = 0; i < len; i++) {
        uint8_t *p = mem_ptr(m, addr + i);
        if (!p) return -1;
        o[i] = *p;
    }
    return 0;
}

int mem_fetch_block(c6x_mem *m, uint32_t addr, void *out, uint32_t len)
{
    uint8_t *o = out;
    for (uint32_t i = 0; i < len; i++) {
        uint32_t a = addr + i;
        int stale_hit = 0;
        for (int r = 0; r < m->stale_n; r++) {
            if (m->stale_active[r] && a >= m->stale_lo[r] && a < m->stale_hi[r]) {
                o[i] = m->stale_snap[r][a - m->stale_lo[r]];
                m->stale_fetches[r]++;
                m->stale_fetches_total++;
                stale_hit = 1;
                break;
            }
        }
        if (stale_hit) continue;
        uint8_t *p = mem_ptr(m, a);
        if (!p) return -1;
        o[i] = *p;
    }
    return 0;
}

uint32_t mem_rd(c6x_mem *m, uint32_t addr, int size)
{
    uint8_t *p = mem_ptr(m, addr);
    if (p) {
        switch (size) {
        case 1: return p[0];
        case 2: return p[0] | (p[1] << 8);
        default: return p[0] | (p[1] << 8) | (p[2] << 16) | ((uint32_t)p[3] << 24);
        }
    }
    if (m->mmio_read) return m->mmio_read(m->sys, addr, size);
    m->unmapped_reads++;
    return 0;
}

/* Flat SDRAM here has no notion of the stock arena/looper reservations.
   Report writes into those zones once per run so a successful emulation is
   never mistaken for a hardware-safe pool placement. Always on, no flag. */
static void zone_warn(c6x_mem *m, uint32_t addr)
{
    if (addr >= 0xC022D000u && addr < 0xC0636980u) {
        m->zone_arena_hits++;
        if (!m->zone_warned_arena) {
            m->zone_warned_arena = 1;
            fprintf(stderr, "SDRAM ZONE WARN: write %08X into stock effect arenas "
                            "(C022D000..C0636980); flat map cannot model reservations\n", addr);
        }
    } else if (addr >= 0xC0636980u && addr < 0xC0800000u) {
        m->zone_looper_hits++;
        if (!m->zone_warned_looper) {
            m->zone_warned_looper = 1;
            fprintf(stderr, "SDRAM ZONE WARN: write %08X into looper/reserved region "
                            "(C0636980..C07FFFFF); emulation pass is not hardware-safe\n", addr);
        }
    }
}

void mem_wr(c6x_mem *m, uint32_t addr, int size, uint32_t val)
{
    uint8_t *p = mem_ptr(m, addr);
    zone_warn(m, addr);
    if (p) stale_touch(m, addr, (uint32_t)size);
    if (m->sys && m->sys->bootlogf) bootlog_hook(m->sys, addr, size, val);
    if (addr >= m->wwatch_lo && addr < m->wwatch_hi && m->on_wwatch) m->on_wwatch(m->sys, addr, size, val);
    if (p) {
        mem_code_touch(m, addr);
        if (size > 1) mem_code_touch(m, addr + size - 1);
        p[0] = (uint8_t)val;
        if (size > 1) p[1] = (uint8_t)(val >> 8);
        if (size > 2) { p[2] = (uint8_t)(val >> 16); p[3] = (uint8_t)(val >> 24); }
        return;
    }
    if (m->mmio_write) { m->mmio_write(m->sys, addr, size, val); return; }
    m->unmapped_writes++;
}

/* map [dst, dst+span) as repeated copies of the RAM at [src, src+size) */
void mem_mirror(c6x_mem *m, uint32_t src, uint32_t size, uint32_t dst, uint32_t span)
{
    for (uint32_t off = 0; off < span; off += 1u << MEM_PAGE_BITS) {
        uint32_t s = src + (off % size);
        m->page[(dst + off) >> MEM_PAGE_BITS] = m->page[s >> MEM_PAGE_BITS];
        m->meta[(dst + off) >> MEM_PAGE_BITS] = m->meta[s >> MEM_PAGE_BITS];
    }
}
