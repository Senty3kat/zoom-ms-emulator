/* C674x cycle engine: decode cache, register write pipeline, branches,
   multicycle NOPs, SPLOOP loop buffer (SPRUFE8B ch. 7) and interrupts. */
#include <stdlib.h>
#include <string.h>
#include "cpu.h"
#include "cache.h"
#include "sem.h"
#include "opcode/tic6x.h"

extern const tic6x_ctrl tic6x_ctrl_table[];
static int ctrl_map[64];

static const struct { const char *n; int id; } ctrl_names[] = {
    {"amr", CR_AMR}, {"csr", CR_CSR}, {"dnum", CR_DNUM}, {"ecr", CR_ECR}, {"efr", CR_EFR},
    {"fadcr", CR_FADCR}, {"faucr", CR_FAUCR}, {"fmcr", CR_FMCR}, {"gfpgfr", CR_GFPGFR},
    {"gplya", CR_GPLYA}, {"gplyb", CR_GPLYB}, {"icr", CR_ICR}, {"ier", CR_IER}, {"ierr", CR_IERR},
    {"ifr", CR_IFR}, {"ilc", CR_ILC}, {"irp", CR_IRP}, {"isr", CR_ISR}, {"istp", CR_ISTP},
    {"itsr", CR_ITSR}, {"nrp", CR_NRP}, {"ntsr", CR_NTSR}, {"pce1", CR_PCE1}, {"rep", CR_REP},
    {"rilc", CR_RILC}, {"ssr", CR_SSR}, {"tsch", CR_TSCH}, {"tscl", CR_TSCL}, {"tsr", CR_TSR},
};

int cpu_ctrl_index(int id) { return (id >= 0 && id < 64) ? ctrl_map[id] : CR_REP; }

static int fetch_cb(void *ctx, uint32_t a, uint8_t out[32]) { return mem_read_block(ctx, a, out, 32); }

void cpu_init(c6x_cpu *c, c6x_mem *m)
{
    memset(c, 0, sizeof *c);
    c->mem = m;
    c->dc_mask = (1u << 14) - 1;
    c->dc = calloc(c->dc_mask + 1, sizeof(c6x_packet));
    for (uint32_t i = 0; i <= c->dc_mask; i++) c->dc[i].addr = 0xFFFFFFFFu;
    for (int i = 0; i < 64; i++) ctrl_map[i] = CR_REP;
    for (int i = 0; i < tic6x_ctrl_max && i < 64; i++)
        for (unsigned k = 0; k < sizeof ctrl_names / sizeof ctrl_names[0]; k++)
            if (!strcmp(tic6x_ctrl_table[i].name, ctrl_names[k].n)) ctrl_map[i] = ctrl_names[k].id;
    exec_init();
}

void cpu_reset(c6x_cpu *c, uint32_t pc)
{
    void (*on_dint)(struct c6x_cpu *c) = c->on_dint;
    memset(c->r, 0, sizeof c->r);
    memset(c->cr, 0, sizeof c->cr);
    c->on_dint = on_dint;
    memset(c->npend, 0, sizeof c->npend);
    memset(&c->lb, 0, sizeof c->lb);
    c->nbr = 0;
    c->nop_left = 0;
    c->cr[CR_IER] = 1;
    c->cr[CR_GFPGFR] = 0x0700001D;
    c->pc = pc;
    c->halted = 0;
    c->idle = 0;
}

FILE *cpu_stwtrace_open(c6x_cpu *c, const char *spec)
{
    if (!spec || !*spec) return NULL;
    char path[600];
    uint32_t base = C6X_STW_BASE_DEFAULT, len = C6X_STW_LEN_DEFAULT;
    const char *comma = strrchr(spec, ',');
    if (comma) {
        size_t n = (size_t)(comma - spec);
        if (!n || n >= sizeof path) { fprintf(stderr, "stwtrace: bad file in %s\n", spec); return NULL; }
        memcpy(path, spec, n); path[n] = 0;
        const char *colon = strchr(comma + 1, ':');
        if (!colon) { fprintf(stderr, "stwtrace: need FILE[,ADDR:LEN], got %s\n", spec); return NULL; }
        char *end;
        unsigned long long b = strtoull(comma + 1, &end, 16);
        if (end == comma + 1 || end != colon) { fprintf(stderr, "stwtrace: bad address in %s\n", spec); return NULL; }
        unsigned long long l = strtoull(colon + 1, &end, 0);
        if (end == colon + 1 || *end || !l || b + l > 0x100000000ULL) {
            fprintf(stderr, "stwtrace: bad length in %s\n", spec); return NULL;
        }
        base = (uint32_t)b; len = (uint32_t)l;
    } else {
        if (snprintf(path, sizeof path, "%s", spec) >= (int)sizeof path) {
            fprintf(stderr, "stwtrace: file name too long\n"); return NULL;
        }
    }
    FILE *f = fopen(path, "w");
    if (!f) { perror(path); return NULL; }
    c->stwtracef = f;
    c->stw_base = base;
    c->stw_end = base + len;
    c->stw_writes = 0;
    fprintf(f, "# cycle pc stw side[index] addr off src val float\n");
    return f;
}

