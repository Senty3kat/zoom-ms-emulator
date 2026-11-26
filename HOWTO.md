# Как работать с эмулятором c6x

Пошаговая инструкция для тех, кто видит эмулятор впервые. Подробности о внутреннем
устройстве и точности — в [README.md](README.md).

Эмулятор запускает на ПК прошивку педалей Zoom MultiStomp (MS-50G, MS-70CDR, их CFW) и
отдельные эффекты ZDL. Педаль для этого не нужна, и на неё ничего не пишется: флеш
педали эмулируется в памяти ПК и после выхода пропадает.

## 1. Что нужно

| Что | Зачем | Где взять |
|---|---|---|
| zig 0.11 или новее | компилятор C для сборки эмулятора | ziglang.org, распаковать куда угодно |
| Git Bash (Windows) или любой sh | запуск `build.sh` и примеров ниже | вместе с Git for Windows |
| Python 3.10+ | утилиты в `tools/` | python.org |
| апдейтер прошивки Zoom (`.exe`) или части прошивки | то, что будем запускать | сайт Zoom или ваша сборка CFW |

## 2. Сборка

```bash
# Запускать из корня репозитория: build.sh лежит в корне.
sh build.sh
```

Если zig не в `PATH`, укажите его явно, например `ZIG=/путь/к/zig.exe sh build.sh`.
Программы появятся в `build/`:

| Программа | Что делает |
|---|---|
| `c6xboot` | запускает прошивку целиком: экран, кнопки, звук, флеш |
| `c6xzdl` | запускает один эффект ZDL на звуковом файле, считает нагрузку |
| `c6xtest` | прогоняет тестовую программу `.out` (для проверки самого эмулятора) |
| `c6xdoom` | запускает порт Doom на эмуляторе |
| `c6xdis` | дизассемблер, сверка с `dis6x` |
| `aisinfo` | показывает, из чего состоит образ AIS |

## 3. Получить прошивку

Прошивка — это папка с четырьмя файлами: `129_main_OS.bin` (ОС), `133_data_133.bin`,
`136_bootloader.bin`, `137_file_system.bin` (эффекты и патчи).

Из апдейтера (стокового или CFW):

```bash
python -I tools/extract_updater.py "ZOOM MS-50G System v3.10 Updater.exe" run/ms50g
```

Если части уже есть отдельными файлами (как у MS-70CDR в внешнем репозитории с прошивкой),
переименуйте их: `Main.bin` → `129_main_OS.bin`, `FS.bin` → `137_file_system.bin`,
`Preset.bin` → `133_data_133.bin`, `boot.bin` → `136_bootloader.bin`.

## 4. Первый запуск

**Для стоковой MS-70CDR 2.10:** до play-экрана около 5–6 с с `-flashfast` и около 21 с без него. До появления play-экрана экран белый — это норма. Готовый рецепт для 70CDR приведён чуть ниже; пример с `-s 6` рассчитан на 50G 3.10.

```bash
mkdir -p run/try && cd run/try
../../build/c6xboot.exe ../ms50g/129_main_OS.bin -s 6 -q -sine 220 0.3
```

Пример рассчитан на рабочую папку `run/try`: оттуда путь к программе — `../../build/c6xboot.exe`. Если используете другую папку, поправьте относительный путь.

Готовый рецепт для MS-70CDR 2.10 (папка прошивки рядом, например `../fw70`):

```bash
../../build/c6xboot.exe ../fw70/129_main_OS.bin -s 8 -q -flashfast -snap 6000:play.png -press 7000:24 -snap 7600:menu.png
```

- `-s 6` — эмулировать 6 секунд работы педали (на ПК это около 25–40 секунд; на 70CDR с кэшем — примерно в 5–7 раз медленнее);
- `-q` — без дампа регистров в конце;
- `-sine 220 0.3` — на вход педали подаётся синус 220 Гц.

Что получится в текущей папке:

| Файл | Что это |
|---|---|
| `lcd.png` | экран педали в момент остановки (в 3 раза крупнее) |
| `out.wav` | звук с выхода педали, 44.1 кГц стерео |

`-snap МС:файл.png` делает снимок в заданную миллисекунду; `lcd.png` — это экран в момент остановки эмулятора.

В консоли — итоговая сводка. На что смотреть:

- `time=6.000s ... halted=0` — прошивка не упала (при падении будет `halted=1` и строка `ERROR`);
- `AUDIO: ... underruns=0` — звук шёл без опустошения буфера;
- `DSP load after 3 s` — две оценки загрузки: по IDLE-циклам (универсальная) и старая по PC (см. раздел 8).

## 5. Нажимать кнопки и крутить ручки

Все действия задаются заранее, по времени в миллисекундах от включения.

| Ключ | Что делает | Пример |
|---|---|---|
| `-press МС:ПИН` | короткое нажатие (120 мс) | `-press 4000:6` — кнопка на ноге 6 на 4-й секунде |
| `-press МС:ПИН:ДЛИТ` | нажатие заданной длины | `-press 4000:35:800` — держать футсвич 0.8 с |
| `-in МС:ПИН:0` с момента 0 | держать кнопку с включения | `-in 0:5:0 -in 0:7:0` — ноги 5 и 7, режим обновления |
| `-turn МС:A:B:ШАГИ` | повернуть ручку на ШАГИ щелчков (минус — против часовой); щелчок — полцикла квадратуры от текущего положения ног, как у ручек педали | `-turn 5000:26:28:-3` |
| `-in МС:ПИН:УРОВЕНЬ` | просто выставить уровень на ноге GPIO | `-in 3000:35:0` |
| `-snap МС:файл.png` | снимок экрана в этот момент | `-snap 4500:after.png` |

Номера ног подтверждены кодом загрузчика; на MS-70CDR проверены курсор, тип эффекта
и ручка 1:

| Орган | Нога GPIO |
|---|---|
| кнопки курсора | 4 / 6 |
| кнопки выбора типа эффекта | 5 / 7 |
| нажатие ручки 1 (MENU) / 2 (MEMORY) / 3 (страница) | 24 / 25 / 27 |
| ручка 1 / 2 / 3 (энкодер) | 17+30 / 18+29 / 26+28 |
| футсвич (вкл/выкл эффекта) | 35 |

Физическое направление кнопок курсора и типа эффекта на MS-70CDR не проверялось, поэтому
в примерах они задаются номерами ног, а не названиями «влево/вправо/вверх/вниз». При выводе
на педаль сверяйте результат по снимку экрана.

Все кнопки и футсвич активны низким уровнем: в покое на ноге 1, нажатие тянет её в 0
(так читает их загрузчик, и так же выглядит дамп регистров с педали). `-press` делает это
сам.

Пример: дождаться загрузки, открыть MENU, сделать снимок:

```bash
../../build/c6xboot.exe ../ms50g/129_main_OS.bin -s 6 -q -press 4500:24 -snap 5500:menu.png
```

