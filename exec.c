/* C674x instruction semantics (SPRUFE8B chapter 3/4).  Operands follow the
   assembler order of the binutils opcode table: src1, src2, dst for
   most instructions; arithmetic is "op0 OP op1" in that order. */
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "cpu.h"
#include "cache.h"
#include "sem.h"
#include "opcode/tic6x.h"

extern const tic6x_opcode tic6x_opcode_table[];
uint16_t opc_sem[tic6x_opcode_max];

void exec_init(void)
{
    for (int i = 0; i < tic6x_opcode_max; i++) {
        opc_sem[i] = S_INVALID;
        for (int s = 1; s < S_COUNT; s++)
            if (!strcmp(sem_names[s], tic6x_opcode_table[i].name)) { opc_sem[i] = (uint16_t)s; break; }
    }
}

typedef int64_t i64;
typedef uint64_t u64;
typedef int32_t i32;
typedef uint32_t u32;

static inline i32 s16lo(u32 v) { return (int16_t)(v & 0xFFFF); }
static inline i32 s16hi(u32 v) { return (int16_t)(v >> 16); }
static inline u32 u16lo(u32 v) { return v & 0xFFFF; }
static inline u32 u16hi(u32 v) { return v >> 16; }
static inline u32 byte(u32 v, int i) { return (v >> (8 * i)) & 0xFF; }

static inline void set_sat(c6x_cpu *c) { c->cr[CR_CSR] |= 1u << 9; }

static inline i32 sat32(c6x_cpu *c, i64 v)
{
    if (v > 0x7FFFFFFFLL) { set_sat(c); return 0x7FFFFFFF; }
    if (v < -0x80000000LL) { set_sat(c); return (i32)0x80000000; }
    return (i32)v;
}
static inline i32 sat16(c6x_cpu *c, i32 v)
{
    if (v > 32767) { if (c) set_sat(c); return 32767; }
    if (v < -32768) { if (c) set_sat(c); return -32768; }
    return v;
}
static inline i64 sext40(u64 v) { v &= 0xFFFFFFFFFFULL; return (v & 0x8000000000ULL) ? (i64)(v | 0xFFFFFF0000000000ULL) : (i64)v; }
static inline i64 sat40(c6x_cpu *c, i64 v)
{
    if (v > 0x7FFFFFFFFFLL) { set_sat(c); return 0x7FFFFFFFFFLL; }
    if (v < -0x8000000000LL) { set_sat(c); return -0x8000000000LL; }
    return v;
}

/* ---- operand access ---- */
static inline u32 RR(c6x_cpu *c, int side, int reg) { return c->r[side][reg]; }

static inline int ovr_idx(c6x_cpu *c, const c6x_operand *o)
{
    if (!c->ovr) return -1;
    long k = o - c->ovr->ins.op;
    return (k >= 0 && k < 4) ? (int)k : -1;
}

static inline u32 rd(c6x_cpu *c, const c6x_operand *o)
{
    int k = ovr_idx(c, o);
    if (k >= 0 && (o->kind == OPK_REG || o->kind == OPK_PAIR)) return c->ovr->lo[k];
    switch (o->kind) {
    case OPK_REG: return c->r[o->side][o->reg];
    case OPK_PAIR: return c->r[o->side][o->reg];
    case OPK_IMM: case OPK_ADDR: return (u32)o->imm;
    case OPK_CTRL: return cpu_rd_ctrl(c, cpu_ctrl_index(o->imm));
    default: return 0;
    }
}
static inline u64 rd64(c6x_cpu *c, const c6x_operand *o)
{
    int k = ovr_idx(c, o);
    if (k >= 0 && o->kind == OPK_PAIR) return ((u64)c->ovr->hi[k] << 32) | c->ovr->lo[k];
    if (k >= 0 && o->kind == OPK_REG) return c->ovr->lo[k];
    if (o->kind == OPK_PAIR) return ((u64)c->r[o->side][o->reg + 1] << 32) | c->r[o->side][o->reg];
    if (o->kind == OPK_IMM) return (u64)(i64)o->imm;
    return c->r[o->side][o->reg];
}
/* 40-bit long (sign extended) from pair or 32-bit reg/imm (sign extended) */
static inline i64 rdl(c6x_cpu *c, const c6x_operand *o)
{
    if (o->kind == OPK_PAIR) return sext40(((u64)(c->r[o->side][o->reg + 1] & 0xFF) << 32) | c->r[o->side][o->reg]);
    return (i32)rd(c, o);
}

#define OP(i) (&in->op[i])
#define V(i) rd(c, OP(i))
#define VS(i) ((i32)rd(c, OP(i)))
#define V64(i) rd64(c, OP(i))
#define VL(i) rdl(c, OP(i))

static inline void W(c6x_cpu *c, const c6x_insn *in, int i, u32 v)
{
    const c6x_operand *o = OP(i);
    if (o->kind == OPK_CTRL) { cpu_wr_ctrl(c, cpu_ctrl_index(o->imm), v); return; }
    cpu_sched(c, o->side, o->reg, v, (in->wlo[i] ? in->wlo[i] : 1) - c->wdelta);
}
static inline void W64(c6x_cpu *c, const c6x_insn *in, int i, u64 v)
{
    const c6x_operand *o = OP(i);
    cpu_sched(c, o->side, o->reg, (u32)v, (in->wlo[i] ? in->wlo[i] : 1) - c->wdelta);
    cpu_sched(c, o->side, o->reg + 1, (u32)(v >> 32), (in->whi[i] ? in->whi[i] : (in->wlo[i] ? in->wlo[i] : 1)) - c->wdelta);
}
static inline void Wl(c6x_cpu *c, const c6x_insn *in, int i, i64 v) /* 40-bit long */
{
    const c6x_operand *o = OP(i);
    if (o->kind != OPK_PAIR) { W(c, in, i, (u32)v); return; }
    W64(c, in, i, (u64)v & 0xFFFFFFFFFFULL);
}
/* write dst either as 32-bit reg or 64-bit pair */
static inline void Wx(c6x_cpu *c, const c6x_insn *in, int i, u64 v)
{
    if (OP(i)->kind == OPK_PAIR) W64(c, in, i, v); else W(c, in, i, (u32)v);
}

/* ---- floating point helpers (C67x: denormals flush to zero) ---- */
static inline float f_of(u32 v) { float f; if ((v & 0x7F800000) == 0) v &= 0x80000000; memcpy(&f, &v, 4); return f; }
static inline u32 u_of(float f) { u32 v; memcpy(&v, &f, 4); if ((v & 0x7F800000) == 0) v &= 0x80000000; return v; }
static inline double d_of(u64 v) { double d; if ((v & 0x7FF0000000000000ULL) == 0) v &= 0x8000000000000000ULL; memcpy(&d, &v, 8); return d; }
static inline u64 ud_of(double d) { u64 v; memcpy(&v, &d, 8); if ((v & 0x7FF0000000000000ULL) == 0) v &= 0x8000000000000000ULL; return v; }

static inline i32 f2i_round(double x)
{
    if (x != x) return 0x7FFFFFFF;
    if (x >= 2147483647.5) return 0x7FFFFFFF;
    if (x <= -2147483648.5) return (i32)0x80000000;
    return (i32)nearbyint(x);
}
static inline i32 f2i_trunc(double x)
{
    if (x != x) return 0x7FFFFFFF;
    if (x >= 2147483648.0) return 0x7FFFFFFF;
    if (x <= -2147483649.0) return (i32)0x80000000;
    return (i32)x;
}