/* ---------------- control registers ---------------- */
uint32_t cpu_rd_ctrl(c6x_cpu *c, int id)
{
    switch (id) {
    case CR_CSR:
        return (0x14u << 24) | (c->cr[CR_CSR] & 0x0000FE00u) | (1u << 8) |
               ((c->cr[CR_ITSR] & TSR_GIE) ? 2u : 0) | ((c->cr[CR_TSR] & TSR_GIE) ? 1u : 0);
    case CR_ISR: case CR_IFR: return c->cr[CR_IFR];
    case CR_TSCL: {
        if (!c->tsc_running) return 0;
        uint64_t t = cpu_now(c) - c->tsc_base;
        c->tsch_latch = (uint32_t)(t >> 32);
        return (uint32_t)t;
    }
    case CR_TSCH: return c->tsch_latch;
    case CR_ILC: return c->cr[CR_ILC];
    default: return c->cr[id];
    }
}

void cpu_wr_ctrl(c6x_cpu *c, int id, uint32_t v)
{
    switch (id) {
    case CR_CSR: {
        uint32_t sat = (v & (1u << 9)) ? (c->cr[CR_CSR] & (1u << 9)) : 0;
        c->cr[CR_CSR] = (v & 0xFC00u) | sat;
        if (!(v & 1) && c->on_dint) c->on_dint(c);
        c->cr[CR_TSR] = (c->cr[CR_TSR] & ~TSR_GIE) | (v & 1 ? TSR_GIE : 0);
        c->cr[CR_ITSR] = (c->cr[CR_ITSR] & ~TSR_GIE) | (v & 2 ? TSR_GIE : 0);
        return;
    }
    case CR_TSR: {   /* SPLX, INT, IB are hardware-only; EXC can only be cleared */
        uint32_t hw = TSR_SPLX | TSR_INT | TSR_IB | TSR_EXC, o = c->cr[CR_TSR];
        c->cr[CR_TSR] = (v & ~hw & 0xFFFFu) | (o & (TSR_SPLX | TSR_INT | TSR_IB)) | (o & v & TSR_EXC);
        return;
    }
    case CR_ISR: c->cr[CR_IFR] |= v & 0xFFF0u; return;
    case CR_ICR: c->cr[CR_IFR] &= ~(v & 0xFFF0u); return;
    case CR_IFR: return;
    case CR_IER: c->cr[CR_IER] = v | 1; return;
    case CR_ISTP: c->cr[CR_ISTP] = v & 0xFFFFFC00u; return;
    case CR_TSCL: c->tsc_running = 1; c->tsc_base = cpu_now(c); return;
    case CR_TSCH: case CR_PCE1: case CR_DNUM: return;
    default: c->cr[id] = v; return;
    }
}

/* ---------------- pipeline helpers ---------------- */
void cpu_sched(c6x_cpu *c, int side, int reg, uint32_t val, int estage)
{
    uint32_t slot = (uint32_t)((c->cycle + (uint64_t)estage) % PEND_RING);
    uint8_t n = c->npend[slot];
    if (n >= MAX_PEND) { snprintf(c->err, sizeof c->err, "pending write overflow"); c->halted = 1; return; }
    c->pend[slot][n].side = (uint8_t)side;
    c->pend[slot][n].reg = (uint8_t)reg;
    c->pend[slot][n].val = val;
    c->npend[slot] = n + 1;
}

