/* c6xdis: disassemble an AIS image at the addresses listed in a dis6x
   reference TSV (first two columns: hex addr, size) -> "addr\ttext". */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../decode.h"
#include "../mem.h"
#include "../ais.h"

static int fetch(void *ctx, uint32_t a, uint8_t out[32]) { return mem_read_block(ctx, a, out, 32); }

int main(int argc, char **argv)
{
    if (argc < 3) { fprintf(stderr, "usage: c6xdis image.ais ref.tsv\n"); return 1; }
    c6x_mem m;
    mem_init(&m);
    mem_add_ram(&m, "L2", 0x11800000, 256 * 1024, 0x00800000);
    mem_add_ram(&m, "SDRAM", 0xC0000000, 64 * 1024 * 1024, 0);
    mem_add_ram(&m, "SHRAM", 0x80000000, 128 * 1024, 0);
    uint32_t len;
    uint8_t *img = read_file(argv[1], &len);
    if (!img) { perror(argv[1]); return 1; }
    ais_info info;
    if (ais_load(&m, img, len, &info, 0)) { fprintf(stderr, "bad AIS\n"); return 1; }
    char line[512], text[256];
    if (!strcmp(argv[2], "-r") && argc >= 5) {
        uint32_t a = (uint32_t)strtoul(argv[3], NULL, 16), e = (uint32_t)strtoul(argv[4], NULL, 16);
        while (a < e) {
            c6x_insn in;
            int n = c6x_decode(fetch, &m, a, &in);
            if (n == 0) break;
            if (!in.valid && in.size == 4 && (a & 31) == 28 && in.header) { a += 4; continue; }
            c6x_format_insn(&in, text, sizeof text);
            printf("%08x %s%s\n", a, in.p ? "|| " : "   ", text);
            a += n;
        }
        return 0;
    }
    FILE *f = fopen(argv[2], "r");
    while (fgets(line, sizeof line, f)) {
        uint32_t a = (uint32_t)strtoul(line, NULL, 16);
        c6x_insn in;
        int n = c6x_decode(fetch, &m, a, &in);
        if (n == 0) strcpy(text, "<fetch error>");
        else if (!in.valid && in.size == 4 && (a & 31) == 28 && in.header) strcpy(text, ".fphead");
        else c6x_format_insn(&in, text, sizeof text);
        printf("%08x\t%d\t%d\t%s\n", a, in.size, in.p, text);
    }
    return 0;
}