/* reciprocal / rsqrt approximations: exact result truncated to 8 mantissa bits */
static u32 approx_sp(double r)
{
    u32 v = u_of((float)r);
    if ((v & 0x7F800000) == 0x7F800000) return v;
    return v & 0xFFFF8000u;
}
static u64 approx_dp(double r)
{
    u64 v = ud_of(r);
    if ((v & 0x7FF0000000000000ULL) == 0x7FF0000000000000ULL) return v;
    return v & 0xFFFFF00000000000ULL;
}

/* ---- addressing ---- */
static u32 circ_add(c6x_cpu *c, int side, int reg, u32 base, i32 delta)
{
    if (reg >= 4 && reg <= 7) {
        u32 amr = c->cr[CR_AMR];
        u32 mode = (amr >> ((side * 4 + (reg - 4)) * 2)) & 3;
        if (mode == 1 || mode == 2) {
            u32 n = mode == 1 ? (amr >> 16) & 31 : (amr >> 21) & 31;
            u32 blk = n >= 31 ? 0xFFFFFFFFu : (2u << n) - 1;
            return (base & ~blk) | ((base + (u32)delta) & blk);
        }
    }
    return base + (u32)delta;
}

static u32 mem_addr(c6x_cpu *c, const c6x_insn *in, const c6x_operand *o, int size)
{
    u32 base = c->r[o->side][o->reg];
    i32 off;
    if (o->offreg) {
        off = (i32)c->r[o->side][o->offnum];
        if (o->scaled) off *= size;
    } else {
        off = o->imm;
        if (o->scaled) off *= size;
    }
    u32 addr, nb;
    switch (o->mode & ~4u) {
    case 0: addr = circ_add(c, o->side, o->reg, base, -off); break;
    case 1: addr = circ_add(c, o->side, o->reg, base, off); break;
    case 8: addr = nb = circ_add(c, o->side, o->reg, base, -off); cpu_sched(c, o->side, o->reg, nb, 1); break;
    case 9: addr = nb = circ_add(c, o->side, o->reg, base, off); cpu_sched(c, o->side, o->reg, nb, 1); break;
    case 10: addr = base; cpu_sched(c, o->side, o->reg, circ_add(c, o->side, o->reg, base, -off), 1); break;
    case 11: addr = base; cpu_sched(c, o->side, o->reg, circ_add(c, o->side, o->reg, base, off), 1); break;
    default: addr = base; break;
    }
    (void)in;
    return addr;
}

static inline u32 ld_un(c6x_cpu *c, u32 a)
{
    if ((a & 3) == 0) return mem_rd(c->mem, a, 4);
    return mem_rd(c->mem, a, 1) | (mem_rd(c->mem, a + 1, 1) << 8) | (mem_rd(c->mem, a + 2, 1) << 16) | (mem_rd(c->mem, a + 3, 1) << 24);
}

static void store(c6x_cpu *c, u32 addr, int size, u32 lo, u32 hi)
{
    if (c->cache) { c->cache->pc = c->cr[CR_PCE1]; c->cache->cycle = c->cycle; cache_write(c->cache, addr, size); }
    if (c->nst < 8) {
        c->st[c->nst].addr = addr; c->st[c->nst].size = (uint8_t)size;
        c->st[c->nst].lo = lo; c->st[c->nst].hi = hi; c->nst++;
    }
}

static void branch_to(c6x_cpu *c, u32 target, int kind)
{
    if (c->nbr < 8) {
        c->br[c->nbr].due = c->cycle + 6;
        c->br[c->nbr].target = target;
        c->br[c->nbr].kind = (uint8_t)kind;
        c->nbr++;
        if (c->brtrace && c->brtracef) {
            const char *kind_name = kind == 0 ? "imm" : (kind == 1 ? "irp" : "nrp");
            fprintf(c->brtracef, "%10llu %08X -> %08X kind=%s\n",
                (unsigned long long)c->cycle, c->pc, target, kind_name);
            fflush(c->brtracef);
        }
    }
}

static inline int cond_ok(c6x_cpu *c, const c6x_insn *in)
{
    if (!in->has_cond) return 1;
    u32 v = c->r[in->cside][in->cnum];
    return in->cz ? v == 0 : v != 0;
}

/* ---- packed helpers ---- */
static u32 lmbd(u32 bit, u32 v)
{
    if (!(bit & 1)) v = ~v;
    for (int i = 31; i >= 0; i--) if (v & (1u << i)) return 31 - i;
    return 32;
}
static u32 norm32(u32 v)
{
    u32 s = v >> 31, n = 0;
    for (int i = 30; i >= 0; i--) { if (((v >> i) & 1) == s) n++; else break; }
    return n;
}
static u32 norm40(i64 v)
{
    u64 u = (u64)v & 0xFFFFFFFFFFULL;
    u64 s = (u >> 39) & 1;
    u32 n = 0;
    for (int i = 38; i >= 0; i--) { if (((u >> i) & 1) == s) n++; else break; }
    return n;
}
static u32 gmpy8(u32 a, u32 b, u32 poly, u32 size)
{
    u32 p = 0;
    a &= 0xFF; b &= 0xFF;
    u32 top = 1u << size;
    for (int i = 0; i < 8; i++) {
        if (b & 1) p ^= a;
        b >>= 1;
        a <<= 1;
        if (a & top) a ^= (poly | top);
    }
    return p & 0xFF;
}
static u32 gmpy32(u32 src1, u32 src2, u32 poly)
{
    u32 pp = 0, mask = 0x100;
    for (int i = 0; i < 8; i++) {
        if (src2 & mask) pp ^= src1;
        mask >>= 1;
        u32 tpp = pp << 1;
        if (pp & 0x80000000) pp = poly ^ tpp; else pp = tpp;
    }
    if (src2 & 1) pp ^= src1;
    return pp;
}

static i64 mpy16(u32 a, int ahi, int asgn, u32 b, int bhi, int bsgn)
{
    i64 x = ahi ? (asgn ? s16hi(a) : (i64)u16hi(a)) : (asgn ? s16lo(a) : (i64)u16lo(a));
    i64 y = bhi ? (bsgn ? s16hi(b) : (i64)u16hi(b)) : (bsgn ? s16lo(b) : (i64)u16lo(b));
    return x * y;
}

static void defer_capture(c6x_cpu *c, defer_op *d, uint32_t estage)
{
    for (int k = 0; k < d->ins.nopnd; k++) {
        const c6x_operand *o = &d->ins.op[k];
        if (o->kind != OPK_REG && o->kind != OPK_PAIR) continue;
        if (d->ins.rlo[k] == estage || (estage == 1 && d->ins.rlo[k] == 0)) d->lo[k] = c->r[o->side][o->reg];
        if (o->kind == OPK_PAIR && (d->ins.rhi[k] == estage || (estage == 1 && d->ins.rhi[k] == 0)))
            d->hi[k] = c->r[o->side][o->reg + 1];
    }
}