static inline void apply_pending(c6x_cpu *c)
{
    uint32_t slot = (uint32_t)(c->cycle % PEND_RING);
    uint8_t n = c->npend[slot];
    for (uint8_t i = 0; i < n; i++) c->r[c->pend[slot][i].side][c->pend[slot][i].reg] = c->pend[slot][i].val;
    if (c->trace >= 2 && n) {
        FILE *f = c->tracef ? c->tracef : stdout;
        fprintf(f, "%10llu          ", (unsigned long long)cpu_now(c));
        for (uint8_t i = 0; i < n; i++)
            fprintf(f, " %c%d=%08X", c->pend[slot][i].side ? 'B' : 'A', c->pend[slot][i].reg, c->pend[slot][i].val);
        fputc(10, f);
    }
    if (c->regtrace && c->regtracef && n) {
        for (uint8_t i = 0; i < n; i++) {
            uint8_t side = c->pend[slot][i].side;
            uint8_t reg = c->pend[slot][i].reg;
            uint32_t old = c->r[side][reg];
            uint32_t nv = c->pend[slot][i].val;
            fprintf(c->regtracef, "%10llu %c%d %08X -> %08X pc=%08X\n",
                (unsigned long long)cpu_now(c), side ? 'B' : 'A', reg, old, nv, c->pc);
        }
        fflush(c->regtracef);
    }
    if (c->regrecord && c->regrecordf && n) {
        for (uint8_t i = 0; i < n; i++) {
            uint8_t side = c->pend[slot][i].side;
            uint8_t reg = c->pend[slot][i].reg;
            uint32_t old = c->r[side][reg];
            uint32_t nv = c->pend[slot][i].val;
            fprintf(c->regrecordf, "%10llu %c%d %08X -> %08X pc=%08X\n",
                (unsigned long long)cpu_now(c), side ? 'B' : 'A', reg, old, nv, c->pc);
        }
        fflush(c->regrecordf);
    }
    c->npend[slot] = 0;
}

/* Replay recorded register writes: overwrite real registers with recorded values */
static void apply_replay(c6x_cpu *c)
{
    if (!c->regreplay || !c->regreplayf) return;
    char line[256];
    while (fgets(line, sizeof line, c->regreplayf)) {
        uint64_t cyc; int side, reg; uint32_t old, nv, pc; char side_c;
        if (sscanf(line, "%llu %c%d %x -> %x pc=%x", &cyc, &side_c, &reg, &old, &nv, &pc) < 6) continue;
        side = (side_c == 'B') ? 1 : 0;
        if (cyc > c->cycle) { /* put back: not yet */ ungetc('\n', c->regreplayf); return; }
        /* apply recorded value */
        c->r[side][reg] = nv;
    }
}

static void flush_stores(c6x_cpu *c)
{
    for (int i = 0; i < c->nst; i++) {
        uint32_t a = c->st[i].addr, lo = c->st[i].lo, hi = c->st[i].hi;
        switch (c->st[i].size) {
        case 1: case 2: case 4: mem_wr(c->mem, a, c->st[i].size, lo); break;
        case 8:
            mem_wr(c->mem, a, 4, lo);
            mem_wr(c->mem, a + 4, 4, hi);
            break;
        case 5: /* STNW */
            if ((a & 3) == 0) mem_wr(c->mem, a, 4, lo);
            else for (int k = 0; k < 4; k++) mem_wr(c->mem, a + k, 1, lo >> (8 * k));
            break;
        case 9: /* STNDW */
            for (int k = 0; k < 4; k++) mem_wr(c->mem, a + k, 1, lo >> (8 * k));
            for (int k = 0; k < 4; k++) mem_wr(c->mem, a + 4 + k, 1, hi >> (8 * k));
            break;
        }
    }
    c->nst = 0;
}

/* ---------------- decode cache ---------------- */
static int packet_valid(c6x_packet *p)
{
    for (int i = 0; i < 2; i++)
        if (p->pm[i] && p->pm[i]->gen[p->blk[i]] != p->gen[i]) return 0;
    return 1;
}

static void mark_code(c6x_cpu *c, c6x_packet *p, int i, uint32_t addr)
{
    page_meta *pm = c->mem->meta[addr >> MEM_PAGE_BITS];
    p->pm[i] = pm;
    if (pm) {
        p->blk[i] = (addr >> 8) & 15;
        pm->code_mask |= (uint16_t)(1u << p->blk[i]);
        p->gen[i] = pm->gen[p->blk[i]];
    }
}