Для 70CDR время 4500 мс слишком раннее. Сначала подтвердите play-экран снимком, затем нажимайте:

```bash
../../build/c6xboot.exe ../fw70/129_main_OS.bin -s 10 -q -flashfast -snap 6000:play.png -press 6500:24 -snap 7500:menu.png
```

## 6. USB: MIDI, SysEx, Effect Manager, перепрошивка

Ключ `-usb` подключает к педали «компьютер». Он ждёт, пока прошивка включит USB, сбрасывает
шину, проводит энумерацию (как Windows) и дальше обменивается USB-MIDI через bulk OUT 03 и
IN 84. Всё, что педаль отправила, печатается строками `MIDI ... <-` и пишется в `midi.txt`;
ход энумерации и дескрипторы — в `usb.txt`.

| Ключ | Что делает | Пример |
|---|---|---|
| `-usb` | подключить хост | |
| `-usbwav ФАЙЛ` | записать изохронный UAC IN в WAV 44,1 кГц / 16 бит / стерео (включает `-usb`) | `-usbwav uac.wav` |
| `-sysex МС:HEX` | отправить сообщение в момент МС (включает `-usb`) | `-sysex 4000:F07E000601F7` |
| `-midifile ФАЙЛ` | сценарий: строки `МС HEX` или `w HEX` (отправить после ответа педали) | см. ниже |
| `-saveflash ФАЙЛ` | сохранить флеш 4 МБ после прогона | `-saveflash after.bin` |

Сценарий запуска Effect Manager:

```
4000 F0 7E 00 06 01 F7      # Identity Request -> F0 7E 00 06 02 52 58 00 00 00 "3.10" F7
4030 F0 52 00 58 01 F7      # -> F0 52 00 58 00 0B F7 (обычный режим)
4100 F0 52 00 58 50 F7      # режим редактора
4200 F0 52 00 58 33 F7      # -> B0 00 00, B0 20 00, C0 <патч>
4400 F0 52 00 58 29 F7      # -> F0 52 00 58 28 + текущий патч (146 байт)
```

`w HEX` отправляет команду только после ответа педали на предыдущую строку.
Поэтому команда перед `w` должна этот ответ давать: `01` и `29` отвечают,
а `50` (режим редактора) — нет. После `50` укажите явное время.

`C0 05` переключает патч, патч из `28 ...` записывается в педаль. В режиме редактора поворот
ручки даёт `F0 52 00 58 31 ...`. Байт модели: 0x58 — MS-50G, 0x61 — MS-70CDR.

Записи с настоящей педали (USBPcap, `.pcapng`) превращаются в сценарий утилитой:

```bash
python -I tools/pcap2midi.py "recording.pcapng" em.txt --from f052005850 --to f052005851
```

### Перепрошивка без педали

Загрузчик (`136_bootloader.bin`) запускается так же, как ОС. Если держать ноги 5 и 7,
он входит в режим обновления (экран FIRMWARE UPDATE, Identity отвечает «1.10»). Дальше
сценарий апдейтера пишет флеш эмулятора, а `-saveflash` сохраняет результат:

```bash
python -I tools/pcap2midi.py "update.pcapng" upd.txt --from f05200580a --to f052005804 --wait
build/c6xboot.exe run/start/136_bootloader.bin -s 11 -q -nocache -in 0:5:0 -in 0:7:0 -midifile upd.txt -saveflash after.bin
```

Так проверено: флеш с пользовательской прошивкой после повтора записанного обновления совпал с образом из
записи байт-в-байт (ОС 0x40000–0xF0000 и логотип 0x3FD000–0x400000), загрузчик не тронут.
Так можно прогнать свою CFW через настоящий загрузчик и настоящий протокол, прежде чем
шить педаль.

## 7. Проверить свою CFW

1. Соберите апдейтер CFW как обычно.
2. Достаньте из него части: `python -I tools/extract_updater.py MyCFW.exe run/mycfw`.
3. Запустите и сделайте снимки нужных экранов (`-snap`), послушайте `out.wav`.
4. Сравните экран со снимком с педали. Ключ `-fb кадр.bin` сохраняет последний кадр
   в формате 1024 байта, 8 страниц по 128 колонок, бит 0 — верхний пиксель.

```bash
../../build/c6xboot.exe ../mycfw/129_main_OS.bin -s 6 -q -press 4500:24 -fb menu.bin
```

Если прошивка упала (`halted=1`), в строке `ERROR` будет адрес. Дальше — раздел 10.

## 8. Проверить эффект ZDL

Стенд `c6xzdl` предназначен для эффектов, у которых есть исходник на C: эффект
собирается компилятором TI, загружается в эмулятор и вызывается аудиофункцией
по блокам по 8 сэмплов. На вход подаётся WAV 44.1 кГц, на выходе — сырые float32
и строка оценки нагрузки DSP. Стоковые эффекты Zoom обращаются к функциям ОС
и в автономном стенде не запускаются — для них используется полный прогон
прошивки через `c6xboot`.

Конкретные команды запуска и значения ручек смотрите в справке: `c6xzdl -h`.
Для поиска лишних записей в буфер вывода используйте
`--stwtrace ФАЙЛ[,АДР:ДЛИНА]`: лог разделяет `left i` и `right i`, по умолчанию
смотрит окно `11F04100:40`. Для сравнения размещения кода добавлен `--text-base HEX`: значение `C0400000`
используется по умолчанию, а `11E00000` загружает код в L1P SRAM и включает
L1PCFG=0. При таком сравнении `out.f32` должен остаться побайтно равным, а
изменяется только стоимость выборок кода.

### Режимы памяти (`--cache`)

На педали эффект работает не один: между его вызовами выполняются другие эффекты и ОС и
вытесняют его код и данные из кэша. Поэтому нагрузка зависит от режима:

| Режим | Что моделирует | Когда смотреть |
|---|---|---|
| `l1cold` (по умолчанию) | L1 перед каждым блоком пуст, L2 тёплый | обычная цепочка из нескольких эффектов, основная оценка |
| `warm` | эффект один, кэш тёплый | нижняя граница |
| `cold` | пусты и L1, и L2 | верхняя граница, худший случай |
| `off` | память без задержек (как было раньше) | сравнение с ПК, отладка |

Смотрите на разницу между режимами, а не на абсолютные проценты — числа зависят
от конкретного эффекта. Для стоковых эффектов, которые требуют ОС, используйте
полный прогон прошивки через `c6xboot`.

`max` в первом блоке всегда большой: код ещё не загружен ни в один кэш.

## 9. Нагрузка всей педали и разгон

`c6xboot` по умолчанию учитывает кэш и задержки SDRAM. Сводка `CACHE:` показывает
промахи и сколько тактов процессор простоял.

