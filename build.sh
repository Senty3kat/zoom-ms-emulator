#!/bin/sh
# Build all c6x tools into build/. Needs zig (any 0.11+); set ZIG if it is not on PATH.
#   sh build.sh            (Git Bash / Linux / macOS)
set -e
cd "$(dirname "$0")"
ZIG="${ZIG:-zig}"
EXE=""
case "$(uname -s)" in MINGW*|MSYS*|CYGWIN*) EXE=.exe ;; esac
mkdir -p build
CORE="cpu.c exec.c decode.c mem.c ais.c cache.c"
SYS="sys.c usb.c"
"$ZIG" cc -O2 -std=gnu11 -Iopcode -o build/c6xboot$EXE tools/boot.c $CORE $SYS
"$ZIG" cc -O2 -std=gnu11 -Iopcode -o build/c6xzdl$EXE tools/zdlstand.c zdl.c elf.c $CORE $SYS
"$ZIG" cc -O2 -std=gnu11 -Iopcode -o build/c6xtest$EXE tools/ctest.c elf.c $CORE $SYS
"$ZIG" cc -O2 -std=gnu11 -Iopcode -o build/c6xdoom$EXE tools/doomrun.c elf.c $CORE $SYS
"$ZIG" cc -O2 -std=gnu11 -Iopcode -o build/c6xdis$EXE tools/dis.c $CORE $SYS
"$ZIG" cc -O2 -std=gnu11 -Iopcode -o build/aisinfo$EXE tools/aisinfo.c $CORE $SYS
echo "built: build/c6xboot build/c6xzdl build/c6xtest build/c6xdoom build/c6xdis build/aisinfo"
