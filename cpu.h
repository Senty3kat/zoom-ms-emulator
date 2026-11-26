/* C674x CPU core: cycle-stepped execute model (SPRUFE8B). */
#ifndef C6X_CPU_H
#define C6X_CPU_H
#include <stdint.h>
#include <stdio.h>
#include "decode.h"
#include "mem.h"
#include "opcode/tic6x.h"

/* control registers (our numbering) */
enum {
    CR_AMR, CR_CSR, CR_GFPGFR, CR_ICR, CR_IER, CR_IFR, CR_IRP, CR_ISR, CR_ISTP, CR_NRP,
    CR_PCE1, CR_FADCR, CR_FAUCR, CR_FMCR, CR_TSCL, CR_TSCH, CR_ILC, CR_RILC, CR_REP,
    CR_DNUM, CR_SSR, CR_GPLYA, CR_GPLYB, CR_TSR, CR_ITSR, CR_NTSR, CR_ECR, CR_EFR, CR_IERR,
    CR_DIER, CR_COUNT
};

/* TSR bits */
#define TSR_GIE  (1u << 0)
#define TSR_SGIE (1u << 1)
#define TSR_GEE  (1u << 2)
#define TSR_XEN  (1u << 3)
#define TSR_INT  (1u << 9)
#define TSR_EXC  (1u << 10)
#define TSR_SPLX (1u << 14)
#define TSR_IB   (1u << 15)

#define PEND_RING 16          /* > max write latency (E10) */
#define MAX_PEND 48
#define PKT_MAX 14
#define LB_MAX 112

typedef struct {
    uint32_t addr;            /* packet start, 0xFFFFFFFF = empty */
    uint32_t next;            /* address of the following execute packet */
    uint8_t n;
    uint8_t cycles;           /* cycles this packet occupies (NOP n, BNOP, CALLP, prot LD) */
    uint8_t has_branch;
    uint8_t has_sploop;
    page_meta *pm[2];
    uint8_t blk[2];
    uint32_t gen[2];
    c6x_insn ins[PKT_MAX];
} c6x_packet;

typedef struct { uint8_t side, reg; uint32_t val; } pend_write;

/* instruction whose operands are read over several E-stages */
typedef struct {
    c6x_insn ins;
    uint64_t issue;
    uint32_t lo[4], hi[4];
    uint8_t maxr;
} defer_op;

typedef struct {
    c6x_insn *ins;            /* points into lb_store */
    uint16_t lc;              /* loading counter at load time */
    uint8_t lbc;
    uint8_t valid;
    uint8_t unitbit;          /* SPMASK unit bit (0xff = none) */
} lb_entry;

