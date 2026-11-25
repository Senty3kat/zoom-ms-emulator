/* Zoom MS pedal system model: C6745 DSP + peripherals. */
#ifndef C6X_SYS_H
#define C6X_SYS_H
#include <stdint.h>
#include <stdio.h>
#include "cpu.h"
#include "cache.h"
#include "usb.h"
#include "mem.h"

#define MMIO_BASE 0x01800000u
#define MMIO_SIZE 0x00800000u

typedef struct {
    uint32_t addr;
    uint32_t reads, writes;
    uint32_t last;
} mmio_stat;

typedef struct c6x_sys {
    c6x_cpu cpu;
    c6x_mem mem;
    uint32_t *mmio;           /* backing store for 0x01800000..0x01FFFFFF */
    mmio_stat stats[4096];
    int nstats;
    int log_mmio;
    uint32_t watch_lo, watch_hi;   /* log reads in [lo, hi) with PC */
    FILE *logf;
    FILE *lcdf;               /* -lcdlog: each LCD page select (page 0 = frame start) */
    FILE *adcf;               /* -adclog: SPI1 SPIDAT1/0 writes (ADC poll) */
    FILE *evf;                /* -evlog: DSP/BIOS event posts (diagnostics) */
    uint32_t lcd_frame_data;  /* data bytes since the last page-0 select */
    FILE *ledf;               /* -led: LED (GPIO 0) changes with time and PC */
    FILE *gpiolf;             /* -gpiolog: all GPIO pin changes with time and PC */
    FILE *dmalf;              /* -dma: EDMA transfers */
    FILE *spilf;              /* -spi: SPI0 words with clock/CS */
    double spi_lcd_max, spi_flash_max;  /* -spilimit, MHz; 0 = no check */
    int spi_limit_warned;

    /* DSP interrupt controller */
    uint32_t evtflag[4];      /* 128 events */
    uint32_t evtmask[4];
    uint32_t intmux[3];

    /* timers (TIMER64P0/1) */
    struct {
        uint64_t start_cycle;
        uint32_t tim12, tim34, prd12, prd34, tcr, tgcr;
        int running12, running34;
        uint64_t last_update;
        uint64_t next_irq12, next_irq34;
    } tmr[2];
    uint32_t cpu_hz;
    uint32_t timer_hz;
    uint32_t emifb[16];       /* EMIFB SDRAM controller 0xB0000000.. (SDCR 08, SDRCR 0C, SDTIMR 10, SDTIMR2 14) */
    void (*on_clock)(struct c6x_sys *, uint64_t now, double ratio);  /* core clock changed: rescale later events */
    int clock_changes;        /* run-time core clock changes (PLL bypass / relock) */
    uint64_t wall_cyc;        /* cycle of the last clock change ... */
    double wall_s;            /* ... and the wall time then, seconds */
    double emif_force;        /* -emif: SDRAM clock in MHz instead of the computed one (0 = computed) */

    /* GPIO inputs (banks of 32 bits) */
    uint32_t gpio_in[5];
    uint32_t gpio_out[5];

    /* LCD (ST7565 over SPI0) */
    uint8_t lcd_vram[8][132];
    uint8_t lcd_page, lcd_col_hi, lcd_col_lo, lcd_contrast_pending, lcd_contrast;
    uint32_t lcd_cmds, lcd_data;
    int lcd_dc_pin;           /* GPIO pin number used for D/C (-1 unknown) */
    uint8_t spi_last[64];
    int spi_nlast;
    int lcd_cs_pin;           /* GPIO pin used as LCD chip select (active low) */

    /* SPI0 receive side */
    uint32_t spibuf;
    int spi_rx_valid;
    uint64_t spi_start, spi_done;   /* CPU cycles: word in flight starts / is shifted out */
    uint64_t spi_busy;              /* total SPI0 shift time, CPU cycles */

    /* serial NOR flash MX25L3233F on SPI0 */
    uint8_t *flash;
    uint32_t flash_size;
    int fl_active;            /* inside a CS transaction */
    int fl_n;                 /* bytes received in this transaction */
    uint8_t fl_cmd;
    uint32_t fl_addr;
    uint8_t fl_status;        /* bit0 WIP, bit1 WEL */
    uint64_t fl_busy_until;   /* CPU cycle when the running program / erase ends (WIP) */
    uint64_t fl_busy;         /* total program / erase time, CPU cycles */
    int fl_instant;           /* -flashfast: program and erase take no time */
    uint32_t fl_reads, fl_writes, fl_erases;

    /* EDMA3 channel controller (single shared view of all regions) */
    struct {
        uint32_t er, eer, ier, ipr, ser, emr;
        uint32_t transfers, events, errors;
    } edma;

    /* McASP0 */
    struct {
        int xrun, rrun;              /* frame sync running */
        int xdata, rdata;            /* XBUF empty / RBUF full */
        uint32_t xbuf, rbuf;
        uint64_t next_slot;          /* cycle of next slot boundary */
        double cyc_per_slot, frac;
        uint32_t slot;               /* slot counter */
        uint32_t underruns, overruns;
        int16_t *out; uint32_t nout, capout; /* captured output samples (interleaved L/R, 16-bit) */
        const int16_t *in; uint32_t nin, inpos; /* input samples (interleaved) */
        double gen_freq, gen_amp;    /* sine generator when no input file */
        uint64_t gen_n;
        /* receive: one word per active RX serializer per slot, lowest serializer first
           (the 70CDR has two ADCs: AXR4 and AXR5; the 50G/60B only AXR5) */
        uint32_t rq[16]; int rq_ser[16], rq_n, rq_pos;
        double gen2_freq, gen2_amp;  /* -sine2: the second input (AXR4 on the 70CDR) */
        uint64_t gen2_n;
    } asp;

    /* SPI1: 8-bit battery ADC (ADC081S-style framing), CS on GPIO 42 */
    uint8_t adc_value;
    int spi1_idx, spi1_rx_valid;
    uint32_t spi1_buf;
    uint32_t adc_reads;
    uint64_t spi1_start, spi1_done;  /* CPU cycles: SPI1 word in flight / shifted out */
    int spi1_timing;                 /* 1 = model SPI1 word time (default), 0 = instant */

    /* GPIO edge interrupts */
    uint32_t gpio_ris[5], gpio_fal[5], gpio_intstat[5];
    /* scheduled input changes */
    struct { uint64_t at; int pin; int val; } inq[4096];
    int ninq;

    uint64_t idle_cycles;         /* cycles spent in IDLE (fast-forwarded) */
    uint32_t unknown_events[128];
    uint64_t next_event;
    c6x_cache cache;              /* timing model; attached to cpu.cache unless -nocache */
    c6x_usb usb;                  /* USB0 + scripted host (-usb) */
} c6x_sys;

