"""Tile several grayscale PNGs (as written by c6xboot) into one image.
    python -I montage.py out.png cols a.png b.png ...
A 4-pixel gray border separates the tiles.
"""
import struct, sys, zlib


def read_png(path):
    d = open(path, "rb").read()
    pos, idat, w, h = 8, b"", 0, 0
    while pos < len(d):
        n = struct.unpack(">I", d[pos:pos + 4])[0]
        t = d[pos + 4:pos + 8]
        body = d[pos + 8:pos + 8 + n]
        if t == b"IHDR":
            w, h = struct.unpack(">II", body[:8])
        elif t == b"IDAT":
            idat += body
        pos += 12 + n
    raw = zlib.decompress(idat)
    return w, h, [raw[y * (w + 1) + 1:(y + 1) * (w + 1)] for y in range(h)]


def write_png(path, w, h, rows):
    raw = b"".join(b"\x00" + bytes(r) for r in rows)
    def chunk(t, b):
        c = struct.pack(">I", len(b)) + t + b
        return c + struct.pack(">I", zlib.crc32(t + b) & 0xFFFFFFFF)
    png = b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 0, 0, 0, 0))
    png += chunk(b"IDAT", zlib.compress(raw, 9)) + chunk(b"IEND", b"")
    open(path, "wb").write(png)


def main():
    out, cols, files = sys.argv[1], int(sys.argv[2]), sys.argv[3:]
    imgs = [read_png(f) for f in files]
    w, h = imgs[0][0], imgs[0][1]
    b = 4
    nrows = (len(imgs) + cols - 1) // cols
    W, H = cols * (w + b) + b, nrows * (h + b) + b
    canvas = [bytearray([128] * W) for _ in range(H)]
    for i, (_, _, rows) in enumerate(imgs):
        x0, y0 = b + (i % cols) * (w + b), b + (i // cols) * (h + b)
        for y in range(h):
            canvas[y0 + y][x0:x0 + w] = rows[y]
    write_png(out, W, H, canvas)


main()
