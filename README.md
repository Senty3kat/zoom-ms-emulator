# c6x — эмулятор Zoom MS (C6745 / C674x) на C

Полный эмулятор педали Zoom MS на ПК: загружает настоящую прошивку и воспроизводит
железо целиком — CPU C674x, экран, кнопки, звук, флеш, USB, кэш и SDRAM. Основное
назначение — отладка кастомных прошивок (CFW): загрузка, UI, обработка MIDI, работа
прерываний и таймеров — ещё до прошивки педали. Скорость около 70 млн тактов DSP
в секунду, то есть примерно 1/4 реального времени педали (300 МГц). На практике с кэшем и задержками флеша 70CDR эмуляция идёт примерно в 4–7 раз медленнее.

В поставку входит и стенд `c6xzdl` для проверки эффектов C674x по блокам — отдельный
режим того же эмулятора. ABI эффектов и формат ZDL описаны сообществом (см. раздел
«Источники»).

**Как пользоваться — пошагово в [HOWTO.md](HOWTO.md).** Здесь — устройство и точность. Если что-то не работает — раздел 13 в HOWTO.

## Что умеет

| Что | Состояние |
|---|---|
| Стоковая ОС MS-50G 3.10 | грузится до рабочего экрана; экран рисует сама прошивка через SPI |
| CFW | грузится: свой логотип ZOOM, затем рабочий экран; шлёт дампы регистров по USB |
| Стоковая ОС MS-70CDR 2.10 | грузится до рабочего патча, кнопки, ручки, звук, USB |
| Загрузчик `boot.bin` | грузит ОС из флеша; с зажатыми ногами 5 и 7 — режим обновления (FIRMWARE UPDATE) |
| Звук | McASP0 + EDMA3, 44.1 кГц, вход — синус или WAV, выход — `out.wav` |
| Кнопки и ручки | 6 клавиш, футсвич и 3 энкодера; сценарий нажатий и поворотов по времени |
| Флеш | MX25L3233F 4 МБ, собирается из частей апдейтера, чтение/запись/стирание, `-saveflash` |
| USB | контроллер USB0 (MUSB + CPPI 4.1) и сценарный хост: энумерация, USB-MIDI, SysEx в обе стороны |
| Кэш и SDRAM | модель L1P/L1D/L2 с настройкой из прошивки, простои при промахах |
| ZDL-стенд | `.ZDL` или сборка C-исходника эффекта; бит-в-бит сравнение с ПК, нагрузка DSP |

## Сборка

```bash
# Запускать из корня репозитория: build.sh лежит в корне.
sh build.sh          # zig в PATH или ZIG=/путь/к/zig.exe
```

## Запуск прошивки: `c6xboot`

Прошивка — папка с частями апдейтера (`129_main_OS.bin`, `133_data_133.bin`,
`136_bootloader.bin`, `137_file_system.bin`). Части из любого апдейтера
(стокового или CFW) достаёт `tools/extract_updater.py UPDATER.exe ПАПКА`.
Первым аргументом обычно идёт ОС (`129_main_OS.bin`); можно дать загрузчик
(`136_bootloader.bin`), тогда он сам прочитает ОС из флеша.

```bash
# 5 секунд работы, снимки экрана на 1.5 и 4 с, финальный экран lcd.png, звук out.wav
build/c6xboot.exe ../../cfw/stock50g/129_main_OS.bin -s 5 -q -snap 1500:boot.png -snap 4000:home.png

# синус 220 Гц на вход, нажать кнопку на ноге 6 на 4 с, повернуть ручку 3 на 4.5 с
build/c6xboot.exe run/cfw/129_main_OS.bin -s 6 -sine 220 0.3 -press 4000:6 -turn 4500:26:28:3

# Identity Request по USB на 5-й секунде
build/c6xboot.exe run/cfw/129_main_OS.bin -s 6 -q -sysex 5000:F07E000601F7
```

Ключи: `-s СЕК`, `-press МС:ПИН[:ДЛИТ[:УРОВЕНЬ]]`, `-in МС:ПИН:УРОВЕНЬ`,
`-turn МС:ПИН_A:ПИН_B:ШАГИ`, `-snap МС:файл.png` (только раньше `-s`), `-lcd файл.png`, `-sine ГЦ АМПЛ`,
`-out файл.wav`, `-gpio ПАРА HEX`, `-fb файл.bin` (кадр 1024 Б: 8 страниц по 128 колонок, бит 0 — верхний пиксель),
`-adc N` (батарея), `-mhz`, `-nocache`, `-flashfast` (без задержек флеша), `-emif МГЦ`, `-stack АДР` (задать `B15` после AIS JumpClose), `-cachejump` (инвалидация кэша после JumpClose, включена по умолчанию; `-no-cachejump` отключает), `-staleicode [АДР:ДЛИНА]` (модель stale-инструкций после загрузки кода, включена по умолчанию; `-no-staleicode` отключает), `-bootflash` (взять AIS из собранной флеши по `0x40000`), `-hwclose` (жёсткий старт включён по умолчанию: требует записи SPIFMT0/1, диагностический порог LCD SPI 25 МГц, меняется `-hwlcdlimit`, синтетический native IRQ residue без `DINT`, остаточная периферия; `-no-hwclose` отключает), `-romrepaint МС` (период синтетической перерисовки boot-лого для `-hwclose`), `-hwlcdlimit МГЦ` (порог LCD SPI для `-hwclose`, по умолчанию 25), старые вызовы до `v1.1` (`-usbtrace`, `-usblog`, `-midilog`, `-cachelogall`, `-hwclose=0/1`) печатают справку и текущую версию вместо ошибки, `-muxstrict` (учитывать владельца CS через PINMUX7; рекомендуется для bare-metal прогонов), `-muxhalt` (fatal при LCD-записи с неправильным mux, быстро ловит firmware без возврата LCD mux после flash_read), `-usbvbus 0..3|ok|fault|sense` (уровень VBUS в битах 4:3 `DEVCTL`; `3`/`ok` — VBusValid по умолчанию, `1`/`fault` — низкий VBUS без перечисления; `sense` — опциональная модель `CFGCHIP2.VBUSSENSE`: при бите 16=1 уровень принудительно 3, при 0 остаётся выбранный. Модель выключена по умолчанию; для отказа T2STAT укажите `1` и `sense`), `-flashfault wp,wip,rx,long,mux` (опциональные отказы SPI flash: защита записи, WIP не сбрасывается, SPIBUF не готовит RX, длинное чтение даёт FF, неверный CS/mux блокируется; по умолчанию выключено), `-bootlog` (чекпоинты bootmini и карта копирования FWIMG в `boot_log.txt`), `-otacheck ФАЙЛ A/B` (сравнить слот флеша с FWIMG после прогона), `-flashlog` (журнал реальных операций записи/стирания SPI flash в `flash_log.txt`), `-stwtrace ФАЙЛ[,АДР:ДЛИНА]` (трасса `STW` в буфер вывода: `left i` и `right i`); USB: `-usb`, `-usbwav ФАЙЛ`, `-sysex МС:HEX`, `-usbphy` (журнал записей и меняющихся чтений в `usbphy_log.txt`), `-readback` (финальные чтения `CFGCHIP2`, `PSC1 MDCTL1/MDSTAT1/PTSTAT`, `DEVCTL` в `usbphy_log.txt`, требует `-usbphy`), `-usbpinmux` (опция: требовать `PINMUX9[7:4]=1h` / `USB0_DRVVBUS` для device-attach; по умолчанию выключено, `-usbrefclk` (опционально: требовать `PINMUX9[11:8]=4h` / `USB_REFCLKIN`; по умолчанию выключено), `-usbphypol` (опционально: требовать `CFGCHIP2 DATPOL=1` и `PHY_PLLON=1`; по умолчанию выключено), `-suspend` (опционально: моделировать `POWER.SUSPENDM` (бит 1); SETUP удерживается, пока бит активен, и снимается чтением `INTRUSB` или импульсом `POWER.RESUME`; по умолчанию выключено), `-inheritenum` (опционально: хост уже настроен загрузчиком до JumpClose; пропустить `SET_ADDRESS`, `GET_DESCRIPTOR`, `SET_CONFIGURATION`, наследовать адрес `0x3A` и готовые bulk `ep3`/`ep4` по 64 байт; по умолчанию выключено), `-usbpath full` (опционально: одна модель полного пути TI `VBUS 1h → Session → SOFTCONN → Bus Reset → EP0 SETUP → SET_ADDRESS → GET_DESCRIPTOR → SET_CONFIGURATION`; по умолчанию уровень `VBUS=1h`, как на железе; пока нет `VBusValid`, хост не шлёт SETUP и адрес остаётся `00`; дефолт v1.1 не меняется)), `-powerhsmode` (опция: читать `POWER.HSMODE` бит 4 как read-only статус, сообщать `POWER=50` при записи 0x40; на attach не влияет), `-csr0rxbit` (опция: требовать бит RXPKTRDY 0x01 вместе с SERV_RXPKTRDY 0x40; A/B для `0x40` против стоковых `0x41/0x49`; по умолчанию выключено), `-sdramgarbage` (опция: заполнить SDRAM шаблоном `A5A5A5A5` до загрузки AIS, чтобы поймать firmware без обнуления `.bss`/`.common`; по умолчанию выключено, память нулевая), `-ep0prereq` (опция: не доставлять SETUP, пока не выполнены предпосылки стока `POWER.SOFTCONN`, `INTRUSBE`, `INTRTXE`, `INTRRXE` и `CSR0.FLUSHFIFO`; по умолчанию выключено), `-ep0fifolanes` (опция: требовать запись байтов FIFO0 строго по `0x01E00420/21/22/23` с самого начала каждого IN-пакета; по умолчанию выключено), `-reattachgap` (опция: блокировать повторное перечисление, если пауза `POWER.SOFTCONN off→on` больше 2 мс; дефолт не ломает), `-wrapirq` (опция: требовать записи `INTMSKSETR` и `INTCLRR` wrapper-прерываний перед attach; по SPRUFM9H сток их пишет, sandbox-сборки — нет; дефолт не ломает),
`-midifile ФАЙЛ`, `-saveflash ФАЙЛ`. `-usbwav` пишет захваченный изохронный поток UAC в WAV 44,1 кГц / 16 бит / стерео. Отладка: `-t ТАКТ [-tl N]` — трасса команд и
записей регистров (`trace.txt`); `-p АДРЕС` — зонд (A4/B4/A6/B6/B3 при входе в
пакет, `probe.txt`) и останов на этом адресе; `-b АДРЕС` — останов; `-m` — журнал записей MMIO; `-w LO HI` —
чтения MMIO; `-ww LO HI ТАКТ` — записи в RAM с PC (`ww.txt`); `-dump АДРЕС ДЛИНА`.
Склейка нескольких PNG: `tools/montage.py`.