c6x_packet *cpu_fetch_packet(c6x_cpu *c, uint32_t pc)
{
    c6x_packet *p = &c->dc[(pc >> 1) & c->dc_mask];
    if (p->addr == pc && packet_valid(p)) return p;
    p->addr = 0xFFFFFFFFu;
    uint32_t a = pc;
    int n = 0;
    uint8_t cycles = 1;
    p->has_branch = p->has_sploop = 0;
    for (;;) {
        c6x_insn *in = &p->ins[n];
        int sz = c6x_decode(fetch_cb, c->mem, a, in);
        if (sz == 0 || !in->valid) {
            if (a == c->last_branch_target)
                snprintf(c->err, sizeof c->err,
                         "invalid instruction at 0x%08X (raw 0x%08X), indirect branch from %08X to %08X",
                         a, in->raw, c->last_branch_pc, c->last_branch_target);
            else
                snprintf(c->err, sizeof c->err, "invalid instruction at 0x%08X (raw 0x%08X)", a, in->raw);
            return NULL;
        }
        in->sem = opc_sem[in->opc];
        switch (in->sem) {
        case S_NOP: case S_IDLE: if (in->nops > cycles) cycles = in->nops; break;
        case S_BNOP: if (in->nops + 1 > cycles) cycles = in->nops + 1; p->has_branch = 1; break;
        case S_ADDKPC: if (in->nops + 1 > cycles) cycles = in->nops + 1; break;
        case S_CALLP: cycles = 6; p->has_branch = 1; break;
        case S_B: case S_BDEC: case S_BPOS: p->has_branch = 1; break;
        case S_SPLOOP: case S_SPLOOPD: case S_SPLOOPW: p->has_sploop = 1; break;
        case S_LDB: case S_LDBU: case S_LDH: case S_LDHU: case S_LDW: case S_LDNW: case S_LDDW: case S_LDNDW:
            if (in->prot && cycles < 5) cycles = 5;
            break;
        default: break;
        }
        n++;
        uint32_t next = c6x_next_addr(fetch_cb, c->mem, a, sz);
        if (!in->p || n >= PKT_MAX) { p->next = next; break; }
        a = next;
    }
    p->n = (uint8_t)n;
    p->cycles = cycles;
    mark_code(c, p, 0, pc);
    mark_code(c, p, 1, p->ins[n - 1].addr);
    p->addr = pc;
    return p;
}

/* ---------------- interrupts ---------------- */
void cpu_raise_irq(c6x_cpu *c, int n)
{
    if (n >= 1 && n <= 15) c->cr[CR_IFR] |= 1u << n;
}

/* cycles between taking an interrupt and the first ISR packet reaching E1 (the ISFP goes
   through PG..DC). Register writes still in flight from the interrupted code (loads,
   multiply, DP ops) land in this gap, as on hardware, not inside the ISR. */
#define IRQ_FETCH_CYCLES 6

static int irq_gap(c6x_cpu *c)
{
    int gap = IRQ_FETCH_CYCLES;
    for (int k = gap + 1; k < PEND_RING; k++)
        if (c->npend[(c->cycle + (uint64_t)k) % PEND_RING]) gap = k;
    if (c->ndq && gap < 10) gap = 10;      /* DP ops still reading operands */
    return gap;
}

/* an enabled interrupt (NMI or maskable with GIE) is pending */
static int irq_wanted(c6x_cpu *c)
{
    uint32_t pend = c->cr[CR_IFR] & c->cr[CR_IER];
    if ((pend & 2) && (c->cr[CR_IER] & 2)) return 1;
    return (c->cr[CR_TSR] & TSR_GIE) && (c->cr[CR_IER] & 2) && (pend & 0xFFF0u);
}

static int try_interrupt(c6x_cpu *c)
{
    uint32_t pend = c->cr[CR_IFR] & c->cr[CR_IER];
    if (!pend) return 0;
    /* NMI */
    if ((pend & 2) && (c->cr[CR_IER] & 2)) {
        c->cr[CR_NRP] = c->pc;
        c->cr[CR_NTSR] = c->cr[CR_TSR] | (c->irq_splx ? TSR_SPLX : 0);
        c->irq_splx = 0;
        c->cr[CR_TSR] &= ~(TSR_GIE | TSR_SPLX);
        c->cr[CR_IFR] &= ~2u;
        c->cr[CR_IER] &= ~2u;
        c->pc = (c->cr[CR_ISTP] & 0xFFFFFC00u) | (1 << 5);
        c->idle = 0;
        c->nop_left = irq_gap(c);
        return 1;
    }
    if (!(c->cr[CR_TSR] & TSR_GIE) || !(c->cr[CR_IER] & 2)) {
        return 0;
    }
    pend &= 0xFFF0u;
    if (!pend) return 0;
    int n = __builtin_ctz(pend);
    c->cr[CR_IRP] = c->pc;
    c->cr[CR_ITSR] = c->cr[CR_TSR] | (c->irq_splx ? TSR_SPLX : 0);
    c->irq_splx = 0;
    c->cr[CR_TSR] = (c->cr[CR_TSR] & ~(TSR_GIE | TSR_SPLX | (3u << 6))) | TSR_INT;
    c->cr[CR_IFR] &= ~(1u << n);
    c->pc = (c->cr[CR_ISTP] & 0xFFFFFC00u) | ((uint32_t)n << 5);
    c->idle = 0;
    c->nop_left = irq_gap(c);
    return 1;
}

