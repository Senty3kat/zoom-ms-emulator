/* C674x decoder.  Structure and table handling follow binutils
   opcodes/tic6x-dis.c (GPL v3, Joseph Myers / Bernd Schmidt); this version
   fills a structured c6x_insn instead of printing text. */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "decode.h"
#include "opcode/tic6x.h"

const tic6x_insn_format tic6x_insn_format_table[tic6x_insn_format_max] = {
#define FMT(name, num_bits, cst_bits, mask, fields) { num_bits, cst_bits, mask, fields },
#include "opcode/tic6x-insn-formats.h"
#undef FMT
};

const tic6x_ctrl tic6x_ctrl_table[tic6x_ctrl_max] = {
#define CTRL(name, isa, rw, crlo, crhi_mask) \
    { STRINGX(name), CONCAT2(TIC6X_INSN_,isa), CONCAT2(tic6x_rw_,rw), crlo, crhi_mask },
#include "opcode/tic6x-control-registers.h"
#undef CTRL
};

const tic6x_opcode tic6x_opcode_table[tic6x_opcode_max] = {
#define INSNU(name, func_unit, format, type, isa, flags, fixed, ops, var) \
    { STRINGX(name), CONCAT2(tic6x_func_unit_,func_unit), CONCAT3(tic6x_insn_format,_,format), \
      CONCAT2(tic6x_pipeline_,type), CONCAT2(TIC6X_INSN_,isa), flags, fixed, ops, var },
#define INSNUE(name, e, func_unit, format, type, isa, flags, fixed, ops, var) \
    { STRINGX(name), CONCAT2(tic6x_func_unit_,func_unit), CONCAT3(tic6x_insn_format,_,format), \
      CONCAT2(tic6x_pipeline_,type), CONCAT2(TIC6X_INSN_,isa), flags, fixed, ops, var },
#define INSN(name, func_unit, format, type, isa, flags, fixed, ops, var) \
    { STRINGX(name), CONCAT2(tic6x_func_unit_,func_unit), CONCAT4(tic6x_insn_format_,func_unit,_,format), \
      CONCAT2(tic6x_pipeline_,type), CONCAT2(TIC6X_INSN_,isa), flags, fixed, ops, var },
#define INSNE(name, e, func_unit, format, type, isa, flags, fixed, ops, var) \
    { STRINGX(name), CONCAT2(tic6x_func_unit_,func_unit), CONCAT4(tic6x_insn_format_,func_unit,_,format), \
      CONCAT2(tic6x_pipeline_,type), CONCAT2(TIC6X_INSN_,isa), flags, fixed, ops, var },
#include "opcode/tic6x-opcode-table.h"
#undef INSN
#undef INSNE
#undef INSNU
#undef INSNUE
};

const char *c6x_opc_name(int opc) { return tic6x_opcode_table[opc].name; }
const char *c6x_ctrl_name(int id) { return id >= 0 && id < tic6x_ctrl_max ? tic6x_ctrl_table[id].name : "?"; }

static const tic6x_insn_field *field_from_fmt(const tic6x_insn_format *fmt, tic6x_insn_field_id field)
{
    for (unsigned f = 0; f < fmt->num_fields; f++)
        if (fmt->fields[f].field_id == field)
            return &fmt->fields[f];
    return NULL;
}

static unsigned field_width(const tic6x_insn_field *field)
{
    if (!field->num_bitfields)
        return field->bitfields[0].width;
    unsigned w = 0;
    for (unsigned i = 0; i < field->num_bitfields; i++)
        w += field->bitfields[i].width;
    return w;
}

static unsigned field_bits(unsigned opcode, const tic6x_insn_field *field)
{
    if (!field->num_bitfields)
        return (opcode >> field->bitfields[0].low_pos) & ((1u << field->bitfields[0].width) - 1);
    unsigned val = 0;
    for (unsigned i = 0; i < field->num_bitfields; i++)
        val |= ((opcode >> field->bitfields[i].low_pos) & ((1u << field->bitfields[i].width) - 1))
               << field->bitfields[i].pos;
    return val;
}

static unsigned ext32(const uint8_t *p) { return p[0] | (p[1] << 8) | (p[2] << 16) | ((unsigned)p[3] << 24); }

