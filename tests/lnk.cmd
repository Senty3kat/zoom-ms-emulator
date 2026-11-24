-stack 0x10000
-heap 0x100000
MEMORY
{
    L2:    o = 0x11800000  l = 0x00040000
    SDRAM: o = 0xC0000000  l = 0x02000000
}
SECTIONS
{
    .text     > SDRAM
    .stack    > L2
    .cinit    > SDRAM
    .const    > SDRAM
    .rodata   > SDRAM
    .switch   > SDRAM
    .bss      > SDRAM
    .neardata > SDRAM
    .fardata  > SDRAM
    .far      > SDRAM
    .data     > SDRAM
    .sysmem   > SDRAM
    .cio      > SDRAM
    .init_array > SDRAM
    .args     > SDRAM
}
