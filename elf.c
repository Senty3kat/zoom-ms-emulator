/* Minimal ELF32 little-endian loader (TI C6000 EABI executables). */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "elf.h"

static uint32_t r32(const uint8_t *p) { return p[0] | (p[1] << 8) | (p[2] << 16) | ((uint32_t)p[3] << 24); }
static uint16_t r16(const uint8_t *p) { return (uint16_t)(p[0] | (p[1] << 8)); }

int elf_load(c6x_mem *m, const uint8_t *d, uint32_t len, elf_info *info)
{
    memset(info, 0, sizeof *info);
    if (len < 52 || memcmp(d, "\x7f" "ELF", 4) || d[4] != 1 || d[5] != 1) return -1;
    info->entry = r32(d + 24);
    uint32_t phoff = r32(d + 28), shoff = r32(d + 32);
    uint16_t phentsize = r16(d + 42), phnum = r16(d + 44), shentsize = r16(d + 46), shnum = r16(d + 48);
    for (int i = 0; i < phnum; i++) {
        const uint8_t *ph = d + phoff + i * phentsize;
        uint32_t type = r32(ph), off = r32(ph + 4), paddr = r32(ph + 12), filesz = r32(ph + 16), memsz = r32(ph + 20);
        if (type != 1) continue;
        if (filesz && mem_load(m, paddr, d + off, filesz))
            fprintf(stderr, "elf: segment 0x%08X not in RAM\n", paddr);
        for (uint32_t k = filesz; k < memsz; k++) { uint8_t z = 0; mem_load(m, paddr + k, &z, 1); }
    }
    /* symbol table */
    for (int i = 0; i < shnum; i++) {
        const uint8_t *sh = d + shoff + i * shentsize;
        if (r32(sh + 4) != 2) continue;  /* SHT_SYMTAB */
        uint32_t off = r32(sh + 16), size = r32(sh + 20), link = r32(sh + 24), ent = r32(sh + 36);
        const uint8_t *strsh = d + shoff + link * shentsize;
        const char *strtab = (const char *)d + r32(strsh + 16);
        uint32_t n = size / ent;
        info->syms = calloc(n, sizeof(elf_sym));
        for (uint32_t k = 0; k < n; k++) {
            const uint8_t *s = d + off + k * ent;
            const char *name = strtab + r32(s);
            if (!name[0]) continue;
            elf_sym *e = &info->syms[info->nsyms++];
            snprintf(e->name, sizeof e->name, "%s", name);
            e->value = r32(s + 4);
            e->size = r32(s + 8);
        }
    }
    return 0;
}

int elf_sym_addr(const elf_info *info, const char *name, uint32_t *addr)
{
    for (int i = 0; i < info->nsyms; i++)
        if (!strcmp(info->syms[i].name, name)) { *addr = info->syms[i].value; return 0; }
    return -1;
}