static void take_exception(c6x_cpu *c, uint32_t ret)
{
    c->cr[CR_NRP] = ret;
    c->cr[CR_NTSR] = c->cr[CR_TSR];
    c->cr[CR_TSR] = (c->cr[CR_TSR] & ~(TSR_GIE | TSR_SPLX)) | TSR_EXC;
    c->pc = (c->cr[CR_ISTP] & 0xFFFFFC00u) | (1 << 5);
    c->nop_left = irq_gap(c);
}

/* ---------------- SPLOOP loop buffer ---------------- */
static int unit_bit(const c6x_insn *in)
{
    static const int order[4] = { 0, 1, 3, 2 }; /* L S M D -> mask order L S D M */
    if (in->unit == UNIT_NONE) return 0xFF;
    return order[in->unit] * 2 + in->side;
}

static void lb_idle(c6x_cpu *c)
{
    c->lb.active = 0;
    c->lb.n = 0;
    c->lb.fetch_en = 1;
    c->lb.reload_armed = 0;
    c->lb.in[0].on = c->lb.in[1].on = 0;
    c->cr[CR_TSR] &= ~TSR_SPLX;
}

static int lb_cond_true(c6x_cpu *c, uint32_t v)
{
    return c->lb.cz ? v == 0 : v != 0;
}

/* start (re)executing the stored body as a new invocation */
static void lb_reload_start(c6x_cpu *c)
{
    int k = c->lb.in[0].on ? 1 : 0;
    memset(&c->lb.in[k], 0, sizeof c->lb.in[k]);
    c->lb.in[k].on = 1;
    c->lb.in[k].reloading = 1;
    if (c->cr[CR_RILC] == 0) c->lb.in[k].init_term = 1;
    else c->cr[CR_ILC] = c->cr[CR_RILC] - 1;
    c->lb.reload_armed = 0;
}

/* stage boundary of invocation k (end of a cycle) */
/* 7.13.1: may the loop start interrupt draining at this stage boundary? */
static int lb_can_interrupt(c6x_cpu *c, int k)
{
    if (k != 0 || c->lb.in[1].on || c->lb.loading || c->lb.in[0].reloading || c->lb.reload_armed) return 0;
    if (c->nbr || !irq_wanted(c)) return 0;
    if (c->lb.kind != 0 && c->lb.in[0].cyc <= 3) return 0;
    if (c->lb.kind != 2 && c->cr[CR_ILC] < (c->lb.dynlen + c->lb.ii - 1) / c->lb.ii) return 0;
    return 1;
}

static void lb_start_int_drain(c6x_cpu *c)
{
    c->lb.in[0].draining = 1;
    c->lb.in[0].drainc = 0;
    c->lb.int_drain = 1;
    c->lb.fetch_en = 0;
}

static void lb_stage_boundary(c6x_cpu *c, int k)
{
    if (c->lb.in[k].draining) {
        /* 7.10.3: SPLOOPW termination is still evaluated while interrupt draining */
        if (c->lb.int_drain && c->lb.kind == 2 && !lb_cond_true(c, c->lb.condhist[(c->cycle - 3) & 7])) {
            c->lb.in[k].on = 0;
            c->lb.int_drain = 0;     /* idle; the interrupt is taken at the post-loop packet */
        }
        return;
    }
    if (c->lb.in[k].init_term) {
        if (!c->lb.loading && !c->lb.in[k].reloading) c->lb.in[k].on = 0;
        return;
    }
    if (c->lb.kind == 2) {                       /* SPLOOPW: no epilog */
        if (c->lb.in[k].cyc <= 3) return;
        if (!lb_cond_true(c, c->lb.condhist[(c->cycle - 3) & 7])) {
            if (c->lb.loading) c->lb.in[k].term_pending = 1;
            else c->lb.in[k].on = 0;
        } else if (lb_can_interrupt(c, k)) lb_start_int_drain(c);
        return;
    }
    if (c->lb.kind == 1 && c->lb.in[k].cyc <= 3) return;   /* SPLOOPD: first 3 cycles */
    if (c->cr[CR_ILC] != 0) {
        if (lb_can_interrupt(c, k)) lb_start_int_drain(c);  /* ILC keeps the remaining iterations */
        else c->cr[CR_ILC]--;
        return;
    }
    /* termination: drain this invocation */
    c->lb.in[k].draining = 1;
    c->lb.in[k].drainc = 0;
    if (!c->lb.loading && c->lb.fetch_delay == 0) c->lb.fetch_en = 1;
    /* nested loop reload: SPLOOP(D) condition true 4 cycles before this boundary */
    if (c->lb.has_cond && lb_cond_true(c, c->lb.condhist[(c->cycle - 4) & 7])) {
        if (c->lb.use_spkernelr) c->lb.reload_armed = 2;   /* start next cycle */
        else c->lb.reload_armed = 1;                        /* wait for SPMASKR */
    }
}