### Диагностические ключи

Ключи можно давать сразу несколько. Пример полного прогона:

```bash
build/c6xboot.exe path/to/firmware/129_main_OS.bin -s 3 -q -flashfast \
  -dma -spi -gpiolog -spilimit 1:50 -cachelog 1:2 \
  -cachepen 5:3:385:40 -prof 1:2 -call 1181A078 -mmiohist -m
```

| Ключ | Файл | Что даёт |
|---|---|---|
| `-dma` | `dma_log.txt` | каждая EDMA-передача: такт, канал, SRC/DST, размер |
| `-spi` | `spi_log.txt` | каждое слово SPI0: устройство, PC, формат, фактический SCK |
| `-flashlog` | `flash_log.txt` | реальные записи/стирания SPI flash: такт, `fl_addr`, `fl_cmd`, `fl_writes`, адрес/байт записи или диапазон стирания |
| `-stwtrace ФАЙЛ[,АДР:ДЛИНА]` | указанный файл | трасса `STW` в буфере вывода: такт, PC, `left i` / `right i`, адрес, исходный регистр, значение и float; по умолчанию окно `11F04100:40` |
| `-staleicode [АДР:ДЛИНА]` | stdout | после первой записи в регион исполняемого кода выборка команд возвращает старые байты до инвалидации L1P/L2; включено по умолчанию, `-no-staleicode` отключает |
| (диапазоны stale) | stdout | по умолчанию несколько независимых регионов: `C0300000:10000` плюс ZDL-пулы `C0198000:8000`, `C0640000:60000`, `C0700000:60000`; стоковый пул `C0200000` намеренно исключён, чтобы не ломать загрузку |
| `-spilimit LCD:FLASH` | stderr | два предела в МГц через двоеточие, например `1:50`; `0` выключает проверку. Рекомендуется явно задавать `1:50`: при разгоне до 408 МГц со стоковыми делителями SPI0 может дать 68 МГц на флеше, а эмулятор по умолчанию не считает это отказом |
| `-gpiolog` | `gpio_log.txt` | все изменения ног GPIO со временем и PC |
| `-cachelog [T1:T2]` | `cache_log.txt` | задержки кэша и попадания EDMA в кэшированную строку |
| `-cachepen P1:P2:P3:P4` | stderr | переопределить штрафы L1D/L2/SDRAM; для 70CDR: `5:3:385:40` |
| `-prof T1:T2` | stdout | гистограмма PC только в окне времени |
| `-audioload` | stdout | доля не-idle циклов в аудио-диспетчере L2 и разбивка по адресам аудиофункций |
| `-call АДР` | `call_log.txt` | каждый вход в функцию: такт, PC, возврат, A4/B4; не останавливает прогон |
| `-watch АДР:ЗНАЧ` | stdout | дождаться значения 32-битного слова и продолжить |
| `-mmiohist` | stdout | топ адресов MMIO по `mmio.txt` (нужен `-m`) |
| `-loadflash ФАЙЛ` | stderr | загрузить сохранённый 4 МБ образ флеша |
| `-spi1fast` | — | старая модель SPI1 без задержки слова; бит-в-бит повторяет вывод старого эмулятора |

`usb.txt` и `midi.txt` пишутся всегда. В `midi.txt` `->` обозначает команду ПК → педаль, `<-` — ответ педали → ПК, включая SysEx. SysEx надо подавать после готовности USB, например `-usb -sysex 4000:F052005850F7`; на 1-й секунде логи будут пустыми. Для MS-70CDR байт модели `61`, например запрос текущего патча: `-usb -sysex 5000:F052006101F7 -sysex 7000:F052006150F7 -sysex 9000:F052006129F7`.

`-p АДР` при попадании останавливает прогон; `-call АДР` только пишет в `call_log.txt` и не останавливает выполнение. Не запускайте несколько прогонов в одной папке: логи перезаписываются, а оставшийся после прерывания процесс `c6xboot` может удерживать файл.
`c6xzdl` понимает `--cachepen 5:3:385:40`, `--text-base HEX` (в том числе `11E00000` для L1P SRAM), `--probe-fx`, `--fw-stubs`, `--syms`, `--pedal-at T=N`.

