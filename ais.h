#ifndef C6X_AIS_H
#define C6X_AIS_H
#include <stdint.h>
#include "mem.h"

typedef struct {
    uint32_t entry;
    int nsets;
    uint32_t sets[64][4];     /* Set: type, addr, data, sleep */
    int nfn;
    uint32_t fn[16][9];       /* FunctionExec: idx, nargs, args[7] */
    int nsections;
    uint32_t sect[256][2];    /* addr, size */
} ais_info;

/* Parse AIS image and load sections into memory. Returns 0 on success. */
int ais_load(c6x_mem *m, const uint8_t *data, uint32_t len, ais_info *info, int verbose);
uint8_t *read_file(const char *path, uint32_t *len);

#endif