static void lb_end_cycle(c6x_cpu *c, int had_spkernel, const c6x_insn *spk, int had_spmaskr)
{
    if (!c->lb.active) return;
    if (c->lb.loading && had_spkernel) {
        c->lb.loading = 0;
        c->lb.restart = 0;
        c->lb.dynlen = c->lb.loadc + 1;
        c->lb.use_spkernelr = spk && spk->sem == S_SPKERNELR;
        uint32_t fstg = spk && spk->nopnd >= 1 ? (uint32_t)spk->op[0].imm : 0;
        uint32_t fcyc = spk && spk->nopnd >= 2 ? (uint32_t)spk->op[1].imm : 0;
        c->lb.fetch_delay = c->lb.use_spkernelr ? 0 : fstg * c->lb.ii + fcyc;
        c->lb.fetch_en = 0;
        if (c->lb.in[0].draining && c->lb.in[0].drainc >= c->lb.fetch_delay) c->lb.fetch_en = 1;
        if (c->lb.in[0].term_pending) { lb_idle(c); return; }
    }
    if (c->lb.loading) c->lb.loadc++;
    for (int k = 0; k < 2; k++) {
        if (!c->lb.in[k].on) continue;
        if (c->lb.in[k].draining) {
            c->lb.in[k].drainc++;
            if (!c->lb.loading && !c->lb.int_drain && c->lb.in[k].drainc >= c->lb.fetch_delay) c->lb.fetch_en = 1;
            if (!c->lb.loading && c->lb.dynlen >= c->lb.ii && c->lb.in[k].drainc >= c->lb.dynlen - c->lb.ii) {
                c->lb.in[k].on = 0;
                if (c->lb.int_drain) {        /* 7.13.4: return address = the SPLOOP packet */
                    c->pc = c->lb.sploop_pc;
                    c->irq_splx = 1;
                }
                continue;
            }
        }
        if (c->lb.in[k].reloading) {
            if (++c->lb.in[k].reloadc >= c->lb.dynlen) {
                c->lb.in[k].reloading = 0;
                c->lb.fetch_en = 0;           /* reload complete: fetch of the epilog code stops */
            }
        }
        c->lb.in[k].cyc++;
        if (++c->lb.in[k].lbc >= c->lb.ii) {
            c->lb.in[k].lbc = 0;
            lb_stage_boundary(c, k);
        }
    }
    if (c->lb.reload_armed == 2 || (c->lb.reload_armed == 1 && had_spmaskr)) lb_reload_start(c);
    if (!c->lb.in[0].on && c->lb.in[1].on) { c->lb.in[0] = c->lb.in[1]; c->lb.in[1].on = 0; }
    if (!c->lb.in[0].on && !c->lb.loading && !c->lb.reload_armed) lb_idle(c);
}

static void lb_start(c6x_cpu *c, const c6x_insn *in, uint32_t pkt_addr)
{
    memset(&c->lb, 0, sizeof c->lb);
    c->lb.active = 1;
    c->lb.kind = in->sem == S_SPLOOP ? 0 : in->sem == S_SPLOOPD ? 1 : 2;
    c->lb.ii = (uint8_t)(in->nopnd ? in->op[0].imm : 1);
    if (c->lb.ii == 0) c->lb.ii = 1;
    c->lb.loading = 1;
    c->lb.fetch_en = 1;
    c->lb.sploop_pc = pkt_addr;
    c->lb.has_cond = in->has_cond;
    c->lb.cside = in->cside; c->lb.cnum = in->cnum; c->lb.cz = in->cz;
    c->lb.in[0].on = 1;
    /* 7.13.2: SPLX already set (restored by B IRP/NRP) = resuming an interrupted loop */
    c->lb.restart = (c->cr[CR_TSR] & TSR_SPLX) && c->lb_resume;
    if (c->lb.restart && c->lb.kind == 1) c->lb.kind = 0;   /* SPLOOPD executes as SPLOOP */
    c->cr[CR_TSR] |= TSR_SPLX;
    if (c->lb.kind == 0) {
        if (c->cr[CR_ILC] == 0) c->lb.in[0].init_term = 1;
        else c->cr[CR_ILC]--;
    }
}

/* ---------------- main step ---------------- */
static void trace_packet(c6x_cpu *c, c6x_packet *p)
{
    char buf[256];
    FILE *f = c->tracef ? c->tracef : stdout;
    for (int i = 0; i < p->n; i++) {
        c6x_format_insn(&p->ins[i], buf, sizeof buf);
        fprintf(f, "%10llu %08X %s%s\n", (unsigned long long)cpu_now(c), p->ins[i].addr, i ? "|| " : "   ", buf);
    }
}

