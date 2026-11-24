/* c6xtest: run a TI-compiled ELF test program and dump a result array.
   usage: c6xtest prog.out [result_symbol] [count] [max_cycles]
   Stops at C$$EXIT / abort / exit. Prints "i value" lines (hex). */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../cpu.h"
#include "../elf.h"
#include "../ais.h"

int main(int argc, char **argv)
{
    if (argc < 2) { fprintf(stderr, "usage: c6xtest prog.out [sym] [count] [max_cycles] [trace]\n"); return 1; }
    const char *sym = argc > 2 ? argv[2] : "results";
    int count = argc > 3 ? atoi(argv[3]) : 0;
    uint64_t maxc = argc > 4 ? strtoull(argv[4], NULL, 0) : 200000000ULL;
    c6x_mem m;
    mem_init(&m);
    mem_add_ram(&m, "L2", 0x11800000, 256 * 1024, 0x00800000);
    mem_add_ram(&m, "SDRAM", 0xC0000000, 64 * 1024 * 1024, 0);
    uint32_t len;
    uint8_t *img = read_file(argv[1], &len);
    if (!img) { perror(argv[1]); return 1; }
    elf_info ei;
    if (elf_load(&m, img, len, &ei)) { fprintf(stderr, "bad ELF\n"); return 1; }
    static c6x_cpu c;
    cpu_init(&c, &m);
    cpu_reset(&c, ei.entry);
    const char *stops[] = { "C$$EXIT", "abort", "exit", "_abort_msg" };
    for (unsigned i = 0; i < sizeof stops / sizeof stops[0]; i++) {
        uint32_t a;
        if (!elf_sym_addr(&ei, stops[i], &a)) c.bp[c.nbp++] = a;
    }
    if (argc > 5) c.trace = 1;
    cpu_run(&c, maxc);
    fprintf(stderr, "cycles=%llu packets=%llu insns=%llu pc=%08X %s%s\n", (unsigned long long)c.cycle,
            (unsigned long long)c.packets, (unsigned long long)c.insns, c.pc,
            c.bp_hit ? "[exit]" : "[NO EXIT]", c.err[0] ? c.err : "");
    if (!c.bp_hit) cpu_dump(&c, stderr);
    uint32_t base;
    if (count && !elf_sym_addr(&ei, sym, &base)) {
        for (int i = 0; i < count; i++) printf("%d %08x\n", i, mem_rd(&m, base + 4 * i, 4));
    }
    return c.bp_hit ? 0 : 2;
}