| Ключ | Что делает |
|---|---|
| `-nocache` | память без задержек (быстрее, для поиска логических ошибок) |
| `-emif МГЦ` | частота SDRAM вместо вычисленной из PLL0 / CFGCHIP3 (сток 133.3 = VCO 600 / 4.5) |
| `-flashfast` | запись и стирание флеша без задержки (по умолчанию — типичное время чипа) |
| `-mhz МГЦ` | частота ядра; без ключа берётся из настройки PLL в прошивке |

При старте эмулятор печатает часы и тайминги SDRAM и предупреждает, если что-то вне паспорта:

```
CLOCKS: VCO 600.0 MHz, core 300.0 MHz, SDRAM 133.3 MHz (VCO/4.5)
SDRAM: CL3 tRCD 22.5 tRP 22.5 tRC 67.5 tRAS 52.5 tRFC 67.5 tWR 15.0 tRRD 15.0 ns, refresh 15.59 us
```

Разгон делается правкой команд AIS в образе ОС — сразу PLL, источника такта SDRAM и
регенерации (`set_pll.py` меняет только PLL и оставляет память вне паспорта):

```bash
python -I tools/overclock.py run/cdr/129_main_OS.bin run/oc360/129_main_OS.bin --core 360
```

(в `run/oc360` скопируйте и остальные три части). Эмулятор покажет, работает ли прошивка
на новой частоте и какая загрузка. Он **не** покажет, выдержит ли кристалл и SDRAM на
реальной плате — это проверяется только на педали.

Печатаются две оценки. Основная — `IDLE cycles; firmware-independent`: доля циклов,
в которых процессор выполнял `IDLE` без ожидающих прерываний; она не привязана к
адресам конкретной прошивки. Строка `PC samples` оставлена для совместимости: она
считается по адресам простоя ОС MS-50G 3.10 и для других прошивок может расходиться.
Для полной картины смотрите также `CACHE: ... stall` и нагрузку ZDL.

Ключ `-audioload` даёт отдельную цифру именно для обработки звука. Он считает
циклы внутри L2-диспетчера ZDL: на 70CDR вызов аудиофункции идёт по `0x1181BE28`,
возврат — на `0x1181BE26`. В сводке печатается доля не-idle циклов после 3 с,
число вызовов и разбивка по адресам аудиофункций. Адрес `0x1181BEC0` — пустая
заглушка для выключенного слота: её процент показывает накладные расходы самого
диспетчера, а не полезную обработку эффекта.

## 10. Отладка

| Ключ | Что делает | Куда пишет |
|---|---|---|
| `-t ТАКТ [-tl N]` | трасса команд и записей в регистры с такта ТАКТ, N тактов | `trace.txt` |
| `-b АДРЕС` | остановиться, когда выполнение дойдёт до адреса | сводка в консоли |
| `-p АДРЕС` | зонд: A4, B4, A6, B6, B3 при каждом входе в адрес; **останавливает прогон** при попадании | `probe.txt` |
| `-call АДРЕС` | логировать вход в функцию с адресом возврата и A4/B4, **не останавливая прогон** | `call_log.txt` |
| `-m` | все записи в регистры периферии с адресом команды | `mmio.txt` |
| `-w LO HI` | чтения периферии в диапазоне адресов | `mmio.txt` |
| `-ww LO HI ТАКТ` | все записи в память в диапазоне с такта ТАКТ | `ww.txt` |
| `-dump АДРЕС ДЛИНА` | показать память в конце | консоль |
| `-stack АДР` | задать `B15` сразу после AIS JumpClose; например `C00F7000` для bootmini DU6 | консоль |
| `-cachejump` | инвалидация L1D, L2 и L1P сразу после JumpClose включена по умолчанию; `-no-cachejump` отключает | консоль |
| `-bootflash` | взять AIS из собранной 4 МБ флеши по `0x40000`, а не из аргумента; ближе к пути BIN/136 | консоль |
| `-hwclose` | hardware-close старт включён по умолчанию: останов без записи SPIFMT0/1, диагностический порог LCD SPI 25 МГц, synthetic native IRQ residue без `DINT`, учёт остаточной периферии boot ROM; `-no-hwclose` отключает. Порог эмулятора, не измеренный предел железа | stderr |
| `-hwlcdlimit МГЦ` | переопределить диагностический порог LCD SPI для `-hwclose`; по умолчанию 25 МГц | stderr |
| устаревшие вызовы до `v1.1` | `-usbtrace`, `-usblog`, `-midilog`, `-cachelogall`, `-hwclose=0/1`: печатают справку, текущую версию `v1.1` и подсказку по замене вместо ошибки | stderr |
| `-muxstrict` | учитывать владельца CS через PINMUX7: LCD требует mux 8, flash — 0/1; блокированные слова считаются. Рекомендуется для всех bare-metal прогонов | stdout |
| `-muxhalt` | то же, что `-muxstrict`, плюс fatal при LCD-записи с неправильным mux; быстро ловит firmware, который не вернул LCD mux после flash_read | stdout |
| `-flashfault wp,wip,rx,long,mux` | опциональные отказы SPI flash: `wp` игнорирует WREN, `wip` не сбрасывает WIP, `rx` не готовит SPIBUF RX, `long` возвращает FF в длинном чтении, `mux` блокирует flash-слово при чужом CS/mux; по умолчанию выключено | stdout |
| `-romrepaint МС` | период синтетической перерисовки boot-лого при `-hwclose`; диагностический параметр, не hardware-факт | stderr |
| `-bootlog` | ловить bootmini-чекпоинты по однородным LCD-кадрам и логировать копирование FWIMG | `boot_log.txt` |
| `-otacheck ФАЙЛ A/B` | сравнить содержимое слота A/B с FWIMG после прогона OTA | stdout |
| без `-q` | регистры CPU, 20 самых «горячих» адресов, обращения к периферии | консоль |

### Новые диагностические ключи