void cpu_exec(c6x_cpu *c, const c6x_insn *in)
{
    if (!in->defer) { exec_insn(c, in); return; }
    if (!cond_ok(c, in)) return;
    if (c->ndq >= 8) { snprintf(c->err, sizeof c->err, "deferred op overflow"); c->halted = 1; return; }
    defer_op *d = &c->dq[c->ndq++];
    d->ins = *in;
    d->ins.has_cond = 0;
    d->issue = c->cycle;
    d->maxr = 1;
    for (int k = 0; k < in->nopnd; k++) {
        if (in->rlo[k] > d->maxr) d->maxr = in->rlo[k];
        if (in->rhi[k] > d->maxr) d->maxr = in->rhi[k];
        /* read-at-E1 parts and defaults */
        const c6x_operand *o = &in->op[k];
        if (o->kind == OPK_REG || o->kind == OPK_PAIR) {
            d->lo[k] = c->r[o->side][o->reg];
            if (o->kind == OPK_PAIR) d->hi[k] = c->r[o->side][o->reg + 1];
        }
    }
    defer_capture(c, d, 1);
}

/* called at the start of every cycle after pending writes are applied */
void cpu_defer_tick(c6x_cpu *c)
{
    for (int i = 0; i < c->ndq; i++) {
        defer_op *d = &c->dq[i];
        uint32_t estage = (uint32_t)(c->cycle - d->issue) + 1;
        if (estage <= 1) continue;
        defer_capture(c, d, estage);
        if (estage >= d->maxr) {
            defer_op done = *d;
            c->dq[i] = c->dq[--c->ndq];
            i--;
            c->ovr = &done;
            c->wdelta = (int)estage - 1;
            exec_insn(c, &done.ins);
            c->ovr = NULL;
            c->wdelta = 0;
        }
    }
}