### Органы управления

Найдены экспериментом на стоковой 3.10; полярность подтверждена кодом загрузчика (он
решает, входить ли в режим обновления) и дампом регистров с педали (IN01 = `EB0600F1`
в покое).

| Пин GPIO | Что | Уровень |
|---|---|---|
| 4 / 6 | кнопки курсора | 0 = нажато |
| 5 / 7 | кнопки выбора типа эффекта | 0 = нажато |
| 24 / 25 / 27 | нажатие ручки 1 (MENU) / 2 (MEMORY) / 3 (страница) | 0 = нажато |
| 35 | футсвич (вкл/выкл эффекта, светодиод GPIO0) | 0 = нажато |
| 17 + 30 / 18 + 29 / 26 + 28 | энкодеры ручек 1 / 2 / 3 | квадратура, прерывание GPIO bank 1 |
| 78 | опрашивается ОС и загрузчиком, назначение не найдено | |

Физическое направление кнопок на MS-70CDR не проверялось: в примерах они задаются номерами ног.

Режим обновления загрузчика: 35, 24, 25, 27, 4, 6 отпущены, 5 и 7 нажаты.

Батарея измеряется внешним 8-битным АЦП на SPI1 (выбор кристалла — GPIO 42,
значение = (байт0 << 3) | (байт1 >> 5), как у АЦП серии ADC081S); по умолчанию 0xF0
(внешнее питание), ключ `-adc N`. Пороги уровней и адреса переменных — в HOWTO, раздел 11.
Встроенного АЦП у C6745 нет, поэтому чтение «регистров АЦП» в пользовательской прошивке давало мусор.

## USB (`usb.c`)

USB0 C6745: обёртка TI (прерывания, `INTSRCR`/`INTMSKR`/`EOIR`), ядро Mentor MUSBMHDRC в
режиме устройства full-speed (EP0 через FIFO, `CSR0`, регистры конечных точек напрямую и
через `INDEX`) и DMA CPPI 4.1: менеджер очередей (64 очереди, `CTRLD` — положить/взять
дескриптор, `PEND`, `QSTATA`), каналы Tx/Rx 0–3 для конечных точек 1–4 и host packet
descriptors по 32 байта. Прерывание — событие DSP 19 (у Zoom → INT7): `INTSRCR & INTMSKR`
или непустая очередь завершения 24–27.

Как этим пользуется прошивка Zoom: 4096 дескрипторов в свободной очереди 28, приём в
очередь 26 из свободных очередей 1–4, передача через очереди 16–23 с возвратом в 24,
программные пулы 32–35; EP0 обслуживается в задаче, очереди завершения — прямо в ISR.

Хост (`-usb`): ждёт `POWER.SOFTCONN`, через 100 мс сбрасывает шину, раз в 1 мс шлёт SOF,
читает дескрипторы устройства, конфигурации и строк, ставит адрес и конфигурацию, затем
раз в 50 мкс отправляет пакет в bulk OUT и опрашивает bulk IN. Сообщения MIDI переводятся в
пакеты USB-MIDI 1.0 (кабель 0) и обратно.

Проверено против записей с настоящей педали (`usb_results`, `ms 60b.pcapng`, `sysex.pcapng`):

| Проверка | Результат |
|---|---|
| Дескрипторы | VID 1686, PID 01A1, bcdDevice 0100, «ZOOM Corporation» / «ZOOM MS Series», bulk OUT 03 и IN 84 по 64 байта — как в записи |
| Identity Request | `F0 7E 00 06 02 52 58 00 00 00 "3.10" F7` (50G), `... 61 ... "2.10"` (70CDR), `"1.10"` в режиме обновления — как у педали |
| Сеанс Effect Manager (121 сообщение из записи) | на все запросы те же ответы; расходятся только сообщения от ручек, которые крутили на педали во время записи |
| Чтение и запись патча | `29` → `28` + 146 байт; записанный патч с другим именем читается обратно |
| Дампы регистров CFW (TT 6–11) | PLL, PSC, SYSCFG, направление и выходы GPIO совпадают с дампом с педали |
| Перепрошивка (361 команда из записи апдейтера) | флеш с CFW после повтора совпал с образом из записи байт-в-байт, загрузчик не тронут |

## Частота DSP и разгон

Частоту эмулятор берёт из настройки PLL в заголовке прошивки (AIS, функция ROM №5,
аргумент 0: биты 31:24 = PLLM, 23:16 = POSTDIV; частота = 24 МГц × (PLLM+1) / (POSTDIV+1)).
Сток 3.10 даёт ровно 300 МГц, что совпадает с дампом регистров PLL, снятым с педали.
Ключ `-mhz` задаёт частоту вручную. Таймеры (24 МГц) и звук (свой кварц) от частоты ядра
не зависят.

`tools/set_pll.py IN OUT --pllm M --postdiv D` правит PLL в копии образа (только файл).
Пример: PLLM=14, POSTDIV=0 → VCO 360 МГц, ядро 360 МГц (в пределах 375 МГц у C6745
вашей педали и 300–600 МГц для VCO).

Что показал эмулятор (синус на входе, с моделью кэша; SDRAM
считается тактируемой от того же PLL, то есть задержки в тактах ядра не меняются):

| Частота | Результат | Загрузка DSP после 3 с (старый PC-метод) |
|---|---|---|
| 250 МГц | работает (раньше падала: ошибка эмулятора с прерыванием в слотах LDW, исправлена) | 36.8% |
| 280 МГц | работает | 32.5% |
| 300 МГц (сток) | работает | 30.6% |
| 360 МГц (`set_pll.py --pllm 14 --postdiv 0`) | работает, экран и звук те же | 25.7% |
| 375 МГц | работает | 24.3% |
| 456 МГц | работает | 20.5% |

Чего эмулятор **не** проверяет: электрическую стабильность кристалла, тайминги SDRAM
(SYSCLK контроллера SDRAM растёт вместе с частотой ядра), скорость SPI и UART от
SYSCLK2. Это проверяется только на железе.

## Кэш и SDRAM (`cache.c`)

Модель хранит только теги (данные всегда берутся из памяти эмулятора) и считает простои:

| Уровень | Геометрия | Промах обходится в |
|---|---|---|
| L1P | до 32 КБ, прямое отображение, строка 32 Б | 8 тактов из L2 |
| L1D | до 32 КБ, 2 пути, LRU, строка 64 Б, выделение при чтении, обратная запись | 10 (L2 SRAM) / 12 (кэш L2) |
| L2 | до 256 КБ, 4 пути, строка 128 Б, обратная запись | 164 такта на строку из SDRAM, 152 на вытеснение грязной |

Размеры берутся из регистров, которые пишет прошивка (у Zoom: L2CFG=3 → 128 КБ кэша,
L1PCFG=4 → 32 КБ, L1DCFG=3 → 16 КБ кэша и 16 КБ SRAM, MAR192 → SDRAM кэшируется).
Блочные и глобальные операции кэша (`L2WB`, `L2WBINV`, `L1PINV` и т. д.) сбрасывают теги
и добавляют время на запись грязных строк. Запись EDMA в L2 SRAM вычищает строки L1D.

