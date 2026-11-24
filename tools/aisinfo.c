/* aisinfo: list AIS commands of an image */
#include <stdio.h>
#include "../ais.h"

int main(int argc, char **argv)
{
    if (argc < 2) return 1;
    c6x_mem m;
    mem_init(&m);
    mem_add_ram(&m, "L2", 0x11800000, 256 * 1024, 0x00800000);
    mem_add_ram(&m, "SDRAM", 0xC0000000, 256 * 1024 * 1024, 0);
    mem_add_ram(&m, "SH", 0x80000000, 128 * 1024, 0);
    mem_add_ram(&m, "L1P", 0x11E00000, 32 * 1024, 0);
    uint32_t len;
    uint8_t *d = read_file(argv[1], &len);
    if (!d) return 1;
    ais_info i;
    int r = ais_load(&m, d, len, &i, 1);
    printf("r=%d entry=%08X\n", r, i.entry);
    for (int k = 0; k < i.nfn; k++) {
        printf("fn %u:", i.fn[k][0]);
        for (unsigned a = 0; a < i.fn[k][1] && a < 7; a++) printf(" %08X", i.fn[k][2 + a]);
        printf("\n");
    }
    return 0;
}
