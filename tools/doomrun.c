/* c6xdoom: run the bare-metal Doom build (doom/out/doom_emu.out) on the C674x core.

   usage: c6xdoom doom_emu.out doom1.wad [options]
     -s SEC            emulated seconds (default 20)
     -key MS:DOWN:KEY  key event at MS: DOWN 1/0, KEY = Doom key code (decimal or 0x..)
     -tap MS:KEY       press at MS, release 120 ms later
     -frames DIR       every frame as DIR/fNNNN_lcd.pgm (128x64) and DIR/fNNNN.ppm (320x200)
     -every N          keep only every Nth frame (default 1)
     -q                no Doom console output
     -probe SYM        print A4/B4/B3 at every entry of SYM (up to 8)

   The program's printf goes through TI's CIO protocol (C$$IO$$ / _CIOBUF_) and is
   printed here. zd_frame_ready() marks a finished frame (zd_lcd, DG_ScreenBuffer,
   colors[]). Keys go into the zd_keys ring. The IWAD is loaded at 0xC3000000 and its
   length written to zd_wad_len. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../cpu.h"
#include "../elf.h"
#include "../ais.h"

#define WAD_AT 0xC3000000u
#define CPU_HZ 300000000.0

static c6x_mem m;
static c6x_cpu c;
static uint32_t a_cio, a_ciobuf, a_frame, a_lcd, a_scr, a_colors, a_keys, a_frames;
static uint32_t stops[4];
static int nstops, quiet, every = 1, nframe, nprobe;
static uint32_t probes[8];
static const char *framedir;

static void cio(void)
{
    uint32_t len = mem_rd(&m, a_ciobuf, 4);
    uint8_t cmd = mem_rd(&m, a_ciobuf + 4, 1), parm[8];
    for (int i = 0; i < 8; i++) parm[i] = mem_rd(&m, a_ciobuf + 5 + i, 1);
    int ret = -1;
    if (cmd == 0xF3) {                            /* write(fd, data, count) */
        int fd = parm[0] | parm[1] << 8, cnt = parm[2] | parm[3] << 8;
        if (cnt > (int)len) cnt = len;
        for (int i = 0; i < cnt; i++) {
            int ch = mem_rd(&m, a_ciobuf + 13 + i, 1);
            if (!quiet) fputc(ch, fd == 2 ? stderr : stdout);
        }
        ret = cnt;
    } else if (cmd == 0xF8 || cmd == 0xF9) {       /* time / clock */
        ret = (int)(c.cycle / CPU_HZ);
    }
    /* reply: length 0, parm[0..1] = result (sign-extended by the RTS) */
    mem_wr(&m, a_ciobuf, 4, 0);
    mem_wr(&m, a_ciobuf + 4, 1, ret & 0xFF);
    mem_wr(&m, a_ciobuf + 5, 1, (ret >> 8) & 0xFF);
    mem_wr(&m, a_ciobuf + 6, 1, (ret >> 16) & 0xFF);
    mem_wr(&m, a_ciobuf + 7, 1, (ret >> 24) & 0xFF);
}

static void frame(void)
{
    nframe++;
    if (!framedir || (nframe - 1) % every) return;
    char path[512];
    snprintf(path, sizeof path, "%s/f%04d_lcd.pgm", framedir, nframe);
    FILE *f = fopen(path, "wb");
    if (f) {
        fprintf(f, "P5 128 64 255\n");
        for (int y = 0; y < 64; y++)
            for (int x = 0; x < 128; x++)
                fputc(mem_rd(&m, a_lcd + (y >> 3) * 128 + x, 1) >> (y & 7) & 1 ? 0 : 255, f);
        fclose(f);
    }
    snprintf(path, sizeof path, "%s/f%04d.ppm", framedir, nframe);
    f = fopen(path, "wb");
    if (f) {
        uint32_t scr = mem_rd(&m, a_scr, 4);
        fprintf(f, "P6 320 200 255\n");
        for (int i = 0; i < 320 * 200; i++) {
            uint32_t col = mem_rd(&m, a_colors + 4 * mem_rd(&m, scr + i, 1), 4);
            fputc(col >> 16 & 0xFF, f); fputc(col >> 8 & 0xFF, f); fputc(col & 0xFF, f);
        }
        fclose(f);
    }
}

static void on_bp(c6x_cpu *cp, uint32_t addr)
{
    if (addr == a_cio) cio();
    else if (addr == a_frame) frame();
    for (int i = 0; i < nprobe; i++)
        if (addr == probes[i]) fprintf(stderr, "%10.3f ms probe %08X A4=%08X B4=%08X B3=%08X\n",
                                       cp->cycle * 1000.0 / CPU_HZ, addr, cp->r[0][4], cp->r[1][4], cp->r[1][3]);
    for (int i = 0; i < nstops; i++) if (addr == stops[i]) cp->bp_hit = 1;
}

typedef struct { double ms; int down, key; } kev;