typedef struct c6x_cpu {
    uint32_t r[2][32];
    uint32_t cr[CR_COUNT];
    void (*on_dint)(struct c6x_cpu *c);   /* hardware-close IRQ residue hook */
    uint32_t last_branch_target, last_branch_pc;  /* for invalid-target diagnostics */
    uint32_t pc;              /* address of the next execute packet to fetch */
    uint32_t cur_next;        /* address of the packet after the executing one */
    uint64_t cycle;
    uint64_t insns;
    uint64_t packets;

    /* opcode histogram: executed count per mnemonic (indexed by opc_sem id) */
    uint64_t opchist[tic6x_opcode_max];

    pend_write pend[PEND_RING][MAX_PEND];
    uint8_t npend[PEND_RING];

    /* branches in flight (at most one per cycle, 5 delay slots) */
    struct { uint64_t due; uint32_t target; uint8_t kind; } br[8];
    int nbr;
    int nop_left;             /* remaining idle cycles of the current packet */
    uint8_t irq_splx;
    uint8_t ret_window;
    uint8_t lb_resume;       /* first packet after B IRP/NRP: SPLX means resume an SPLOOP */
    struct c6x_cache *cache;  /* optional cache timing model (NULL = every access 1 cycle) */
    uint64_t stall_total;     /* memory stall cycles: wall time = cycle + stall_total */         /* next interrupt returns to an interrupted SPLOOP (IRP = pc, ITSR.SPLX = 1) */
    defer_op dq[8];
    int ndq;
    const defer_op *ovr;      /* operand override while finishing a deferred op */
    int wdelta;               /* E-stage offset of writes issued by a deferred op */

    uint8_t tsc_running;
    uint64_t tsc_base;
    uint32_t tsch_latch;

    struct {
        uint8_t active, kind, ii, loading, fetch_en;
        uint8_t has_cond, cside, cnum, cz;   /* SPLOOP(D): reload condition; SPLOOPW: loop condition */
        uint8_t reload_armed;                /* reload condition true, waiting for SPMASKR */
        uint8_t use_spkernelr;               /* body ended with SPKERNELR (perfect overlap reload) */
        uint8_t int_drain;                   /* draining to take an interrupt (SPRUFE8B 7.13.1) */
        uint8_t restart;                     /* piping up again after B IRP/NRP with SPLX=1 (7.13.2) */
        uint32_t sploop_pc, loadc, dynlen, fetch_delay;
        int n;
        lb_entry e[LB_MAX];
        c6x_insn store[LB_MAX];
        uint32_t condhist[8];                /* predicate register value per cycle (cycle & 7) */
        struct {
            uint8_t on, draining, reloading, init_term, term_pending;
            uint32_t lbc, cyc, drainc, reloadc;
            uint8_t valid[LB_MAX];
        } in[2];                             /* [0] current/draining invocation, [1] reloaded one */
        uint8_t mask_units;
    } lb;

    c6x_packet *dc;
    uint32_t dc_mask;

    c6x_mem *mem;
    void *sys;
    void (*on_unimpl)(struct c6x_cpu *, const c6x_insn *);

    int halted;
    int idle;
    char err[256];
    uint32_t trace;
    FILE *tracef;
    uint8_t regtrace;
    FILE *regtracef;
    uint8_t brtrace;
    FILE *brtracef;
    uint8_t regrecord;
    FILE *regrecordf;
    uint8_t regreplay;
    FILE *regreplayf;
    uint64_t replay_next_cycle;
    uint32_t bp[16];
    int nbp;
    int bp_hit;
    void (*on_bp)(struct c6x_cpu *, uint32_t addr);  /* if set, called instead of stopping */
    uint32_t exc_count;

    struct { uint32_t addr; uint8_t size; uint32_t lo, hi; } st[8];
    int nst;
    uint32_t unimpl_count;
    uint64_t sat_pending;     /* CSR.SAT set request */
} c6x_cpu;

void cpu_init(c6x_cpu *c, c6x_mem *m);
void cpu_reset(c6x_cpu *c, uint32_t pc);
int cpu_step(c6x_cpu *c);                 /* one cycle; returns 0 ok, <0 halted */
uint64_t cpu_run(c6x_cpu *c, uint64_t max_cycles);
void cpu_raise_irq(c6x_cpu *c, int n);
uint32_t cpu_rd_ctrl(c6x_cpu *c, int id);
void cpu_wr_ctrl(c6x_cpu *c, int id, uint32_t v);
void cpu_dump(c6x_cpu *c, FILE *f);
c6x_packet *cpu_fetch_packet(c6x_cpu *c, uint32_t pc);
int cpu_ctrl_index(int tic6x_ctrl_id);

/* exec.c */
void exec_insn(c6x_cpu *c, const c6x_insn *in);
void cpu_exec(c6x_cpu *c, const c6x_insn *in);
void cpu_defer_tick(c6x_cpu *c);
void exec_init(void);
extern uint16_t opc_sem[];
void cpu_sched(c6x_cpu *c, int side, int reg, uint32_t val, int estage);

static inline uint64_t cpu_now(const c6x_cpu *c) { return c->cycle + c->stall_total; }

#endif
