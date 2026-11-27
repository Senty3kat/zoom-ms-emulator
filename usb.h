/* USB0 of the C6745/OMAP-L137 (TI wrapper + Mentor MUSBMHDRC + CPPI 4.1 DMA and queue
   manager) in peripheral mode, plus a scripted full-speed host that enumerates the
   device and exchanges USB-MIDI (SysEx) with it. See README "USB". */
#ifndef C6X_USB_H
#define C6X_USB_H
#include <stdint.h>
#include <stdio.h>

struct c6x_sys;

#define USB_NEP 5
#define USB_NQ 64
#define USB_QDEPTH 4096
#define USB_FIFO 1024

typedef struct {
    uint16_t txmaxp, txcsr, rxmaxp, rxcsr, count;
    uint8_t txtype, txinterval, rxtype, rxinterval;
    uint8_t fifosize;            /* value written to endpoint FIFO size register */
    uint8_t rx[USB_FIFO];        /* host -> device bytes waiting in the FIFO */
    uint32_t rxn, rxpos;
    uint8_t tx[USB_FIFO];        /* device -> host bytes loaded by the CPU */
    uint32_t txn;
    /* CPPI Tx packet being sent on this endpoint */
    uint32_t tx_desc, tx_len, tx_off;
} usb_ep;

typedef struct {
    uint32_t ring[USB_QDEPTH];
    uint32_t head, n;
} usb_queue;

typedef struct {
    uint8_t data[2600];
    int len;
    uint64_t at;                 /* wall cycle when it may be sent */
    int wait;                    /* send only after the device answered the previous one */
} usb_msg;

