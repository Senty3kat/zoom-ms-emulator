#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ais.h"

static uint32_t w32(const uint8_t *p) { return p[0] | (p[1] << 8) | (p[2] << 16) | ((uint32_t)p[3] << 24); }

uint8_t *read_file(const char *path, uint32_t *len)
{
    FILE *f = fopen(path, "rb");
    if (!f) return NULL;
    fseek(f, 0, SEEK_END);
    long n = ftell(f);
    fseek(f, 0, SEEK_SET);
    uint8_t *b = malloc(n + 1);
    if (fread(b, 1, n, f) != (size_t)n) { fclose(f); free(b); return NULL; }
    fclose(f);
    *len = (uint32_t)n;
    return b;
}

int ais_load(c6x_mem *m, const uint8_t *d, uint32_t len, ais_info *info, int verbose)
{
    memset(info, 0, sizeof *info);
    if (len < 4 || w32(d) != 0x41504954) return -1;
    uint32_t o = 4;
    while (o + 4 <= len) {
        uint32_t op = w32(d + o);
        o += 4;
        switch (op) {
        case 0x58535901: { /* SectionLoad */
            uint32_t addr = w32(d + o), size = w32(d + o + 4);
            if (verbose) printf("ais: SectionLoad 0x%08X +0x%X\n", addr, size);
            if (mem_load(m, addr, d + o + 8, size)) fprintf(stderr, "ais: section 0x%08X not in RAM\n", addr);
            if (info->nsections < 256) { info->sect[info->nsections][0] = addr; info->sect[info->nsections][1] = size; info->nsections++; }
            o += 8 + ((size + 3) & ~3u);
            break;
        }
        case 0x5853590A: { /* SectionFill: addr, size, type, pattern */
            uint32_t addr = w32(d + o), size = w32(d + o + 4), type = w32(d + o + 8), pat = w32(d + o + 12);
            if (verbose) printf("ais: SectionFill 0x%08X +0x%X type=%u pat=0x%X\n", addr, size, type, pat);
            for (uint32_t i = 0; i < size; i++) {
                uint8_t *p = mem_ptr(m, addr + i);
                if (p) *p = (uint8_t)(pat >> (8 * (i & 3)));
            }
            o += 16;
            break;
        }
        case 0x58535907: /* Set: type, addr, data, sleep */
            if (info->nsets < 64) memcpy(info->sets[info->nsets++], d + o, 16);
            if (verbose) printf("ais: Set type=%u addr=0x%08X data=0x%08X sleep=%u\n", w32(d + o), w32(d + o + 4), w32(d + o + 8), w32(d + o + 12));
            o += 16;
            break;
        case 0x5853590D: { /* FunctionExec */
            uint32_t hdr = w32(d + o), n = hdr >> 16, idx = hdr & 0xFFFF;
            if (info->nfn < 16) {
                info->fn[info->nfn][0] = idx; info->fn[info->nfn][1] = n;
                for (uint32_t i = 0; i < n && i < 7; i++) info->fn[info->nfn][2 + i] = w32(d + o + 4 + 4 * i);
                info->nfn++;
            }
            if (verbose) printf("ais: FunctionExec fn=%u nargs=%u\n", idx, n);
            o += 4 + 4 * n;
            break;
        }
        case 0x58535902: o += 8; break;           /* RequestCRC */
        case 0x58535903: case 0x58535904: case 0x58535963: break;
        case 0x58535905: case 0x58535906:          /* Jump / JumpClose */
            info->entry = w32(d + o);
            if (verbose) printf("ais: %s 0x%08X\n", op == 0x58535906 ? "JumpClose" : "Jump", info->entry);
            o += 4;
            if (op == 0x58535906) return 0;
            break;
        default:
            fprintf(stderr, "ais: unknown opcode 0x%08X at 0x%X\n", op, o - 4);
            return -2;
        }
    }
    return 0;
}