| Ключ | Что делает | Куда пишет |
|---|---|---|
| `-cachelog [T1:T2]` | задержки кэша и попадания EDMA в кэшированную строку | `cache_log.txt` |
| `-cachepen P1:P2:P3:P4` | переопределить штрафы L1D/L2/SDRAM; для CFW 5.38 на 408 МГц — `5:3:385:40` | stderr |
| `-dma` | каждая EDMA-передача: такт, канал, SRC/DST, размер | `dma_log.txt` |
| `-spi` | каждое слово SPI0: устройство, PC, формат, фактический SCK | `spi_log.txt` |
| `-flashlog` | реальные записи/стирания SPI flash: такт, `fl_addr`, `fl_cmd`, `fl_writes`, адрес/байт записи или диапазон стирания; позволяет отличить перезапись `FW_META` от stale-чтения bootmini | `flash_log.txt` |
| `-stwtrace ФАЙЛ[,АДР:ДЛИНА]` | каждая инструкция `STW` в окне буфера вывода: такт, PC, `left i` или `right i`, адрес, регистр-источник, значение и float; по умолчанию `11F04100:40` | указанный файл |
| `-staleicode [АДР:ДЛИНА]` | выборка команд из региона исполняемого кода возвращает старые байты после загрузки до инвалидации L1P/L2; включено по умолчанию, `-no-staleicode` отключает | stdout |
| `-spilimit LCD:FLASH` | два предела в МГц через двоеточие, например `1:50`; `0` выключает проверку. Рекомендуется явно задавать `1:50`: при 408 МГц со стоковыми делителями флеш SPI0 может получить 68 МГц, а по умолчанию эмулятор не считает это отказом | stderr |
| `-gpiolog` | все изменения ног GPIO со временем и PC | `gpio_log.txt` |
| `-prof T1:T2` | гистограмма PC только в окне времени | stdout |
| `-audioload` | доля не-idle циклов в аудио-диспетчере L2 и разбивка по адресам аудиофункций | stdout |
| `-watch АДР:ЗНАЧ` | дождаться значения 32-битного слова и продолжить | stdout |
| `-mmiohist` | топ адресов MMIO по `mmio.txt` (нужен `-m`) | stdout |
| `-loadflash ФАЙЛ` | загрузить сохранённый 4 МБ образ флеша | stderr |
| `-spi1fast` | старая модель SPI1 без задержки слова, бит-в-бит со старым эмулятором | — |

`usb.txt` и `midi.txt` пишутся всегда, отдельного ключа для них нет. В `midi.txt`
`->` — команда ПК → педаль, `<-` — ответ педали → ПК, включая SysEx.
SysEx подавайте после готовности USB, например `-usb -sysex 4000:F052005850F7`.
Для MS-70CDR байт модели `61`; чтобы получить ответ от железа:
`-usb -sysex 5000:F052006101F7 -sysex 7000:F052006150F7 -sysex 9000:F052006129F7`.
В `midi.txt` появится `-> F0 52 00 61 29 F7` и `<- F0 52 00 61 28 ... F7` с текущим патчем.

Не запускайте несколько `c6xboot` в одной рабочей папке: `probe.txt`, `call_log.txt`, `ww.txt` и другие логи открываются с начала и перезаписываются. Если сессию прервали, проверьте `Get-Process c6xboot` — оставшийся процесс продолжает держать файл, и следующий прогон может показать старое или пустое содержимое. Для параллельных проверок используйте отдельные папки.

Такты везде одни и те же: время эмуляции × частоту ядра, вместе с простоями памяти.
Частота ядра 300 МГц, поэтому 1 секунда — это 300 000 000 тактов.

Типичный порядок поиска падения:

1. Запустить без `-q`, узнать такт и адрес падения из сводки.
2. Повторить с `-t <такт − 500000> -tl 600000` и прочитать конец `trace.txt`.
3. Если испорчена память (например, стек), найти, кто её пишет: `-ww LO HI ТАКТ`.
4. Сравнить с дизассемблером прошивки (листинг ОС, полученный из апдейтера или
   из внешнего репозитория с прошивкой).

Если прошивка падает только с кэшем, а с `-nocache` работает, — это почти наверняка гонка
в эмуляторе, а не в прошивке: присылайте трассу.

## 11. Батарея

Батарею меряет внешний 8-битный АЦП на SPI1 (выбор кристалла — нога GPIO 42). Показание
задаётся ключом `-adc N` (0..255, по умолчанию 240 — питание от адаптера).

Как прошивка MS-50G 3.10 переводит показание в уровень (функции `0xC00DB6E0` и `0xC00D7828`):

| Показание АЦП | Уровень |
|---|---|
| 154 и больше | 5 — внешнее питание |
| 100–153 | 4 |
| 88–99 | 3 |
| 77–87 | 2 |
| 73–76 | 1 |
| 72 и меньше | 0 — окно «Low Battery!» при следующем действии в интерфейсе |

Это пороги для типа батареи 0 (стоит по умолчанию, по-видимому Alkaline), при движении вниз; вверх уровень растёт с
гистерезисом (77, 88, 100, 112). Для типа 1 (Ni-MH) пороги свои: 87, 90, 95, 97. Последнее
показание лежит байтом в `0xC00EFD32`, уровень — словом в `0xC00EFED4` (адреса MS-50G 3.10):
CFW может читать их оттуда, не трогая SPI1.

## 12. Чего эмулятор пока не умеет

- USB моделирует full-speed устройство и сценарный хост. Есть OUT data stage с ожиданием
  `SERV_RXPKTRDY`, UAC `GET_CUR`/`SET_CUR`, изохронный IN и запись потока через `-usbwav`.
  Нет полноценного host-режима USB и полной обработки всех UAC class requests со стороны
  прошивки. Запись во флеш мгновенная, поэтому обновление идёт быстрее, чем на педали
  (6 с против 24).
- Задержки кэша и SDRAM откалиброваны по железу на CFW 5.38 при 408 МГц
  (`-cachepen 5:3:385:40`, L2 и SDRAM в пределах 1–3% от педали). Для других частот
  и прошивок штрафы пересчитывать; смотрите на разницу между вариантами, а не на
  последний процент.
- Устаревание кэша перед DMA проверено на CFW 5.38: за 8 с и 1,4 млн EDMA-передач
  счётчик `n_dma_snoop` дал 0 попаданий в кэшированные строки L1D, то есть в текущей
  нагрузке эффект не проявляется. Данные в модели всегда свежие; при появлении CFW
  с EDMA в L2 SRAM счётчик сработает сразу.
- Изменения флеша (сохранённые патчи) живут только до выхода из программы.


## 13. Если что-то не работает