void exec_insn(c6x_cpu *c, const c6x_insn *in)
{
    u32 a, b, r;
    i64 l;
    if (!cond_ok(c, in)) return;
    c->insns++;
    if (opc_sem[in->opc] < tic6x_opcode_max) c->opchist[opc_sem[in->opc]]++;
    switch (opc_sem[in->opc]) {
    /* ---------- no-ops / control ---------- */
    case S_NOP: case S_SPMASK: case S_SPMASKR: case S_SPKERNEL: case S_SPKERNELR:
    case S_SPLOOP: case S_SPLOOPD: case S_SPLOOPW:
        return;
    case S_IDLE: c->idle = 1; return;
    case S_DINT: {
        u32 t = c->cr[CR_TSR];
        t = (t & ~TSR_SGIE) | ((t & TSR_GIE) ? TSR_SGIE : 0);
        t &= ~TSR_GIE;
        c->cr[CR_TSR] = t;
        return;
    }
    case S_RINT: {
        u32 t = c->cr[CR_TSR];
        t = (t & ~TSR_GIE) | ((t & TSR_SGIE) ? TSR_GIE : 0);
        t &= ~TSR_SGIE;
        c->cr[CR_TSR] = t;
        return;
    }
    case S_SWE: case S_SWENR:
        c->cr[CR_EFR] |= 2;  /* SXF */
        c->exc_count++;
        return;

    /* ---------- branches ---------- */
    case S_B: case S_BNOP: {
        const c6x_operand *o = OP(0);
        if (o->kind == OPK_CTRL) {
            int id = cpu_ctrl_index(o->imm);
            branch_to(c, cpu_rd_ctrl(c, id), id == CR_IRP ? 1 : id == CR_NRP ? 2 : 0);
            if (id == CR_IRP) {           /* B IRP: TSR <- ITSR (GIE <- PGIE) in E1 */
                c->cr[CR_TSR] = c->cr[CR_ITSR];
            } else if (id == CR_NRP) {
                c->cr[CR_TSR] = c->cr[CR_NTSR];
                c->cr[CR_IER] |= 2;       /* NMIE */
            }
        } else {
            branch_to(c, rd(c, o) & ~1u, 0);
        }
        return;
    }
    case S_CALLP:
        W(c, in, 1, c->cur_next);
        branch_to(c, (u32)OP(0)->imm, 0);
        return;
    case S_BDEC: {
        i32 v = VS(1);
        if (v >= 0) { branch_to(c, (u32)OP(0)->imm, 0); W(c, in, 1, (u32)(v - 1)); }
        return;
    }
    case S_BPOS:
        if (VS(1) >= 0) branch_to(c, (u32)OP(0)->imm, 0);
        return;
    case S_ADDKPC:
        W(c, in, 1, (u32)OP(0)->imm);
        return;

    /* ---------- moves ---------- */
    case S_MV:
        if (OP(1)->kind == OPK_PAIR) Wl(c, in, 1, VL(0)); else W(c, in, 1, V(0));
        return;
    case S_MVK: case S_MVKL:
        W(c, in, 1, V(0));
        return;
    case S_MVKH:
        W(c, in, 1, (V(0) & 0xFFFF0000u) | (V(1) & 0xFFFF));
        return;
    case S_MVKLH:
        W(c, in, 1, (V(0) << 16) | (V(1) & 0xFFFF));
        return;
    case S_ZERO:
        if (OP(0)->kind == OPK_PAIR) W64(c, in, 0, 0); else W(c, in, 0, 0);
        return;
    case S_MVC:
        W(c, in, 1, V(0));
        return;
    case S_MVD:
        W(c, in, 1, V(0));
        return;
    case S_DMV:
        W64(c, in, 2, ((u64)V(0) << 32) | V(1));
        return;

    /* ---------- integer add/sub ---------- */
    case S_ADD:
        if (OP(2)->kind == OPK_PAIR) Wl(c, in, 2, VL(0) + VL(1));
        else W(c, in, 2, V(0) + V(1));
        return;
    case S_SUB:
        if (OP(2)->kind == OPK_PAIR) Wl(c, in, 2, VL(0) - VL(1));
        else W(c, in, 2, V(0) - V(1));
        return;
    case S_ADDU:
        if (OP(1)->kind == OPK_PAIR) l = (i64)V(0) + (i64)(((u64)V64(1)) & 0xFFFFFFFFFFULL);
        else l = (i64)V(0) + (i64)V(1);
        Wl(c, in, 2, l);
        return;
    case S_SUBU:
        Wl(c, in, 2, (i64)V(0) - (i64)V(1));
        return;
    case S_SADD:
        if (OP(2)->kind == OPK_PAIR) Wl(c, in, 2, sat40(c, VL(0) + VL(1)));
        else W(c, in, 2, (u32)sat32(c, (i64)VS(0) + VS(1)));
        return;
    case S_SSUB:
        if (OP(2)->kind == OPK_PAIR) Wl(c, in, 2, sat40(c, VL(0) - VL(1)));
        else W(c, in, 2, (u32)sat32(c, (i64)VS(0) - VS(1)));
        return;
    case S_ADDK:
        W(c, in, 1, V(1) + V(0));
        return;
    case S_ADDAB: case S_ADDAH: case S_ADDAW: case S_ADDAD:
    case S_SUBAB: case S_SUBAH: case S_SUBAW: {
        int sh = 0, sem = opc_sem[in->opc];
        if (sem == S_ADDAH || sem == S_SUBAH) sh = 1;
        if (sem == S_ADDAW || sem == S_SUBAW) sh = 2;
        if (sem == S_ADDAD) sh = 3;
        i32 d = (i32)(V(1) << sh);
        if (sem == S_SUBAB || sem == S_SUBAH || sem == S_SUBAW) d = -d;
        const c6x_operand *o = OP(0);
        if (o->kind == OPK_REG) W(c, in, 2, circ_add(c, o->side, o->reg, V(0), d));
        else W(c, in, 2, V(0) + (u32)d);
        return;
    }
    case S_NEG:
        if (OP(1)->kind == OPK_PAIR) Wl(c, in, 1, -VL(0)); else W(c, in, 1, 0u - V(0));
        return;
    case S_ABS:
        if (OP(1)->kind == OPK_PAIR) { l = VL(0); if (l == -0x8000000000LL) l = 0x7FFFFFFFFFLL; else if (l < 0) l = -l; Wl(c, in, 1, l); }
        else { i32 v = VS(0); W(c, in, 1, v == (i32)0x80000000 ? 0x7FFFFFFF : (u32)(v < 0 ? -v : v)); }
        return;
    case S_SAT:
        W(c, in, 1, (u32)sat32(c, VL(0)));
        return;
    case S_SUBC: {
        a = V(0); b = V(1);
        if ((i64)(u64)a - (i64)(u64)b >= 0) W(c, in, 2, ((a - b) << 1) + 1);
        else W(c, in, 2, a << 1);
        return;
    }
    case S_ADD2:
        a = V(0); b = V(1);
        W(c, in, 2, ((a & 0xFFFF0000u) + (b & 0xFFFF0000u)) | ((a + b) & 0xFFFF));
        return;
    case S_SUB2:
        a = V(0); b = V(1);
        W(c, in, 2, ((a & 0xFFFF0000u) - (b & 0xFFFF0000u)) | ((a - b) & 0xFFFF));
        return;
    case S_ADD4: case S_SUB4:
        a = V(0); b = V(1); r = 0;
        for (int i = 0; i < 4; i++)
            r |= ((opc_sem[in->opc] == S_ADD4 ? byte(a, i) + byte(b, i) : byte(a, i) - byte(b, i)) & 0xFF) << (8 * i);
        W(c, in, 2, r);
        return;
    case S_SADD2:
        a = V(0); b = V(1);
        W(c, in, 2, ((u32)(sat16(c, s16hi(a) + s16hi(b)) & 0xFFFF) << 16) | (sat16(c, s16lo(a) + s16lo(b)) & 0xFFFF));
        return;
    case S_SSUB2:
        a = V(0); b = V(1);
        W(c, in, 2, ((u32)(sat16(c, s16hi(a) - s16hi(b)) & 0xFFFF) << 16) | (sat16(c, s16lo(a) - s16lo(b)) & 0xFFFF));
        return;
    case S_SADDUS2: case S_SADDSU2: {
        a = V(0); b = V(1);
        if (opc_sem[in->opc] == S_SADDSU2) { u32 t = a; a = b; b = t; } /* src1 signed, src2 unsigned */
        r = 0;
        for (int h = 0; h < 2; h++) {
            i32 v = (i32)((a >> (16 * h)) & 0xFFFF) + (int16_t)(b >> (16 * h));
            if (v < 0) { v = 0; set_sat(c); }
            if (v > 0xFFFF) { v = 0xFFFF; set_sat(c); }
            r |= (u32)v << (16 * h);
        }
        W(c, in, 2, r);
        return;
    }
    case S_SADDU4:
        a = V(0); b = V(1); r = 0;
        for (int i = 0; i < 4; i++) { u32 v = byte(a, i) + byte(b, i); if (v > 255) { v = 255; set_sat(c); } r |= v << (8 * i); }
        W(c, in, 2, r);
        return;
    case S_ADDSUB:
        W64(c, in, 2, ((u64)(V(0) + V(1)) << 32) | (u32)(V(0) - V(1)));
        return;
    case S_SADDSUB:
        W64(c, in, 2, ((u64)(u32)sat32(c, (i64)VS(0) + VS(1)) << 32) | (u32)sat32(c, (i64)VS(0) - VS(1)));
        return;
    case S_ADDSUB2: {
        a = V(0); b = V(1);
        u32 hi = ((a & 0xFFFF0000u) + (b & 0xFFFF0000u)) | ((a + b) & 0xFFFF);
        u32 lo = ((a & 0xFFFF0000u) - (b & 0xFFFF0000u)) | ((a - b) & 0xFFFF);
        W64(c, in, 2, ((u64)hi << 32) | lo);
        return;
    }
    case S_SADDSUB2: {
        a = V(0); b = V(1);
        u32 hi = ((u32)(sat16(c, s16hi(a) + s16hi(b)) & 0xFFFF) << 16) | (sat16(c, s16lo(a) + s16lo(b)) & 0xFFFF);
        u32 lo = ((u32)(sat16(c, s16hi(a) - s16hi(b)) & 0xFFFF) << 16) | (sat16(c, s16lo(a) - s16lo(b)) & 0xFFFF);
        W64(c, in, 2, ((u64)hi << 32) | lo);
        return;
    }
    case S_AVG2:
        a = V(0); b = V(1);
        W(c, in, 2, (((u32)((s16hi(a) + s16hi(b) + 1) >> 1) & 0xFFFF) << 16) | ((u32)((s16lo(a) + s16lo(b) + 1) >> 1) & 0xFFFF));
        return;
    case S_AVGU4:
        a = V(0); b = V(1); r = 0;
        for (int i = 0; i < 4; i++) r |= (((byte(a, i) + byte(b, i) + 1) >> 1) & 0xFF) << (8 * i);
        W(c, in, 2, r);
        return;
    case S_ABS2: {
        a = V(0); r = 0;
        for (int h = 0; h < 2; h++) {
            i32 v = (int16_t)(a >> (16 * h));
            v = v == -32768 ? 32767 : (v < 0 ? -v : v);
            r |= (u32)(v & 0xFFFF) << (16 * h);
        }
        W(c, in, 1, r);
        return;
    }
    case S_MAX2: case S_MIN2: {
        a = V(0); b = V(1); r = 0;
        for (int h = 0; h < 2; h++) {
            i32 x = (int16_t)(a >> (16 * h)), y = (int16_t)(b >> (16 * h));
            i32 v = opc_sem[in->opc] == S_MAX2 ? (x > y ? x : y) : (x < y ? x : y);
            r |= (u32)(v & 0xFFFF) << (16 * h);
        }
        W(c, in, 2, r);
        return;
    }
    case S_MAXU4: case S_MINU4: {
        a = V(0); b = V(1); r = 0;
        for (int i = 0; i < 4; i++) {
            u32 x = byte(a, i), y = byte(b, i);
            r |= (opc_sem[in->opc] == S_MAXU4 ? (x > y ? x : y) : (x < y ? x : y)) << (8 * i);
        }
        W(c, in, 2, r);
        return;
    }
    case S_SUBABS4: {
        a = V(0); b = V(1); r = 0;
        for (int i = 0; i < 4; i++) { i32 d = (i32)byte(a, i) - (i32)byte(b, i); r |= (u32)(d < 0 ? -d : d) << (8 * i); }
        W(c, in, 2, r);
        return;
    }

    /* ---------- logic ---------- */
    case S_AND: W(c, in, 2, V(0) & V(1)); return;
    case S_ANDN: W(c, in, 2, V(0) & ~V(1)); return;
    case S_OR: W(c, in, 2, V(0) | V(1)); return;
    case S_XOR: W(c, in, 2, V(0) ^ V(1)); return;
    case S_NOT: W(c, in, 1, ~V(0)); return;

    /* ---------- compares ---------- */
    case S_CMPEQ: W(c, in, 2, OP(1)->kind == OPK_PAIR ? (u32)((i64)VS(0) == VL(1)) : (u32)(V(0) == V(1))); return;
    case S_CMPGT: W(c, in, 2, OP(1)->kind == OPK_PAIR ? (u32)((i64)VS(0) > VL(1)) : (u32)(VS(0) > VS(1))); return;
    case S_CMPLT: W(c, in, 2, OP(1)->kind == OPK_PAIR ? (u32)((i64)VS(0) < VL(1)) : (u32)(VS(0) < VS(1))); return;
    case S_CMPGTU:
        if (OP(1)->kind == OPK_PAIR) W(c, in, 2, (u64)V(0) > (V64(1) & 0xFFFFFFFFFFULL));
        else W(c, in, 2, (u32)(V(0) > V(1)));
        return;
    case S_CMPLTU:
        if (OP(1)->kind == OPK_PAIR) W(c, in, 2, (u64)V(0) < (V64(1) & 0xFFFFFFFFFFULL));
        else W(c, in, 2, (u32)(V(0) < V(1)));
        return;
    case S_CMPEQ2: case S_CMPGT2: case S_CMPLT2: {
        a = V(0); b = V(1); r = 0;
        for (int h = 0; h < 2; h++) {
            i32 x = (int16_t)(a >> (16 * h)), y = (int16_t)(b >> (16 * h));
            int t = opc_sem[in->opc] == S_CMPEQ2 ? x == y : opc_sem[in->opc] == S_CMPGT2 ? x > y : x < y;
            r |= (u32)t << h;
        }
        W(c, in, 2, r);
        return;
    }
    case S_CMPEQ4: case S_CMPGTU4: case S_CMPLTU4: {
        a = V(0); b = V(1); r = 0;
        for (int i = 0; i < 4; i++) {
            u32 x = byte(a, i), y = byte(b, i);
            int t = opc_sem[in->opc] == S_CMPEQ4 ? x == y : opc_sem[in->opc] == S_CMPGTU4 ? x > y : x < y;
            r |= (u32)t << i;
        }
        W(c, in, 2, r);
        return;
    }

    /* ---------- shifts / bit fields ---------- */
    case S_SHL: {
        u32 s = V(1) & 0x3F;
        if (s > 40) s = 40;
        if (OP(2)->kind == OPK_PAIR) {
            i64 v = OP(0)->kind == OPK_PAIR ? VL(0) : (i64)(u64)V(0);
            Wl(c, in, 2, s >= 40 ? 0 : (i64)((u64)v << s));
        } else {
            W(c, in, 2, s >= 32 ? 0 : V(0) << s);
        }
        return;
    }
    case S_SHR: {
        u32 s = V(1) & 0x3F;
        if (s > 40) s = 40;
        if (OP(2)->kind == OPK_PAIR) { l = VL(0); Wl(c, in, 2, l >> (s > 39 ? 39 : s)); }
        else { i32 v = VS(0); W(c, in, 2, (u32)(v >> (s > 31 ? 31 : s))); }
        return;
    }
    case S_SHRU: {
        u32 s = V(1) & 0x3F;
        if (s > 40) s = 40;
        if (OP(2)->kind == OPK_PAIR) { u64 v = V64(0) & 0xFFFFFFFFFFULL; Wl(c, in, 2, s >= 40 ? 0 : (i64)(v >> s)); }
        else W(c, in, 2, s >= 32 ? 0 : V(0) >> s);
        return;
    }
    case S_SSHL: {
        u32 s = V(1) & 0x3F;
        i32 v = VS(0);
        i64 res;
        if (s == 0) res = v;
        else if (s >= 32) res = v == 0 ? 0 : (v > 0 ? 0x7FFFFFFF : (i64)(i32)0x80000000);
        else {
            res = (i64)v << s;
            if (res > 0x7FFFFFFF || res < -0x80000000LL) { set_sat(c); res = v > 0 ? 0x7FFFFFFF : -0x80000000LL; }
        }
        W(c, in, 2, (u32)res);
        return;
    }
    case S_SSHVL: case S_SSHVR: {
        i32 v = VS(0), s = VS(1);
        if (opc_sem[in->opc] == S_SSHVR) s = -s;
        i64 res;
        if (s > 31) s = 31;
        if (s < -31) s = -31;
        if (s >= 0) res = sat32(c, (i64)v << s);
        else res = v >> (-s);
        W(c, in, 2, (u32)res);
        return;
    }
    case S_SHR2: case S_SHRU2: {
        u32 s = V(1) & 31;
        a = V(0); r = 0;
        for (int h = 0; h < 2; h++) {
            u32 x = (a >> (16 * h)) & 0xFFFF, v;
            if (opc_sem[in->opc] == S_SHR2) v = (u32)((int16_t)x >> (s > 15 ? 15 : s)) & 0xFFFF;
            else v = s > 15 ? 0 : x >> s;
            r |= v << (16 * h);
        }
        W(c, in, 2, r);
        return;
    }
    case S_ROTL: {
        u32 s = V(1) & 31;
        a = V(0);
        W(c, in, 2, s ? (a << s) | (a >> (32 - s)) : a);
        return;
    }
    case S_SHLMB: a = V(0); b = V(1); W(c, in, 2, (b << 8) | (a >> 24)); return;
    case S_SHRMB: a = V(0); b = V(1); W(c, in, 2, (b >> 8) | (a << 24)); return;
    case S_EXT: case S_EXTU: case S_SET: case S_CLR: {
        u32 csta, cstb;
        int dsti;
        if (in->nopnd == 4) { csta = V(1) & 31; cstb = V(2) & 31; dsti = 3; }
        else { u32 x = V(1); csta = (x >> 5) & 31; cstb = x & 31; dsti = 2; }
        a = V(0);
        switch (opc_sem[in->opc]) {
        case S_EXT: r = (u32)((i32)(a << csta) >> cstb); break;
        case S_EXTU: r = (a << csta) >> cstb; break;
        case S_SET: case S_CLR: {
            u32 mask = 0;
            if (cstb >= csta) mask = (cstb - csta == 31) ? 0xFFFFFFFFu : (((1u << (cstb - csta + 1)) - 1) << csta);
            r = opc_sem[in->opc] == S_SET ? (a | mask) : (a & ~mask);
            break;
        }
        default: r = 0;
        }
        W(c, in, dsti, r);
        return;
    }
    case S_LMBD: W(c, in, 2, lmbd(V(0), V(1))); return;
    case S_NORM:
        if (OP(0)->kind == OPK_PAIR) W(c, in, 1, norm40(VL(0)));
        else W(c, in, 1, norm32(V(0)));
        return;
    case S_BITC4: a = V(0); r = 0; for (int i = 0; i < 4; i++) r |= (u32)__builtin_popcount(byte(a, i)) << (8 * i); W(c, in, 1, r); return;
    case S_BITR: a = V(0); r = 0; for (int i = 0; i < 32; i++) if (a & (1u << i)) r |= 1u << (31 - i); W(c, in, 1, r); return;
    case S_SHFL: a = V(0); r = 0; for (int i = 0; i < 16; i++) { r |= ((a >> i) & 1) << (2 * i); r |= ((a >> (16 + i)) & 1) << (2 * i + 1); } W(c, in, 1, r); return;
    case S_DEAL: a = V(0); r = 0; for (int i = 0; i < 16; i++) { r |= ((a >> (2 * i)) & 1) << i; r |= ((a >> (2 * i + 1)) & 1) << (16 + i); } W(c, in, 1, r); return;
    case S_SHFL3: {
        u32 s1 = V(0), s2 = V(1);
        u32 in0 = s2 & 0xFFFF, in1 = s1 & 0xFFFF, in2 = (s1 >> 16) & 0xFFFF;
        u64 res = 0;
        for (int i = 0; i < 16; i++) {
            res |= (u64)((in0 >> i) & 1) << (i * 3);
            res |= (u64)((in1 >> i) & 1) << (i * 3 + 1);
            res |= (u64)((in2 >> i) & 1) << (i * 3 + 2);
        }
        W64(c, in, 2, res);
        return;
    }
    case S_XPND2: a = V(0); W(c, in, 1, ((a & 2) ? 0xFFFF0000u : 0) | ((a & 1) ? 0xFFFFu : 0)); return;
    case S_XPND4: a = V(0); r = 0; for (int i = 0; i < 4; i++) if (a & (1u << i)) r |= 0xFFu << (8 * i); W(c, in, 1, r); return;
    case S_SWAP2: a = V(0); W(c, in, 1, (a << 16) | (a >> 16)); return;
    case S_SWAP4: a = V(0); W(c, in, 1, ((a & 0x00FF00FFu) << 8) | ((a & 0xFF00FF00u) >> 8)); return;
    case S_UNPKHU4: a = V(0); W(c, in, 1, (byte(a, 3) << 16) | byte(a, 2)); return;
    case S_UNPKLU4: a = V(0); W(c, in, 1, (byte(a, 1) << 16) | byte(a, 0)); return;

    /* ---------- packing ---------- */
    case S_PACK2: a = V(0); b = V(1); W(c, in, 2, (a << 16) | (b & 0xFFFF)); return;
    case S_PACKH2: a = V(0); b = V(1); W(c, in, 2, (a & 0xFFFF0000u) | (b >> 16)); return;
    case S_PACKHL2: a = V(0); b = V(1); W(c, in, 2, (a & 0xFFFF0000u) | (b & 0xFFFF)); return;
    case S_PACKLH2: a = V(0); b = V(1); W(c, in, 2, (a << 16) | (b >> 16)); return;
    case S_PACKH4: a = V(0); b = V(1); W(c, in, 2, (byte(a, 3) << 24) | (byte(a, 1) << 16) | (byte(b, 3) << 8) | byte(b, 1)); return;
    case S_PACKL4: a = V(0); b = V(1); W(c, in, 2, (byte(a, 2) << 24) | (byte(a, 0) << 16) | (byte(b, 2) << 8) | byte(b, 0)); return;
    case S_SPACK2: W(c, in, 2, ((u32)(sat16(c, sat32(c, VS(0))) & 0xFFFF) << 16) | ((u32)sat16(c, VS(1)) & 0xFFFF)); return;
    case S_SPACKU4: {
        a = V(0); b = V(1);
        i32 v[4] = { s16lo(b), s16hi(b), s16lo(a), s16hi(a) };
        r = 0;
        for (int i = 0; i < 4; i++) { i32 x = v[i] < 0 ? 0 : v[i] > 255 ? 255 : v[i]; if (x != v[i]) set_sat(c); r |= (u32)x << (8 * i); }
        W(c, in, 2, r);
        return;
    }
    case S_RPACK2: {
        i32 x = sat32(c, (i64)VS(0) << 1), y = sat32(c, (i64)VS(1) << 1);
        u32 hx = (u32)sat32(c, (i64)x + 0x8000) >> 16, hy = (u32)sat32(c, (i64)y + 0x8000) >> 16;
        W(c, in, 2, (hx << 16) | (hy & 0xFFFF));
        return;
    }
    case S_DPACK2: a = V(0); b = V(1); W64(c, in, 2, ((u64)((a & 0xFFFF0000u) | (b >> 16)) << 32) | ((a << 16) | (b & 0xFFFF))); return;
    case S_DPACKX2: a = V(0); b = V(1);
        W64(c, in, 2, ((u64)((b << 16) | (a >> 16)) << 32) | ((a << 16) | (b >> 16)));
        return;

    /* ---------- 16x16 multiplies (1 delay slot) ---------- */
    case S_MPY:    W(c, in, 2, (u32)mpy16(V(0), 0, 1, V(1), 0, 1)); return;
    case S_MPYU:   W(c, in, 2, (u32)mpy16(V(0), 0, 0, V(1), 0, 0)); return;
    case S_MPYUS:  W(c, in, 2, (u32)mpy16(V(0), 0, 0, V(1), 0, 1)); return;
    case S_MPYSU:  W(c, in, 2, (u32)mpy16(V(0), 0, 1, V(1), 0, 0)); return;
    case S_MPYH:   W(c, in, 2, (u32)mpy16(V(0), 1, 1, V(1), 1, 1)); return;
    case S_MPYHU:  W(c, in, 2, (u32)mpy16(V(0), 1, 0, V(1), 1, 0)); return;
    case S_MPYHUS: W(c, in, 2, (u32)mpy16(V(0), 1, 0, V(1), 1, 1)); return;
    case S_MPYHSU: W(c, in, 2, (u32)mpy16(V(0), 1, 1, V(1), 1, 0)); return;
    case S_MPYHL:  W(c, in, 2, (u32)mpy16(V(0), 1, 1, V(1), 0, 1)); return;
    case S_MPYHLU: W(c, in, 2, (u32)mpy16(V(0), 1, 0, V(1), 0, 0)); return;
    case S_MPYHULS:W(c, in, 2, (u32)mpy16(V(0), 1, 0, V(1), 0, 1)); return;
    case S_MPYHSLU:W(c, in, 2, (u32)mpy16(V(0), 1, 1, V(1), 0, 0)); return;
    case S_MPYLH:  W(c, in, 2, (u32)mpy16(V(0), 0, 1, V(1), 1, 1)); return;
    case S_MPYLHU: W(c, in, 2, (u32)mpy16(V(0), 0, 0, V(1), 1, 0)); return;
    case S_MPYLUHS:W(c, in, 2, (u32)mpy16(V(0), 0, 0, V(1), 1, 1)); return;
    case S_MPYLSHU:W(c, in, 2, (u32)mpy16(V(0), 0, 1, V(1), 1, 0)); return;
    case S_SMPY: case S_SMPYH: case S_SMPYHL: case S_SMPYLH: {
        int s = opc_sem[in->opc];
        i64 p = mpy16(V(0), s == S_SMPYH || s == S_SMPYHL, 1, V(1), s == S_SMPYH || s == S_SMPYLH, 1);
        if (p == 0x40000000) { set_sat(c); W(c, in, 2, 0x7FFFFFFF); }
        else W(c, in, 2, (u32)(p << 1));
        return;
    }

    /* ---------- 32-bit / packed multiplies ---------- */
    case S_MPY32:
        if (OP(2)->kind == OPK_PAIR) W64(c, in, 2, (u64)((i64)VS(0) * VS(1)));
        else W(c, in, 2, (u32)((i64)VS(0) * VS(1)));
        return;
    case S_MPY32U: W64(c, in, 2, (u64)V(0) * V(1)); return;
    case S_MPY32SU: W64(c, in, 2, (u64)((i64)VS(0) * (i64)(u64)V(1))); return;
    case S_MPY32US: W64(c, in, 2, (u64)((i64)(u64)V(0) * (i64)VS(1))); return;
    case S_SMPY32: {
        i32 x = VS(0), y = VS(1);
        if (x == (i32)0x80000000 && y == (i32)0x80000000) { set_sat(c); W(c, in, 2, 0x7FFFFFFF); }
        else W(c, in, 2, (u32)(((i64)x * y) >> 31));
        return;
    }
    case S_MPYI: W(c, in, 2, (u32)((i64)VS(0) * VS(1))); return;
    case S_MPYID: W64(c, in, 2, (u64)((i64)VS(0) * VS(1))); return;
    case S_MPYHI: W64(c, in, 2, (u64)((i64)s16hi(V(0)) * VS(1))); return;
    case S_MPYLI: W64(c, in, 2, (u64)((i64)s16lo(V(0)) * VS(1))); return;
    case S_MPYIH: W64(c, in, 2, (u64)((i64)VS(0) * s16hi(V(1)))); return;
    case S_MPYIL: W64(c, in, 2, (u64)((i64)VS(0) * s16lo(V(1)))); return;
    case S_MPYHIR: W(c, in, 2, (u32)(((i64)s16hi(V(0)) * VS(1) + 0x4000) >> 15)); return;
    case S_MPYLIR: W(c, in, 2, (u32)(((i64)s16lo(V(0)) * VS(1) + 0x4000) >> 15)); return;
    case S_MPYIHR: W(c, in, 2, (u32)(((i64)VS(0) * s16hi(V(1)) + 0x4000) >> 15)); return;
    case S_MPYILR: W(c, in, 2, (u32)(((i64)VS(0) * s16lo(V(1)) + 0x4000) >> 15)); return;
    case S_MPY2: a = V(0); b = V(1);
        W64(c, in, 2, ((u64)(u32)(s16hi(a) * s16hi(b)) << 32) | (u32)(s16lo(a) * s16lo(b)));
        return;
    case S_SMPY2: {
        a = V(0); b = V(1);
        i64 ph = (i64)s16hi(a) * s16hi(b), pl = (i64)s16lo(a) * s16lo(b);
        u32 rh = ph == 0x40000000 ? (set_sat(c), 0x7FFFFFFFu) : (u32)(ph << 1);
        u32 rl = pl == 0x40000000 ? (set_sat(c), 0x7FFFFFFFu) : (u32)(pl << 1);
        W64(c, in, 2, ((u64)rh << 32) | rl);
        return;
    }
    case S_MPY2IR: {
        a = V(0); i32 y = VS(1);
        u32 ro, re;
        if (u16hi(a) == 0x8000 && (u32)y == 0x80000000u) { ro = 0x7FFFFFFF; set_sat(c); }
        else ro = (u32)(((i64)s16hi(a) * y + 0x4000) >> 15);
        if (u16lo(a) == 0x8000 && (u32)y == 0x80000000u) { re = 0x7FFFFFFF; set_sat(c); }
        else re = (u32)(((i64)s16lo(a) * y + 0x4000) >> 15);
        W64(c, in, 2, ((u64)ro << 32) | re);
        return;
    }
    case S_MPYSU4: case S_MPYUS4: case S_MPYU4: {
        a = V(0); b = V(1);
        int sem = opc_sem[in->opc];
        if (sem == S_MPYUS4) { u32 t = a; a = b; b = t; }  /* src1 unsigned, src2 signed */
        u64 res = 0;
        for (int i = 0; i < 4; i++) {
            i32 x = sem == S_MPYU4 ? (i32)byte(a, i) : (int8_t)byte(a, i);
            i32 y = (i32)byte(b, i);
            res |= (u64)((u32)(x * y) & 0xFFFF) << (16 * i);
        }
        W64(c, in, 2, res);
        return;
    }
    case S_DOTP2: case S_DOTPN2: {
        a = V(0); b = V(1);
        i64 hi = (i64)s16hi(a) * s16hi(b), lo = (i64)s16lo(a) * s16lo(b);
        i64 v = opc_sem[in->opc] == S_DOTP2 ? hi + lo : hi - lo;
        if (OP(2)->kind == OPK_PAIR) Wl(c, in, 2, v); else W(c, in, 2, (u32)v);
        return;
    }
    case S_DOTPRSU2: case S_DOTPRUS2: case S_DOTPNRSU2: case S_DOTPNRUS2: {
        a = V(0); b = V(1);
        int sem = opc_sem[in->opc];
        if (sem == S_DOTPRUS2 || sem == S_DOTPNRUS2) { u32 t = a; a = b; b = t; }
        i64 hi = (i64)s16hi(a) * (i64)u16hi(b), lo = (i64)s16lo(a) * (i64)u16lo(b);
        i64 v = (sem == S_DOTPRSU2 || sem == S_DOTPRUS2) ? hi + lo : hi - lo;
        W(c, in, 2, (u32)((v + 0x8000) >> 16));
        return;
    }
    case S_DOTPSU4: case S_DOTPUS4: case S_DOTPU4: {
        a = V(0); b = V(1);
        int sem = opc_sem[in->opc];
        if (sem == S_DOTPUS4) { u32 t = a; a = b; b = t; }
        i64 s = 0;
        for (int i = 0; i < 4; i++) s += (i64)(sem == S_DOTPU4 ? (i32)byte(a, i) : (int8_t)byte(a, i)) * (i32)byte(b, i);
        W(c, in, 2, (u32)s);
        return;
    }
    case S_DDOTP4: {
        a = V(0); b = V(1);
        i32 e = s16hi(a) * (int8_t)byte(b, 1) + s16lo(a) * (int8_t)byte(b, 0);
        i32 o = s16hi(a) * (int8_t)byte(b, 3) + s16lo(a) * (int8_t)byte(b, 2);
        W64(c, in, 2, ((u64)(u32)o << 32) | (u32)e);
        return;
    }
    case S_DDOTPH2: case S_DDOTPL2: case S_DDOTPH2R: case S_DDOTPL2R: {
        u64 p = V64(0); u32 e1 = (u32)p, o1 = (u32)(p >> 32);
        b = V(1);
        int sem = opc_sem[in->opc];
        i64 ro, re;
        if (sem == S_DDOTPH2 || sem == S_DDOTPH2R) {
            ro = (i64)s16hi(o1) * s16hi(b) + (i64)s16lo(o1) * s16lo(b);
            re = (i64)s16lo(o1) * s16hi(b) + (i64)s16hi(e1) * s16lo(b);
        } else {
            re = (i64)s16hi(e1) * s16hi(b) + (i64)s16lo(e1) * s16lo(b);
            ro = (i64)s16lo(o1) * s16hi(b) + (i64)s16hi(e1) * s16lo(b);
        }
        if (sem == S_DDOTPH2 || sem == S_DDOTPL2) {
            W64(c, in, 2, ((u64)(u32)sat32(c, ro) << 32) | (u32)sat32(c, re));
        } else {
            u32 h = (u32)sat32(c, ro + 0x8000) >> 16, lo = (u32)sat32(c, re + 0x8000) >> 16;
            W(c, in, 2, (h << 16) | (lo & 0xFFFF));
        }
        return;
    }
    case S_CMPY: {
        a = V(0); b = V(1);
        i64 e = (i64)s16lo(a) * s16hi(b) + (i64)s16hi(a) * s16lo(b);
        i64 o = (i64)s16hi(a) * s16hi(b) - (i64)s16lo(a) * s16lo(b);
        W64(c, in, 2, ((u64)(u32)o << 32) | (u32)sat32(c, e));
        return;
    }
    case S_CMPYR: case S_CMPYR1: {
        a = V(0); b = V(1);
        i64 e = (i64)s16lo(a) * s16hi(b) + (i64)s16hi(a) * s16lo(b);
        i64 o = (i64)s16hi(a) * s16hi(b) - (i64)s16lo(a) * s16lo(b);
        if (opc_sem[in->opc] == S_CMPYR1) { e = (i64)sat32(c, e) << 1; o = (i64)sat32(c, o) << 1; }
        u32 te = (u32)sat32(c, e), to = (u32)sat32(c, o);
        u32 he = (u32)sat32(c, (i64)(i32)te + 0x8000) >> 16, ho = (u32)sat32(c, (i64)(i32)to + 0x8000) >> 16;
        W(c, in, 2, (ho << 16) | (he & 0xFFFF));
        return;
    }
    case S_GMPY4: {
        a = V(0); b = V(1);
        u32 g = c->cr[CR_GFPGFR], poly = g & 0xFF, size = ((g >> 24) & 7) + 1;
        r = 0;
        for (int i = 0; i < 4; i++) r |= gmpy8(byte(a, i), byte(b, i), poly, size) << (8 * i);
        W(c, in, 2, r);
        return;
    }
    case S_GMPY: W(c, in, 2, gmpy32(V(0), V(1) & 0x1FF, in->side ? c->cr[CR_GPLYB] : c->cr[CR_GPLYA])); return;
    case S_XORMPY: W(c, in, 2, gmpy32(V(0), V(1) & 0x1FF, 0)); return;

    /* ---------- single precision ---------- */
    case S_ADDSP: W(c, in, 2, u_of(f_of(V(0)) + f_of(V(1)))); return;
    case S_SUBSP: W(c, in, 2, u_of(f_of(V(0)) - f_of(V(1)))); return;
    case S_MPYSP: W(c, in, 2, u_of(f_of(V(0)) * f_of(V(1)))); return;
    case S_ABSSP: W(c, in, 1, V(0) & 0x7FFFFFFFu); return;
    case S_RCPSP: W(c, in, 1, approx_sp(1.0 / (double)f_of(V(0)))); return;
    case S_RSQRSP: W(c, in, 1, approx_sp(1.0 / sqrt((double)f_of(V(0))))); return;
    case S_INTSP: W(c, in, 1, u_of((float)VS(0))); return;
    case S_INTSPU: W(c, in, 1, u_of((float)V(0))); return;
    case S_SPINT: W(c, in, 1, (u32)f2i_round(f_of(V(0)))); return;
    case S_SPTRUNC: W(c, in, 1, (u32)f2i_trunc(f_of(V(0)))); return;
    case S_SPDP: W64(c, in, 1, ud_of((double)f_of(V(0)))); return;
    case S_CMPEQSP: W(c, in, 2, f_of(V(0)) == f_of(V(1))); return;
    case S_CMPGTSP: W(c, in, 2, f_of(V(0)) > f_of(V(1))); return;
    case S_CMPLTSP: W(c, in, 2, f_of(V(0)) < f_of(V(1))); return;

    /* ---------- double precision ---------- */
    case S_ADDDP: W64(c, in, 2, ud_of(d_of(V64(0)) + d_of(V64(1)))); return;
    case S_SUBDP: W64(c, in, 2, ud_of(d_of(V64(0)) - d_of(V64(1)))); return;
    case S_MPYDP: W64(c, in, 2, ud_of(d_of(V64(0)) * d_of(V64(1)))); return;
    case S_MPYSPDP: W64(c, in, 2, ud_of((double)f_of(V(0)) * d_of(V64(1)))); return;
    case S_MPYSP2DP: W64(c, in, 2, ud_of((double)f_of(V(0)) * (double)f_of(V(1)))); return;
    case S_ABSDP: W64(c, in, 1, V64(0) & 0x7FFFFFFFFFFFFFFFULL); return;
    case S_RCPDP: W64(c, in, 1, approx_dp(1.0 / d_of(V64(0)))); return;
    case S_RSQRDP: W64(c, in, 1, approx_dp(1.0 / sqrt(d_of(V64(0))))); return;
    case S_INTDP: W64(c, in, 1, ud_of((double)VS(0))); return;
    case S_INTDPU: W64(c, in, 1, ud_of((double)V(0))); return;
    case S_DPINT: W(c, in, 1, (u32)f2i_round(d_of(V64(0)))); return;
    case S_DPTRUNC: W(c, in, 1, (u32)f2i_trunc(d_of(V64(0)))); return;
    case S_DPSP: W(c, in, 1, u_of((float)d_of(V64(0)))); return;
    case S_CMPEQDP: W(c, in, 2, d_of(V64(0)) == d_of(V64(1))); return;
    case S_CMPGTDP: W(c, in, 2, d_of(V64(0)) > d_of(V64(1))); return;
    case S_CMPLTDP: W(c, in, 2, d_of(V64(0)) < d_of(V64(1))); return;

    /* ---------- loads ---------- */
    case S_LDB: case S_LDBU: case S_LDH: case S_LDHU: case S_LDW: case S_LDNW: {
        int sem = opc_sem[in->opc];
        int size = (sem == S_LDB || sem == S_LDBU) ? 1 : (sem == S_LDH || sem == S_LDHU) ? 2 : 4;
        u32 ad = mem_addr(c, in, OP(0), size);
        u32 v;
        if (c->cache) { c->cache->pc = c->cr[CR_PCE1]; c->cache->cycle = c->cycle; cache_read(c->cache, ad, size); }
        if (sem == S_LDNW) v = ld_un(c, ad);
        else v = mem_rd(c->mem, ad & ~(u32)(size - 1), size);
        if (sem == S_LDB) v = (u32)(int8_t)v;
        if (sem == S_LDH) v = (u32)(int16_t)v;
        W(c, in, 1, v);
        return;
    }
    case S_LDDW: case S_LDNDW: {
        u32 ad = mem_addr(c, in, OP(0), 8);
        u32 lo, hi;
        if (c->cache) { c->cache->pc = c->cr[CR_PCE1]; c->cache->cycle = c->cycle; cache_read(c->cache, ad, 8); }
        if (opc_sem[in->opc] == S_LDDW) { ad &= ~7u; lo = mem_rd(c->mem, ad, 4); hi = mem_rd(c->mem, ad + 4, 4); }
        else { lo = ld_un(c, ad); hi = ld_un(c, ad + 4); }
        W64(c, in, 1, ((u64)hi << 32) | lo);
        return;
    }
    /* ---------- stores ---------- */
    case S_STB: case S_STH: case S_STW: case S_STNW: {
        int sem = opc_sem[in->opc];
        int size = sem == S_STB ? 1 : sem == S_STH ? 2 : 4;
        u32 v = V(0);
        u32 ad = mem_addr(c, in, OP(1), size);
        if (sem != S_STNW) ad &= ~(u32)(size - 1);
        store(c, ad, sem == S_STNW ? 5 : size, v, 0);
        return;
    }
    case S_STDW: case S_STNDW: {
        u64 v = V64(0);
        u32 ad = mem_addr(c, in, OP(1), 8);
        if (opc_sem[in->opc] == S_STDW) ad &= ~7u;
        store(c, ad, opc_sem[in->opc] == S_STDW ? 8 : 9, (u32)v, (u32)(v >> 32));
        return;
    }

    default:
        c->unimpl_count++;
        if (c->on_unimpl) c->on_unimpl(c, in);
        else {
            snprintf(c->err, sizeof c->err, "unimplemented %s at 0x%08X", sem_names[opc_sem[in->opc]], in->addr);
            c->halted = 1;
        }
        return;
    }
}