Стоимость строки SDRAM посчитана из настройки контроллера в образе (AIS, функция ROM №2:
SDRAM 16 бит, CL3, 4 банка, страница 256 слов): 72 такта шины × (ядро / шина) + ~20 тактов
на коммутатор и контроллер L2. Частота шины SDRAM в образе не записана; по периоду
регенерации (2079 тактов) это 133–150 МГц, принято 150 (ключ `-emif`). Чтение регистра
периферии — 20 тактов, некэшируемое чтение SDRAM — 40.

Эти числа откалиброваны по железу на CFW 5.38 при 408 МГц: подбор `-cachepen 5:3:385:40`
даёт совпадение L2 и SDRAM с педалью в пределах 1–3% (75/151/12475 тактов на 32 чтения
для L1-hit/L2-hit/SDRAM). Для других частот ядра и SDRAM штрафы нужно пересчитать.
Время в эмуляторе «стенное»: такты конвейера плюс простои; таймеры, звук, USB и снимки
идут по нему.

На стоковой 50G загрузка выросла с 25.8% до 30.6%, простои памяти —
около 6% времени (промахи: 7% обращений в L1D, 13% выборок L1P, 0.7% обращений в L2).

## Стенд эффектов: `c6xzdl`

Основное назначение эмулятора — отладка прошивки (CFW) через `c6xboot`.
Дополнительно в поставку входит стенд для готовых эффектов ELF/ZDL: он
загружает эффект в эмулятор и вызывает аудиофункцию по блокам по 8 сэмплов,
оценивая нагрузку DSP. Опция `--text-base 11E00000` переносит код эффекта в L1P SRAM и автоматически включает режим L1PCFG=0; это позволяет сравнить стоимость выборок из SDRAM и из внутренней SRAM. Подробности команд — в [HOWTO.md](HOWTO.md).

## Насколько можно верить

| Проверка | Результат |
|---|---|
| Декодер против `dis6x` (всё ОС 3.10) | 99.997% инструкций кода; остаток — данные |
| `tests/lat.asm`: задержки LD/MPY, предикаты, BNOP | совпадает со справочником TI |
| `tests/t1.c`: целые, 64 бит, float/double, sprintf, qsort, SPLOOP | 400/400 как на ПК |
| `tests/t3.c`: SPLOOP с малым числом итераций, while, вложенные | 2000/2000 |
| `tests/intr`: 135 интринсиков, свёртка компилятором TI против эмулятора | 134/135 (в `_ldotp2` ошибается сама свёртка) |
| Набор пользовательских эффектов, собранных TI, против ПК-сборки | бит-в-бит для тех, у которых ПК-сборка проходит; единичные расхождения вызваны ошибками ПК-сборки или чтением памяти прошивки |
| Готовые ZDL из набора эффектов | бит-в-бит |
| Экран MENU против снимка с педали | совпадает до пикселя, кроме последней цифры версии прошивки |
| MS-70CDR 2.10 | грузится, кнопки, ручки, звук и USB работают; без кэша — на 200–360 МГц, с кэшем — при SDRAM 100–300 МГц |
| USB | см. таблицу в разделе USB |

Справочник TI SPRUFE8B — документ Texas Instruments, в репозиторий не включается.

## Прерывания (SPRUFE8B 2.8, 5, 7.13)

- Между приёмом прерывания и первой командой обработчика проходит 6 тактов (выборка ISFP),
  поэтому отложенные записи регистров прерванного кода (LD, MPY, DP) завершаются до
  обработчика. Без этого прерывание в слотах задержки LDW теряло загруженное значение
  (так падали 70CDR с кэшем и 50G на 250 МГц).
- Внутри SPLOOP прерывание принимается на границе стадии: цикл сливается эпилогом,
  IRP = адрес пакета SPLOOP, в ITSR ставится SPLX; после `B IRP` цикл заново разгоняется
  прологом (команды рядом с SPLOOP и SPMASK из памяти — как NOP, SPLOOPD — как SPLOOP).
  SPLOOPW проверяет условие выхода и во время слива. Без этого 70CDR зависал на заставке.
- TSR: GIE 0, SGIE 1, GEE 2, XEN 3, INT 9, EXC 10, SPLX 14, IB 15; SPLX, INT и IB через MVC
  не пишутся.

## Ограничения

- **Задержки памяти откалиброваны под CFW 5.38 на 408 МГц** (`-cachepen 5:3:385:40`,
  L2 и SDRAM в пределах 1–3% от железа). Для других частот и прошивок штрафы
  пересчитывать; смотрите на разницу между вариантами, а не на последний процент.
- **Устаревание кэша перед DMA** в текущей нагрузке не проявляется: за 8 с и 1,4 млн
  EDMA-передач счётчик `n_dma_snoop` дал 0 попаданий в кэшированные строки L1D.
  Данные в модели всегда свежие; если появится CFW с EDMA в L2 SRAM, счётчик покажет
  это сразу (см. `-cachelog`).
- **USB** — эмулируется full-speed устройство и сценарный хост. Есть EP0 OUT data stage с
  ожиданием `SERV_RXPKTRDY`, UAC `GET_CUR`/`SET_CUR`, изохронный IN и запись потока через
  `-usbwav`. Нет полноценного host-режима USB и полной обработки всех UAC class requests
  со стороны прошивки. Запись во флеш мгновенная, поэтому обновление идёт быстрее, чем
  на педали.
- Номера событий таймеров и GPIO, кроме проверенных (EDMA = 8, TIMER64P1 = 40,
  GPIO bank 1 = 41, USB0 = 19), взяты по аналогии.
- Уровни ног GPIO, отданных другой периферии, читаются из `-gpio`/значений по умолчанию,
  а не из самой периферии. Проверено по CFW 5.38: прошивка читает только ноги 4–7, 24, 25,
  27, 35, 37, 59, 64, 78, 90 и 91; все расходящиеся биты относятся к ногам, которые
  она не читает, поэтому на поведение это не влияет.

## Исправленные ошибки таблиц binutils (`opcode/`)

- Компактная `SPKERNEL`: порядок бит поля fstg/fcyc (SPRUFE8B, рис. H-7).
- Компактные `LDNDW`/`STNDW` с `++`/`--`: смещение масштабируется (C-13, C-15).
- `GMPY`: разрешён кросс-путь (`GMPY.M1X`, как в `dis6x`).
- RS (верхний набор регистров) применяется к 3-битным полям и к парам, но не к 5-битным.

## Файлы

`cache.c` — модель кэша и SDRAM; `usb.c` — USB0 и хост; `decode.c` — декодер (порт
`tic6x-dis.c`); `exec.c` — семантика команд; `cpu.c` — такты, конвейер записи, ветвления,
SPLOOP (с перезагрузкой и прерываниями), прерывания; `sys.c` — периферия (INTC, таймеры,
GPIO, SPI0 LCD+флеш, SPI1 АЦП, EDMA3, McASP0, кэш); `zdl.c` — загрузчик ZDL; `ais.c`,
`elf.c` — загрузчики образов; `tools/` — программы (`pcap2midi.py` — сценарий из записи USB).


## Источники и библиотеки

Эмулятор разработан как самостоятельная реализация на базе открытой документации
и общедоступных спецификаций. Ни один из перечисленных проектов не является
зависимостью эмулятора — это источники знаний и смежные работы.

### Аппаратная документация

- TI TMS320C674x DSP — архитектура и набор инструкций: SPRUFE8B
  (документ Texas Instruments, в репозиторий не включается)
- TI C674x megamodule — геометрия кэша и тайминги: SPRUG82
- MUSBMHDRC + CPPI 4.1 (USB0) — ядро USB Mentor Graphics и спецификация
  CPPI 4.1 от Texas Instruments
