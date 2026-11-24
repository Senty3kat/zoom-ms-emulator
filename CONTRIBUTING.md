# Как участвовать

## Сообщения об ошибках

- Опишите, какая прошивка загружается (стоковая ОС или пользовательская).
- Укажите команду запуска и флаги.
- Приложите фрагмент лога (usb.txt, midi.txt, trace.txt или cache_log.txt).
- Укажите версию прошивки и модель педали (MS-50G / MS-60B / MS-70CDR).

## Pull request'ы

- Собирайте через `sh build.sh` (требуется zig в PATH).
- Проверяйте, что прошивки по-прежнему загружаются и USB работает.
- Не добавляйте в коммит прошивки, логи, дампы и бинарники (см. .gitignore).

## Сборка

```
zig cc -O2 -std=gnu11 -Iopcode -o build/c6xboot.exe tools/boot.c sys.c usb.c cpu.c exec.c decode.c mem.c ais.c cache.c
zig cc -O2 -std=gnu11 -Iopcode -o build/c6xzdl.exe tools/zdlstand.c zdl.c elf.c cpu.c exec.c decode.c mem.c ais.c cache.c
```

## Лицензия

GPL v3. См. [LICENSE](LICENSE). Части кода (`decode.c`, `opcode/`) являются
портом binutils (GPL v3, Free Software Foundation).