static int check_header(const uint8_t *fp, tic6x_fetch_packet_header *h)
{
    h->header = ext32(fp + 28);
    if ((h->header & 0xf0000000) != 0xe0000000) {
        memset(h, 0, sizeof *h);
        h->header = ext32(fp + 28);
        return 0;
    }
    for (int i = 0; i < 7; i++) h->word_compact[i] = (h->header & (1u << (21 + i))) != 0;
    h->prot = (h->header & (1u << 20)) != 0;
    h->rs = (h->header & (1u << 19)) != 0;
    h->dsz = (h->header >> 16) & 7;
    h->br = (h->header & (1u << 15)) != 0;
    h->sat = (h->header & (1u << 14)) != 0;
    for (int i = 0; i < 14; i++) h->p_bits[i] = (h->header & (1u << i)) != 0;
    return 1;
}

static unsigned ext16(const uint8_t *p, const tic6x_fetch_packet_header *h)
{
    unsigned op16 = p[0] | (p[1] << 8);
    op16 |= (h->sat << TIC6X_COMPACT_SAT_POS);
    op16 |= (h->br << TIC6X_COMPACT_BR_POS);
    op16 |= (h->dsz << TIC6X_COMPACT_DSZ_POS);
    return op16;
}

uint32_t c6x_next_addr(c6x_fetch_fn fetch, void *ctx, uint32_t addr, int size)
{
    uint32_t n = addr + size;
    if ((n & 31) == 28) {
        uint8_t fp[32];
        if (fetch(ctx, n & ~31u, fp) == 0 && (ext32(fp + 28) & 0xf0000000) == 0xe0000000)
            return (n & ~31u) + 32;
    }
    return n;
}

static int unit_of(int fu)
{
    switch (fu) {
    case tic6x_func_unit_l: return UNIT_L;
    case tic6x_func_unit_s: return UNIT_S;
    case tic6x_func_unit_m: return UNIT_M;
    case tic6x_func_unit_d: return UNIT_D;
    default: return UNIT_NONE;
    }
}

static int find_ctrl(const char *name)
{
    for (int i = 0; i < tic6x_ctrl_max; i++)
        if (!strcmp(tic6x_ctrl_table[i].name, name)) return i;
    return -1;
}