- Контроллер LCD семейства ST7565 (судя по набору команд прошивки), дисплей 128x64
- MX25L3233F — 4 МБ SPI flash, Macronix, спецификация микросхемы
- EDMA3 — Enhanced Direct Memory Access 3, Texas Instruments
- McASP0 — Multichannel Audio Serial Port, Texas Instruments
- USB-MIDI 1.0 — спецификация USB Implementers Forum

### Исходный код и инструменты

- binutils (GNU, GPL v3, Joseph Myers / Bernd Schmidt) — `opcodes/tic6x-dis.c` и таблицы
  опкодов `opcode/tic6x-*.h`: база декодера C674x (`decode.c`). Строго GPL v3 — см. лицензию.
- Сообщество Zoom Multistomp — документированный ABI эффектов, формат
  дескрипторов и ZDL, семантика ctx и host-callback; база для стенда `c6xzdl`.
- Ранние проекты сообщества — прототип контекста для вызова аудиофункции
  и первый линкер ZDL: формат дескрипторов и эмпирические константы.
- `zoom-fx-modding-ref` (CH_2.md) — разбор DSP-циклов LineSel.
- `ZoomPedalFun-main` (checkme.py; архивная ссылка — файл удалён из текущего HEAD `shooking/ZoomPedalFun`) — независимый реверс layout точки входа SonicStomp.
- Zig — компилятор C для сборки (`zig cc`)

### Связанные проекты (для справки, не зависимости)

- themanro / ZoomMultistompZDL — эффекты, линкер, редактор патчей;
  дизассемблер `main_os.dis` использовался для сверки дизассемблирования
- Ziddle (berbasoft.com) — эмулятор эффектов, VST/CLAP адаптеры,
  офлайн-рендерер, запись и воспроизведение трассы выполнения
- Leemuzhko / ZOOM_development — заметки и исследования по педалям Zoom
- TI simulator — только моделирование CPU C674x, без периферии педали

## Лицензия

GPL v3. Части кода (`decode.c`, `opcode/`) являются портом binutils (GPL v3,
Free Software Foundation), поэтому весь проект распространяется по GPL v3.
См. [LICENSE](LICENSE).


---

# English version

# c6x — a Zoom MS emulator (C6745 / C674x) in C

A full pedal emulator that runs on a PC: it loads a real firmware image and
reproduces the hardware as a whole — C674x CPU, LCD, buttons, audio, flash,
USB, cache and SDRAM. Its main purpose is debugging custom firmware (CFW):
boot, UI, MIDI handling, interrupts and timers — before flashing the pedal.
Speed is about 70 million DSP cycles per second, roughly 1/4 of real time
for the pedal (300 MHz). In practice, with cache and flash delays on 70CDR, emulation runs about 4–7 times slower.

The package also includes the `c6xzdl` bench for testing C674x effects block
by block — a separate mode of the same emulator. The effect ABI and ZDL
format were documented by the community (see "Sources").

**Step-by-step usage: [HOWTO.md](HOWTO.md) (English section at the end).** If something does not work, see section 13 in HOWTO.
This file describes the design and accuracy.

## Features

| Feature | Status |
|---|---|
| Stock MS-50G 3.10 OS | boots to the working screen; the firmware draws the LCD itself over SPI |
| Custom firmware (CFW) | boots its own ZOOM logo, then the working screen; sends register dumps over USB |
| Stock MS-70CDR 2.10 OS | boots to a working patch; buttons, knobs, audio and USB work |
| Bootloader `boot.bin` | loads the OS from flash; with pins 5 and 7 held — firmware update mode |
| Audio | McASP0 + EDMA3, 44.1 kHz, input is a sine or WAV, output is `out.wav` |
| Buttons and knobs | 6 keys, footswitch and 3 encoders; timed press/turn scripts |
| Flash | MX25L3233F 4 MB, assembled from updater parts, read/write/erase, `-saveflash` |
| USB | USB0 controller (MUSB + CPPI 4.1) and scripted host: enumeration, USB-MIDI, SysEx both ways |
| Cache and SDRAM | L1P/L1D/L2 model configured by the firmware, stalls on misses |
| Effect bench | effects with C sources; bit-exact comparison with the PC build, DSP load |

## Build

```bash
# Run from the repository root: build.sh is at the top level.
sh build.sh          # zig in PATH, or ZIG=/path/to/zig.exe
```

## Running firmware: `c6xboot`

A firmware is a folder with updater parts (`129_main_OS.bin`, `133_data_133.bin`,
`136_bootloader.bin`, `137_file_system.bin`). Parts can be extracted from any
updater (stock or custom) with `tools/extract_updater.py UPDATER.exe FOLDER`.
The first argument is usually the OS (`129_main_OS.bin`); the bootloader
(`136_bootloader.bin`) can be given instead — it reads the OS from flash itself.

```bash
# 5 seconds, screen snapshots at 1.5 and 4 s, final screen lcd.png, audio out.wav
build/c6xboot.exe ../../cfw/stock50g/129_main_OS.bin -s 5 -q -snap 1500:boot.png -snap 4000:home.png

# 220 Hz sine input, press the button on pin 6 at 4 s, turn knob 3 at 4.5 s
build/c6xboot.exe run/cfw/129_main_OS.bin -s 6 -sine 220 0.3 -press 4000:6 -turn 4500:26:28:3

# Identity Request over USB at second 5
build/c6xboot.exe run/cfw/129_main_OS.bin -s 6 -q -sysex 5000:F07E000601F7
```

