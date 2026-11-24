"""Plan an overclock (core, SDRAM clock, refresh) and write it into an AIS image.

On the pedal the AIS route only works for the bootloader image (BIN/136), which must never
be flashed: Zoom's bootloader skips the clock commands of the OS image. The real overclock
is cfw/dialup/asm/oc_boot.asm (build_dialup4.py uses plan() from here); the AIS route is
kept for planning and for emulator runs of a bootloader image.

    python -I overclock.py IN_129_main_OS.bin OUT.bin --core 360 [--sdram-max 133.4]

The boot ROM sets the clocks from three AIS commands before it loads the OS:
  FunctionExec 5 (PLL0)   arg0 = PLLM << 24 | POSTDIV << 16 | PLLDIV3 << 8 | PLLDIV5
  Set CFGCHIP3            bit 0 = SDRAM from VCO / 4.5, else from SYSCLK5 (bit 2 = DIV4.5 on)
  FunctionExec 2 (EMIFB)  SDCR, SDTIMR, SDTIMR2, SDRCR (refresh period in SDRAM clocks)
Stock: VCO 600 = 24 MHz x 25, core 600 / 2 = 300, SDRAM 600 / 4.5 = 133.3 MHz, SDRCR 2079.
Raising only PLLM pushes the VCO past 600 MHz and the SDRAM past its 143 MHz; dropping
POSTDIV instead leaves SDRAM at VCO / 4.5 = 80 MHz with a refresh period that is too long.
So this tool picks the VCO (300..600 MHz) and POSTDIV for the core clock, feeds the SDRAM
from VCO / 4.5 or SYSCLK5 = core / (PLLDIV5 + 1), whichever is fastest without passing
--sdram-max, and sets SDRCR to 15.6 us at that clock. SDTIMR stays as it is (the stock
values hold at any SDRAM clock up to 133 MHz); the emulator prints and checks all of it.
Writes a file only; flashing is a separate, deliberate step.
"""
import argparse
import struct

XTAL = 24.0


def commands(d):
    """(offset of the opcode, opcode, offset of its arguments)"""
    o = 4
    while o + 4 <= len(d):
        op = struct.unpack_from("<I", d, o)[0]
        yield o, op, o + 4
        if op == 0x58535901:                                  # SectionLoad
            o += 12 + ((struct.unpack_from("<I", d, o + 8)[0] + 3) & ~3)
        elif op == 0x5853590A:                                # SectionFill
            o += 20
        elif op == 0x58535907:                                # Set
            o += 20
        elif op == 0x5853590D:                                # FunctionExec
            o += 8 + 4 * (struct.unpack_from("<I", d, o + 4)[0] >> 16)
        elif op == 0x58535902:                                # RequestCRC
            o += 12
        elif op in (0x58535905, 0x58535906):                  # Jump, JumpClose
            return
        else:
            o += 4


def plan(core, sdram_max):
    best = None
    for m in range(4, 33):
        vco = XTAL * (m + 1)
        if not 300 <= vco <= 600:
            continue
        for pd in range(0, 32):
            c = vco / (pd + 1)
            if abs(c - core) > 0.05:
                continue
            opts = [(vco / 4.5, "vco/4.5", None)] + \
                   [(c / (k + 1), "sysclk5", k) for k in range(1, 32)]
            fit = [o for o in opts if o[0] <= sdram_max + 1e-9]
            sd = max(fit)
            if best is None or sd[0] > best[3][0]:
                best = (m, pd, vco, sd)
    if not best:
        raise SystemExit(f"no PLL setting gives {core} MHz (24 MHz x (M+1) / (D+1), VCO 300..600)")
    return best


def overclock(d, core, sdram_max=133.4):
    """Patch the AIS image d (bytearray) in place; returns the lines it would print."""
    if struct.unpack_from("<I", d, 0)[0] != 0x41504954:
        raise SystemExit("not an AIS image")
    m, pd, vco, (sdram, src, div5) = plan(core, sdram_max)
    sdrcr = int(15.6 * sdram)                                 # 64 ms / 4096 rows, rounded down
    done, log = set(), []
    for o, op, arg in commands(d):
        if op == 0x5853590D:
            idx = struct.unpack_from("<I", d, arg)[0] & 0xFFFF
            if idx == 5:
                a0 = struct.unpack_from("<I", d, arg + 4)[0]
                new = (m << 24) | (pd << 16) | (a0 & 0xFF00) | (div5 if div5 is not None else a0 & 0xFF)
                struct.pack_into("<I", d, arg + 4, new)
                log.append(f"PLL0     {a0:08X} -> {new:08X}")
                done.add("pll")
            elif idx == 2:
                old = struct.unpack_from("<I", d, arg + 16)[0]
                struct.pack_into("<I", d, arg + 16, (old & ~0xFFFF) | sdrcr)
                log.append(f"SDRCR    {old:08X} -> {(old & ~0xFFFF) | sdrcr:08X}")
                done.add("emifb")
        elif op == 0x58535907 and struct.unpack_from("<I", d, arg + 4)[0] == 0x01C14188:
            old = struct.unpack_from("<I", d, arg + 8)[0]
            new = (old | 1) if src == "vco/4.5" else (old & ~1)
            struct.pack_into("<I", d, arg + 8, new)
            log.append(f"CFGCHIP3 {old:08X} -> {new:08X}")
            done.add("cfgchip3")
    missing = {"pll", "emifb", "cfgchip3"} - done
    if missing:
        raise SystemExit(f"AIS commands not found: {', '.join(sorted(missing))}")
    log.append(f"VCO {vco:.0f} MHz, core {vco / (pd + 1):.1f} MHz, SDRAM {sdram:.1f} MHz ({src}), "
               f"refresh {sdrcr} clocks = {sdrcr / sdram:.2f} us")
    return log


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("inp")
    ap.add_argument("out")
    ap.add_argument("--core", type=float, required=True, help="core clock in MHz, e.g. 360")
    ap.add_argument("--sdram-max", type=float, default=133.4, help="highest SDRAM clock to use")
    a = ap.parse_args()
    d = bytearray(open(a.inp, "rb").read())
    log = overclock(d, a.core, a.sdram_max)
    open(a.out, "wb").write(d)
    print("\n".join(log))


if __name__ == "__main__":
    main()