| Симптом | Что проверить |
|---|---|
| `lcd.png` и все `-snap` белые | В сводке смотрите строку `LCD: cmds=... data=...`. Если `cmds=0`, прошивка ещё не инициализировала экран: увеличьте `-s`, добавьте `-flashfast`, сдвиньте `-snap` позже. Белый экран во время загрузки — норма. |
| `-snap` в момент `-s` не создаётся | Снимки пишутся только внутри прогона. Ставьте `-snap` строго раньше времени остановки; последний кадр всегда доступен как `lcd.png`. |
| Нужно поймать момент смены экрана в незнакомой прошивке | Сделайте серию `-snap` с шагом 1–3 с, а вокруг перехода — 50–100 мс, с `-flashfast`. Сверяйте строку `LCD: cmds=... data=...` и склеивайте кадры через `python -I tools/montage.py out.png 3 s1.png s2.png ...`. |
| Старт занимает слишком долго | Добавьте `-flashfast`: без него запись и стирание флеша могут занять значительную часть прогона. В сводке смотрите строку `FLASH: ... program/erase`. |
| `sh` или `zig` не находятся в PATH | Запустите Git Bash полным путём, например `& "C:\Program Files\Git\bin\sh.exe" -c "cd '<папка>' && ZIG=/c/.../zig.exe sh build.sh"`, либо выполните команды `zig cc` из `build.sh` вручную. |
| `-press` не меняет экран | Эмулятор лишь выставляет уровень на GPIO; смысл нажатия определяет прошивка и текущий экран. Сначала снимком подтвердите нужный экран, затем повторите нажатие. Для стоковой 70CDR play-экран появляется примерно на 5–6 с с `-flashfast` и около 21 с без него. |
| Все снимки одинаковые | Если они пустые — см. строку выше. Если не пустые, но одинаковые — проверьте, что `-press` был после play-экрана и что прогон дошёл до конца `-s`: `halted=0`, `time=` равно запрошенному времени. |
| `load failed: -h` | У `c6xboot` нет ключа `-h`. Полный список ключей — в README, раздел «Диагностические опции», и в HOWTO, разделы 5, 9 и 10. |
| `flash: missing ...` | Части прошивки должны лежать рядом и называться `129_main_OS.bin`, `133_data_133.bin`, `136_bootloader.bin`, `137_file_system.bin`. |
| Эффект даёт тишину в `c6xzdl` | Для эффектов, которым нужна инициализация прошивкой, используйте `c6xboot` с полной прошивкой: ОС сама вызывает `_init`. Автономный `c6xzdl` этой инициализации не делает, поэтому его тишина не означает, что эффект не работает. |
| `halted=1`, `ERROR` | Это краш, а не «ограничение эмулятора». Остановитесь и доложите. Для диагностики не используйте `-q`: он убирает `hot PCs`. Если в строке есть `indirect branch from ... to ...`, это переход по нулевому/мусорному указателю; адрес перехода показан. |
| `AUDIO: frames=0`, `DSP load after 3 s: 100.0%` на ранней стадии загрузки | При `halted=0` и без `ERROR` это может быть нормальная стадия старта, особенно без `-flashfast`. Крашом считайте `halted=1` или `ERROR`. |
| Кнопка «не удержалась» | `-press` по умолчанию держит 120 мс. Для удержания укажите длительность явно: `-press 4500:24:500`. |
| Не могу найти логи | Все лог-файлы создаются в текущей рабочей директории, откуда запущен `c6xboot.exe`. Для проверки экрана есть ключ `-lcdlog` → `lcdlog.txt`. |
| Путь `../../build/...` не находится | Примеры HOWTO рассчитаны на папку `run/try`. Из другой папки путь к `build/c6xboot.exe` другой — поправьте его. |
| В PowerShell строки `DSP clock`, `CLOCKS`, `CACHE` красные | Это вывод в stderr, а не ошибка. Главный признак успеха — `halted=0` в итоговой сводке. |

Стоковая прошивка между событиями действительно проводит время в idle-путах — это нормально. Нажатие кнопки **после play-экрана** меняет экран; если этого не происходит, сначала проверьте тайминг, а не делайте вывод, что UI не работает.


---

# English version

# How to use the c6x emulator

A step-by-step guide for someone seeing the emulator for the first time.
Details of the design and accuracy are in [README.md](README.md) (English
section at the end).

The emulator runs the firmware of Zoom MultiStomp pedals (MS-50G, MS-70CDR
and their custom builds) on a PC, plus individual ZDL effects. The pedal is
not needed and nothing is written to it: the flash is emulated in PC memory
and disappears when the program exits.

## 1. What you need

| What | Why | Where to get it |
|---|---|---|
| zig 0.11 or newer | C compiler to build the emulator | ziglang.org, unpack anywhere |
| Git Bash (Windows) or any sh | to run `build.sh` and the examples | comes with Git for Windows |
| Python 3.10+ | utilities in `tools/` | python.org |
| a Zoom firmware updater (`.exe`) or firmware parts | what we are going to run | Zoom website or your own custom build |

## 2. Build

```bash
# Run from the repository root: build.sh is at the top level.
sh build.sh
```

If zig is not in `PATH`, specify it explicitly, for example `ZIG=/path/to/zig.exe sh build.sh`.
The programs appear in `build/`:

| Program | What it does |
|---|---|
| `c6xboot` | runs the whole firmware: LCD, buttons, audio, flash |
| `c6xzdl` | runs a single ZDL effect on an audio file, measures load |
| `c6xtest` | runs a test `.out` program (checks the emulator itself) |
| `c6xdoom` | runs the Doom port on the emulator |
| `c6xdis` | disassembler, cross-check against `dis6x` |
| `aisinfo` | shows what an AIS image consists of |

## 3. Get a firmware

A firmware is a folder with four files: `129_main_OS.bin` (OS),
`133_data_133.bin`, `136_bootloader.bin`, `137_file_system.bin` (effects and
patches).

From an updater (stock or custom):

```bash
python -I tools/extract_updater.py "ZOOM MS-50G System v3.10 Updater.exe" run/ms50g
```

If the parts already exist as separate files, rename them: `Main.bin` →
`129_main_OS.bin`, `FS.bin` → `137_file_system.bin`, `Preset.bin` →
`133_data_133.bin`, `boot.bin` → `136_bootloader.bin`.

## 4. First run

**For stock MS-70CDR 2.10:** the Play screen appears at about 5–6 s with `-flashfast` and about 21 s without it. The screen is blank white until then — this is normal. A ready recipe for 70CDR is just below; the `-s 6` example is for 50G 3.10.

```bash
mkdir -p run/try && cd run/try
../../build/c6xboot.exe ../ms50g/129_main_OS.bin -s 6 -q -sine 220 0.3
```

The example assumes the `run/try` working directory: from there the program is at `../../build/c6xboot.exe`. If you use a different folder, adjust the relative path.

Ready-made recipe for MS-70CDR 2.10 (firmware parts together in a folder such as `../fw70`):

```bash
../../build/c6xboot.exe ../fw70/129_main_OS.bin -s 8 -q -flashfast -snap 6000:play.png -press 7000:24 -snap 7600:menu.png
```

- `-s 6` — emulate 6 seconds of pedal operation (about 25–40 seconds on a PC; on 70CDR with cache, about 5–7 times slower);
- `-q` — no register dump at the end;
- `-sine 220 0.3` — feed a 220 Hz sine into the pedal input.

Files in the current folder:

| File | What it is |
|---|---|
| `lcd.png` | the pedal screen at the stop moment (3x larger) |
| `out.wav` | audio from the pedal output, 44.1 kHz stereo |

`-snap MS:file.png` takes a snapshot at the given millisecond; `lcd.png` is the screen at the moment the emulator stops.

The console prints a final summary. What to look at:

- `time=6.000s ... halted=0` — the firmware did not crash (`halted=1` plus an
  `ERROR` line means it did);