Options: `-s SEC`, `-press MS:PIN[:DURATION[:LEVEL]]`, `-in MS:PIN:LEVEL`,
`-turn MS:PIN_A:PIN_B:STEPS`, `-snap MS:file.png` (before `-s`), `-lcd file.png`, `-sine HZ AMP`,
`-out file.wav`, `-gpio PAIR HEX`, `-fb file.bin` (1024-byte frame:
8 pages of 128 columns, bit 0 is the top pixel), `-adc N` (battery), `-mhz`, `-nocache`, `-flashfast` (no flash delays), `-emif MHZ`, `-stack ADDR`
(set `B15` after AIS JumpClose), `-cachejump` (cache invalidation after JumpClose is on by default; `-no-cachejump` disables it), `-staleicode [ADDR:LEN]` (stale instruction model after a code load is on by default; `-no-staleicode` disables it), `-bootflash`
(parse AIS from assembled flash at `0x40000`), `-hwclose` (hardware-close start is on by default:
require SPIFMT0/1 writes, diagnostic 25 MHz LCD SPI threshold (override with `-hwlcdlimit`), synthetic native
IRQ residue without `DINT`, boot-ROM residue; `-no-hwclose` disables it), `-romrepaint MS` (synthetic boot-logo repaint period for
`-hwclose`), `-hwlcdlimit MHZ` (LCD SPI threshold for `-hwclose`, default 25), legacy pre-v1.1 calls (`-usbtrace`, `-usblog`, `-midilog`, `-cachelogall`, `-hwclose=0/1`) print help and the current version instead of an error, `-muxstrict` (honor PINMUX7 CS ownership; recommended for bare-metal runs), `-muxhalt` (fatal on an LCD write with the wrong mux; quickly catches firmware that does not restore the LCD mux after flash_read), `-usbvbus 0..3|ok|fault|sense` (DEVCTL VBUS level in bits 4:3; 3/ok is VBusValid by default, 1/fault reproduces a low-VBUS non-enumerating cable; sense enables the optional CFGCHIP2.VBUSSENSE model: bit16=1 forces level 3, bit16=0 keeps the selected level; disabled by default; for the T2STAT fault select both 1 and sense), `-flashfault wp,wip,rx,long,mux` (optional SPI flash faults: write-protect, stuck WIP, SPIBUF RX never ready, long reads return 0xFF, bad CS/mux drops words; disabled by default), `-bootlog` (bootmini checkpoints and FWIMG copy map in `boot_log.txt`), `-otacheck FILE A/B` (compare flash slot with FWIMG after the run), `-flashlog` (log real SPI flash program/erase transactions in `flash_log.txt`), `-stwtrace FILE[,ADDR:LEN]` (trace `STW` writes into the output buffer: `left i` and `right i`); USB: `-usb`, `-sysex MS:HEX`, `-midifile FILE`, `-usbwav FILE`, `-usbphy` (log USB PHY writes and changing readbacks in `usbphy_log.txt`), `-readback` (final CFGCHIP2, PSC1 MDCTL1/MDSTAT1/PTSTAT and DEVCTL readbacks in `usbphy_log.txt`, requires `-usbphy`), `-usbpinmux` (optional: require PINMUX9 bits 7:4 = 1h / USB0_DRVVBUS for device attach; disabled by default, `-usbrefclk` (optional: require PINMUX9 bits 11:8 = 4h / USB_REFCLKIN; disabled by default), `-usbphypol` (optional: require CFGCHIP2 DATPOL=1 and PHY_PLLON=1; disabled by default), `-suspend` (optional: model POWER.SUSPENDM (bit1); SETUP is withheld while active and released by an INTRUSB read or a POWER.RESUME pulse; disabled by default), `-inheritenum` (optional: host was already configured by the bootloader before JumpClose; skip SET_ADDRESS/GET_DESCRIPTOR/SET_CONFIGURATION, inherit address 0x3A and ready bulk ep3/ep4 at 64 bytes; disabled by default), `-usbpath full` (optional: one TI-documented full path model VBUS 1h -> Session -> SOFTCONN -> Bus Reset -> EP0 SETUP -> SET_ADDRESS -> GET_DESCRIPTOR -> SET_CONFIGURATION; VBUS level defaults to 1h as on hardware; without VBusValid the host sends no SETUP and FADDR stays 00; default v1.1 unchanged)), `-powerhsmode` (optional: report POWER.HSMODE bit4 as a read-only status, so POWER=50 reads back after a 0x40 write; does not affect attach), `-csr0rxbit` (optional: require RXPKTRDY bit0 with SERV_RXPKTRDY; A/B for 0x40 vs stock 0x41/0x49; disabled by default), `-sdramgarbage` (optional: fill SDRAM with 0xA5A5A5A5 before the AIS load to catch firmware that does not zero `.bss`/`.common`; disabled by default, memory stays zeroed), `-ep0prereq` (optional: withhold SETUP until the stock prerequisites POWER.SOFTCONN, INTRUSBE, INTRTXE, INTRRXE and CSR0.FLUSHFIFO are present; disabled by default), `-ep0fifolanes` (optional: require EP0 FIFO bytes to be written through lanes 0x20/21/22/23, restarting at lane 0 for every IN packet; disabled by default), `-reattachgap` (optional: block re-enumeration when the POWER.SOFTCONN off-to-on gap exceeds 2 ms; disabled by default), `-wrapirq` (optional: require INTMSKSETR and INTCLRR wrapper IRQ writes before attach; per SPRUFM9H stock writes them while sandbox builds do not; disabled by default)
(UAC isochronous IN capture), `-saveflash FILE`. Debug: `-t CYCLE [-tl N]`
(instruction and register-write trace, `trace.txt`); `-p ADDR` (probe:
A4/B4/A6/B6/B3 on packet entry, `probe.txt`, and stop at that address); `-b ADDR` (stop); `-m` (MMIO write
log); `-w LO HI` (MMIO reads); `-ww LO HI CYCLE` (RAM writes with PC, `ww.txt`);
`-dump ADDR LEN`. To join several PNGs: `tools/montage.py`.

### Diagnostic options

Several options can be given at once. Example of a full run:

```bash
build/c6xboot.exe path/to/firmware/129_main_OS.bin -s 3 -q -flashfast \
  -dma -spi -gpiolog -spilimit 1:50 -cachelog 1:2 \
  -cachepen 5:3:385:40 -prof 1:2 -call 1181A078 -mmiohist -m
```

| Option | File | What it gives |
|---|---|---|
| `-dma` | `dma_log.txt` | every EDMA transfer: cycle, channel, SRC/DST, size |
| `-spi` | `spi_log.txt` | every SPI0 word: device, PC, format, actual SCK |
| `-flashlog` | `flash_log.txt` | real SPI flash program/erase transactions: cycle, `fl_addr`, `fl_cmd`, `fl_writes`, written address/byte or erase range |
| `-stwtrace FILE[,ADDR:LEN]` | chosen file | trace `STW` writes into the output buffer: cycle, PC, `left i` / `right i`, address, source register, value and float; default window `11F04100:40` |
| `-staleicode [ADDR:LEN]` | stdout | after the first write into the code region, instruction fetch returns pre-copy bytes until an L1P/L2 invalidate; on by default, `-no-staleicode` disables it |
| (stale ranges) | stdout | by default several independent regions: `C0300000:10000` plus ZDL pools `C0198000:8000`, `C0640000:60000`, `C0700000:60000`; stock pool `C0200000` is excluded to keep stock boot intact |
| `-spilimit LCD:FLASH` | stderr | two MHz limits separated by a colon, e.g. `1:50`; `0` disables the check. Recommended explicitly: at 408 MHz with stock dividers SPI0 can reach 68 MHz on flash, while the emulator does not treat this as a hardware failure by default |
| `-gpiolog` | `gpio_log.txt` | all GPIO pin changes with time and PC |
| `-cachelog [T1:T2]` | `cache_log.txt` | cache stalls and EDMA hits on cached lines |
| `-cachepen P1:P2:P3:P4` | stderr | override L1D/L2/SDRAM penalties; for 70CDR: `5:3:385:40` |
| `-prof T1:T2` | stdout | PC histogram only inside a time window |
| `-audioload` | stdout | non-idle cycle share inside the L2 audio dispatcher, split by audio function address |
| `-call ADDR` | `call_log.txt` | every entry into a function: cycle, PC, return, A4/B4; does not stop |
| `-watch ADDR:VALUE` | stdout | wait until a 32-bit word equals VALUE, then continue |
| `-mmiohist` | stdout | top MMIO addresses from `mmio.txt` (needs `-m`) |
| `-loadflash FILE` | stderr | load a saved 4 MB flash image |
| `-spi1fast` | — | old SPI1 model without word delay; bit-exact with the old emulator output |

`usb.txt` and `midi.txt` are always written. In `midi.txt`, `->` means a PC → pedal
command and `<-` means a pedal → PC reply, including SysEx. Send SysEx after USB is
ready, e.g. `-usb -sysex 4000:F052005850F7`; during the first second the logs
will be empty. For MS-70CDR the model byte is `61`; a current-patch request is
`-usb -sysex 5000:F052006101F7 -sysex 7000:F052006150F7 -sysex 9000:F052006129F7`.

