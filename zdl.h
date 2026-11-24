/* Zoom ZDL effect loader: 76-byte Zoom header + TI C6000 ELF (ET_DYN). */
#ifndef C6X_ZDL_H
#define C6X_ZDL_H
#include <stdint.h>
#include "mem.h"

typedef struct { char name[96]; uint32_t value; uint32_t size; int shndx; } zdl_sym;

typedef struct {
    uint32_t text_base, const_base;  /* where vaddr 0 / 0x80000000 were placed */
    zdl_sym syms[256];
    int nsyms;
    int nrel, nrel_bad;
    char undefined[16][96];
    int nundef;
    uint32_t text_size, const_size;
} zdl_info;

/* map a ZDL virtual address to the emulator address */
uint32_t zdl_map(const zdl_info *z, uint32_t vaddr);
int zdl_load(c6x_mem *m, const uint8_t *d, uint32_t len, uint32_t text_base, uint32_t const_base,
             uint32_t undef_stub, zdl_info *z);
const zdl_sym *zdl_find(const zdl_info *z, const char *name);
/* audio function: Fx_* without _init/_onf/_edit suffix */
const zdl_sym *zdl_audio_func(const zdl_info *z);

#endif