int c6x_decode(c6x_fetch_fn fetch, void *ctx, uint32_t addr, c6x_insn *out)
{
    uint8_t fp[32];
    tic6x_fetch_packet_header header;
    uint32_t fp_offset = addr & 0x1f, fp_addr = addr - fp_offset;

    memset(out, 0, sizeof *out);
    out->addr = addr;
    out->fp_addr = fp_addr;
    if (fetch(ctx, fp_addr, fp))
        return 0;
    int hdr = check_header(fp, &header);
    out->header = hdr;
    out->prot = hdr && header.prot;
    if (hdr) {
        if (fp_offset & 1) return 1;
        if ((fp_offset & 3) && (fp_offset >= 28 || !header.word_compact[fp_offset >> 2])) return 2;
        if (fp_offset == 28) { out->size = 4; out->raw = header.header; return 4; }
    } else if (fp_offset & 3) {
        return 1;
    }

    unsigned num_bits = 32, opcode;
    if (hdr && header.word_compact[fp_offset >> 2]) num_bits = 16;
    if (num_bits == 16) opcode = ext16(fp + fp_offset, &header);
    else opcode = ext32(fp + fp_offset);
    out->raw = opcode;
    out->size = num_bits / 8;

    /* p-bit: parallel with the NEXT instruction */
    if (num_bits == 16) out->p = header.p_bits[fp_offset >> 1];
    else out->p = opcode & 1;

    for (int opcode_id = 0; opcode_id < tic6x_opcode_max; opcode_id++) {
        const tic6x_opcode *const opc = &tic6x_opcode_table[opcode_id];
        const tic6x_insn_format *const fmt = &tic6x_insn_format_table[opc->format];
        unsigned func_unit_side = 0, func_unit_data_side = 0, func_unit_cross = 0, t_val = 0;
        int have_t = 0, has_cond = 0, cside = 0, cnum = 0, cz = 0;
        c6x_insn r;

        if (opc->flags & TIC6X_FLAG_MACRO) continue;
        if (fmt->num_bits != num_bits) continue;
        if ((opcode & fmt->mask) != fmt->cst_bits) continue;
        if (!(opc->isa_variants & (TIC6X_INSN_C62X | TIC6X_INSN_C64X | TIC6X_INSN_C64XP |
                                   TIC6X_INSN_C67X | TIC6X_INSN_C67XP | TIC6X_INSN_C674X)))
            continue;

        const tic6x_insn_field *creg_field = field_from_fmt(fmt, tic6x_field_creg);
        if (creg_field) {
            const tic6x_insn_field *z_field = field_from_fmt(fmt, tic6x_field_z);
            if (!z_field) abort();
            unsigned cv = field_bits(opcode, creg_field), zv = field_bits(opcode, z_field);
            static const int cs[8] = { -1, 1, 1, 1, 0, 0, 0, -2 };
            static const int cn[8] = { 0, 0, 1, 2, 1, 2, 0, 0 };
            if (cs[cv] == -2) continue;
            if (cv == 0 && zv) continue;  /* reserved */
            if (cv) { has_cond = 1; cside = cs[cv]; cnum = cn[cv]; cz = zv; }
        }
        if (opc->flags & TIC6X_FLAG_INSN16_SPRED) {
            const tic6x_insn_field *cc_field = field_from_fmt(fmt, tic6x_field_cc);
            unsigned s_value, z_value;
            if (cc_field) {
                unsigned cc = field_bits(opcode, cc_field);
                s_value = (cc & 2) >> 1; z_value = cc & 1;
            } else {
                const tic6x_insn_field *s_field = field_from_fmt(fmt, tic6x_field_s);
                const tic6x_insn_field *z_field = field_from_fmt(fmt, tic6x_field_z);
                if (!s_field || !z_field) abort();
                s_value = field_bits(opcode, s_field);
                z_value = field_bits(opcode, z_field);
            }
            has_cond = 1; cside = s_value; cnum = 0; cz = z_value;
        }

        int fixed_ok = 1;
        for (unsigned fix = 0; fix < opc->num_fixed_fields; fix++) {
            const tic6x_insn_field *field = field_from_fmt(fmt, opc->fixed_fields[fix].field_id);
            if (!field) abort();
            unsigned fb = field_bits(opcode, field);
            if (fb < opc->fixed_fields[fix].min_val || fb > opc->fixed_fields[fix].max_val) { fixed_ok = 0; break; }
        }
        if (!fixed_ok) continue;

        memset(&r, 0, sizeof r);
        r.addr = addr; r.raw = opcode; r.fp_addr = fp_addr; r.size = num_bits / 8;
        r.p = out->p; r.prot = out->prot; r.header = hdr;
        r.opc = opcode_id;
        r.unit = unit_of(opc->func_unit);
        r.has_cond = has_cond; r.cside = cside; r.cnum = cnum; r.cz = cz;

        if (opc->func_unit != tic6x_func_unit_nfu) {
            int have_areg = 0, have_cross = 0;
            func_unit_side = (opc->flags & TIC6X_FLAG_SIDE_B_ONLY) ? 2 : 0;
            func_unit_data_side = (opc->flags & TIC6X_FLAG_SIDE_T2_ONLY) ? 2 : 0;
            for (unsigned fld_num = 0; fld_num < opc->num_variable_fields; fld_num++) {
                const tic6x_coding_field *const enc = &opc->variable_fields[fld_num];
                const tic6x_insn_field *field = field_from_fmt(fmt, enc->field_id);
                if (!field) abort();
                unsigned fv = field_bits(opcode, field);
                switch (enc->coding_method) {
                case tic6x_coding_fu: func_unit_side = fv ? 2 : 1; break;
                case tic6x_coding_data_fu: func_unit_data_side = fv ? 2 : 1; break;
                case tic6x_coding_xpath: have_cross = 1; func_unit_cross = fv; break;
                case tic6x_coding_rside: have_t = 1; t_val = fv; func_unit_data_side = t_val ? 2 : 1; break;
                case tic6x_coding_areg: have_areg = 1; break;
                default: break;
                }
            }
            if (func_unit_side != 1 && func_unit_side != 2) abort();
            if (have_areg && !func_unit_data_side) func_unit_cross = func_unit_side == 1;
            if ((opc->flags & TIC6X_FLAG_INSN16_BSIDE) && func_unit_side == 1) func_unit_cross = 1;
            r.side = func_unit_side == 2;
            r.cross = func_unit_cross;
            r.dside = func_unit_data_side ? func_unit_data_side == 2 : r.side;
        }

        int operands_ok = 1;
        unsigned num_operands = opc->num_operands;
        for (unsigned op_num = 0; op_num < num_operands; op_num++) {
            c6x_operand *o = &r.op[op_num];
            unsigned mem_base_reg = 0, mem_offset = 0, mem_mode = 0, mem_scaled = 0, crlo = 0, crhi = 0;
            int mem_base_known = 0, mem_base_known_long = 0, mem_off_known = 0, mem_off_known_long = 0;
            int mem_mode_known = 0, mem_scaled_known = 0, crlo_known = 0, crhi_known = 0;
            int done = 0, spmask_skip = 0, prev_sploop_found = 0;
            unsigned fcyc_bits = 0;
            int bside = func_unit_side == 2;
            const tic6x_operand_info *oi = &opc->operand_info[op_num];

            r.rw[op_num] = oi->rw;
            o->size = (uint8_t)oi->size;
            if ((oi->rw == tic6x_rw_read || oi->rw == tic6x_rw_read_write) &&
                oi->form != tic6x_operand_mem_short && oi->form != tic6x_operand_mem_long &&
                oi->form != tic6x_operand_mem_ndw && oi->form != tic6x_operand_mem_deref) {
                r.rlo[op_num] = (uint8_t)oi->low_last;
                r.rhi[op_num] = (uint8_t)oi->high_last;
                if (oi->low_last > 1 || oi->high_last > 1) r.defer = 1;
            }
            if (oi->rw == tic6x_rw_write || oi->rw == tic6x_rw_read_write) {
                r.wlo[op_num] = (uint8_t)oi->low_last;
                r.whi[op_num] = (uint8_t)oi->high_last;
            }

            switch (oi->form) {
            case tic6x_operand_b15reg: o->kind = OPK_REG; o->side = 1; o->reg = 15; continue;
            case tic6x_operand_zreg: o->kind = OPK_REG; o->side = bside; o->reg = 0; continue;
            case tic6x_operand_retreg: o->kind = OPK_REG; o->side = bside; o->reg = 3; continue;
            case tic6x_operand_irp: o->kind = OPK_CTRL; o->imm = find_ctrl("irp"); continue;
            case tic6x_operand_nrp: o->kind = OPK_CTRL; o->imm = find_ctrl("nrp"); continue;
            case tic6x_operand_ilc: o->kind = OPK_CTRL; o->imm = find_ctrl("ilc"); continue;
            case tic6x_operand_hw_const_minus_1: o->kind = OPK_IMM; o->imm = -1; continue;
            case tic6x_operand_hw_const_0: o->kind = OPK_IMM; o->imm = 0; continue;
            case tic6x_operand_hw_const_1: o->kind = OPK_IMM; o->imm = 1; continue;
            case tic6x_operand_hw_const_5: o->kind = OPK_IMM; o->imm = 5; continue;
            case tic6x_operand_hw_const_16: o->kind = OPK_IMM; o->imm = 16; continue;
            case tic6x_operand_hw_const_24: o->kind = OPK_IMM; o->imm = 24; continue;
            case tic6x_operand_hw_const_31: o->kind = OPK_IMM; o->imm = 31; continue;
            default: break;
            }

            for (unsigned fld_num = 0; fld_num < opc->num_variable_fields; fld_num++) {
                const tic6x_coding_field *const enc = &opc->variable_fields[fld_num];
                if (enc->operand_num != op_num) continue;
                const tic6x_insn_field *field = field_from_fmt(fmt, enc->field_id);
                if (!field) abort();
                unsigned fv = field_bits(opcode, field);
                unsigned reg_base = 0;
                int sv;
                switch (enc->coding_method) {
                case tic6x_coding_cst_s3i:
                    if (fv == 0) fv = 0x10;
                    else if (fv == 7) fv = 8;
                    /* fall through */
                case tic6x_coding_ucst:
                case tic6x_coding_ulcst_dpr_byte:
                case tic6x_coding_ulcst_dpr_half:
                case tic6x_coding_ulcst_dpr_word:
                case tic6x_coding_lcst_low16:
                    switch (oi->form) {
                    case tic6x_operand_asm_const:
                    case tic6x_operand_link_const:
                        o->kind = OPK_IMM; o->imm = fv; done = 1; break;
                    case tic6x_operand_mem_long:
                        mem_offset = fv; mem_off_known_long = 1; break;
                    default: abort();
                    }
                    break;
                case tic6x_coding_lcst_high16:
                    o->kind = OPK_IMM; o->imm = (int32_t)(fv << 16); done = 1; break;
                case tic6x_coding_scst_l3i:
                    if (fv == 0) sv = 8;
                    else { sv = (int)fv; sv ^= (1 << (field_width(field) - 1)); sv -= (1 << (field_width(field) - 1)); }
                    o->kind = OPK_IMM; o->imm = sv; done = 1; break;
                case tic6x_coding_scst:
                    sv = (int)fv; sv ^= (1 << (field_width(field) - 1)); sv -= (1 << (field_width(field) - 1));
                    o->kind = OPK_IMM; o->imm = sv; done = 1; break;
                case tic6x_coding_ucst_minus_one:
                    o->kind = OPK_IMM; o->imm = fv + 1; done = 1; break;
                case tic6x_coding_pcrel:
                case tic6x_coding_pcrel_half:
                    sv = (int)fv; sv ^= (1 << (field_width(field) - 1)); sv -= (1 << (field_width(field) - 1));
                    if (hdr && enc->coding_method == tic6x_coding_pcrel_half) sv *= 2; else sv *= 4;
                    o->kind = OPK_ADDR; o->imm = (int32_t)(fp_addr + sv); done = 1; break;
                case tic6x_coding_regpair_msb:
                    if (oi->form != tic6x_operand_regpair) abort();
                    o->kind = OPK_PAIR; o->side = bside; o->reg = (fv | 1) - 1; done = 1; break;
                case tic6x_coding_pcrel_half_unsigned:
                    o->kind = OPK_ADDR; o->imm = (int32_t)(fp_addr + 2 * fv); done = 1; break;
                case tic6x_coding_reg_shift:
                    fv <<= 1;
                    /* fall through */
                case tic6x_coding_reg:
                    /* RS selects A16-A23/B16-B23 only for 3-bit compact register
                       fields; 5-bit fields (lsdmvto/lsdmvfr) are absolute. */
                    if (num_bits == 16 && header.rs && !(opc->flags & TIC6X_FLAG_INSN16_NORS) &&
                        (field_width(field) == 3 || enc->coding_method == tic6x_coding_reg_shift)) reg_base = 16;
                    switch (oi->form) {
                    case tic6x_operand_treg:
                        if (!have_t) abort();
                        o->kind = OPK_REG; o->side = t_val ? 1 : 0; o->reg = reg_base + fv; done = 1; break;
                    case tic6x_operand_reg:
                        o->kind = OPK_REG; o->side = bside; o->reg = reg_base + fv; done = 1; break;
                    case tic6x_operand_reg_nors:
                        o->kind = OPK_REG; o->side = bside; o->reg = fv; done = 1; break;
                    case tic6x_operand_reg_bside:
                        o->kind = OPK_REG; o->side = 1; o->reg = reg_base + fv; done = 1; break;
                    case tic6x_operand_reg_bside_nors:
                        o->kind = OPK_REG; o->side = 1; o->reg = fv; done = 1; break;
                    case tic6x_operand_xreg:
                        o->kind = OPK_REG; o->side = (func_unit_side == 2) ^ func_unit_cross; o->reg = reg_base + fv; done = 1; break;
                    case tic6x_operand_dreg:
                        o->kind = OPK_REG; o->side = func_unit_data_side == 2; o->reg = reg_base + fv; done = 1; break;
                    case tic6x_operand_regpair:
                        if (fv & 1) operands_ok = 0;
                        o->kind = OPK_PAIR; o->side = bside; o->reg = reg_base + fv; done = 1; break;
                    case tic6x_operand_xregpair:
                        if (fv & 1) operands_ok = 0;
                        o->kind = OPK_PAIR; o->side = (func_unit_side == 2) ^ func_unit_cross; o->reg = reg_base + fv; done = 1; break;
                    case tic6x_operand_tregpair:
                        if (!have_t) abort();
                        if (fv & 1) operands_ok = 0;
                        o->kind = OPK_PAIR; o->side = t_val ? 1 : 0; o->reg = reg_base + fv; done = 1; break;
                    case tic6x_operand_dregpair:
                        if (fv & 1) operands_ok = 0;
                        o->kind = OPK_PAIR; o->side = func_unit_data_side == 2; o->reg = reg_base + fv; done = 1; break;
                    case tic6x_operand_mem_deref:
                        o->kind = OPK_MEM; o->side = bside; o->reg = reg_base + fv; o->mode = TIC6X_MEM_MODE_POSITIVE;
                        o->size = oi->size; o->imm = 0; done = 1; break;
                    case tic6x_operand_mem_short:
                    case tic6x_operand_mem_ndw:
                        mem_base_reg = fv; mem_base_known = 1; break;
                    default: abort();
                    }
                    break;
                case tic6x_coding_reg_ptr:
                    if (fv > 3) abort();
                    mem_base_reg = 4 | fv; mem_base_known = 1; break;
                case tic6x_coding_areg:
                    switch (oi->form) {
                    case tic6x_operand_areg:
                        o->kind = OPK_REG; o->side = 1; o->reg = fv ? 15 : 14; done = 1; break;
                    case tic6x_operand_mem_long:
                        mem_base_reg = fv ? 15 : 14; mem_base_known_long = 1; break;
                    default: abort();
                    }
                    break;
                case tic6x_coding_mem_offset_minus_one_noscale:
                case tic6x_coding_mem_offset_minus_one:
                    fv += 1;
                    /* fall through */
                case tic6x_coding_mem_offset_noscale:
                case tic6x_coding_mem_offset:
                    mem_offset = fv; mem_off_known = 1;
                    if (num_bits == 16) {
                        mem_mode_known = 1;
                        mem_mode = TIC6X_INSN16_MEM_MODE_VAL(opc->flags);
                        mem_scaled_known = 1;
                        mem_scaled = 1;
                        if (opc->flags & TIC6X_FLAG_INSN16_B15PTR) { mem_base_known = 1; mem_base_reg = 15; }
                        if (enc->coding_method == tic6x_coding_mem_offset_noscale ||
                            enc->coding_method == tic6x_coding_mem_offset_minus_one_noscale)
                            mem_scaled = 0;
                    }
                    break;
                case tic6x_coding_mem_mode: mem_mode = fv; mem_mode_known = 1; break;
                case tic6x_coding_scaled: mem_scaled = fv; mem_scaled_known = 1; break;
                case tic6x_coding_crlo: crlo = fv; crlo_known = 1; break;
                case tic6x_coding_crhi: crhi = fv; crhi_known = 1; break;
                case tic6x_coding_fstg:
                case tic6x_coding_fcyc:
                    if (!prev_sploop_found) {
                        uint32_t sfa = fp_addr, sfo = fp_offset;
                        int shdr = hdr;
                        tic6x_fetch_packet_header sh = header;
                        uint8_t sfp[32];
                        unsigned ii = 0;
                        memcpy(sfp, fp, 32);
                        for (int i = 0; i < 48 * 8; i++) {
                            unsigned snb, sop;
                            if (sfo & 2) sfo -= 2;
                            else if (sfo >= 4) {
                                if (shdr && sh.word_compact[(sfo >> 2) - 1]) sfo -= 2; else sfo -= 4;
                            } else {
                                sfa -= 32;
                                if (fetch(ctx, sfa, sfp)) break;
                                shdr = check_header(sfp, &sh);
                                sfo = shdr ? (sh.word_compact[6] ? 26 : 24) : 28;
                            }
                            snb = (shdr && sh.word_compact[sfo >> 2]) ? 16 : 32;
                            sop = snb == 16 ? ext16(sfp + sfo, &header) : ext32(sfp + sfo);
                            if (snb == 32 && ((sop & 0x003ffffe) == 0x00038000 || (sop & 0x003ffffe) == 0x0003a000 ||
                                              (sop & 0x003ffffe) == 0x0003e000)) {
                                prev_sploop_found = 1; ii = ((sop >> 23) & 0x1f) + 1;
                            } else if (snb == 16 && (sop & 0x3c7e) == 0x0c66) {
                                prev_sploop_found = 1; ii = (((sop >> 7) & 7) | ((sop >> 11) & 8)) + 1;
                            }
                            if (prev_sploop_found) {
                                if (ii <= 1) fcyc_bits = 0;
                                else if (ii <= 2) fcyc_bits = 1;
                                else if (ii <= 4) fcyc_bits = 2;
                                else if (ii <= 8) fcyc_bits = 3;
                                else if (ii <= 14) fcyc_bits = 4;
                                else prev_sploop_found = 0;
                            }
                            if (prev_sploop_found) break;
                        }
                    }
                    if (!prev_sploop_found) { operands_ok = 0; done = 1; o->kind = OPK_IMM; break; }
                    if (enc->coding_method == tic6x_coding_fstg) {
                        int t = 0;
                        for (int i = fcyc_bits; i < 6; i++) t = (t << 1) | ((fv >> i) & 1);
                        o->kind = OPK_IMM; o->imm = t;
                    } else {
                        o->kind = OPK_IMM; o->imm = fv & ((1 << fcyc_bits) - 1);
                    }
                    done = 1;
                    break;
                case tic6x_coding_spmask:
                    if (fv == 0) spmask_skip = 1;
                    else { o->kind = OPK_UNITS; o->imm = fv; done = 1; }
                    break;
                case tic6x_coding_fu:
                case tic6x_coding_data_fu:
                case tic6x_coding_xpath:
                case tic6x_coding_rside:
                    break;
                default:
                    abort();
                }

                if (mem_base_known_long && mem_off_known_long) {
                    o->kind = OPK_MEM; o->side = 1; o->reg = mem_base_reg; o->mode = TIC6X_MEM_MODE_POSITIVE;
                    o->size = oi->size; o->scaled = 0; o->imm = mem_offset * oi->size; done = 1;
                }
                if (mem_base_known && mem_off_known && mem_mode_known &&
                    (mem_scaled_known || oi->form != tic6x_operand_mem_ndw)) {
                    int offset_is_reg = (mem_mode & 4) != 0;
                    o->kind = OPK_MEM; o->side = bside; o->reg = mem_base_reg; o->mode = mem_mode;
                    o->size = oi->size;
                    if ((mem_mode & ~4u) == 2 || (mem_mode & ~4u) == 3) operands_ok = 0;
                    if (offset_is_reg) {
                        if (num_bits == 16 && header.rs && !(opc->flags & TIC6X_FLAG_INSN16_NORS)) reg_base = 16;
                        o->offreg = 1; o->offnum = reg_base + mem_offset;
                        o->scaled = oi->form == tic6x_operand_mem_ndw ? mem_scaled != 0 : 1;
                    } else if (oi->form == tic6x_operand_mem_ndw) {
                        o->scaled = mem_scaled != 0; o->imm = mem_offset;
                    } else {
                        o->scaled = 0; o->imm = mem_offset * oi->size;
                    }
                    done = 1;
                }
                if (crlo_known && crhi_known) {
                    int rw = oi->rw, crid;
                    for (crid = 0; crid < tic6x_ctrl_max; crid++) {
                        if (crlo == tic6x_ctrl_table[crid].crlo && (crhi & tic6x_ctrl_table[crid].crhi_mask) == 0 &&
                            (rw == tic6x_rw_read
                                 ? (tic6x_ctrl_table[crid].rw == tic6x_rw_read || tic6x_ctrl_table[crid].rw == tic6x_rw_read_write)
                                 : (tic6x_ctrl_table[crid].rw == tic6x_rw_write || tic6x_ctrl_table[crid].rw == tic6x_rw_read_write)))
                            break;
                    }
                    if (crid == tic6x_ctrl_max) operands_ok = 0;
                    o->kind = OPK_CTRL; o->imm = crid; done = 1;
                }
                if (done || spmask_skip) break;
            }
            if (spmask_skip) { num_operands = 0; break; }
            if (!done) { fprintf(stderr, "opcode %x: operand #%u not decoded\n", opcode, op_num); abort(); }
        }
        if (!operands_ok) continue;
        r.nopnd = num_operands;

        /* NOP count operands */
        {
            const char *nm = opc->name;
            if (!strcmp(nm, "nop") || !strcmp(nm, "idle")) {
                r.nops = num_operands ? (uint8_t)r.op[0].imm : 1;
            } else if (!strcmp(nm, "bnop")) {
                r.nops = (uint8_t)r.op[num_operands - 1].imm;
            } else if (!strcmp(nm, "addkpc")) {
                r.nops = num_operands >= 3 ? (uint8_t)r.op[2].imm : 0;
            } else if (!strcmp(nm, "callp")) {
                r.nops = 5;
            }
        }
        r.valid = 1;
        *out = r;
        return num_bits / 8;
    }
    out->valid = 0;
    return num_bits / 8;
}

