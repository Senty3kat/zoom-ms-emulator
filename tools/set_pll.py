"""Patch the PLL0 setup (AIS FunctionExec #5, arg0) of a Zoom MS main OS image.
    python -I set_pll.py IN_129_main_OS.bin OUT.bin --pllm M --postdiv D
DSP clock = 24 MHz * (M + 1) / (D + 1); VCO = 24 MHz * (M + 1) must stay in
300..600 MHz. Stock MS-50G 3.10: M=24, D=1 -> 300 MHz.
Arg0 layout (bits 31:24 PLLM, 23:16 POSTDIV) is inferred from the stock image
and the live register dump; the other bytes are kept as they are.
Writes a file only; flashing is a separate, deliberate step.
"""
import argparse, struct


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("inp")
    ap.add_argument("out")
    ap.add_argument("--pllm", type=int, required=True)
    ap.add_argument("--postdiv", type=int, required=True)
    a = ap.parse_args()
    d = bytearray(open(a.inp, "rb").read())
    if struct.unpack_from("<I", d, 0)[0] != 0x41504954:
        raise SystemExit("not an AIS image")
    o = 4
    while o + 4 <= len(d):
        op = struct.unpack_from("<I", d, o)[0]
        o += 4
        if op == 0x5853590D:
            hdr = struct.unpack_from("<I", d, o)[0]
            n, idx = hdr >> 16, hdr & 0xFFFF
            if idx == 5:
                a0 = struct.unpack_from("<I", d, o + 4)[0]
                new = (a0 & 0x0000FFFF) | ((a.pllm & 0xFF) << 24) | ((a.postdiv & 0xFF) << 16)
                struct.pack_into("<I", d, o + 4, new)
                vco = 24 * (a.pllm + 1)
                print(f"PLL arg0 {a0:08X} -> {new:08X}: VCO {vco} MHz, DSP {vco / (a.postdiv + 1):.1f} MHz")
                if not 300 <= vco <= 600:
                    print("WARNING: VCO outside 300..600 MHz")
            o += 4 + 4 * n
        elif op == 0x58535901:
            size = struct.unpack_from("<I", d, o + 4)[0]
            o += 8 + ((size + 3) & ~3)
        elif op in (0x5853590A, 0x58535907):
            o += 16
        elif op == 0x58535902:
            o += 8
        elif op in (0x58535905, 0x58535906):
            o += 4
            if op == 0x58535906:
                break
    open(a.out, "wb").write(d)


main()
