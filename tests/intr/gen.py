"""Generate intrinsic oracle tests: each C674x intrinsic from c6x.h is
evaluated with literal constants (folded by cl6x -> oracle) and with
volatile inputs (executed by the emulator).
    python -I gen.py C6X_H OUT.c LIST.txt
"""
import re, random, sys

SKIP = {"_hi", "_hif", "_hill", "_lo", "_lof", "_loll", "_itod", "_ftod", "_itoll",
        "_itof", "_ftoi", "_dtol", "_ltod", "_dtoll", "_lltod", "_fabs", "_fabsf"}

EDGE32 = [0, 1, 0xFFFFFFFF, 0x7FFFFFFF, 0x80000000, 0x00008000, 0x80008000, 0x7FFF7FFF,
          0x12345678, 0x9ABCDEF0, 0x00FF00FF, 0xFF00FF00, 0x0000FFFF, 0x00000123]


def sigs(path):
    out = []
    for l in open(path):
        m = re.match(r"\s*(unsigned long long|long long|unsigned|int|double|float|__int40_t)\s+(_\w+)\s*\(([^)]*)\)\s*;", l)
        if not m:
            continue
        ret, name, args = m.groups()
        if name in SKIP:
            continue
        args = [a.strip() for a in args.split(",") if a.strip()]
        if any(a not in ("int", "unsigned", "long long", "double", "float", "__int40_t") for a in args):
            continue
        out.append((ret, name, args))
        if name == "_xormpy":
            break
    return out


def lit(t, v):
    if t == "unsigned":
        return "0x%08xu" % (v & 0xFFFFFFFF)
    if t == "int":
        return "(int)0x%08xu" % (v & 0xFFFFFFFF)
    if t in ("long long", "__int40_t"):
        return "(long long)0x%016xull" % (v & 0xFFFFFFFFFFFFFFFF)
    if t == "float":
        return "_itof(0x%08xu)" % (v & 0xFFFFFFFF)
    if t == "double":
        return "_lltod(0x%016xll)" % (v & 0xFFFFFFFFFFFFFFFF)


def main():
    random.seed(7)
    ss = sigs(sys.argv[1])
    folded, runtime, inits, names = [], [], [], []
    vin = []
    k = 0
    for ret, name, args in ss:
        for case in range(10):
            vals = []
            for i, t in enumerate(args):
                if t in ("long long", "__int40_t", "double"):
                    v = (random.choice(EDGE32) << 32) | random.choice(EDGE32)
                    if t == "__int40_t":
                        v &= 0xFFFFFFFFFF
                        if v & 0x8000000000:
                            v |= 0xFFFFFF0000000000
                    if t == "double" and case < 5:
                        v = random.choice([0x3FF0000000000000, 0x4008000000000000, 0xC059000000000000,
                                           0x3FB999999999999A, 0x40C3880000000000])
                elif t == "float":
                    v = random.choice([0x3F800000, 0x40400000, 0xC2C80000, 0x3DCCCCCD, 0x461C4000, 0x80000000,
                                       0x7F7FFFFF, 0x00000000, 0x3EAAAAAB, 0x4B000000])
                else:
                    v = EDGE32[(case * 3 + i * 5) % len(EDGE32)] if case < 6 else random.getrandbits(32)
                    if name in ("_extu", "_ext", "_set", "_clr") and i > 0:
                        v = random.randrange(32)
                    if name in ("_sshl", "_shr2", "_shru2", "_rotl") and i == 1:
                        v = random.randrange(40)
                    if name in ("_sshvl", "_sshvr") and i == 1:
                        v = random.randrange(-40, 40) & 0xFFFFFFFF
                    if name == "_lmbd" and i == 0:
                        v = case & 1
                vals.append(v)
            # result conversion to 1 or 2 words
            if ret in ("long long", "__int40_t", "unsigned long long"):
                cast_hi = "(unsigned)((unsigned long long)(%s) >> 32)"
                cast_lo = "(unsigned)(%s)"
                nw = 2
            elif ret == "double":
                cast_hi, cast_lo, nw = "_hi(%s)", "_lo(%s)", 2
            elif ret == "float":
                cast_lo, nw = "_ftoi(%s)", 1
            else:
                cast_lo, nw = "(unsigned)(%s)", 1
            fexpr = "%s(%s)" % (name, ", ".join(lit(t, v) for t, v in zip(args, vals)))
            rargs = []
            for t, v in zip(args, vals):
                idx = len(vin)
                vin.append((t, v))
                rargs.append("vin_%s[%d]" % ({"unsigned": "u", "int": "i", "long long": "ll", "__int40_t": "ll",
                                                "float": "f", "double": "d"}[t], idx))
            rexpr = "%s(%s)" % (name, ", ".join(rargs))
            folded.append("    F[%d] = %s;" % (k, cast_lo % fexpr))
            runtime.append("    R[%d] = %s;" % (k, cast_lo % rexpr))
            names.append("%s#%d lo %s" % (name, case, ",".join("%x" % (v & 0xFFFFFFFFFFFFFFFF) for v in vals)))
            k += 1
            if nw == 2:
                folded.append("    F[%d] = %s;" % (k, cast_hi % fexpr))
                runtime.append("    R[%d] = %s;" % (k, cast_hi % rexpr))
                names.append("%s#%d hi" % (name, case))
                k += 1
    n = len(vin)
    with open(sys.argv[2], "w") as f:
        f.write("#include <c6x.h>\n#define N %d\nunsigned F[N], R[N];\n" % k)
        for nm, ty in (("u", "unsigned"), ("i", "int"), ("ll", "long long"), ("f", "float"), ("d", "double")):
            f.write("volatile %s vin_%s[%d];\n" % (ty, nm, max(1, n)))
        f.write("#pragma FUNC_CANNOT_INLINE(fold)\nvoid fold(void)\n{\n" + "\n".join(folded) + "\n}\n")
        f.write("#pragma FUNC_CANNOT_INLINE(run)\nvoid run(void)\n{\n" + "\n".join(runtime) + "\n}\n")
        f.write("int main(void)\n{\n")
        for idx, (t, v) in enumerate(vin):
            nm = {"unsigned": "u", "int": "i", "long long": "ll", "__int40_t": "ll", "float": "f", "double": "d"}[t]
            f.write("    vin_%s[%d] = %s;\n" % (nm, idx, lit(t, v)))
        f.write("    fold();\n    run();\n    return 0;\n}\n")
    open(sys.argv[3], "w").write("\n".join(names) + "\n")
    print(k, "results,", len(ss), "intrinsics")


main()