typedef struct c6x_usb {
    int enabled;                 /* -usb: a host is attached */
    int vbus_level;              /* DEVCTL VBUS bits 4:3; 3 = VBusValid */
    int vbus_sense_model;        /* optional: CFGCHIP2.VBUSSENSE controls effective VBUS */
    int usb0_vbussense;          /* last CFGCHIP2 bit16, 1 until firmware writes it */
    uint32_t pinmux9;            /* last PINMUX9 write */
    int pinmux9_required;        /* optional: require USB0_DRVVBUS mux bits 7:4 = 1h */
    int usbrefclk_model;         /* optional: require PINMUX9[11:8]=4h (USB_REFCLKIN) */
    int usbphy_polarity_model;   /* optional: require CFGCHIP2 DATPOL=1 and PHY_PLLON=1 */
    uint32_t cfgchip2;           /* last CFGCHIP2 write */
    int full_path;               /* optional: TI-documented VBUS->session->reset->EP0 path as a whole */
    int path_stage;              /* 0 VBUS, 1 session, 2 attach, 3 bus reset, 4 SETUP, 5 SET_ADDRESS, 6 GET_DESC, 7 SET_CFG */
    uint32_t path_bus_resets;    /* bus resets observed in full-path mode */
    uint32_t path_setups;        /* EP0 SETUP requests delivered in full-path mode */
    uint32_t path_eoir;          /* EOIR writes observed */
    int inherit_enum;            /* optional: host already configured by bootloader, no EP0 */
    uint8_t inherit_addr;        /* FADDR inherited from the bootloader (0x3A) */
    int suspend_model;           /* optional: model POWER.SUSPENDM (bit1) and RESUME release */
    int suspend_active;          /* SUSPENDM set: SETUP is withheld until cleared */
    uint64_t suspend_since;      /* cycle when SUSPENDM was set */
    uint32_t resume_pulses;      /* number of POWER.RESUME pulses observed */
    uint64_t resume_last_ms;     /* duration of the last RESUME pulse in ms */
    uint64_t resume_on_at;       /* cycle when POWER.RESUME went high */
    int power_hsmode;            /* optional: report POWER.HSMODE bit4 as read-only status */
    int csr0_rxbit_required;     /* optional: require RXPKTRDY bit0 with SERV_RXPKTRDY */
    int ep0_prereq;              /* optional: gate SETUP delivery on stock EP0 prerequisites */
    int wrapirq_model;           /* optional: require INTMSKSETR + INTCLRR before attach */
    uint8_t wrap_irqmask_seen;   /* INTMSKSETR 0x01E00030 written */
    uint8_t wrap_irqclear_seen;  /* INTCLRR 0x01E00028 written */
    uint8_t ep0_flush_seen;      /* CSR0 FLUSHFIFO written after POWER.SOFTCONN */
    uint8_t ep0_prereq_missing;  /* bitmask of unmet prerequisites for the report */
    uint8_t ep0_prereq_logged;
    int ep0_lanes_model;         /* optional: enforce FIFO0 byte lanes 0x20..0x23 */
    uint8_t ep0_lane_pos;        /* expected lane of the next EP0 FIFO byte */
    uint8_t ep0_lane_bad;        /* a byte was written to the wrong FIFO lane */
    uint8_t ep0_lanes_fatal;     /* enumeration must fail after a lane error */
    /* wrapper */
    uint32_t ctrlr, mode, intsrc, intmsk;
    uint32_t ctrlr_resets;       /* CTRLR bit0 software reset observed */
    int reattach_gap_model;      /* optional: enforce a short SOFTCONN off->on gap */
    uint64_t softconn_off_at;    /* cycle when POWER.SOFTCONN went 1 -> 0 */
    uint64_t softconn_gap_cycles;/* last off->on gap */
    uint32_t reattach_gaps_seen; /* number of off->on transitions observed */
    uint32_t reattach_gaps_bad;  /* off->on gaps longer than the allowed window */
    int reattach_rejected;       /* current too-long reattach blocks enumeration */
    int line;                    /* interrupt line level last reported */
    /* MUSB core */
    uint8_t faddr, power, index, testmode, devctl, intrusbe;
    uint16_t intrtx, intrrx, intrtxe, intrrxe;
    uint8_t intrusb;
    uint16_t frame;
    uint8_t core_misc[0x100];    /* plain storage for registers without side effects */
    usb_ep ep[USB_NEP];
    /* CPPI 4.1 */
    uint32_t dma[0x400];         /* 0x1000..0x1FFF words */
    usb_queue q[USB_NQ];

    /* host state */
    uint64_t next_tick, next_sof, connect_at;
    int state;                   /* see usb.c */
    int ctl_step;                /* enumeration script position */
    uint8_t setup[8];
    uint8_t ctl_buf[512];
    uint8_t ctl_out[512];        /* host -> device control data stage */
    int ctl_len, ctl_phase, ctl_wait, ctl_out_len, ctl_out_sent;
    uint64_t ctl_deadline;
    int addr, configured;
    int ep_out, ep_in, mps_out, mps_in;
    /* UAC1 isochronous IN capture */
    int iso_ep, iso_mps, iso_interval, iso_alt, iso_enabled;
    uint64_t iso_at;
    FILE *iso_wav;
    uint32_t iso_packets, iso_bytes, iso_underruns;
    uint8_t devdesc[18], cfgdesc[256];
    int cfglen;
    /* MIDI */
    usb_msg *out;                /* grows as messages are queued (a full update is ~1800) */
    int nout, outpos, outcap;
    uint8_t outbuf[16384];       /* USB-MIDI event bytes waiting for bulk OUT */
    int outbuf_n;
    uint8_t sysex[4096];
    int sysex_n;
    int nin;                     /* complete messages received */
    int awaiting, wait_nin;      /* waiting for an answer before the next "wait" message */
    uint64_t wait_deadline;
    FILE *log, *midilog;
} c6x_usb;

void usb_init(struct c6x_sys *s);
uint32_t usb_read(struct c6x_sys *s, uint32_t addr, int size);
void usb_write(struct c6x_sys *s, uint32_t addr, int size, uint32_t val);
void usb_sync(struct c6x_sys *s);
uint64_t usb_next_event(struct c6x_sys *s);
int usb_queue_sysex(struct c6x_sys *s, uint64_t at, const char *hex, int wait);
int usb_iso_wav_open(struct c6x_sys *s, const char *path);
void usb_iso_wav_close(struct c6x_sys *s);
void usb_report(struct c6x_sys *s, FILE *f);

#endif
