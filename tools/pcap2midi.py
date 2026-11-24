"""Turn a USBPcap capture of a Zoom pedal into a c6xboot -midifile script.

    python -I pcap2midi.py capture.pcapng script.txt [--from HEX] [--to HEX] [--wait] [--t0 MS] [--dev N]

Every host -> pedal MIDI message becomes a line. With --wait each message is sent after the
emulated pedal answered the previous one ("w HEX"), which is how Zoom's updater and Effect
Manager talk; otherwise the captured timing is kept, starting at --t0 ms (default 3000).
The pedal's answers from the capture are written as "# <- HEX" comments for comparison.
--from / --to: start at the first host message starting with HEX, stop after one starting
with HEX (e.g. --from f05200580a --to f052005804 for a firmware update).
Standard library only.
"""
import argparse
import struct


def packets(data):
    p = 0
    while p + 12 <= len(data):
        btype, blen = struct.unpack_from("<II", data, p)
        if blen < 12:
            break
        if btype == 6:                                   # Enhanced Packet Block
            _, th, tl, cap, _ = struct.unpack_from("<IIIII", data, p + 8)
            yield ((th << 32) | tl) * 1e-6, data[p + 28:p + 28 + cap]
        p += blen


CIN_LEN = {0x2: 2, 0x3: 3, 0x5: 1, 0x6: 2, 0x7: 3, 0x8: 3, 0x9: 3, 0xA: 3, 0xB: 3, 0xC: 2, 0xD: 2,
           0xE: 3, 0xF: 1}


def messages(cap):
    """(time s, device, 'OUT'/'IN', bytes) for every USB-MIDI message in bulk transfers."""
    out, buf = [], {}
    for t, pk in packets(cap):
        if len(pk) < 27:
            continue
        hl = struct.unpack_from("<H", pk, 0)[0]          # USBPcap header
        dev = struct.unpack_from("<H", pk, 19)[0]
        ep, xfer = pk[21], pk[22]
        data = pk[hl:]
        if xfer != 3 or not data:                        # bulk only
            continue
        d = "IN" if ep & 0x80 else "OUT"
        for i in range(0, len(data) - 3, 4):
            cin, b = data[i] & 15, data[i + 1:i + 4]
            if data[i:i + 4] == b"\0\0\0\0":
                continue
            k = (dev, d)
            if cin == 4:
                buf.setdefault(k, bytearray()).extend(b)
            elif cin in (5, 6, 7) and (k in buf or b[0] == 0xF0):
                m = buf.pop(k, bytearray())
                m.extend(b[:cin - 4])
                out.append((t, dev, d, bytes(m)))
            elif cin in CIN_LEN:
                out.append((t, dev, d, bytes(b[:CIN_LEN[cin]])))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("capture")
    ap.add_argument("script")
    ap.add_argument("--from", dest="start")
    ap.add_argument("--to", dest="stop")
    ap.add_argument("--wait", action="store_true")
    ap.add_argument("--t0", type=float, default=3000)
    ap.add_argument("--dev", type=int)
    a = ap.parse_args()
    msgs = messages(open(a.capture, "rb").read())
    zoom = {m[1] for m in msgs if m[3][:2] == b"\xF0\x52"}
    lines = [f"# from {a.capture}"]
    started, t_first, n = not a.start, None, 0
    for t, dev, d, m in msgs:
        if (a.dev is not None and dev != a.dev) or (a.dev is None and dev not in zoom):
            continue
        h = m.hex()
        if not started and d == "OUT" and h.startswith(a.start.lower()):
            started = True
        if not started:
            continue
        if d == "IN":
            lines.append(f"# <- {h if len(m) <= 40 else h[:80] + f'... ({len(m)} B)'}")
            continue
        if t_first is None:
            t_first = t
        lines.append(f"w {h}" if a.wait and n else f"{a.t0 + (t - t_first) * 1000:.1f} {h}")
        n += 1
        if a.stop and h.startswith(a.stop.lower()):
            break
    open(a.script, "w").write("\n".join(lines) + "\n")
    print(f"{n} messages -> {a.script}")


main()