- `AUDIO: ... underruns=0` — audio ran without buffer underruns;
- `DSP load after 3 s` — two estimates: IDLE-cycle based (firmware-independent) and the legacy PC-sample one (see §8).

## 5. Press buttons and turn knobs

All actions are scheduled in advance, in milliseconds from power-on.

| Option | What it does | Example |
|---|---|---|
| `-press MS:PIN` | short press (120 ms) | `-press 4000:6` — button on pin 6 at second 4 |
| `-press MS:PIN:DURATION` | press of given length | `-press 4000:35:800` — hold footswitch 0.8 s |
| `-in MS:PIN:0` from moment 0 | hold a button from startup | `-in 0:5:0 -in 0:7:0` — pins 5 and 7, update mode |
| `-turn MS:A:B:STEPS` | turn a knob by STEPS clicks (minus = counter-clockwise); one click is half a quadrature cycle from the current pin state | `-turn 5000:26:28:-3` |
| `-in MS:PIN:LEVEL` | just set a GPIO pin level | `-in 3000:35:0` |
| `-snap MS:file.png` | screen snapshot at that moment | `-snap 4500:after.png` |

Pin numbers are confirmed by the bootloader code; on MS-70CDR the cursor,
effect type and knob 1 were checked:

| Control | GPIO pin |
|---|---|
| cursor buttons | 4 / 6 |
| effect-type buttons | 5 / 7 |
| knob 1 (MENU) / 2 (MEMORY) / 3 (page) press | 24 / 25 / 27 |
| knob 1 / 2 / 3 (encoder) | 17+30 / 18+29 / 26+28 |
| footswitch (effect on/off) | 35 |

Physical directions of the cursor and effect-type buttons on MS-70CDR were not
verified, so the examples use pin numbers rather than "left/right/up/down".
When outputting to the pedal, check the result against a screen snapshot.

All buttons and the footswitch are active low: idle is 1 on the pin, pressing
pulls it to 0. `-press` does this automatically.

Example: wait for boot, open MENU, make a snapshot:

```bash
../../build/c6xboot.exe ../ms50g/129_main_OS.bin -s 6 -q -press 4500:24 -snap 5500:menu.png
```

For 70CDR, 4500 ms is too early. Confirm the Play screen with a snapshot first, then press:

```bash
../../build/c6xboot.exe ../fw70/129_main_OS.bin -s 10 -q -flashfast -snap 6000:play.png -press 6500:24 -snap 7500:menu.png
```

## 6. USB: MIDI, SysEx, Effect Manager, re-flashing

`-usb` connects a "computer" to the pedal. It waits until the firmware enables
USB, resets the bus, performs enumeration (like Windows), then exchanges
USB-MIDI over bulk OUT 03 and IN 84. Everything the pedal sends is printed as
`MIDI ... <-` and written to `midi.txt`; enumeration and descriptors go to
`usb.txt`.

| Option | What it does | Example |
|---|---|---|
| `-usb` | connect the host | |
| `-usbwav FILE` | capture UAC isochronous IN to WAV (44.1 kHz, 16-bit stereo; implies `-usb`) | `-usbwav uac.wav` |
| `-sysex MS:HEX` | send a message at MS (implies `-usb`) | `-sysex 4000:F07E000601F7` |
| `-midifile FILE` | script: lines `MS HEX` or `w HEX` (send after pedal reply) | see below |
| `-saveflash FILE` | save the 4 MB flash after the run | `-saveflash after.bin` |

An Effect Manager session script:

```
4000 F0 7E 00 06 01 F7      # Identity Request -> F0 7E 00 06 02 52 58 00 00 00 "3.10" F7
4030 F0 52 00 58 01 F7      # -> F0 52 00 58 00 0B F7 (normal mode)
4100 F0 52 00 58 50 F7      # editor mode
4200 F0 52 00 58 33 F7      # -> B0 00 00, B0 20 00, C0 <patch>
4400 F0 52 00 58 29 F7      # -> F0 52 00 58 28 + current patch (146 bytes)
```

`w HEX` sends its command only after the pedal replies to the previous line.
The preceding command must produce a reply: `01` and `29` do, while `50`
(editor mode) does not. Give `50` an explicit time instead of `w`.

`C0 05` switches the patch, a patch from `28 ...` is written into the pedal.
In editor mode turning a knob gives `F0 52 00 58 31 ...`. Model byte: 0x58 —
MS-50G, 0x61 — MS-70CDR.

Recordings from a real pedal (USBPcap, `.pcapng`) are converted into a script:

```bash
python -I tools/pcap2midi.py "recording.pcapng" em.txt --from f052005850 --to f052005851
```

### Re-flashing without a pedal

The bootloader (`136_bootloader.bin`) starts just like the OS. Holding
pins 5 and 7 enters update mode (FIRMWARE UPDATE screen, Identity answers
"1.10"). Then an updater script writes the emulator flash, and `-saveflash`
saves the result:

```bash
python -I tools/pcap2midi.py "update.pcapng" upd.txt --from f05200580a --to f052005804 --wait
build/c6xboot.exe run/start/136_bootloader.bin -s 11 -q -nocache -in 0:5:0 -in 0:7:0 -midifile upd.txt -saveflash after.bin
```

Verified: the flash of a custom firmware after replaying a recorded update
matches the recorded image byte for byte (OS 0x40000–0xF0000 and logo
0x3FD000–0x400000), the bootloader is untouched. This lets you run your own
CFW through the real bootloader and real protocol before flashing the pedal.

## 7. Check your own CFW

1. Build the CFW updater as usual.
2. Extract the parts: `python -I tools/extract_updater.py MyCFW.exe run/mycfw`.
3. Run it and make the screen snapshots you need (`-snap`), listen to `out.wav`.
4. Compare the screen with a pedal snapshot. The `-fb frame.bin` option saves
   the last frame: 1024 bytes, 8 pages of 128 columns, bit 0 is the top pixel.

```bash
../../build/c6xboot.exe ../mycfw/129_main_OS.bin -s 6 -q -press 4500:24 -fb menu.bin
```

If the firmware crashes (`halted=1`), the `ERROR` line contains an address.
Then see §10.

## 8. Check a ZDL effect

The `c6xzdl` bench is intended for effects that have a C source: the effect is
compiled by the TI compiler, loaded into the emulator and called block by
block, 8 samples per block. Input is a 44.1 kHz WAV, output is raw float32
plus a DSP load estimate. Stock Zoom effects call OS functions and do not run
in the standalone bench — use a full firmware run through `c6xboot` for them.

Command details and knob values are in the built-in help: `c6xzdl -h`.
To find unwanted writes into the output buffer, use
`--stwtrace FILE[,ADDR:LEN]`: the log separates `left i` from `right i` and
watches the `11F04100:40` window by default. To compare code placement, use `--text-base HEX`: the default is `C0400000`,
while `11E00000` loads code into L1P SRAM and sets L1PCFG=0. In such a comparison
`out.f32` must stay bit-identical; only the cost of instruction fetches changes.

