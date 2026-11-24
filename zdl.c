#include <stdio.h>
#include <string.h>
#include "zdl.h"

static uint32_t r32(const uint8_t *p) { return p[0] | (p[1] << 8) | (p[2] << 16) | ((uint32_t)p[3] << 24); }
static uint16_t r16(const uint8_t *p) { return (uint16_t)(p[0] | (p[1] << 8)); }

uint32_t zdl_map(const zdl_info *z, uint32_t va)
{
    if (va >= 0x80000000u) return z->const_base + (va - 0x80000000u);
    return z->text_base + va;
}

static void patch_cst16(c6x_mem *m, uint32_t p, uint32_t v16)
{
    uint32_t w = mem_rd(m, p, 4);
    w = (w & ~(0xFFFFu << 7)) | ((v16 & 0xFFFF) << 7);
    mem_wr(m, p, 4, w);
}

int zdl_load(c6x_mem *m, const uint8_t *d, uint32_t len, uint32_t text_base, uint32_t const_base,
             uint32_t undef_stub, zdl_info *z)
{
    memset(z, 0, sizeof *z);
    z->text_base = text_base;
    z->const_base = const_base;
    if (len < 76 + 52) return -1;
    const uint8_t *e = d + 76;
    uint32_t elen = len - 76;
    if (memcmp(e, "\x7f" "ELF", 4)) return -2;
    uint32_t phoff = r32(e + 28), shoff = r32(e + 32);
    uint16_t phes = r16(e + 42), phn = r16(e + 44), shes = r16(e + 46), shn = r16(e + 48);
    for (int i = 0; i < phn; i++) {
        const uint8_t *ph = e + phoff + i * phes;
        if (r32(ph) != 1) continue;
        uint32_t off = r32(ph + 4), va = r32(ph + 8), fsz = r32(ph + 16), msz = r32(ph + 20);
        uint32_t at = zdl_map(z, va);
        if (off + fsz > elen) return -3;
        mem_load(m, at, e + off, fsz);
        for (uint32_t k = fsz; k < msz; k++) { uint8_t zz = 0; mem_load(m, at + k, &zz, 1); }
        if (va < 0x80000000u) { if (va + msz > z->text_size) z->text_size = va + msz; }
        else if (va + msz - 0x80000000u > z->const_size) z->const_size = va + msz - 0x80000000u;
    }
    /* sections */
    const uint8_t *dynsym = NULL, *dynstr = NULL, *rela = NULL;
    uint32_t nsym = 0, nrela = 0;
    for (int i = 0; i < shn; i++) {
        const uint8_t *sh = e + shoff + i * shes;
        uint32_t type = r32(sh + 4), off = r32(sh + 16), size = r32(sh + 20), link = r32(sh + 24);
        if (type == 11) { /* SHT_DYNSYM */
            dynsym = e + off; nsym = size / 16;
            dynstr = e + r32(e + shoff + link * shes + 16);
        } else if (type == 4 && size) { /* SHT_RELA */
            rela = e + off; nrela = size / 12;
        }
    }
    if (!dynsym) return -4;
    for (uint32_t i = 0; i < nsym && z->nsyms < 256; i++) {
        const uint8_t *s = dynsym + 16 * i;
        zdl_sym *o = &z->syms[z->nsyms++];
        snprintf(o->name, sizeof o->name, "%s", (const char *)dynstr + r32(s));
        o->value = r32(s + 4);
        o->size = r32(s + 8);
        o->shndx = r16(s + 14);
    }
    for (uint32_t i = 0; i < nrela; i++) {
        const uint8_t *r = rela + 12 * i;
        uint32_t off = r32(r), info = r32(r + 4);
        int32_t add = (int32_t)r32(r + 8);
        uint32_t type = info & 0xFF, si = info >> 8;
        uint32_t S = 0;
        if (si && si < (uint32_t)z->nsyms) {
            const zdl_sym *sy = &z->syms[si];
            if (sy->shndx == 0) {
                if (z->nundef < 16) snprintf(z->undefined[z->nundef++], 96, "%s", sy->name);
                S = undef_stub;
            } else S = zdl_map(z, sy->value);
        }
        uint32_t P = zdl_map(z, off), V = S + (uint32_t)add;
        switch (type) {
        case 1: mem_wr(m, P, 4, V); break;                         /* R_C6000_ABS32 */
        case 9: patch_cst16(m, P, V & 0xFFFF); break;              /* ABS_L16 (MVKL) */
        case 10: patch_cst16(m, P, V >> 16); break;                /* ABS_H16 (MVKH) */
        case 4: {                                                  /* PCR_S21 */
            uint32_t w = mem_rd(m, P, 4);
            int32_t disp = (int32_t)(V - (P & ~31u)) >> 2;
            w = (w & ~(0x1FFFFFu << 7)) | (((uint32_t)disp & 0x1FFFFF) << 7);
            mem_wr(m, P, 4, w);
            break;
        }
        default: z->nrel_bad++; break;
        }
        z->nrel++;
    }
    return 0;
}

const zdl_sym *zdl_find(const zdl_info *z, const char *name)
{
    for (int i = 0; i < z->nsyms; i++)
        if (!strcmp(z->syms[i].name, name)) return &z->syms[i];
    return NULL;
}

const zdl_sym *zdl_audio_func(const zdl_info *z)
{
    for (int i = 0; i < z->nsyms; i++) {
        const char *n = z->syms[i].name;
        size_t l = strlen(n);
        if (strncmp(n, "Fx_", 3) || z->syms[i].shndx == 0) continue;
        if ((l > 5 && !strcmp(n + l - 5, "_init")) || (l > 4 && !strcmp(n + l - 4, "_onf")) ||
            (l > 5 && !strcmp(n + l - 5, "_edit")) || strstr(n, "_Coe")) continue;
        return &z->syms[i];
    }
    return NULL;
}