`-p ADDR` stops the run on a hit; `-call ADDR` only writes to `call_log.txt`
and does not stop execution. Do not run several `c6xboot` instances in one
folder: logs are overwritten, and an interrupted process may keep a file open.
`c6xzdl` understands `--cachepen 5:3:385:40`, `--text-base HEX` (including `11E00000` for L1P SRAM), `--probe-fx`, `--fw-stubs`,
`--syms`, `--pedal-at T=N`.

### Controls

Found experimentally on stock 3.10; polarity confirmed by the bootloader code
(which decides whether to enter update mode) and by a register dump from the pedal.

| GPIO pin | What | Level |
|---|---|---|
| 4 / 6 | cursor buttons | 0 = pressed |
| 5 / 7 | effect-type buttons | 0 = pressed |
| 24 / 25 / 27 | knob 1 (MENU) / 2 (MEMORY) / 3 (page) press | 0 = pressed |
| 35 | footswitch (effect on/off, GPIO0 LED) | 0 = pressed |
| 17 + 30 / 18 + 29 / 26 + 28 | knob 1 / 2 / 3 encoders | quadrature, GPIO bank 1 interrupt |
| 78 | polled by the OS and bootloader, purpose unknown | |

Physical directions of the buttons on MS-70CDR were not verified: the examples use pin numbers.

Bootloader update mode: 35, 24, 25, 27, 4, 6 released; 5 and 7 pressed.

The battery is measured by an external 8-bit ADC on SPI1 (chip select is GPIO 42,
value = (byte0 << 3) | (byte1 >> 5), as for the ADC081S family); default 0xF0
(external power), option `-adc N`. Thresholds and variable addresses are in
HOWTO, section 11. The C6745 has no built-in ADC, so reading "ADC registers"
in custom firmware produced garbage.

## USB (`usb.c`)

USB0 of the C6745: the TI wrapper (interrupts, `INTSRCR`/`INTMSKR`/`EOIR`),
the Mentor MUSBMHDRC core in full-speed device mode (EP0 via FIFO, `CSR0`,
endpoint registers directly and via `INDEX`) and CPPI 4.1 DMA: a queue manager
(64 queues, `CTRLD` — push/pop a descriptor, `PEND`, `QSTATA`), Tx/Rx channels
0–3 for endpoints 1–4 and 32-byte host packet descriptors. The interrupt is
DSP event 19 (INT7 on Zoom): `INTSRCR & INTMSKR`, or a non-empty completion
queue 24–27.

How the Zoom firmware uses it: 4096 descriptors in the free queue 28, receive
into queue 26 from free queues 1–4, transmit via queues 16–23 with return to 24,
software pools 32–35; EP0 is handled in a task, completion queues directly in
the ISR.

The host (`-usb`) waits for `POWER.SOFTCONN`, resets the bus after 100 ms, sends
SOF every 1 ms, reads device/configuration/string descriptors, sets the address
and configuration, then sends a bulk OUT packet and polls bulk IN every 50 µs.
MIDI messages are converted to and from USB-MIDI 1.0 packets (cable 0).

Checked against recordings from a real pedal:

| Check | Result |
|---|---|
| Descriptors | VID 1686, PID 01A1, bcdDevice 0100, "ZOOM Corporation" / "ZOOM MS Series", bulk OUT 03 and IN 84, 64 bytes — as recorded |
| Identity Request | `F0 7E 00 06 02 52 58 00 00 00 "3.10" F7` (50G), `... 61 ... "2.10"` (70CDR), `"1.10"` in update mode — as on the pedal |
| Effect Manager session (121 messages) | same replies to every request; only knob-generated messages from the recording differ |
| Patch read/write | `29` → `28` + 146 bytes; a patch written under another name reads back |
| CFW register dumps (TT 6–11) | PLL, PSC, SYSCFG, GPIO direction and outputs match the pedal dump |
| Re-flashing (361 updater commands) | flash after replay matches the recorded image byte for byte, bootloader untouched |

## DSP frequency and overclocking

The frequency is taken from the PLL setup in the firmware header (AIS, ROM
function #5, argument 0: bits 31:24 = PLLM, 23:16 = POSTDIV; frequency =
24 MHz × (PLLM+1) / (POSTDIV+1)). Stock 3.10 gives exactly 300 MHz, matching
a PLL register dump taken from the pedal. Option `-mhz` sets it manually.
Timers (24 MHz) and audio (own crystal) do not depend on the core clock.

`tools/set_pll.py IN OUT --pllm M --postdiv D` patches the PLL in a copy of the
image (file only). Example: PLLM=14, POSTDIV=0 → VCO 360 MHz, core 360 MHz.

What the emulator showed (sine input, cache model; SDRAM assumed clocked from
the same PLL, so stalls in core cycles do not change):

| Frequency | Result | DSP load after 3 s (legacy PC method) |
|---|---|---|
| 250 MHz | works (used to fail: an emulator bug with an interrupt in LDW delay slots, fixed) | 36.8% |
| 280 MHz | works | 32.5% |
| 300 MHz (stock) | works | 30.6% |
| 360 MHz | works, same screen and audio | 25.7% |
| 375 MHz | works | 24.3% |
| 456 MHz | works | 20.5% |

What the emulator does **not** check: electrical stability of the chip, SDRAM
timings (the SDRAM controller SYSCLK grows with the core clock), SPI and UART
speed from SYSCLK2. That can only be checked on hardware.

## Cache and SDRAM (`cache.c`)

The model stores tags only (data is always read from emulator memory) and
counts stalls:

| Level | Geometry | Miss costs |
|---|---|---|
| L1P | up to 32 KB, direct mapped, 32-byte line | 8 cycles from L2 |
| L1D | up to 32 KB, 2-way, LRU, 64-byte line, allocate on read, write-back | 10 (L2 SRAM) / 12 (L2 cache) |
| L2 | up to 256 KB, 4-way, 128-byte line, write-back | 164 cycles for a line from SDRAM, 152 to evict a dirty one |

Sizes are taken from registers written by the firmware (Zoom: L2CFG=3 → 128 KB
L2 cache, L1PCFG=4 → 32 KB, L1DCFG=3 → 16 KB cache and 16 KB SRAM, MAR192 →
SDRAM is cached). Block and global cache operations (`L2WB`, `L2WBINV`,
`L1PINV`, ...) invalidate tags and add time for dirty write-backs. EDMA writes
into L2 SRAM invalidate L1D lines.