### Memory modes (`--cache`)

On the pedal an effect is not alone: other effects and the OS run between its
calls and evict its code and data from the cache. Load therefore depends on
the mode:

| Mode | What it models | When to look |
|---|---|---|
| `l1cold` (default) | L1 emptied before each block, L2 warm | a normal chain of several effects, main estimate |
| `warm` | one effect, warm cache | lower bound |
| `cold` | both L1 and L2 empty | upper bound, worst case |
| `off` | memory without delays (as before) | comparison with the PC, debugging |

Look at the difference between modes, not at absolute percentages — numbers
depend on the effect. For stock effects that need the OS, use a full firmware
run through `c6xboot`.

## 9. Whole-pedal load and overclocking

`c6xboot` accounts for cache and SDRAM delays by default. The `CACHE:` summary
shows misses and how many cycles the CPU stalled.

| Option | What it does |
|---|---|
| `-nocache` | memory without delays (faster, for finding logic bugs) |
| `-emif MHZ` | SDRAM frequency instead of the one computed from PLL0 / CFGCHIP3 (stock 133.3 = VCO 600 / 4.5) |
| `-flashfast` | flash program/erase without delay (by default — typical chip time) |
| `-mhz MHZ` | core frequency; without the option it is taken from the PLL setup in the firmware |

At startup the emulator prints the clocks and SDRAM timings and warns if
something is out of spec.

Overclocking is done by patching AIS commands in the OS image — PLL, SDRAM
clock source and refresh together (`set_pll.py` patches only the PLL and leaves
the memory out of spec). The emulator shows whether the firmware works at the
new frequency and what the load is. It does **not** show whether the chip and
SDRAM survive on a real board — that is hardware-only.

Two estimates are printed. The main one is `IDLE cycles; firmware-independent`:
the share of cycles in which the CPU executed `IDLE` with no pending interrupts;
it is not tied to any firmware addresses. The `PC samples` line is kept for
compatibility: it uses MS-50G 3.10 idle addresses and may differ for other
firmwares. For the full picture, check `CACHE: ... stall` and the ZDL load too.

The `-audioload` option gives a separate number for audio processing itself. It
counts cycles inside the L2 ZDL dispatcher: on 70CDR the audio function is called
at `0x1181BE28` and returns to `0x1181BE26`. The summary prints the non-idle
cycle share after 3 s, the call count and a breakdown by audio function address.
Address `0x1181BEC0` is the empty-slot stub: its percentage is dispatcher
overhead, not useful effect work.

## 10. Debugging

| Option | What it does | Where it writes |
|---|---|---|
| `-t CYCLE [-tl N]` | instruction and register-write trace from CYCLE, N cycles | `trace.txt` |
| `-b ADDR` | stop when execution reaches ADDR | summary on console |
| `-p ADDR` | probe: A4, B4, A6, B6, B3 on every entry to ADDR; **stops the run** on a hit | `probe.txt` |
| `-call ADDR` | log entries into a function with return address and A4/B4, **without stopping** | `call_log.txt` |
| `-m` | all peripheral register writes with the instruction address | `mmio.txt` |
| `-w LO HI` | peripheral reads in an address range | `mmio.txt` |
| `-ww LO HI CYCLE` | all memory writes in a range from CYCLE | `ww.txt` |
| `-dump ADDR LEN` | show memory at the end | console |
| `-stack ADDR` | set `B15` right after AIS JumpClose, e.g. `C00F7000` for DU6 bootmini | console |
| `-cachejump` | L1D, L2 and L1P invalidation right after JumpClose is on by default; `-no-cachejump` disables it | console |
| `-bootflash` | parse AIS from the assembled 4 MB flash at `0x40000` instead of the argument file; closer to the BIN/136 path | console |
| `-hwclose` | hardware-close start is on by default: stop without SPIFMT0/1 writes, diagnostic 25 MHz LCD SPI threshold, synthetic native IRQ residue without `DINT`, model boot-ROM peripheral residue; `-no-hwclose` disables it. This is an emulator threshold, not a measured hardware limit | stderr |
| `-hwlcdlimit MHZ` | override the diagnostic LCD SPI threshold for `-hwclose`; default 25 MHz | stderr |
| `-romrepaint MS` | synthetic boot-logo repaint period for `-hwclose`; diagnostic parameter, not a hardware fact | stderr |
| `-bootlog` | capture bootmini checkpoints from uniform LCD frames and log FWIMG copy writes | `boot_log.txt` |
| `-otacheck FILE A/B` | compare the A/B flash slot with the FWIMG after the run | stdout |
| without `-q` | CPU registers, 20 hottest addresses, peripheral accesses | console |

### New diagnostic options

| Option | What it does | Where it writes |
|---|---|---|
| `-cachelog [T1:T2]` | cache stalls and EDMA hits on a cached line | `cache_log.txt` |
| `-cachepen P1:P2:P3:P4` | override L1D/L2/SDRAM penalties; for CFW 5.38 at 408 MHz — `5:3:385:40` | stderr |
| `-dma` | every EDMA transfer: cycle, channel, SRC/DST, size | `dma_log.txt` |
| `-spi` | every SPI0 word: device, PC, format, actual SCK | `spi_log.txt` |
| `-flashlog` | real SPI flash program/erase transactions: cycle, `fl_addr`, `fl_cmd`, `fl_writes`, written address/byte or erase range; distinguishes an actual `FW_META` rewrite from stale bootmini reads | `flash_log.txt` |
| `-stwtrace FILE[,ADDR:LEN]` | each `STW` in the output-buffer window: cycle, PC, `left i` or `right i`, address, source register, value and float; default `11F04100:40` | chosen file |
| `-staleicode [ADDR:LEN]` | instruction fetch from the loaded-code region returns pre-copy bytes until an L1P/L2 invalidate; on by default, `-no-staleicode` disables it | stdout |
| `-spilimit LCD:FLASH` | two MHz limits separated by a colon, e.g. `1:50`; `0` disables the check. Recommended explicitly: at 408 MHz with stock dividers SPI0 flash can reach 68 MHz, while the emulator does not treat this as a failure by default | stderr |
| `-gpiolog` | all GPIO pin changes with time and PC | `gpio_log.txt` |
| `-prof T1:T2` | PC histogram only inside a time window | stdout |
| `-audioload` | non-idle cycle share inside the L2 audio dispatcher, split by audio function address | stdout |
| `-watch ADDR:VALUE` | wait until a 32-bit word equals VALUE, then continue | stdout |
| `-mmiohist` | top MMIO addresses from `mmio.txt` (needs `-m`) | stdout |
| `-loadflash FILE` | load a saved 4 MB flash image | stderr |
| `-spi1fast` | old SPI1 model without word delay, bit-exact with the old emulator | — |