/* ---- text formatting (for comparison against dis6x) ---- */
static int fmt_reg(char *b, int side, int reg) { return sprintf(b, "%c%d", side ? 'B' : 'A', reg); }

int c6x_format_insn(const c6x_insn *in, char *buf, int n)
{
    char tmp[256];
    int k = 0;
    if (!in->valid) return snprintf(buf, n, "<invalid 0x%08x>", in->raw);
    const tic6x_opcode *opc = &tic6x_opcode_table[in->opc];
    if (in->has_cond) k += sprintf(tmp + k, "[%s%c%d] ", in->cz ? "!" : "", in->cside ? 'B' : 'A', in->cnum);
    for (const char *p = opc->name; *p; p++) tmp[k++] = (*p >= 'a' && *p <= 'z') ? *p - 32 : *p;
    if (in->unit != UNIT_NONE) {
        k += sprintf(tmp + k, ".%c%d%s", "LSMD"[in->unit], in->side + 1, in->cross ? "X" : "");
        if (in->unit == UNIT_D && (opc->flags & (TIC6X_FLAG_LOAD | TIC6X_FLAG_STORE)))
            k += sprintf(tmp + k, "T%d", in->dside + 1);
    }
    for (int i = 0; i < in->nopnd; i++) {
        const c6x_operand *o = &in->op[i];
        tmp[k++] = i ? ',' : ' ';
        switch (o->kind) {
        case OPK_REG: k += fmt_reg(tmp + k, o->side, o->reg); break;
        case OPK_PAIR: k += fmt_reg(tmp + k, o->side, o->reg + 1); tmp[k++] = ':'; k += fmt_reg(tmp + k, o->side, o->reg); break;
        case OPK_IMM: k += sprintf(tmp + k, "%d", o->imm); break;
        case OPK_ADDR: k += sprintf(tmp + k, "0x%08x", (uint32_t)o->imm); break;
        case OPK_CTRL: {
            const char *nm = c6x_ctrl_name(o->imm);
            for (; *nm; nm++) tmp[k++] = (*nm >= 'a' && *nm <= 'z') ? *nm - 32 : *nm;
            break;
        }
        case OPK_UNITS:
            for (int b = 0; b < 8; b++) if (o->imm & (1 << b)) k += sprintf(tmp + k, "%c%d,", "LSDM"[b / 2], (b & 1) + 1);
            k--;
            break;
        case OPK_MEM: {
            char base[8], off[16];
            fmt_reg(base, o->side, o->reg);
            if (o->offreg) fmt_reg(off, o->side, o->offnum);
            else sprintf(off, "%d", o->imm);
            const char *l = o->scaled ? "[" : "(", *r = o->scaled ? "]" : ")";
            switch (o->mode & ~4u) {
            case 0: k += sprintf(tmp + k, "*-%s%s%s%s", base, l, off, r); break;
            case 1: k += sprintf(tmp + k, "*+%s%s%s%s", base, l, off, r); break;
            case 8: k += sprintf(tmp + k, "*--%s%s%s%s", base, l, off, r); break;
            case 9: k += sprintf(tmp + k, "*++%s%s%s%s", base, l, off, r); break;
            case 10: k += sprintf(tmp + k, "*%s--%s%s%s", base, l, off, r); break;
            case 11: k += sprintf(tmp + k, "*%s++%s%s%s", base, l, off, r); break;
            }
            break;
        }
        default: k += sprintf(tmp + k, "?"); break;
        }
    }
    tmp[k] = 0;
    return snprintf(buf, n, "%s", tmp);
}
