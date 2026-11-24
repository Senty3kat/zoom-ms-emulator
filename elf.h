#ifndef C6X_ELF_H
#define C6X_ELF_H
#include <stdint.h>
#include "mem.h"

typedef struct { char name[64]; uint32_t value, size; } elf_sym;
typedef struct {
    uint32_t entry;
    elf_sym *syms;
    int nsyms;
} elf_info;

int elf_load(c6x_mem *m, const uint8_t *d, uint32_t len, elf_info *info);
int elf_sym_addr(const elf_info *info, const char *name, uint32_t *addr);

#endif
