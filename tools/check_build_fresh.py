#!/usr/bin/env python3
"""Warn when an emulator executable is older than its sources.

Usage:
    python tools/check_build_fresh.py
    python tools/check_build_fresh.py --exe build/c6xzdl.exe
    python tools/check_build_fresh.py --warn-only

Exit status:
    0 = executable is fresh (or --warn-only was used)
    1 = executable is older than a source file
    2 = executable not found
"""

import argparse
from pathlib import Path


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    root_default = Path(__file__).resolve().parent.parent
    parser.add_argument("--root", type=Path, default=root_default,
                        help="emulator source root (default: parent of tools/)")
    parser.add_argument("--exe", type=Path, default=None,
                        help="executable to check (default: build/c6xboot.exe)")
    parser.add_argument("--warn-only", action="store_true",
                        help="print a warning but always return 0")
    args = parser.parse_args()

    root = args.root.resolve()
    exe = (args.exe if args.exe else root / "build" / "c6xboot.exe").resolve()
    if not exe.exists():
        print(f"STALE: executable not found: {exe}")
        return 0 if args.warn_only else 2

    sources = []
    for pattern in ("*.c", "*.h", "build.sh"):
        for path in root.rglob(pattern):
            if not path.is_file():
                continue
            rel = path.relative_to(root)
            if any(part in {"build", ".git"} for part in rel.parts):
                continue
            if path.name.startswith(".") or ".bak" in path.name:
                continue
            sources.append(path)

    if not sources:
        print(f"STALE: no sources found under {root}")
        return 0 if args.warn_only else 1

    newest = max(sources, key=lambda p: p.stat().st_mtime_ns)
    exe_time = exe.stat().st_mtime_ns
    src_time = newest.stat().st_mtime_ns

    if src_time > exe_time:
        print(f"STALE: {exe.name} is older than {newest.relative_to(root)}")
        print(f"  exe    {exe_time}")
        print(f"  source {src_time}")
        print("  rebuild: cd emulator && sh build.sh")
        return 0 if args.warn_only else 1

    print(f"FRESH: {exe.name} >= newest source {newest.relative_to(root)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