static void push_key(int down, int key)
{
    uint32_t head = mem_rd(&m, a_keys, 4);
    mem_wr(&m, a_keys + 8 + (head & 63) * 2, 1, down);
    mem_wr(&m, a_keys + 8 + (head & 63) * 2 + 1, 1, key);
    mem_wr(&m, a_keys, 4, head + 1);
}

static uint32_t sym(elf_info *ei, const char *n)
{
    uint32_t a;
    if (elf_sym_addr(ei, n, &a)) { fprintf(stderr, "missing symbol %s\n", n); exit(1); }
    return a;
}

int main(int argc, char **argv)
{
    if (argc < 3) { fprintf(stderr, "usage: c6xdoom doom_emu.out doom1.wad [-s SEC] [-key MS:DOWN:KEY] [-tap MS:KEY] [-frames DIR] [-every N] [-q]\n"); return 1; }
    double secs = 20;
    static kev keys[1024];
    int nkeys = 0;
    for (int i = 3; i < argc; i++) {
        if (!strcmp(argv[i], "-s") && i + 1 < argc) secs = atof(argv[++i]);
        else if (!strcmp(argv[i], "-key") && i + 1 < argc && nkeys < 1024) {
            char *p = argv[++i];
            keys[nkeys].ms = strtod(p, &p); keys[nkeys].down = strtol(p + 1, &p, 0);
            keys[nkeys].key = strtol(p + 1, NULL, 0); nkeys++;
        } else if (!strcmp(argv[i], "-tap") && i + 1 < argc && nkeys < 1023) {
            char *p = argv[++i];
            double ms = strtod(p, &p); int k = strtol(p + 1, NULL, 0);
            keys[nkeys++] = (kev){ ms, 1, k };
            keys[nkeys++] = (kev){ ms + 120, 0, k };
        } else if (!strcmp(argv[i], "-frames") && i + 1 < argc) framedir = argv[++i];
        else if (!strcmp(argv[i], "-every") && i + 1 < argc) every = atoi(argv[++i]);
        else if (!strcmp(argv[i], "-q")) quiet = 1;
        else if (!strcmp(argv[i], "-probe") && i + 1 < argc && nprobe < 8) probes[nprobe++] = 0, i++;
    }
    mem_init(&m);
    mem_add_ram(&m, "L2", 0x11800000, 256 * 1024, 0x00800000);
    mem_add_ram(&m, "SDRAM", 0xC0000000, 64 * 1024 * 1024, 0);
    uint32_t len, wlen;
    uint8_t *img = read_file(argv[1], &len), *wad = read_file(argv[2], &wlen);
    if (!img || !wad) { perror("read"); return 1; }
    elf_info ei;
    if (elf_load(&m, img, len, &ei)) { fprintf(stderr, "bad ELF\n"); return 1; }
    mem_load(&m, WAD_AT, wad, wlen);
    mem_wr(&m, sym(&ei, "zd_wad_len"), 4, wlen);
    a_cio = sym(&ei, "C$$IO$$"); a_ciobuf = sym(&ei, "__CIOBUF_");
    a_frame = sym(&ei, "zd_frame_ready"); a_lcd = sym(&ei, "zd_lcd");
    a_scr = sym(&ei, "DG_ScreenBuffer"); a_colors = sym(&ei, "colors");
    a_keys = sym(&ei, "zd_keys"); a_frames = sym(&ei, "zd_frames");
    const char *stopn[] = { "C$$EXIT", "abort" };
    for (int i = 0; i < 2; i++) { uint32_t a; if (!elf_sym_addr(&ei, stopn[i], &a)) stops[nstops++] = a; }
    cpu_init(&c, &m);
    cpu_reset(&c, ei.entry);
    c.bp[c.nbp++] = a_cio; c.bp[c.nbp++] = a_frame;
    for (int i = 0; i < nstops; i++) c.bp[c.nbp++] = stops[i];
    for (int i = 3, k = 0; i < argc; i++)
        if (!strcmp(argv[i], "-probe") && i + 1 < argc) { probes[k] = sym(&ei, argv[i + 1]); c.bp[c.nbp++] = probes[k++]; }
    c.on_bp = on_bp;
    uint64_t end = (uint64_t)(secs * CPU_HZ), slice = (uint64_t)(CPU_HZ / 1000);
    int next = 0;
    while (c.cycle < end && !c.bp_hit && !c.err[0]) {
        double ms = c.cycle * 1000.0 / CPU_HZ;
        while (next < nkeys && keys[next].ms <= ms) { push_key(keys[next].down, keys[next].key); next++; }
        cpu_run(&c, slice);
        if (c.halted) break;
    }
    fprintf(stderr, "\ntime=%.2f s cycles=%llu frames=%d (%.1f fps) pc=%08X %s%s\n", c.cycle / CPU_HZ,
            (unsigned long long)c.cycle, nframe, nframe / (c.cycle / CPU_HZ), c.pc,
            c.bp_hit ? "[exit] " : "", c.err);
    if (c.err[0] || c.bp_hit) cpu_dump(&c, stderr);
    return 0;
}