static int cpu_step_inner(c6x_cpu *c)
{
    if (c->halted) return -1;
    apply_pending(c);
    apply_replay(c);
    if (c->ndq) cpu_defer_tick(c);

    /* branch completion */
    for (int i = 0; i < c->nbr; i++) {
        if (c->br[i].due == c->cycle) {
            c->pc = c->br[i].target;
            c->nop_left = 0;
            if (c->br[i].kind) c->ret_window = 1;
            if (c->lb.active) {
                if (c->lb.in[0].reloading || c->lb.in[1].reloading) c->lb.fetch_en = 0;  /* outer-loop branch while reloading */
                else lb_idle(c);
            }
            c->br[i] = c->br[--c->nbr];
            i--;
        }
    }

    /* SPLOOPW / reload condition history: value visible during this cycle */
    if (c->lb.active && c->lb.has_cond)
        c->lb.condhist[c->cycle & 7] = c->r[c->lb.cside][c->lb.cnum];

    if (!c->nbr && !c->nop_left && !c->lb.active && (c->cr[CR_IFR] & c->cr[CR_IER] & ~1u)) {
        if (try_interrupt(c)) { c->cycle++; return 0; }
    }
    c->irq_splx = 0;          /* interrupt went away while draining: the loop restarts from scratch */
    if (c->idle) { c->cycle++; return 0; }

    c6x_packet *pk = NULL;
    if (c->nop_left > 0) {
        c->nop_left--;
    } else if (!c->lb.active || c->lb.fetch_en) {
        pk = cpu_fetch_packet(c, c->pc);
        if (!pk) { c->halted = 1; return -1; }
    }

    uint8_t mask = 0;
    int had_spkernel = 0, start_loop = 0, had_spmaskr = 0;
    const c6x_insn *spk = NULL;
    if (pk) {
        for (int i = 0; i < pk->n; i++) {
            const c6x_insn *in = &pk->ins[i];
            if ((in->sem == S_SPMASK || in->sem == S_SPMASKR) && in->nopnd) mask |= (uint8_t)in->op[0].imm;
            if (in->sem == S_SPMASKR) had_spmaskr = 1;
            if (in->sem == S_SPKERNEL || in->sem == S_SPKERNELR) { had_spkernel = 1; spk = in; }
        }
        if (pk->has_sploop && (pk->ins[0].sem == S_SPLOOP || pk->ins[0].sem == S_SPLOOPD || pk->ins[0].sem == S_SPLOOPW))
            start_loop = 1;
        int resume = c->ret_window && (c->cr[CR_TSR] & TSR_SPLX);
        if (c->ret_window) {
            c->ret_window = 0;
            if (!start_loop) c->cr[CR_TSR] &= ~TSR_SPLX;   /* returned to ordinary code */
        }
        if (start_loop && !c->lb.active && resume) {
            /* resuming an interrupted loop: instructions parallel to SPLOOP are not executed */
            c->pc = pk->next;
            c->nop_left = pk->cycles - 1;
            c->packets++;
            c->lb_resume = 1;
            lb_start(c, &pk->ins[0], pk->addr);
            c->lb_resume = 0;
            flush_stores(c);
            c->cycle++;
            return 0;
        }
        c->cr[CR_PCE1] = pk->ins[0].fp_addr;
        if (c->cache) {
            c->cache->pc = c->cr[CR_PCE1]; c->cache->cycle = c->cycle;
            cache_fetch(c->cache, pk->ins[0].fp_addr);
            cache_fetch(c->cache, pk->ins[pk->n - 1].fp_addr);
        }
        c->cur_next = pk->next;
        if (c->trace && c->cycle >= 0) trace_packet(c, pk);
        for (int i = 0; i < c->nbp; i++)
            if (c->bp[i] == pk->addr) { if (c->on_bp) c->on_bp(c, pk->addr); else c->bp_hit = 1; }
    }

    /* loop buffer: drain / reload / dispatch, per invocation */
    if (c->lb.active && !start_loop) {
        for (int k = 0; k < 2; k++) {
            if (!c->lb.in[k].on) continue;
            uint32_t lbc = c->lb.in[k].lbc;
            for (int i = 0; i < c->lb.n; i++) {
                lb_entry *e = &c->lb.e[i];
                if (e->lbc != lbc) continue;
                if (c->lb.in[k].draining && e->lc == c->lb.in[k].drainc) c->lb.in[k].valid[i] = 0;
                if (c->lb.in[k].reloading && e->lc == c->lb.in[k].reloadc && !c->lb.in[k].init_term) c->lb.in[k].valid[i] = 1;
                if (!c->lb.in[k].valid[i]) continue;
                if (e->unitbit != 0xFF && (mask & (1u << e->unitbit)) && !c->lb.restart) continue;
                cpu_exec(c, e->ins);
            }
        }
    }

    if (pk) {
        int loading = c->lb.active && c->lb.loading && !start_loop;
        for (int i = 0; i < pk->n; i++) {
            const c6x_insn *in = &pk->ins[i];
            int ub = unit_bit(in);
            int masked = ub != 0xFF && (mask & (1u << ub));
            if (loading && c->lb.in[0].init_term && !masked && in->sem != S_SPKERNEL && in->sem != S_SPMASK) {
                continue;  /* initial termination: body executes as NOPs */
            }
            /* 7.13.2: on restart SPMASKed instructions and BNOP label act as NOPs */
            if (loading && c->lb.restart && (masked || (in->sem == S_BNOP && in->op[0].kind == OPK_ADDR))) continue;
            cpu_exec(c, in);
            if (loading && !masked && !c->lb.in[0].init_term && c->lb.n < LB_MAX) {
                int s = in->sem;
                if (s == S_NOP || s == S_SPKERNEL || s == S_SPKERNELR || s == S_SPMASK || s == S_SPMASKR) continue;
                if (s == S_BNOP && in->op[0].kind == OPK_ADDR) continue;
                c->lb.store[c->lb.n] = *in;
                lb_entry *e = &c->lb.e[c->lb.n];
                e->ins = &c->lb.store[c->lb.n];
                e->lc = (uint16_t)c->lb.loadc;
                e->lbc = (uint8_t)c->lb.in[0].lbc;
                e->valid = 1;
                e->unitbit = (uint8_t)ub;
                c->lb.in[0].valid[c->lb.n] = 1;
                c->lb.n++;
            }
        }
        c->pc = pk->next;
        c->nop_left = pk->cycles - 1;
        c->packets++;
        if (start_loop) lb_start(c, &pk->ins[0], pk->addr);
    }

    if (c->lb.active && !start_loop) lb_end_cycle(c, had_spkernel, spk, had_spmaskr);

    flush_stores(c);
    if (c->exc_count) {
        c->exc_count = 0;
        if (c->cr[CR_TSR] & TSR_GEE) take_exception(c, c->pc);
        else { snprintf(c->err, sizeof c->err, "software exception (SWE) with exceptions disabled near 0x%08X", c->pc); c->halted = 1; }
    }
    c->cycle++;
    return c->halted ? -1 : 0;
}