c6x_sys *sys_create(void);
int sys_load_ais(c6x_sys *s, const char *path);
void sys_set_jump_stack(c6x_sys *s, uint32_t b15);   /* -stack: B15 after JumpClose */
int sys_load_flash_parts(c6x_sys *s, const char *dir);
/* clocks from PLL0 + CFGCHIP3, SDRAM timings from EMIFB; updates the cache model */
void sys_clock_rates(c6x_sys *s, double *vco, double *core, double *emif);
void sys_update_clocks(c6x_sys *s);
double sys_wall(c6x_sys *s);        /* emulated seconds, across clock changes */
int sys_sdram_check(c6x_sys *s, FILE *f);   /* prints clocks and timings, returns warnings */
void sys_raise_event(c6x_sys *s, int e);
uint64_t sys_run(c6x_sys *s, uint64_t cycles);
void sys_report_mmio(c6x_sys *s, FILE *f);
void sys_lcd_dump_pgm(c6x_sys *s, const char *path);
int sys_lcd_dump_png(c6x_sys *s, const char *path, int scale);
int sys_write_wav(c6x_sys *s, const char *path);
void sys_gpio_input(c6x_sys *s, int pin, int val);
void sys_schedule_input(c6x_sys *s, uint64_t at, int pin, int val);

#endif
