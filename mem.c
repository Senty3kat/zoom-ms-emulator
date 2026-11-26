#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "mem.h"
#include "sys.h"

static void bootlog_hook(struct c6x_sys *s, uint32_t addr, int size, uint32_t val)
{
    sys_bootlog_write(s, addr, size, val);
}

void mem_init(c6x_mem *m)
{
    memset(m, 0, sizeof *m);
    m->page = calloc(MEM_PAGES, sizeof(uint8_t *));
    m->meta = calloc(MEM_PAGES, sizeof(page_meta *));
}

void mem_free(c6x_mem *m)
{
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

void mem_wr(c6x_mem *m, uint32_t addr, int size, uint32_t val)
{
    uint8_t *p = mem_ptr(m, addr);
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