int cpu_step(c6x_cpu *c)
{
    if (!c->cache) return cpu_step_inner(c);
    uint64_t s0 = c->cache->stall;
    int r = cpu_step_inner(c);
    c->stall_total += c->cache->stall - s0;
    return r;
}

uint64_t cpu_run(c6x_cpu *c, uint64_t max_cycles)
{
    uint64_t start = c->cycle, end = c->cycle + max_cycles;
    c->bp_hit = 0;
    while (c->cycle < end && !c->halted && !c->bp_hit) {
        if (cpu_step(c) < 0) break;
    }
    return c->cycle - start;
}

void cpu_dump(c6x_cpu *c, FILE *f)
{
    fprintf(f, "PC=%08X cycle=%llu packets=%llu insns=%llu\n", c->pc, (unsigned long long)c->cycle,
            (unsigned long long)c->packets, (unsigned long long)c->insns);
    for (int i = 0; i < 32; i++) {
        fprintf(f, "A%-2d=%08X B%-2d=%08X%s", i, c->r[0][i], i, c->r[1][i], (i & 3) == 3 ? "\n" : "  ");
    }
    fprintf(f, "CSR=%08X IER=%08X IFR=%08X ISTP=%08X IRP=%08X TSR=%08X ILC=%u AMR=%08X\n",
            cpu_rd_ctrl(c, CR_CSR), c->cr[CR_IER], c->cr[CR_IFR], c->cr[CR_ISTP], c->cr[CR_IRP],
            c->cr[CR_TSR], c->cr[CR_ILC], c->cr[CR_AMR]);
    if (c->err[0]) fprintf(f, "ERR: %s\n", c->err);
    fprintf(f, "\nOPCODE HISTOGRAM (executed per mnemonic):\n");
    int shown = 0;
    for (int i = 0; i < tic6x_opcode_max; i++) {
        if (c->opchist[i]) {
            fprintf(f, "  %-10s %llu\n", sem_names[i], (unsigned long long)c->opchist[i]);
            shown++;
        }
    }
    if (!shown) fprintf(f, "  (none executed)\n");
}