`usb.txt` and `midi.txt` are always written; there is no separate option for them.
In `midi.txt`, `->` is a PC → pedal command and `<-` is a pedal → PC reply,
including SysEx. Send SysEx after USB is ready, e.g. `-usb -sysex 4000:F052005850F7`.
For MS-70CDR the model byte is `61`; to get a reply from the pedal use
`-usb -sysex 5000:F052006101F7 -sysex 7000:F052006150F7 -sysex 9000:F052006129F7`.
`midi.txt` then contains `-> F0 52 00 61 29 F7` and `<- F0 52 00 61 28 ... F7`
with the current patch.

Cycles are the same everywhere: emulation time × core frequency, including
memory stalls. The core is 300 MHz, so 1 second is 300,000,000 cycles.

Typical crash-hunting order:

1. Run without `-q`, find the cycle and address of the crash in the summary.
2. Repeat with `-t <cycle − 500000> -tl 600000` and read the end of `trace.txt`.
3. If memory is corrupted (e.g. the stack), find who writes it: `-ww LO HI CYCLE`.
4. Compare with a firmware disassembly.

If the firmware crashes only with cache but works with `-nocache`, it is
almost certainly a race in the emulator, not in the firmware: please send the
trace.

## 11. Battery

The battery is measured by an external 8-bit ADC on SPI1 (chip select is GPIO
42). The reading is set by `-adc N` (0..255, default 240 — external power).

How stock MS-50G 3.10 converts the reading to a level (functions `0xC00DB6E0`
and `0xC00D7828`):

| ADC reading | Level |
|---|---|
| 154 and above | 5 — external power |
| 100–153 | 4 |
| 88–99 | 3 |
| 77–87 | 2 |
| 73–76 | 1 |
| 72 and below | 0 — "Low Battery!" window on the next UI action |

These are thresholds for battery type 0 (default, apparently Alkaline) when
moving down; moving up has hysteresis (77, 88, 100, 112). Type 1 (Ni-MH) has
its own thresholds: 87, 90, 95, 97. The last reading is a byte at `0xC00EFD32`,
the level is a word at `0xC00EFED4` (MS-50G 3.10 addresses): custom firmware
can read them there without touching SPI1.

## 12. What the emulator cannot do yet

- USB models a full-speed device plus a scripted host. OUT data stage with
  `SERV_RXPKTRDY`, UAC `GET_CUR`/`SET_CUR`, isochronous IN and `-usbwav` capture
  are supported. A full USB host mode and complete firmware-side handling of
  every UAC class request are not modelled. Flash writes are instant, so updates
  run faster than on the pedal (6 s versus 24).
- Cache and SDRAM delays are calibrated on hardware with CFW 5.38 at 408 MHz
  (`-cachepen 5:3:385:40`, L2 and SDRAM within 1-3% of the pedal). For other
  frequencies and firmwares the penalties must be recalculated; compare variants
  rather than the last percent.
- Stale cache before DMA was checked with CFW 5.38: over 8 s and 1.4 million
  EDMA transfers the `n_dma_snoop` counter found 0 hits in cached L1D lines, so
  the effect does not occur in the current workload. Model data is always fresh;
  a CFW that performs EDMA into L2 SRAM will trigger the counter immediately.
- Flash changes (saved patches) live only until the program exits.

## 13. Troubleshooting

| Symptom | What to check |
|---|---|
| `lcd.png` and every `-snap` are blank white | Check the `LCD: cmds=... data=...` line in the summary. `cmds=0` means the firmware has not initialized the display yet: increase `-s`, add `-flashfast`, move `-snap` later. A white screen during boot is normal. |
| A `-snap` at exactly `-s` is not created | Snapshots are written only during the run. Put `-snap` strictly before the stop time; the final frame is always available as `lcd.png`. |
| You need to catch a screen transition in an unfamiliar firmware | Take a series of `-snap` every 1–3 s, then every 50–100 ms around the transition, with `-flashfast`. Check the `LCD: cmds=... data=...` line and join frames with `python -I tools/montage.py out.png 3 s1.png s2.png ...`. |
| Boot takes too long | Add `-flashfast`: without it, flash program and erase can take a large part of the run. Check the `FLASH: ... program/erase` line in the summary. |
| `sh` or `zig` is not in PATH | Run Git Bash by full path, for example `& "C:\Program Files\Git\bin\sh.exe" -c "cd '<folder>' && ZIG=/c/.../zig.exe sh build.sh"`, or run the `zig cc` commands from `build.sh` manually. |
| `-press` does not change the screen | The emulator only drives a GPIO level; the meaning of a press is defined by the firmware and the current screen. Confirm the target screen with a snapshot first, then repeat the press. For stock 70CDR the Play screen appears at about 5–6 s with `-flashfast` and about 21 s without it. |
| Every snapshot is identical | If they are blank, see above. If they are not blank but identical, check that `-press` happened after the Play screen and that the run reached the requested `-s`: `halted=0`, `time=` equals the requested time. |
| `load failed: -h` | `c6xboot` has no `-h` option. The full key list is in README, "Diagnostic options", and in HOWTO sections 5, 9 and 10. |
| `flash: missing ...` | The firmware parts must sit together and be named `129_main_OS.bin`, `133_data_133.bin`, `136_bootloader.bin`, `137_file_system.bin`. |
| An effect is silent in `c6xzdl` | For effects that need firmware initialization, use `c6xboot` with the full firmware: the OS calls `_init` itself. The standalone `c6xzdl` does not do this, so silence there does not mean the effect is broken. |
| `halted=1`, `ERROR` | This is a crash, not an "emulator limitation". Stop and report it. Do not use `-q` for diagnosis: it removes `hot PCs`. If the line contains `indirect branch from ... to ...`, a zero/garbage function pointer was used; the branch target is shown. |
| `AUDIO: frames=0`, `DSP load after 3 s: 100.0%` early in boot | With `halted=0` and no `ERROR` this can be a normal startup stage, especially without `-flashfast`. Treat `halted=1` or `ERROR` as a crash. |
| A button press "did not stick" | `-press` holds for 120 ms by default. Give the duration explicitly: `-press 4500:24:500`. |
| Cannot find the logs | All log files are written to the current working directory where `c6xboot.exe` was started. Use `-lcdlog` to write `lcdlog.txt` for display checks. |
| `../../build/...` path not found | HOWTO examples assume the `run/try` folder. From another folder the path to `build/c6xboot.exe` differs — adjust it. |
| `DSP clock`, `CLOCKS`, `CACHE` lines are red in PowerShell | This is stderr output, not an error. The main success sign is `halted=0` in the final summary. |

A stock firmware does spend time in idle paths between events — that is normal. A button press **after the Play screen** changes the screen; if it does not, check the timing before concluding that the UI is broken.
