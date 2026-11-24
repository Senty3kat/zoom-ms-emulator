"""Extract firmware parts (129 main OS, 133 preset/logo, 136 boot, 137 FS)
from a Zoom MS updater .exe (stock or CFW) into a directory.
    python -I extract_updater.py UPDATER.exe OUTDIR
"""
import sys
from pathlib import Path

ROLES = {129: "129_main_OS.bin", 133: "133_data_133.bin",
         136: "136_bootloader.bin", 137: "137_file_system.bin"}


def u32(d, o):
    return int.from_bytes(d[o:o + 4], "little")


def extract(data):
    e_lfanew = u32(data, 0x3C)
    coff = e_lfanew + 4
    nsec = int.from_bytes(data[coff + 2:coff + 4], "little")
    optsz = int.from_bytes(data[coff + 16:coff + 18], "little")
    opt = coff + 20
    magic = int.from_bytes(data[opt:opt + 2], "little")
    dd = opt + (96 if magic == 0x10B else 112)
    res_rva = u32(data, dd + 16)
    sects = []
    sh = opt + optsz
    for i in range(nsec):
        s = sh + i * 40
        sects.append((u32(data, s + 12), max(u32(data, s + 8), u32(data, s + 16)), u32(data, s + 20)))

    def rva2off(rva):
        for va, sz, raw in sects:
            if va <= rva < va + sz:
                return raw + (rva - va)
        return rva

    base = rva2off(res_rva)
    out = {}

    def walk(off, depth, want_id=None):
        if depth > 4 or off + 16 > len(data):
            return
        n = int.from_bytes(data[off + 12:off + 14], "little") + int.from_bytes(data[off + 14:off + 16], "little")
        p = off + 16
        for _ in range(n):
            name, off2 = u32(data, p), u32(data, p + 4)
            p += 8
            eid = name & 0xFFFF
            if off2 & 0x80000000:
                nid = eid if (depth == 0 and eid in ROLES) or (depth == 1 and want_id not in ROLES) else want_id
                walk(base + (off2 & 0x7FFFFFFF), depth + 1, nid)
            else:
                de = base + off2
                rva, sz = u32(data, de), u32(data, de + 4)
                if want_id in ROLES and sz > 0:
                    out[want_id] = data[rva2off(rva):rva2off(rva) + sz]

    walk(base, 0)
    return out


def main():
    parts = extract(Path(sys.argv[1]).read_bytes())
    out = Path(sys.argv[2])
    out.mkdir(parents=True, exist_ok=True)
    for rid, blob in sorted(parts.items()):
        (out / ROLES[rid]).write_bytes(blob)
        print(f"{ROLES[rid]}: {len(blob)} bytes")


main()
