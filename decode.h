/* C674x instruction decoder: binutils tic6x opcode tables -> structured insn. */
#ifndef C6X_DECODE_H
#define C6X_DECODE_H
#include <stdint.h>

enum {
    OPK_NONE = 0,
    OPK_REG,      /* side, reg */
    OPK_PAIR,     /* side, reg = even (low) register */
    OPK_IMM,      /* imm */
    OPK_ADDR,     /* imm = absolute target address */
    OPK_MEM,      /* side, reg = base; mode; offreg/offnum or imm (byte offset if !scaled) */
    OPK_CTRL,     /* imm = tic6x_ctrl_id */
    OPK_UNITS,    /* imm = SPMASK unit bitmask: bit i = "LSDM"[i/2], side i&1 */
};

enum { UNIT_L = 0, UNIT_S, UNIT_M, UNIT_D, UNIT_NONE };

typedef struct {
    uint8_t kind;
    uint8_t side;     /* 0 = A, 1 = B */
    uint8_t reg;
    uint8_t mode;     /* mem: TIC6X_MEM_MODE_* (0,1,4,5,8,9,10,11) */
    uint8_t scaled;   /* mem: offset is scaled by access size */
    uint8_t size;     /* mem: access size in bytes */
    uint8_t offreg;   /* mem: offset is register (reg number in offnum) */
    uint8_t offnum;
    int32_t imm;
} c6x_operand;

typedef struct {
    uint32_t addr;
    uint32_t raw;
    uint32_t fp_addr;   /* fetch packet address (PCE1) */
    uint16_t opc;       /* tic6x_opcode_id */
    uint16_t sem;       /* semantic id, filled by executor */
    uint8_t size;       /* 2 or 4 */
    uint8_t unit;       /* UNIT_* */
    uint8_t side;       /* 0 = .x1, 1 = .x2 */
    uint8_t cross;
    uint8_t dside;      /* D unit data path side (T1=0/T2=1) */
    uint8_t has_cond;
    uint8_t cside, cnum, cz;
    uint8_t p;          /* parallel with NEXT instruction */
    uint8_t prot;       /* fetch packet is in protected-load mode */
    uint8_t header;     /* fetch packet is header based */
    uint8_t nops;       /* NOP count operand (NOP n, BNOP n, ADDKPC n), 0 if none */
    uint8_t nopnd;
    uint8_t valid;
    uint8_t wlo[4], whi[4]; /* write cycles (E-stage) per operand, 0 if not written */
    uint8_t rw[4];      /* tic6x_rw per operand */
    uint8_t rlo[4], rhi[4]; /* last E-stage at which low/high part is read (0 = not read) */
    uint8_t defer;      /* some operand is read after E1 (DP / MPYI family) */
    c6x_operand op[4];
} c6x_insn;

/* read 32 bytes of the fetch packet at fp_addr; return 0 on success */
typedef int (*c6x_fetch_fn)(void *ctx, uint32_t fp_addr, uint8_t out[32]);

/* Decode instruction at addr. Returns size in bytes (2/4), 4 for a header word
   (valid=0), or 0 on fetch error. */
int c6x_decode(c6x_fetch_fn fetch, void *ctx, uint32_t addr, c6x_insn *out);

/* Address of the instruction following the one at addr of the given size,
   skipping the fetch packet header word. */
uint32_t c6x_next_addr(c6x_fetch_fn fetch, void *ctx, uint32_t addr, int size);

const char *c6x_opc_name(int opc);
const char *c6x_ctrl_name(int id);
int c6x_format_insn(const c6x_insn *in, char *buf, int n);

#endif