SDRAM line cost is derived from the controller setup in the image (AIS, ROM
function #2: 16-bit SDRAM, CL3, 4 banks, 256-word page): 72 bus cycles ×
(core / bus) + ~20 cycles for the switch and L2 controller. The SDRAM bus
frequency is not stored in the image; from the refresh period (2079 cycles)
it is 133–150 MHz, 150 is assumed (option `-emif`). A peripheral register read
is 20 cycles, an uncached SDRAM read is 40.

These numbers were calibrated on hardware with CFW 5.38 at 408 MHz:
`-cachepen 5:3:385:40` matches L2 and SDRAM within 1-3% (75 / 151 / 12475 cycles
per 32 reads for L1-hit / L2-hit / SDRAM). For other core and SDRAM frequencies
the penalties must be recalculated. Emulator time is "wall" time: pipeline cycles
plus stalls; timers, audio, USB and snapshots follow it.

## Effect bench: `c6xzdl`

The main purpose of the emulator is firmware (CFW) debugging through `c6xboot`.
Additionally the package includes a bench for ready ELF/ZDL effects: it loads
an effect into the emulator and calls its audio function block by block,
8 samples per block, estimating DSP load. The `--text-base 11E00000` option places
effect code in L1P SRAM and switches L1PCFG to 0, so fetch cost from SDRAM and
internal SRAM can be compared. Command details are in [HOWTO.md](HOWTO.md).

## How much to trust it

| Check | Result |
|---|---|
| Decoder against `dis6x` (all of OS 3.10) | 99.997% of code instructions; the rest is data |
| `tests/lat.asm`: LD/MPY delays, predicates, BNOP | matches the TI manual |
| `tests/t1.c`: integers, 64-bit, float/double, sprintf, qsort, SPLOOP | 400/400 as on the PC |
| `tests/t3.c`: SPLOOP with small iteration counts, while, nested | 2000/2000 |
| `tests/intr`: 135 intrinsics, TI-compiled vs emulator | 134/135 (`_ldotp2` — the TI compiler itself is wrong) |
| A set of user effects compiled by TI vs PC build | bit-exact where the PC build passes; isolated differences come from PC build errors or reads of firmware memory |
| Ready ZDL files from the effect set | bit-exact |
| MENU screen vs a pedal snapshot | pixel-exact except the last digit of the firmware version |
| MS-70CDR 2.10 | boots, buttons, knobs, audio and USB work; without cache at 200–360 MHz, with cache at SDRAM 100–300 MHz |
| USB | see the table in the USB section |

The TI SPRUFE8B manual is a Texas Instruments document, not included in the repository.

## Interrupts (SPRUFE8B 2.8, 5, 7.13)

- Between taking an interrupt and the first handler instruction there are 6
  cycles (ISFP fetch), so delayed register writes of the interrupted code
  (LD, MPY, DP) complete before the handler. Without this, an interrupt in LDW
  delay slots lost the loaded value (that is why 70CDR with cache and 50G at
  250 MHz used to fail).
- Inside SPLOOP an interrupt is taken at a stage boundary: the loop drains its
  epilogue, IRP is the SPLOOP packet address, ITSR has SPLX set; after `B IRP`
  the loop spins up again through the prologue (instructions next to SPLOOP
  and SPMASK from memory act as NOPs, SPLOOPD acts as SPLOOP). SPLOOPW checks
  its exit condition while draining too. Without this, 70CDR hung at the logo.
- TSR: GIE 0, SGIE 1, GEE 2, XEN 3, INT 9, EXC 10, SPLX 14, IB 15; SPLX, INT
  and IB are not writable through MVC.

## Limitations

- **Memory latencies are calibrated for CFW 5.38 at 408 MHz** (`-cachepen 5:3:385:40`,
  L2 and SDRAM within 1-3% of the hardware). For other frequencies and firmwares
  the penalties must be recalculated; compare variants rather than the last percent.
- **Stale cache before DMA** does not occur in the current workload: over 8 s and
  1.4 million EDMA transfers the `n_dma_snoop` counter found 0 hits in cached L1D
  lines. Model data is always fresh; a CFW that performs EDMA into L2 SRAM will be
  caught by the counter immediately (see `-cachelog`).
- **USB** models a full-speed device plus a scripted host. EP0 OUT data stage with
  `SERV_RXPKTRDY`, UAC `GET_CUR`/`SET_CUR`, isochronous IN and `-usbwav` capture are
  supported. A full USB host mode and complete firmware-side handling of every UAC
  class request are not modelled. Flash writes are instant, so updates run faster
  than on the pedal.
- Timer and GPIO event numbers, apart from the verified ones (EDMA = 8,
  TIMER64P1 = 40, GPIO bank 1 = 41, USB0 = 19), are by analogy.
- GPIO pins given to other peripherals are read from `-gpio`/defaults,
  not from the peripherals themselves. Verified with CFW 5.38: the firmware only
  reads pins 4-7, 24, 25, 27, 35, 37, 59, 64, 78, 90 and 91; every differing bit
  belongs to a pin it never reads, so this does not affect behaviour.

## Fixed binutils table errors (`opcode/`)

- Compact `SPKERNEL`: bit order of the fstg/fcyc field (SPRUFE8B, fig. H-7).
- Compact `LDNDW`/`STNDW` with `++`/`--`: offset is scaled (C-13, C-15).
- `GMPY`: cross path is allowed (`GMPY.M1X`, as in `dis6x`).
- RS (upper register set) applies to 3-bit fields and pairs, but not to 5-bit ones.

## Files

`cache.c` — cache and SDRAM model; `usb.c` — USB0 and host; `decode.c` —
decoder (a port of `tic6x-dis.c`); `exec.c` — instruction semantics; `cpu.c` —
cycles, register write pipeline, branches, SPLOOP (with reload and
interrupts), interrupts; `sys.c` — peripherals (INTC, timers, GPIO, SPI0
LCD+flash, SPI1 ADC, EDMA3, McASP0, cache); `zdl.c` — ZDL loader; `ais.c`,
`elf.c` — image loaders; `tools/` — utilities (`pcap2midi.py` — build a script
from a USB capture).

## Sources and libraries

The emulator is an independent implementation based on open documentation and
public specifications. None of the projects below is a dependency — they are
sources of knowledge and related work.

### Hardware documentation

- TI TMS320C674x DSP — architecture and instruction set: SPRUFE8B
  (Texas Instruments document, not included in the repository)
- TI C674x megamodule — cache geometry and timings: SPRUG82
- MUSBMHDRC + CPPI 4.1 (USB0) — Mentor Graphics USB core and the CPPI 4.1
  specification from Texas Instruments
- LCD controller of the ST7565 family (judging by the command set used by the
  firmware), 128x64 display
- MX25L3233F — 4 MB SPI flash, Macronix, chip specification
- EDMA3 — Enhanced Direct Memory Access 3, Texas Instruments
- McASP0 — Multichannel Audio Serial Port, Texas Instruments
- USB-MIDI 1.0 — specification of the USB Implementers Forum

### Source code and tools

- binutils (GNU, GPL v3, Joseph Myers / Bernd Schmidt) —
  `opcodes/tic6x-dis.c` and the opcode tables `opcode/tic6x-*.h`: the basis of
  the C674x decoder (`decode.c`). Strictly GPL v3 — see the license.
- Zoom Multistomp community — documented effect ABI, descriptor and ZDL
  format, ctx and host-callback semantics; the basis of the `c6xzdl` bench.
- Early community projects — a prototype context for calling the audio
  function and the first ZDL linker: descriptor format and empirical constants.
- `zoom-fx-modding-ref` (CH_2.md) — disassembly of LineSel DSP loops.
- `ZoomPedalFun-main` (checkme.py; archived reference — the file was removed from the current `shooking/ZoomPedalFun` HEAD) — independent reverse engineering of the
  SonicStomp entry layout.
- Zig — the C compiler used for the build (`zig cc`)

### Related projects (for reference, not dependencies)

- themanro / ZoomMultistompZDL — effects, linker, patch editor; the
  `main_os.dis` disassembly was used to cross-check decoding
- Ziddle (berbasoft.com) — effect emulator, VST/CLAP adapters, offline
  renderer, execution recording and replay
- Leemuzhko / ZOOM_development — notes and research on Zoom pedals
- TI simulator — C674x CPU only, without pedal peripherals

## License

GPL v3. Parts of the code (`decode.c`, `opcode/`) are a port of binutils
(GPL v3, Free Software Foundation), so the whole project is distributed under
GPL v3. See [LICENSE](LICENSE).

