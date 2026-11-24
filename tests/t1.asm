;******************************************************************************
;* TMS320C6x G3 C/C++ Codegen                                                PC v8.5.0.LTS *
;* Date/Time created: Tue Oct 27 04:14:20 2026                                *
;******************************************************************************
	.compiler_opts --abi=eabi --array_alignment=8 --c64p_l1d_workaround=off --endian=little --hll_source=on --long_precision_bits=32 --mem_model:code=near --mem_model:const=data --mem_model:data=far_aggregates --object_format=elf --silicon_version=6740 --symdebug:dwarf --symdebug:dwarf_version=3 

;******************************************************************************
;* GLOBAL FILE PARAMETERS                                                     *
;*                                                                            *
;*   Architecture      : TMS320C674x                                          *
;*   Optimization      : Enabled at level 3                                   *
;*   Optimizing for    : Speed                                                *
;*                       Based on options: -o3, no -ms                        *
;*   Endian            : Little                                               *
;*   Interrupt Thrshld : Disabled                                             *
;*   Data Access Model : Far Aggregate Data                                   *
;*   Pipelining        : Enabled                                              *
;*   Speculate Loads   : Enabled with threshold = 0                           *
;*   Memory Aliases    : Presume are aliases (pessimistic)                    *
;*   Debug Info        : DWARF Debug                                          *
;*                                                                            *
;******************************************************************************

	.asg	A15, FP
	.asg	B14, DP
	.asg	B15, SP
	.global	$bss


$C$DW$CU	.dwtag  DW_TAG_compile_unit
	.dwattr $C$DW$CU, DW_AT_name("t1.c")
	.dwattr $C$DW$CU, DW_AT_producer("TI TMS320C6x G3 C/C++ Codegen PC v8.5.0.LTS Copyright (c) 1996-2018 Texas Instruments Incorporated")
	.dwattr $C$DW$CU, DW_AT_TI_version(0x01)
	.dwattr $C$DW$CU, DW_AT_comp_dir("tests")
	.global	results
	.farcommon	results,1600,8
$C$DW$1	.dwtag  DW_TAG_variable
	.dwattr $C$DW$1, DW_AT_name("results")
	.dwattr $C$DW$1, DW_AT_TI_symbol_name("results")
	.dwattr $C$DW$1, DW_AT_location[DW_OP_addr results]
	.dwattr $C$DW$1, DW_AT_type(*$C$DW$T$169)
	.dwattr $C$DW$1, DW_AT_external
	.dwattr $C$DW$1, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$1, DW_AT_decl_line(0x09)
	.dwattr $C$DW$1, DW_AT_decl_column(0x0a)

	.bss	ri,4,4
$C$DW$2	.dwtag  DW_TAG_variable
	.dwattr $C$DW$2, DW_AT_name("restrict int")
	.dwattr $C$DW$2, DW_AT_TI_symbol_name("ri")
	.dwattr $C$DW$2, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$2, DW_AT_location[DW_OP_addr ri]
	.dwattr $C$DW$2, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$2, DW_AT_decl_line(0x0a)
	.dwattr $C$DW$2, DW_AT_decl_column(0x0c)

	.sect	".neardata", RW
	.align	4
	.elfsym	vzero,SYM_SIZE(4)
vzero:
	.bits		0,32
			; vzero @ 0

$C$DW$3	.dwtag  DW_TAG_variable
	.dwattr $C$DW$3, DW_AT_name("vzero")
	.dwattr $C$DW$3, DW_AT_TI_symbol_name("vzero")
	.dwattr $C$DW$3, DW_AT_type(*$C$DW$T$128)
	.dwattr $C$DW$3, DW_AT_location[DW_OP_addr vzero]
	.dwattr $C$DW$3, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$3, DW_AT_decl_line(0x0f)
	.dwattr $C$DW$3, DW_AT_decl_column(0x15)

	.sect	".neardata", RW
	.align	4
	.elfsym	lcg,SYM_SIZE(4)
lcg:
	.bits		0x3039,32
			; lcg @ 0

$C$DW$4	.dwtag  DW_TAG_variable
	.dwattr $C$DW$4, DW_AT_name("lcg")
	.dwattr $C$DW$4, DW_AT_TI_symbol_name("lcg")
	.dwattr $C$DW$4, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$4, DW_AT_location[DW_OP_addr lcg]
	.dwattr $C$DW$4, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$4, DW_AT_decl_line(0x10)
	.dwattr $C$DW$4, DW_AT_decl_column(0x11)

	.global	sa
	.farcommon	sa,512,8
$C$DW$5	.dwtag  DW_TAG_variable
	.dwattr $C$DW$5, DW_AT_name("sa")
	.dwattr $C$DW$5, DW_AT_TI_symbol_name("sa")
	.dwattr $C$DW$5, DW_AT_location[DW_OP_addr sa]
	.dwattr $C$DW$5, DW_AT_type(*$C$DW$T$89)
	.dwattr $C$DW$5, DW_AT_external
	.dwattr $C$DW$5, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$5, DW_AT_decl_line(0x20)
	.dwattr $C$DW$5, DW_AT_decl_column(0x07)

	.global	sb
	.farcommon	sb,512,8
$C$DW$6	.dwtag  DW_TAG_variable
	.dwattr $C$DW$6, DW_AT_name("sb")
	.dwattr $C$DW$6, DW_AT_TI_symbol_name("sb")
	.dwattr $C$DW$6, DW_AT_location[DW_OP_addr sb]
	.dwattr $C$DW$6, DW_AT_type(*$C$DW$T$89)
	.dwattr $C$DW$6, DW_AT_external
	.dwattr $C$DW$6, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$6, DW_AT_decl_line(0x20)
	.dwattr $C$DW$6, DW_AT_decl_column(0x10)

	.global	ia
	.farcommon	ia,2048,8
$C$DW$7	.dwtag  DW_TAG_variable
	.dwattr $C$DW$7, DW_AT_name("ia")
	.dwattr $C$DW$7, DW_AT_TI_symbol_name("ia")
	.dwattr $C$DW$7, DW_AT_location[DW_OP_addr ia]
	.dwattr $C$DW$7, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$7, DW_AT_external
	.dwattr $C$DW$7, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$7, DW_AT_decl_line(0x21)
	.dwattr $C$DW$7, DW_AT_decl_column(0x05)

	.global	ib
	.farcommon	ib,2048,8
$C$DW$8	.dwtag  DW_TAG_variable
	.dwattr $C$DW$8, DW_AT_name("ib")
	.dwattr $C$DW$8, DW_AT_TI_symbol_name("ib")
	.dwattr $C$DW$8, DW_AT_location[DW_OP_addr ib]
	.dwattr $C$DW$8, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$8, DW_AT_external
	.dwattr $C$DW$8, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$8, DW_AT_decl_line(0x21)
	.dwattr $C$DW$8, DW_AT_decl_column(0x0e)

	.global	fa
	.farcommon	fa,1024,8
$C$DW$9	.dwtag  DW_TAG_variable
	.dwattr $C$DW$9, DW_AT_name("fa")
	.dwattr $C$DW$9, DW_AT_TI_symbol_name("fa")
	.dwattr $C$DW$9, DW_AT_location[DW_OP_addr fa]
	.dwattr $C$DW$9, DW_AT_type(*$C$DW$T$220)
	.dwattr $C$DW$9, DW_AT_external
	.dwattr $C$DW$9, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$9, DW_AT_decl_line(0x22)
	.dwattr $C$DW$9, DW_AT_decl_column(0x07)

	.global	fb
	.farcommon	fb,1024,8
$C$DW$10	.dwtag  DW_TAG_variable
	.dwattr $C$DW$10, DW_AT_name("fb")
	.dwattr $C$DW$10, DW_AT_TI_symbol_name("fb")
	.dwattr $C$DW$10, DW_AT_location[DW_OP_addr fb]
	.dwattr $C$DW$10, DW_AT_type(*$C$DW$T$220)
	.dwattr $C$DW$10, DW_AT_external
	.dwattr $C$DW$10, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$10, DW_AT_decl_line(0x22)
	.dwattr $C$DW$10, DW_AT_decl_column(0x10)

	.global	bytes
	.farcommon	bytes,1024,8
$C$DW$11	.dwtag  DW_TAG_variable
	.dwattr $C$DW$11, DW_AT_name("bytes")
	.dwattr $C$DW$11, DW_AT_TI_symbol_name("bytes")
	.dwattr $C$DW$11, DW_AT_location[DW_OP_addr bytes]
	.dwattr $C$DW$11, DW_AT_type(*$C$DW$T$83)
	.dwattr $C$DW$11, DW_AT_external
	.dwattr $C$DW$11, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$11, DW_AT_decl_line(0x23)
	.dwattr $C$DW$11, DW_AT_decl_column(0x0f)


$C$DW$12	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$12, DW_AT_name("modff")
	.dwattr $C$DW$12, DW_AT_TI_symbol_name("modff")
	.dwattr $C$DW$12, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$12, DW_AT_declaration
	.dwattr $C$DW$12, DW_AT_external
	.dwattr $C$DW$12, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/mathf.h")
	.dwattr $C$DW$12, DW_AT_decl_line(0x50)
	.dwattr $C$DW$12, DW_AT_decl_column(0x14)
$C$DW$13	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$13, DW_AT_type(*$C$DW$T$18)

$C$DW$14	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$14, DW_AT_type(*$C$DW$T$217)

	.dwendtag $C$DW$12


$C$DW$15	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$15, DW_AT_name("memset")
	.dwattr $C$DW$15, DW_AT_TI_symbol_name("memset")
	.dwattr $C$DW$15, DW_AT_type(*$C$DW$T$3)
	.dwattr $C$DW$15, DW_AT_declaration
	.dwattr $C$DW$15, DW_AT_external
	.dwattr $C$DW$15, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h")
	.dwattr $C$DW$15, DW_AT_decl_line(0x88)
	.dwattr $C$DW$15, DW_AT_decl_column(0x16)
$C$DW$16	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$16, DW_AT_type(*$C$DW$T$3)

$C$DW$17	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$17, DW_AT_type(*$C$DW$T$10)

$C$DW$18	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$18, DW_AT_type(*$C$DW$T$53)

	.dwendtag $C$DW$15


$C$DW$19	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$19, DW_AT_name("memmove")
	.dwattr $C$DW$19, DW_AT_TI_symbol_name("memmove")
	.dwattr $C$DW$19, DW_AT_type(*$C$DW$T$3)
	.dwattr $C$DW$19, DW_AT_declaration
	.dwattr $C$DW$19, DW_AT_external
	.dwattr $C$DW$19, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h")
	.dwattr $C$DW$19, DW_AT_decl_line(0x79)
	.dwattr $C$DW$19, DW_AT_decl_column(0x16)
$C$DW$20	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$20, DW_AT_type(*$C$DW$T$3)

$C$DW$21	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$21, DW_AT_type(*$C$DW$T$52)

$C$DW$22	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$22, DW_AT_type(*$C$DW$T$53)

	.dwendtag $C$DW$19


$C$DW$23	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$23, DW_AT_name("sprintf")
	.dwattr $C$DW$23, DW_AT_TI_symbol_name("sprintf")
	.dwattr $C$DW$23, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$23, DW_AT_declaration
	.dwattr $C$DW$23, DW_AT_external
	.dwattr $C$DW$23, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$23, DW_AT_decl_line(0x113)
	.dwattr $C$DW$23, DW_AT_decl_column(0x19)
$C$DW$24	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$24, DW_AT_type(*$C$DW$T$109)

$C$DW$25	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$25, DW_AT_type(*$C$DW$T$110)

$C$DW$26	.dwtag  DW_TAG_unspecified_parameters

	.dwendtag $C$DW$23


$C$DW$27	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$27, DW_AT_name("atoi")
	.dwattr $C$DW$27, DW_AT_TI_symbol_name("atoi")
	.dwattr $C$DW$27, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$27, DW_AT_declaration
	.dwattr $C$DW$27, DW_AT_external
	.dwattr $C$DW$27, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$27, DW_AT_decl_line(0x9f)
	.dwattr $C$DW$27, DW_AT_decl_column(0x1c)
$C$DW$28	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$28, DW_AT_type(*$C$DW$T$106)

	.dwendtag $C$DW$27


$C$DW$29	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$29, DW_AT_name("strtol")
	.dwattr $C$DW$29, DW_AT_TI_symbol_name("strtol")
	.dwattr $C$DW$29, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$29, DW_AT_declaration
	.dwattr $C$DW$29, DW_AT_external
	.dwattr $C$DW$29, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$29, DW_AT_decl_line(0xa7)
	.dwattr $C$DW$29, DW_AT_decl_column(0x1c)
$C$DW$30	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$30, DW_AT_type(*$C$DW$T$110)

$C$DW$31	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$31, DW_AT_type(*$C$DW$T$116)

$C$DW$32	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$32, DW_AT_type(*$C$DW$T$10)

	.dwendtag $C$DW$29


$C$DW$33	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$33, DW_AT_name("qsort")
	.dwattr $C$DW$33, DW_AT_TI_symbol_name("qsort")
	.dwattr $C$DW$33, DW_AT_declaration
	.dwattr $C$DW$33, DW_AT_external
	.dwattr $C$DW$33, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$33, DW_AT_decl_line(0xd7)
	.dwattr $C$DW$33, DW_AT_decl_column(0x19)
$C$DW$34	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$34, DW_AT_type(*$C$DW$T$3)

$C$DW$35	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$35, DW_AT_type(*$C$DW$T$53)

$C$DW$36	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$36, DW_AT_type(*$C$DW$T$53)

$C$DW$37	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$37, DW_AT_type(*$C$DW$T$63)

	.dwendtag $C$DW$33

	.sect	".const:$P$T0$1"
	.align	8
	.elfsym	$P$T0$1,SYM_SIZE(24)
$P$T0$1:
	.bits		0xfb,8
			; $P$T0$1.c @ 0
	.bits		0,8

	.bits		0xfed4,16
			; $P$T0$1.s @ 16
	.bits		0x11170,32
			; $P$T0$1.i @ 32
	.bits		0xffffffe34166e5ec,64
			; $P$T0$1.ll @ 64
	.word	03fc00000h		; $P$T0$1.f @ 128
	.bits		0,32


$C$DW$38	.dwtag  DW_TAG_variable
	.dwattr $C$DW$38, DW_AT_name("$P$T0$1")
	.dwattr $C$DW$38, DW_AT_TI_symbol_name("$P$T0$1")
	.dwattr $C$DW$38, DW_AT_type(*$C$DW$T$49)
	.dwattr $C$DW$38, DW_AT_location[DW_OP_addr $P$T0$1]
	.dwattr $C$DW$38, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$38, DW_AT_decl_line(0x6c)
	.dwattr $C$DW$38, DW_AT_decl_column(0x10)


$C$DW$39	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$39, DW_AT_name("sqrtf")
	.dwattr $C$DW$39, DW_AT_TI_symbol_name("sqrtf")
	.dwattr $C$DW$39, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$39, DW_AT_declaration
	.dwattr $C$DW$39, DW_AT_external
	.dwattr $C$DW$39, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/mathf.h")
	.dwattr $C$DW$39, DW_AT_decl_line(0x36)
	.dwattr $C$DW$39, DW_AT_decl_column(0x14)
$C$DW$40	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$40, DW_AT_type(*$C$DW$T$18)

	.dwendtag $C$DW$39


$C$DW$41	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$41, DW_AT_name("sqrt")
	.dwattr $C$DW$41, DW_AT_TI_symbol_name("sqrt")
	.dwattr $C$DW$41, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$41, DW_AT_declaration
	.dwattr $C$DW$41, DW_AT_external
	.dwattr $C$DW$41, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/math.h")
	.dwattr $C$DW$41, DW_AT_decl_line(0x50)
	.dwattr $C$DW$41, DW_AT_decl_column(0x15)
$C$DW$42	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$42, DW_AT_type(*$C$DW$T$19)

	.dwendtag $C$DW$41


$C$DW$43	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$43, DW_AT_name("sinf")
	.dwattr $C$DW$43, DW_AT_TI_symbol_name("sinf")
	.dwattr $C$DW$43, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$43, DW_AT_declaration
	.dwattr $C$DW$43, DW_AT_external
	.dwattr $C$DW$43, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/mathf.h")
	.dwattr $C$DW$43, DW_AT_decl_line(0x3b)
	.dwattr $C$DW$43, DW_AT_decl_column(0x14)
$C$DW$44	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$44, DW_AT_type(*$C$DW$T$18)

	.dwendtag $C$DW$43


$C$DW$45	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$45, DW_AT_name("cos")
	.dwattr $C$DW$45, DW_AT_TI_symbol_name("cos")
	.dwattr $C$DW$45, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$45, DW_AT_declaration
	.dwattr $C$DW$45, DW_AT_external
	.dwattr $C$DW$45, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/math.h")
	.dwattr $C$DW$45, DW_AT_decl_line(0x56)
	.dwattr $C$DW$45, DW_AT_decl_column(0x15)
$C$DW$46	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$46, DW_AT_type(*$C$DW$T$19)

	.dwendtag $C$DW$45


$C$DW$47	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$47, DW_AT_name("expf")
	.dwattr $C$DW$47, DW_AT_TI_symbol_name("expf")
	.dwattr $C$DW$47, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$47, DW_AT_declaration
	.dwattr $C$DW$47, DW_AT_external
	.dwattr $C$DW$47, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/mathf.h")
	.dwattr $C$DW$47, DW_AT_decl_line(0x37)
	.dwattr $C$DW$47, DW_AT_decl_column(0x14)
$C$DW$48	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$48, DW_AT_type(*$C$DW$T$18)

	.dwendtag $C$DW$47


$C$DW$49	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$49, DW_AT_name("log")
	.dwattr $C$DW$49, DW_AT_TI_symbol_name("log")
	.dwattr $C$DW$49, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$49, DW_AT_declaration
	.dwattr $C$DW$49, DW_AT_external
	.dwattr $C$DW$49, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/math.h")
	.dwattr $C$DW$49, DW_AT_decl_line(0x52)
	.dwattr $C$DW$49, DW_AT_decl_column(0x15)
$C$DW$50	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$50, DW_AT_type(*$C$DW$T$19)

	.dwendtag $C$DW$49


$C$DW$51	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$51, DW_AT_name("atan2f")
	.dwattr $C$DW$51, DW_AT_TI_symbol_name("atan2f")
	.dwattr $C$DW$51, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$51, DW_AT_declaration
	.dwattr $C$DW$51, DW_AT_external
	.dwattr $C$DW$51, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/mathf.h")
	.dwattr $C$DW$51, DW_AT_decl_line(0x41)
	.dwattr $C$DW$51, DW_AT_decl_column(0x14)
$C$DW$52	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$52, DW_AT_type(*$C$DW$T$18)

$C$DW$53	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$53, DW_AT_type(*$C$DW$T$18)

	.dwendtag $C$DW$51


$C$DW$54	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$54, DW_AT_name("powf")
	.dwattr $C$DW$54, DW_AT_TI_symbol_name("powf")
	.dwattr $C$DW$54, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$54, DW_AT_declaration
	.dwattr $C$DW$54, DW_AT_external
	.dwattr $C$DW$54, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/mathf.h")
	.dwattr $C$DW$54, DW_AT_decl_line(0x3a)
	.dwattr $C$DW$54, DW_AT_decl_column(0x14)
$C$DW$55	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$55, DW_AT_type(*$C$DW$T$18)

$C$DW$56	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$56, DW_AT_type(*$C$DW$T$18)

	.dwendtag $C$DW$54

	.sect	".text"
	.clink

$C$DW$57	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$57, DW_AT_name("op_sub")
	.dwattr $C$DW$57, DW_AT_low_pc(op_sub)
	.dwattr $C$DW$57, DW_AT_high_pc(0x00)
	.dwattr $C$DW$57, DW_AT_TI_symbol_name("op_sub")
	.dwattr $C$DW$57, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$57, DW_AT_TI_begin_file("t1.c")
	.dwattr $C$DW$57, DW_AT_TI_begin_line(0x27)
	.dwattr $C$DW$57, DW_AT_TI_begin_column(0x0c)
	.dwattr $C$DW$57, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$57, DW_AT_decl_line(0x27)
	.dwattr $C$DW$57, DW_AT_decl_column(0x0c)
	.dwattr $C$DW$57, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t1.c",line 39,column 33,is_stmt,address op_sub,isa 0

	.dwfde $C$DW$CIE, op_sub
$C$DW$58	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$58, DW_AT_name("a")
	.dwattr $C$DW$58, DW_AT_TI_symbol_name("a")
	.dwattr $C$DW$58, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$58, DW_AT_location[DW_OP_reg4]

$C$DW$59	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$59, DW_AT_name("b")
	.dwattr $C$DW$59, DW_AT_TI_symbol_name("b")
	.dwattr $C$DW$59, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$59, DW_AT_location[DW_OP_reg20]


;******************************************************************************
;* FUNCTION NAME: op_sub                                                      *
;*                                                                            *
;*   Regs Modified     : A4                                                   *
;*   Regs Used         : A4,B3,B4                                             *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
op_sub:
;** --------------------------------------------------------------------------*
	.dwcfi	cfa_offset, 0
	.dwpsn	file "t1.c",line 39,column 49,is_stmt,isa 0
$C$DW$60	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$60, DW_AT_low_pc(0x00)
	.dwattr $C$DW$60, DW_AT_TI_return

           RETNOP          B3,4              ; [] |39| 
	.dwpsn	file "t1.c",line 39,column 35,is_stmt,isa 0
           SUB     .L1X    A4,B4,A4          ; [A_L674] |39| 
	.dwpsn	file "t1.c",line 39,column 49,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |39| 
	.dwattr $C$DW$57, DW_AT_TI_end_file("t1.c")
	.dwattr $C$DW$57, DW_AT_TI_end_line(0x27)
	.dwattr $C$DW$57, DW_AT_TI_end_column(0x31)
	.dwendentry
	.dwendtag $C$DW$57

	.sect	".text"
	.clink

$C$DW$61	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$61, DW_AT_name("op_mul")
	.dwattr $C$DW$61, DW_AT_low_pc(op_mul)
	.dwattr $C$DW$61, DW_AT_high_pc(0x00)
	.dwattr $C$DW$61, DW_AT_TI_symbol_name("op_mul")
	.dwattr $C$DW$61, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$61, DW_AT_TI_begin_file("t1.c")
	.dwattr $C$DW$61, DW_AT_TI_begin_line(0x28)
	.dwattr $C$DW$61, DW_AT_TI_begin_column(0x0c)
	.dwattr $C$DW$61, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$61, DW_AT_decl_line(0x28)
	.dwattr $C$DW$61, DW_AT_decl_column(0x0c)
	.dwattr $C$DW$61, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t1.c",line 40,column 33,is_stmt,address op_mul,isa 0

	.dwfde $C$DW$CIE, op_mul
$C$DW$62	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$62, DW_AT_name("a")
	.dwattr $C$DW$62, DW_AT_TI_symbol_name("a")
	.dwattr $C$DW$62, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$62, DW_AT_location[DW_OP_reg4]

$C$DW$63	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$63, DW_AT_name("b")
	.dwattr $C$DW$63, DW_AT_TI_symbol_name("b")
	.dwattr $C$DW$63, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$63, DW_AT_location[DW_OP_reg20]


;******************************************************************************
;* FUNCTION NAME: op_mul                                                      *
;*                                                                            *
;*   Regs Modified     : A4                                                   *
;*   Regs Used         : A4,B3,B4                                             *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
op_mul:
;** --------------------------------------------------------------------------*
$C$DW$64	.dwtag  DW_TAG_variable
	.dwattr $C$DW$64, DW_AT_name("a")
	.dwattr $C$DW$64, DW_AT_TI_symbol_name("a")
	.dwattr $C$DW$64, DW_AT_type(*$C$DW$T$130)
	.dwattr $C$DW$64, DW_AT_location[DW_OP_reg4]

$C$DW$65	.dwtag  DW_TAG_variable
	.dwattr $C$DW$65, DW_AT_name("b")
	.dwattr $C$DW$65, DW_AT_TI_symbol_name("b")
	.dwattr $C$DW$65, DW_AT_type(*$C$DW$T$130)
	.dwattr $C$DW$65, DW_AT_location[DW_OP_reg20]

	.dwcfi	cfa_offset, 0
	.dwpsn	file "t1.c",line 40,column 49,is_stmt,isa 0
$C$DW$66	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$66, DW_AT_low_pc(0x00)
	.dwattr $C$DW$66, DW_AT_TI_return

           RETNOP          B3,1              ; [] |40| 
	.dwpsn	file "t1.c",line 40,column 35,is_stmt,isa 0
           MPY32   .M1X    B4,A4,A4          ; [A_M674] |40| 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t1.c",line 40,column 49,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |40| 
	.dwattr $C$DW$61, DW_AT_TI_end_file("t1.c")
	.dwattr $C$DW$61, DW_AT_TI_end_line(0x28)
	.dwattr $C$DW$61, DW_AT_TI_end_column(0x31)
	.dwendentry
	.dwendtag $C$DW$61

	.sect	".text"
	.clink

$C$DW$67	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$67, DW_AT_name("op_add")
	.dwattr $C$DW$67, DW_AT_low_pc(op_add)
	.dwattr $C$DW$67, DW_AT_high_pc(0x00)
	.dwattr $C$DW$67, DW_AT_TI_symbol_name("op_add")
	.dwattr $C$DW$67, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$67, DW_AT_TI_begin_file("t1.c")
	.dwattr $C$DW$67, DW_AT_TI_begin_line(0x26)
	.dwattr $C$DW$67, DW_AT_TI_begin_column(0x0c)
	.dwattr $C$DW$67, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$67, DW_AT_decl_line(0x26)
	.dwattr $C$DW$67, DW_AT_decl_column(0x0c)
	.dwattr $C$DW$67, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t1.c",line 38,column 33,is_stmt,address op_add,isa 0

	.dwfde $C$DW$CIE, op_add
$C$DW$68	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$68, DW_AT_name("a")
	.dwattr $C$DW$68, DW_AT_TI_symbol_name("a")
	.dwattr $C$DW$68, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$68, DW_AT_location[DW_OP_reg4]

$C$DW$69	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$69, DW_AT_name("b")
	.dwattr $C$DW$69, DW_AT_TI_symbol_name("b")
	.dwattr $C$DW$69, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$69, DW_AT_location[DW_OP_reg20]


;******************************************************************************
;* FUNCTION NAME: op_add                                                      *
;*                                                                            *
;*   Regs Modified     : A4                                                   *
;*   Regs Used         : A4,B3,B4                                             *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
op_add:
;** --------------------------------------------------------------------------*
	.dwcfi	cfa_offset, 0
	.dwpsn	file "t1.c",line 38,column 49,is_stmt,isa 0
$C$DW$70	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$70, DW_AT_low_pc(0x00)
	.dwattr $C$DW$70, DW_AT_TI_return

           RETNOP          B3,4              ; [] |38| 
	.dwpsn	file "t1.c",line 38,column 35,is_stmt,isa 0
           ADD     .L1X    B4,A4,A4          ; [A_L674] |38| 
	.dwpsn	file "t1.c",line 38,column 49,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |38| 
	.dwattr $C$DW$67, DW_AT_TI_end_file("t1.c")
	.dwattr $C$DW$67, DW_AT_TI_end_line(0x26)
	.dwattr $C$DW$67, DW_AT_TI_end_column(0x31)
	.dwendentry
	.dwendtag $C$DW$67

	.sect	".text"
	.clink

$C$DW$71	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$71, DW_AT_name("put")
	.dwattr $C$DW$71, DW_AT_low_pc(put)
	.dwattr $C$DW$71, DW_AT_high_pc(0x00)
	.dwattr $C$DW$71, DW_AT_TI_symbol_name("put")
	.dwattr $C$DW$71, DW_AT_TI_begin_file("t1.c")
	.dwattr $C$DW$71, DW_AT_TI_begin_line(0x0b)
	.dwattr $C$DW$71, DW_AT_TI_begin_column(0x0d)
	.dwattr $C$DW$71, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$71, DW_AT_decl_line(0x0b)
	.dwattr $C$DW$71, DW_AT_decl_column(0x0d)
	.dwattr $C$DW$71, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t1.c",line 11,column 29,is_stmt,address put,isa 0

	.dwfde $C$DW$CIE, put
$C$DW$72	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$72, DW_AT_name("v")
	.dwattr $C$DW$72, DW_AT_TI_symbol_name("v")
	.dwattr $C$DW$72, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$72, DW_AT_location[DW_OP_reg4]


;******************************************************************************
;* FUNCTION NAME: put                                                         *
;*                                                                            *
;*   Regs Modified     : A0,A3,B4,B5,B6                                       *
;*   Regs Used         : A0,A3,A4,B3,B4,B5,B6,DP                              *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
put:
;** --------------------------------------------------------------------------*
$C$DW$73	.dwtag  DW_TAG_variable
	.dwattr $C$DW$73, DW_AT_name("v")
	.dwattr $C$DW$73, DW_AT_TI_symbol_name("v")
	.dwattr $C$DW$73, DW_AT_type(*$C$DW$T$165)
	.dwattr $C$DW$73, DW_AT_location[DW_OP_reg4]

	.dwcfi	cfa_offset, 0
	.dwpsn	file "t1.c",line 11,column 31,is_stmt,isa 0
           LDW     .D2T2   *+DP(ri),B4       ; [B_D64P] |11| 
           MVK     .S1     400,A3            ; [A_S674] |11| 
	.dwpsn	file "t1.c",line 11,column 62,is_stmt,isa 0
$C$DW$74	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$74, DW_AT_low_pc(0x00)
	.dwattr $C$DW$74, DW_AT_TI_return

           RETNOP          B3,2              ; [] |11| 
	.dwpsn	file "t1.c",line 11,column 31,is_stmt,isa 0

           MVKL    .S2     results,B6        ; [B_Sb674] |11| 
||         CMPLT   .L1X    B4,A3,A0          ; [A_L674] |11| 
||         ADD     .L2     1,B4,B5           ; [B_L674] |11| 

	.dwpsn	file "t1.c",line 11,column 43,is_stmt,isa 0

           MVKH    .S2     results,B6        ; [B_Sb674] |11| 
|| [ A0]   STW     .D2T2   B5,*+DP(ri)       ; [B_D64P] |11| 

   [ A0]   STW     .D2T1   A4,*+B6[B4]       ; [B_D64P] |11| 
	.dwpsn	file "t1.c",line 11,column 62,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |11| 
	.dwattr $C$DW$71, DW_AT_TI_end_file("t1.c")
	.dwattr $C$DW$71, DW_AT_TI_end_line(0x0b)
	.dwattr $C$DW$71, DW_AT_TI_end_column(0x3e)
	.dwendentry
	.dwendtag $C$DW$71

	.sect	".text"
	.clink

$C$DW$75	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$75, DW_AT_name("fbits")
	.dwattr $C$DW$75, DW_AT_low_pc(fbits)
	.dwattr $C$DW$75, DW_AT_high_pc(0x00)
	.dwattr $C$DW$75, DW_AT_TI_symbol_name("fbits")
	.dwattr $C$DW$75, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$75, DW_AT_TI_begin_file("t1.c")
	.dwattr $C$DW$75, DW_AT_TI_begin_line(0x0c)
	.dwattr $C$DW$75, DW_AT_TI_begin_column(0x11)
	.dwattr $C$DW$75, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$75, DW_AT_decl_line(0x0c)
	.dwattr $C$DW$75, DW_AT_decl_column(0x11)
	.dwattr $C$DW$75, DW_AT_TI_max_frame_size(0x08)
	.dwpsn	file "t1.c",line 12,column 32,is_stmt,address fbits,isa 0

	.dwfde $C$DW$CIE, fbits
$C$DW$76	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$76, DW_AT_name("f")
	.dwattr $C$DW$76, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$76, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$76, DW_AT_location[DW_OP_reg4]


;******************************************************************************
;* FUNCTION NAME: fbits                                                       *
;*                                                                            *
;*   Regs Modified     : A4,B4,B5,SP                                          *
;*   Regs Used         : A4,B3,B4,B5,SP                                       *
;*   Local Frame Size  : 0 Args + 8 Auto + 0 Save = 8 byte                    *
;******************************************************************************
fbits:
;** --------------------------------------------------------------------------*
$C$DW$77	.dwtag  DW_TAG_variable
	.dwattr $C$DW$77, DW_AT_name("f")
	.dwattr $C$DW$77, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$77, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$77, DW_AT_location[DW_OP_breg31 4]

$C$DW$78	.dwtag  DW_TAG_variable
	.dwattr $C$DW$78, DW_AT_name("u")
	.dwattr $C$DW$78, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$78, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$78, DW_AT_location[DW_OP_breg31 8]

$C$DW$79	.dwtag  DW_TAG_variable
	.dwattr $C$DW$79, DW_AT_name("f")
	.dwattr $C$DW$79, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$79, DW_AT_type(*$C$DW$T$221)
	.dwattr $C$DW$79, DW_AT_location[DW_OP_reg4]

	.dwcfi	cfa_offset, 0
           SUB     .L2     SP,8,SP           ; [B_L674] |12| 
	.dwcfi	cfa_offset, 8

           ADD     .L2     4,SP,B4           ; [B_L674] |12| 
||         STW     .D2T1   A4,*SP(4)         ; [B_D64P] |12| 

	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           LDW     .D2T2   *B4(0),B4         ; [B_D64P] |12| 
           ADD     .L2     8,SP,B5           ; [B_L674] |12| 
           NOP             3                 ; [A_L674] 
$C$DW$80	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$80, DW_AT_low_pc(0x04)
	.dwattr $C$DW$80, DW_AT_TI_return


           STW     .D2T2   B4,*B5(0)         ; [B_D64P] |12| 
||         RET     .S2     B3                ; [B_Sb674] |12| 

	.dwpsn	file "t1.c",line 12,column 65,is_stmt,isa 0
           LDW     .D2T1   *SP(8),A4         ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 12,column 75,is_stmt,isa 0
           ADD     .L2     8,SP,SP           ; [B_L674] |12| 
	.dwcfi	cfa_offset, 0
           NOP             3                 ; [A_L674] 
           ; BRANCH OCCURS {B3}              ; [] |12| 
	.dwattr $C$DW$75, DW_AT_TI_end_file("t1.c")
	.dwattr $C$DW$75, DW_AT_TI_end_line(0x0c)
	.dwattr $C$DW$75, DW_AT_TI_end_column(0x4b)
	.dwendentry
	.dwendtag $C$DW$75

	.sect	".text"
	.clink

$C$DW$81	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$81, DW_AT_name("putd")
	.dwattr $C$DW$81, DW_AT_low_pc(putd)
	.dwattr $C$DW$81, DW_AT_high_pc(0x00)
	.dwattr $C$DW$81, DW_AT_TI_symbol_name("putd")
	.dwattr $C$DW$81, DW_AT_TI_begin_file("t1.c")
	.dwattr $C$DW$81, DW_AT_TI_begin_line(0x0d)
	.dwattr $C$DW$81, DW_AT_TI_begin_column(0x0d)
	.dwattr $C$DW$81, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$81, DW_AT_decl_line(0x0d)
	.dwattr $C$DW$81, DW_AT_decl_column(0x0d)
	.dwattr $C$DW$81, DW_AT_TI_max_frame_size(0x18)
	.dwpsn	file "t1.c",line 13,column 28,is_stmt,address putd,isa 0

	.dwfde $C$DW$CIE, putd
$C$DW$82	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$82, DW_AT_name("d")
	.dwattr $C$DW$82, DW_AT_TI_symbol_name("d")
	.dwattr $C$DW$82, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$82, DW_AT_location[DW_OP_reg4]


;******************************************************************************
;* FUNCTION NAME: putd                                                        *
;*                                                                            *
;*   Regs Modified     : A0,A1,A3,A4,B3,B4,B5,B6,SP                           *
;*   Regs Used         : A0,A1,A3,A4,A5,B3,B4,B5,B6,DP,SP                     *
;*   Local Frame Size  : 0 Args + 20 Auto + 0 Save = 20 byte                  *
;******************************************************************************
putd:
;** --------------------------------------------------------------------------*
$C$DW$83	.dwtag  DW_TAG_variable
	.dwattr $C$DW$83, DW_AT_name("d")
	.dwattr $C$DW$83, DW_AT_TI_symbol_name("d")
	.dwattr $C$DW$83, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$83, DW_AT_location[DW_OP_breg31 8]

$C$DW$84	.dwtag  DW_TAG_variable
	.dwattr $C$DW$84, DW_AT_name("u")
	.dwattr $C$DW$84, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$84, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$84, DW_AT_location[DW_OP_breg31 16]

	.dwcfi	cfa_offset, 0

           SUB     .D2     SP,24,SP          ; [B_D64P] |13| 
||         MV      .L2X    A4,B4             ; [B_L674] |13| 

	.dwcfi	cfa_offset, 24
           MV      .L2X    A5,B5             ; [B_L674] |13| 

           ADD     .L1X    8,SP,A3           ; [A_L674] |13| 
||         STDW    .D2T2   B5:B4,*SP(8)      ; [B_D64P] |13| 

	.dwpsn	file "t1.c",line 13,column 52,is_stmt,isa 0
           LDDW    .D1T2   *A3(0),B5:B4      ; [A_D64P] |13| 
           ADD     .D2     SP,16,B6          ; [B_D64P] |13| 
	.dwpsn	file "t1.c",line 13,column 28,is_stmt,isa 0
           MV      .L1X    B3,A1             ; [A_L674] |13| 
	.dwcfi	save_reg_to_reg, 19, 1
           NOP             2                 ; [A_L674] 
	.dwpsn	file "t1.c",line 13,column 52,is_stmt,isa 0
           STDW    .D2T2   B5:B4,*B6(0)      ; [B_D64P] |13| 
	.dwpsn	file "t1.c",line 13,column 71,is_stmt,isa 0
$C$DW$85	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$85, DW_AT_low_pc(0x00)
	.dwattr $C$DW$85, DW_AT_name("put")
	.dwattr $C$DW$85, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |13| 
||         LDW     .D2T1   *SP(16),A4        ; [B_D64P] |13| 

$C$RL0:    ; CALLP OCCURS {put} {0}          ; [] |13| 
	.dwpsn	file "t1.c",line 13,column 89,is_stmt,isa 0
           LDDW    .D2T2   *SP(16),B5:B4     ; [B_D64P] |13| 
           NOP             4                 ; [A_L674] 
$C$DW$86	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$86, DW_AT_low_pc(0x00)
	.dwattr $C$DW$86, DW_AT_name("put")
	.dwattr $C$DW$86, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |13| 
||         MV      .L1X    B5,A4             ; [A_L674] |13| 

$C$RL2:    ; CALLP OCCURS {put} {0}          ; [] |13| 
	.dwpsn	file "t1.c",line 13,column 115,is_stmt,isa 0
$C$DW$87	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$87, DW_AT_low_pc(0x00)
	.dwattr $C$DW$87, DW_AT_TI_return

           RETNOP          A1,4              ; [] |13| 
           ADDAW   .D2     SP,6,SP           ; [B_D64P] |13| 
	.dwcfi	cfa_offset, 0
           ; BRANCH OCCURS {A1}              ; [] |13| 
	.dwattr $C$DW$81, DW_AT_TI_end_file("t1.c")
	.dwattr $C$DW$81, DW_AT_TI_end_line(0x0d)
	.dwattr $C$DW$81, DW_AT_TI_end_column(0x73)
	.dwendentry
	.dwendtag $C$DW$81

	.sect	".text"
	.clink

$C$DW$88	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$88, DW_AT_name("fib")
	.dwattr $C$DW$88, DW_AT_low_pc(fib)
	.dwattr $C$DW$88, DW_AT_high_pc(0x00)
	.dwattr $C$DW$88, DW_AT_TI_symbol_name("fib")
	.dwattr $C$DW$88, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$88, DW_AT_TI_begin_file("t1.c")
	.dwattr $C$DW$88, DW_AT_TI_begin_line(0x14)
	.dwattr $C$DW$88, DW_AT_TI_begin_column(0x0c)
	.dwattr $C$DW$88, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$88, DW_AT_decl_line(0x14)
	.dwattr $C$DW$88, DW_AT_decl_column(0x0c)
	.dwattr $C$DW$88, DW_AT_TI_max_frame_size(0x18)
	.dwpsn	file "t1.c",line 20,column 23,is_stmt,address fib,isa 0

	.dwfde $C$DW$CIE, fib
$C$DW$89	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$89, DW_AT_name("n")
	.dwattr $C$DW$89, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$89, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$89, DW_AT_location[DW_OP_reg4]


;******************************************************************************
;* FUNCTION NAME: fib                                                         *
;*                                                                            *
;*   Regs Modified     : A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A16,A17,A18,   *
;*                           A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30, *
;*                           A31,B0,B1,B2,B3,B4,B5,B6,B7,B8,B9,B13,SP,B16,B17,*
;*                           B18,B19,B20,B21,B22,B23,B24,B25,B26,B27,B28,B29, *
;*                           B30,B31                                          *
;*   Regs Used         : A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A16,A17,A18,   *
;*                           A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30, *
;*                           A31,B0,B1,B2,B3,B4,B5,B6,B7,B8,B9,B13,DP,SP,B16, *
;*                           B17,B18,B19,B20,B21,B22,B23,B24,B25,B26,B27,B28, *
;*                           B29,B30,B31                                      *
;*   Local Frame Size  : 0 Args + 0 Auto + 24 Save = 24 byte                  *
;******************************************************************************
fib:
;** --------------------------------------------------------------------------*
$C$DW$90	.dwtag  DW_TAG_variable
	.dwattr $C$DW$90, DW_AT_name("n")
	.dwattr $C$DW$90, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$90, DW_AT_type(*$C$DW$T$130)
	.dwattr $C$DW$90, DW_AT_location[DW_OP_reg10]

	.dwcfi	cfa_offset, 0

           CMPLT   .L1     A4,2,A0           ; [A_L674] |20| 
||         STW     .D2T2   B13,*SP++(-8)     ; [B_D64P] |20| 
||         MV      .L2     B3,B13            ; [B_L674] |20| 
	.dwcfi	cfa_offset, 8
	.dwcfi	save_reg_to_mem, 29, 0
	.dwcfi	save_reg_to_reg, 19, 29

   [ A0]   B       .S2     $C$L1             ; [B_Sb674] |20| 
||         STDW    .D2T1   A11:A10,*SP++(-8) ; [B_D64P] |20| 
||         MV      .L1     A4,A10            ; [A_L674] |20| 
||         SUB     .S1     A4,1,A4           ; [A_S674] |20| 
|| [ A0]   MV      .L2     B13,B3            ; [B_L674] |20| 

	.dwcfi	cfa_offset, 16
	.dwcfi	save_reg_to_mem, 11, -4
	.dwcfi	save_reg_to_mem, 10, -8
	.dwpsn	file "t1.c",line 20,column 25,is_stmt,isa 0
$C$DW$91	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$91, DW_AT_low_pc(0x00)
	.dwattr $C$DW$91, DW_AT_name("fib")
	.dwattr $C$DW$91, DW_AT_TI_call


   [!A0]   CALL    .S1     fib               ; [A_S674] |20| 
|| [ A0]   MV      .L1     A10,A4            ; [A_L674] |20| 
|| [ A0]   LDDW    .D2T1   *++SP(8),A11:A10  ; [B_D64P] |20| 

	.dwpsn	file "t1.c",line 20,column 69,is_stmt,isa 0
$C$DW$92	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$92, DW_AT_low_pc(0x00)
	.dwattr $C$DW$92, DW_AT_TI_return


   [ A0]   RETNOP          B3,3              ; [] |20| 
|| [ A0]   LDW     .D2T2   *++SP(8),B13      ; [B_D64P] |20| 

	.dwpsn	file "t1.c",line 20,column 25,is_stmt,isa 0
           ; BRANCHCC OCCURS {$C$L1}         ; [] |20| 
;** --------------------------------------------------------------------------*
           ADDKPC  .S2     $C$RL6,B3,0       ; [B_Sb674] |20| 
$C$RL6:    ; CALL OCCURS {fib} {0}           ; [] |20| 
;** --------------------------------------------------------------------------*
$C$DW$93	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$93, DW_AT_low_pc(0x00)
	.dwattr $C$DW$93, DW_AT_name("fib")
	.dwattr $C$DW$93, DW_AT_TI_call


           CALLP   .S2     fib,B3            ; [B_Sb674] |20| 
||         SUB     .L1     A10,2,A4          ; [A_L674] |20| 
||         MV      .S1     A4,A11            ; [A_S674] |20| 

$C$RL4:    ; CALLP OCCURS {fib} {0}          ; [] |20| 
;** --------------------------------------------------------------------------*

           ADD     .L1     A4,A11,A10        ; [A_L674] |20| 
||         MV      .L2     B13,B3            ; [B_L674] |20| 

	.dwcfi	restore_reg, 19
$C$DW$94	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$94, DW_AT_low_pc(0x08)
	.dwattr $C$DW$94, DW_AT_TI_return


           MV      .L1     A10,A4            ; [A_L674] |20| 
||         LDDW    .D2T1   *++SP(8),A11:A10  ; [B_D64P] |20| 
||         RET     .S2     B3                ; [B_Sb674] |20| 

	.dwcfi	cfa_offset, 8
	.dwcfi	restore_reg, 11
	.dwcfi	restore_reg, 10
	.dwpsn	file "t1.c",line 20,column 69,is_stmt,isa 0
           LDW     .D2T2   *++SP(8),B13      ; [B_D64P] |20| 
	.dwcfi	cfa_offset, 0
	.dwcfi	restore_reg, 29
           NOP             2                 ; [A_L674] 
;** --------------------------------------------------------------------------*
$C$L1:    
	.dwcfi	restore_reg, 19
	.dwcfi	cfa_offset, 8
	.dwcfi	restore_reg, 11
	.dwcfi	restore_reg, 10
	.dwcfi	cfa_offset, 0
	.dwcfi	restore_reg, 29
           NOP             2                 ; [A_L674] 
           ; BRANCH OCCURS {B3}              ; [] |20| 
	.dwattr $C$DW$88, DW_AT_TI_end_file("t1.c")
	.dwattr $C$DW$88, DW_AT_TI_end_line(0x14)
	.dwattr $C$DW$88, DW_AT_TI_end_column(0x45)
	.dwendentry
	.dwendtag $C$DW$88

	.sect	".text"
	.clink

$C$DW$95	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$95, DW_AT_name("cmp_int")
	.dwattr $C$DW$95, DW_AT_low_pc(cmp_int)
	.dwattr $C$DW$95, DW_AT_high_pc(0x00)
	.dwattr $C$DW$95, DW_AT_TI_symbol_name("cmp_int")
	.dwattr $C$DW$95, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$95, DW_AT_TI_begin_file("t1.c")
	.dwattr $C$DW$95, DW_AT_TI_begin_line(0x13)
	.dwattr $C$DW$95, DW_AT_TI_begin_column(0x0c)
	.dwattr $C$DW$95, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$95, DW_AT_decl_line(0x13)
	.dwattr $C$DW$95, DW_AT_decl_column(0x0c)
	.dwattr $C$DW$95, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t1.c",line 19,column 50,is_stmt,address cmp_int,isa 0

	.dwfde $C$DW$CIE, cmp_int
$C$DW$96	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$96, DW_AT_name("a")
	.dwattr $C$DW$96, DW_AT_TI_symbol_name("a")
	.dwattr $C$DW$96, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$96, DW_AT_location[DW_OP_reg4]

$C$DW$97	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$97, DW_AT_name("b")
	.dwattr $C$DW$97, DW_AT_TI_symbol_name("b")
	.dwattr $C$DW$97, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$97, DW_AT_location[DW_OP_reg20]


;******************************************************************************
;* FUNCTION NAME: cmp_int                                                     *
;*                                                                            *
;*   Regs Modified     : A3,A4,B0,B4                                          *
;*   Regs Used         : A3,A4,B0,B3,B4                                       *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
cmp_int:
;** --------------------------------------------------------------------------*
$C$DW$98	.dwtag  DW_TAG_variable
	.dwattr $C$DW$98, DW_AT_name("b")
	.dwattr $C$DW$98, DW_AT_TI_symbol_name("b")
	.dwattr $C$DW$98, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$98, DW_AT_location[DW_OP_reg20]

$C$DW$99	.dwtag  DW_TAG_variable
	.dwattr $C$DW$99, DW_AT_name("a")
	.dwattr $C$DW$99, DW_AT_TI_symbol_name("a")
	.dwattr $C$DW$99, DW_AT_type(*$C$DW$T$60)
	.dwattr $C$DW$99, DW_AT_location[DW_OP_reg4]

	.dwcfi	cfa_offset, 0
	.dwpsn	file "t1.c",line 19,column 98,is_stmt,isa 0

           LDW     .D1T1   *A4(0),A3         ; [A_D64P] |19| 
||         LDW     .D2T2   *B4(0),B4         ; [B_D64P] |19| 

	.dwpsn	file "t1.c",line 19,column 125,is_stmt,isa 0
$C$DW$100	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$100, DW_AT_low_pc(0x00)
	.dwattr $C$DW$100, DW_AT_TI_return

           RETNOP          B3,3              ; [] |19| 
	.dwpsn	file "t1.c",line 19,column 98,is_stmt,isa 0

           CMPLT   .L2X    A3,B4,B0          ; [B_L674] |19| 
||         MVK     .L1     -1,A4             ; [A_L674] |19| 

   [!B0]   CMPGT   .L1X    A3,B4,A4          ; [A_L674] |19| 
	.dwpsn	file "t1.c",line 19,column 125,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |19| 
	.dwattr $C$DW$95, DW_AT_TI_end_file("t1.c")
	.dwattr $C$DW$95, DW_AT_TI_end_line(0x13)
	.dwattr $C$DW$95, DW_AT_TI_end_column(0x7d)
	.dwendentry
	.dwendtag $C$DW$95

	.sect	".text"
	.clink
	.global	main

$C$DW$101	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$101, DW_AT_name("main")
	.dwattr $C$DW$101, DW_AT_low_pc(main)
	.dwattr $C$DW$101, DW_AT_high_pc(0x00)
	.dwattr $C$DW$101, DW_AT_TI_symbol_name("main")
	.dwattr $C$DW$101, DW_AT_external
	.dwattr $C$DW$101, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$101, DW_AT_TI_begin_file("t1.c")
	.dwattr $C$DW$101, DW_AT_TI_begin_line(0x2a)
	.dwattr $C$DW$101, DW_AT_TI_begin_column(0x05)
	.dwattr $C$DW$101, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$101, DW_AT_decl_line(0x2a)
	.dwattr $C$DW$101, DW_AT_decl_column(0x05)
	.dwattr $C$DW$101, DW_AT_TI_max_frame_size(0x250)
	.dwpsn	file "t1.c",line 43,column 1,is_stmt,address main,isa 0

	.dwfde $C$DW$CIE, main

;******************************************************************************
;* FUNCTION NAME: main                                                        *
;*                                                                            *
;*   Regs Modified     : A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,   *
;*                           A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26, *
;*                           A27,A28,A29,A30,A31,B0,B1,B2,B3,B4,B5,B6,B7,B8,  *
;*                           B9,B10,B11,B12,B13,SP,B16,B17,B18,B19,B20,B21,   *
;*                           B22,B23,B24,B25,B26,B27,B28,B29,B30,B31          *
;*   Regs Used         : A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,   *
;*                           A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26, *
;*                           A27,A28,A29,A30,A31,B0,B1,B2,B3,B4,B5,B6,B7,B8,  *
;*                           B9,B10,B11,B12,B13,DP,SP,B16,B17,B18,B19,B20,B21,*
;*                           B22,B23,B24,B25,B26,B27,B28,B29,B30,B31          *
;*   Local Frame Size  : 40 Args + 492 Auto + 56 Save = 588 byte              *
;******************************************************************************
main:
;** --------------------------------------------------------------------------*
$C$DW$102	.dwtag  DW_TAG_variable
	.dwattr $C$DW$102, DW_AT_name("ops")
	.dwattr $C$DW$102, DW_AT_TI_symbol_name("ops")
	.dwattr $C$DW$102, DW_AT_type(*$C$DW$T$126)
	.dwattr $C$DW$102, DW_AT_location[DW_OP_breg31 448]

$C$DW$103	.dwtag  DW_TAG_variable
	.dwattr $C$DW$103, DW_AT_name("f")
	.dwattr $C$DW$103, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$103, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$103, DW_AT_location[DW_OP_breg31 464]

$C$DW$104	.dwtag  DW_TAG_variable
	.dwattr $C$DW$104, DW_AT_name("u")
	.dwattr $C$DW$104, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$104, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$104, DW_AT_location[DW_OP_breg31 468]

$C$DW$105	.dwtag  DW_TAG_variable
	.dwattr $C$DW$105, DW_AT_name("f")
	.dwattr $C$DW$105, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$105, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$105, DW_AT_location[DW_OP_breg31 472]

$C$DW$106	.dwtag  DW_TAG_variable
	.dwattr $C$DW$106, DW_AT_name("u")
	.dwattr $C$DW$106, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$106, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$106, DW_AT_location[DW_OP_breg31 476]

$C$DW$107	.dwtag  DW_TAG_variable
	.dwattr $C$DW$107, DW_AT_name("f")
	.dwattr $C$DW$107, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$107, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$107, DW_AT_location[DW_OP_breg31 480]

$C$DW$108	.dwtag  DW_TAG_variable
	.dwattr $C$DW$108, DW_AT_name("u")
	.dwattr $C$DW$108, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$108, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$108, DW_AT_location[DW_OP_breg31 484]

$C$DW$109	.dwtag  DW_TAG_variable
	.dwattr $C$DW$109, DW_AT_name("f")
	.dwattr $C$DW$109, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$109, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$109, DW_AT_location[DW_OP_breg31 488]

$C$DW$110	.dwtag  DW_TAG_variable
	.dwattr $C$DW$110, DW_AT_name("u")
	.dwattr $C$DW$110, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$110, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$110, DW_AT_location[DW_OP_breg31 492]

$C$DW$111	.dwtag  DW_TAG_variable
	.dwattr $C$DW$111, DW_AT_name("f")
	.dwattr $C$DW$111, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$111, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$111, DW_AT_location[DW_OP_breg31 496]

$C$DW$112	.dwtag  DW_TAG_variable
	.dwattr $C$DW$112, DW_AT_name("u")
	.dwattr $C$DW$112, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$112, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$112, DW_AT_location[DW_OP_breg31 500]

$C$DW$113	.dwtag  DW_TAG_variable
	.dwattr $C$DW$113, DW_AT_name("f")
	.dwattr $C$DW$113, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$113, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$113, DW_AT_location[DW_OP_breg31 504]

$C$DW$114	.dwtag  DW_TAG_variable
	.dwattr $C$DW$114, DW_AT_name("u")
	.dwattr $C$DW$114, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$114, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$114, DW_AT_location[DW_OP_breg31 508]

$C$DW$115	.dwtag  DW_TAG_variable
	.dwattr $C$DW$115, DW_AT_name("f")
	.dwattr $C$DW$115, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$115, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$115, DW_AT_location[DW_OP_breg31 512]

$C$DW$116	.dwtag  DW_TAG_variable
	.dwattr $C$DW$116, DW_AT_name("u")
	.dwattr $C$DW$116, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$116, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$116, DW_AT_location[DW_OP_breg31 516]

$C$DW$117	.dwtag  DW_TAG_variable
	.dwattr $C$DW$117, DW_AT_name("y")
	.dwattr $C$DW$117, DW_AT_TI_symbol_name("y")
	.dwattr $C$DW$117, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$117, DW_AT_location[DW_OP_breg31 520]

$C$DW$118	.dwtag  DW_TAG_variable
	.dwattr $C$DW$118, DW_AT_name("f")
	.dwattr $C$DW$118, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$118, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$118, DW_AT_location[DW_OP_breg31 524]

$C$DW$119	.dwtag  DW_TAG_variable
	.dwattr $C$DW$119, DW_AT_name("u")
	.dwattr $C$DW$119, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$119, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$119, DW_AT_location[DW_OP_breg31 528]

$C$DW$120	.dwtag  DW_TAG_variable
	.dwattr $C$DW$120, DW_AT_name("i")
	.dwattr $C$DW$120, DW_AT_TI_symbol_name("i")
	.dwattr $C$DW$120, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$120, DW_AT_location[DW_OP_reg20]

$C$DW$121	.dwtag  DW_TAG_variable
	.dwattr $C$DW$121, DW_AT_name("i")
	.dwattr $C$DW$121, DW_AT_TI_symbol_name("i")
	.dwattr $C$DW$121, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$121, DW_AT_location[DW_OP_reg21]

$C$DW$122	.dwtag  DW_TAG_variable
	.dwattr $C$DW$122, DW_AT_name("i")
	.dwattr $C$DW$122, DW_AT_TI_symbol_name("i")
	.dwattr $C$DW$122, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$122, DW_AT_location[DW_OP_reg21]

$C$DW$123	.dwtag  DW_TAG_variable
	.dwattr $C$DW$123, DW_AT_name("i")
	.dwattr $C$DW$123, DW_AT_TI_symbol_name("i")
	.dwattr $C$DW$123, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$123, DW_AT_location[DW_OP_reg9]

$C$DW$124	.dwtag  DW_TAG_variable
	.dwattr $C$DW$124, DW_AT_name("i")
	.dwattr $C$DW$124, DW_AT_TI_symbol_name("i")
	.dwattr $C$DW$124, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$124, DW_AT_location[DW_OP_reg7]

$C$DW$125	.dwtag  DW_TAG_variable
	.dwattr $C$DW$125, DW_AT_name("i")
	.dwattr $C$DW$125, DW_AT_TI_symbol_name("i")
	.dwattr $C$DW$125, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$125, DW_AT_location[DW_OP_reg8]

$C$DW$126	.dwtag  DW_TAG_variable
	.dwattr $C$DW$126, DW_AT_name("h")
	.dwattr $C$DW$126, DW_AT_TI_symbol_name("h")
	.dwattr $C$DW$126, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$126, DW_AT_location[DW_OP_reg4]

$C$DW$127	.dwtag  DW_TAG_variable
	.dwattr $C$DW$127, DW_AT_name("h")
	.dwattr $C$DW$127, DW_AT_TI_symbol_name("h")
	.dwattr $C$DW$127, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$127, DW_AT_location[DW_OP_reg4]

$C$DW$128	.dwtag  DW_TAG_variable
	.dwattr $C$DW$128, DW_AT_name("j")
	.dwattr $C$DW$128, DW_AT_TI_symbol_name("j")
	.dwattr $C$DW$128, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$128, DW_AT_location[DW_OP_reg24]

$C$DW$129	.dwtag  DW_TAG_variable
	.dwattr $C$DW$129, DW_AT_name("a")
	.dwattr $C$DW$129, DW_AT_TI_symbol_name("a")
	.dwattr $C$DW$129, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$129, DW_AT_location[DW_OP_reg9]

$C$DW$130	.dwtag  DW_TAG_variable
	.dwattr $C$DW$130, DW_AT_name("b")
	.dwattr $C$DW$130, DW_AT_TI_symbol_name("b")
	.dwattr $C$DW$130, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$130, DW_AT_location[DW_OP_reg23]

$C$DW$131	.dwtag  DW_TAG_variable
	.dwattr $C$DW$131, DW_AT_name("ua")
	.dwattr $C$DW$131, DW_AT_TI_symbol_name("ua")
	.dwattr $C$DW$131, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$131, DW_AT_location[DW_OP_regx 0x25]

$C$DW$132	.dwtag  DW_TAG_variable
	.dwattr $C$DW$132, DW_AT_name("x")
	.dwattr $C$DW$132, DW_AT_TI_symbol_name("x")
	.dwattr $C$DW$132, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$132, DW_AT_location[DW_OP_reg11 DW_OP_piece 4 DW_OP_reg14 DW_OP_piece 4]

$C$DW$133	.dwtag  DW_TAG_variable
	.dwattr $C$DW$133, DW_AT_name("fx")
	.dwattr $C$DW$133, DW_AT_TI_symbol_name("fx")
	.dwattr $C$DW$133, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$133, DW_AT_location[DW_OP_reg9]

$C$DW$134	.dwtag  DW_TAG_variable
	.dwattr $C$DW$134, DW_AT_name("fy")
	.dwattr $C$DW$134, DW_AT_TI_symbol_name("fy")
	.dwattr $C$DW$134, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$134, DW_AT_location[DW_OP_reg23]

$C$DW$135	.dwtag  DW_TAG_variable
	.dwattr $C$DW$135, DW_AT_name("dx")
	.dwattr $C$DW$135, DW_AT_TI_symbol_name("dx")
	.dwattr $C$DW$135, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$135, DW_AT_location[DW_OP_reg24]

$C$DW$136	.dwtag  DW_TAG_variable
	.dwattr $C$DW$136, DW_AT_name("dy")
	.dwattr $C$DW$136, DW_AT_TI_symbol_name("dy")
	.dwattr $C$DW$136, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$136, DW_AT_location[DW_OP_reg6]

$C$DW$137	.dwtag  DW_TAG_variable
	.dwattr $C$DW$137, DW_AT_name("acc")
	.dwattr $C$DW$137, DW_AT_TI_symbol_name("acc")
	.dwattr $C$DW$137, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$137, DW_AT_location[DW_OP_reg5]

$C$DW$138	.dwtag  DW_TAG_variable
	.dwattr $C$DW$138, DW_AT_name("acc64")
	.dwattr $C$DW$138, DW_AT_TI_symbol_name("acc64")
	.dwattr $C$DW$138, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$138, DW_AT_location[DW_OP_reg6 DW_OP_piece 4 DW_OP_reg8 DW_OP_piece 4]

$C$DW$139	.dwtag  DW_TAG_variable
	.dwattr $C$DW$139, DW_AT_name("h")
	.dwattr $C$DW$139, DW_AT_TI_symbol_name("h")
	.dwattr $C$DW$139, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$139, DW_AT_location[DW_OP_reg3]

$C$DW$140	.dwtag  DW_TAG_variable
	.dwattr $C$DW$140, DW_AT_name("h")
	.dwattr $C$DW$140, DW_AT_TI_symbol_name("h")
	.dwattr $C$DW$140, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$140, DW_AT_location[DW_OP_reg4]

$C$DW$141	.dwtag  DW_TAG_variable
	.dwattr $C$DW$141, DW_AT_name("s")
	.dwattr $C$DW$141, DW_AT_TI_symbol_name("s")
	.dwattr $C$DW$141, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$141, DW_AT_location[DW_OP_reg4]

$C$DW$142	.dwtag  DW_TAG_variable
	.dwattr $C$DW$142, DW_AT_name("v")
	.dwattr $C$DW$142, DW_AT_TI_symbol_name("v")
	.dwattr $C$DW$142, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$142, DW_AT_location[DW_OP_reg4]

$C$DW$143	.dwtag  DW_TAG_variable
	.dwattr $C$DW$143, DW_AT_name("string1")
	.dwattr $C$DW$143, DW_AT_TI_symbol_name("string1")
	.dwattr $C$DW$143, DW_AT_type(*$C$DW$T$106)
	.dwattr $C$DW$143, DW_AT_location[DW_OP_reg20]

$C$DW$144	.dwtag  DW_TAG_variable
	.dwattr $C$DW$144, DW_AT_name("string2")
	.dwattr $C$DW$144, DW_AT_TI_symbol_name("string2")
	.dwattr $C$DW$144, DW_AT_type(*$C$DW$T$106)
	.dwattr $C$DW$144, DW_AT_location[DW_OP_reg4]

$C$DW$145	.dwtag  DW_TAG_variable
	.dwattr $C$DW$145, DW_AT_name("c1")
	.dwattr $C$DW$145, DW_AT_TI_symbol_name("c1")
	.dwattr $C$DW$145, DW_AT_type(*$C$DW$T$6)
	.dwattr $C$DW$145, DW_AT_location[DW_OP_reg21]

$C$DW$146	.dwtag  DW_TAG_variable
	.dwattr $C$DW$146, DW_AT_name("res")
	.dwattr $C$DW$146, DW_AT_TI_symbol_name("res")
	.dwattr $C$DW$146, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$146, DW_AT_location[DW_OP_reg4]

$C$DW$147	.dwtag  DW_TAG_variable
	.dwattr $C$DW$147, DW_AT_name("f")
	.dwattr $C$DW$147, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$147, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$147, DW_AT_location[DW_OP_reg20]

	.dwcfi	cfa_offset, 0
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0

           LDW     .D2T1   *+DP(lcg),A4      ; [B_D64P] |17| 
||         MVKL    .S1     0x41c64e6d,A3     ; [A_S674] |17| 
||         MVKL    .S2     0x41c64e6d,B4     ; [B_Sb674] |47| 
||         ZERO    .L1     A8                ; [A_L674] |46| 

           STW     .D2T1   A11,*SP++(-8)     ; [B_D64P] |43| 
||         MVKH    .S1     0x41c64e6d,A3     ; [A_S674] |17| 
||         MVKH    .S2     0x41c64e6d,B4     ; [B_Sb674] |47| 

	.dwcfi	cfa_offset, 8
	.dwcfi	save_reg_to_mem, 11, 0
	.dwpsn	file "t1.c",line 43,column 1,is_stmt,isa 0
           STW     .D2T1   A10,*SP++(-8)     ; [B_D64P] |43| 
	.dwcfi	cfa_offset, 16
	.dwcfi	save_reg_to_mem, 10, -8
           STDW    .D2T2   B13:B12,*SP++(-8) ; [B_D64P] |43| 
	.dwcfi	cfa_offset, 24
	.dwcfi	save_reg_to_mem, 29, -12
	.dwcfi	save_reg_to_mem, 28, -16
           STDW    .D2T2   B11:B10,*SP++(-8) ; [B_D64P] |43| 
	.dwcfi	cfa_offset, 32
	.dwcfi	save_reg_to_mem, 27, -20
	.dwcfi	save_reg_to_mem, 26, -24
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0

           MPY32   .M1     A3,A4,A3          ; [A_M674] |17| 
||         STDW    .D2T1   A15:A14,*SP++(-8) ; [B_D64P] |43| 
||         MV      .L1X    B4,A4             ; [A_L674] |47| 

	.dwcfi	cfa_offset, 40
	.dwcfi	save_reg_to_mem, 15, -28
	.dwcfi	save_reg_to_mem, 14, -32
	.dwpsn	file "t1.c",line 43,column 1,is_stmt,isa 0

           STDW    .D2T1   A13:A12,*SP++(-8) ; [B_D64P] |43| 
||         MVK     .S1     12345,A12         ; [A_S674] 

	.dwcfi	cfa_offset, 48
	.dwcfi	save_reg_to_mem, 13, -36
	.dwcfi	save_reg_to_mem, 12, -40
           STW     .D2T2   B3,*SP++(-8)      ; [B_D64P] |43| 
	.dwcfi	cfa_offset, 56
	.dwcfi	save_reg_to_mem, 19, -48
           ADDK    .S2     -536,SP           ; [B_Sb674] |43| 
	.dwcfi	cfa_offset, 592
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0
           ADD     .L1     A12,A3,A9         ; [A_L674] |17| 
	.dwpsn	file "t1.c",line 47,column 31,is_stmt,isa 0
           MPY32   .M1X    B4,A9,A3          ; [A_M674] |47| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 46
;*    Loop opening brace source line   : 46
;*    Loop closing brace source line   : 51
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains control code
;*    Disqualified loop: Bad loop structure
;*----------------------------------------------------------------------------*
$C$L2:    
           NOP             3                 ; [A_L674] 
           ADD     .L1     A12,A3,A3         ; [A_L674] |47| 
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0
           MPY32   .M1     A4,A3,A4          ; [A_M674] |17| 
	.dwpsn	file "t1.c",line 47,column 31,is_stmt,isa 0
           SHRU    .S1     A3,A8,A3          ; [A_S674] |47| 
           NOP             2                 ; [A_L674] 
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0
           ADD     .L1     A12,A4,A16        ; [A_L674] |17| 
	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0
$C$DW$148	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$148, DW_AT_low_pc(0x04)
	.dwattr $C$DW$148, DW_AT_name("__c6xabi_divi")
	.dwattr $C$DW$148, DW_AT_TI_call


           MPY32   .M1X    B4,A16,A4         ; [A_M674] |17| 
||         CALL    .S1     __c6xabi_divi     ; [A_S674] |49| 

	.dwpsn	file "t1.c",line 47,column 31,is_stmt,isa 0
           OR      .L2X    1,A3,B7           ; [B_L674] |47| 
	.dwpsn	file "t1.c",line 49,column 9,is_stmt,isa 0
           MV      .L2     B7,B4             ; [B_L674] |49| 
           ADDKPC  .S2     $C$RL8,B3,0       ; [B_Sb674] |49| 
	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0

           ADD     .L1     A12,A4,A7         ; [A_L674] |17| 
||         MV      .S1     A9,A4             ; [A_S674] |49| 

           STW     .D2T1   A7,*+DP(lcg)      ; [B_D64P] |17| 
	.dwpsn	file "t1.c",line 49,column 9,is_stmt,isa 0
$C$RL8:    ; CALL OCCURS {__c6xabi_divi} {0}  ; [] |49| 
;** --------------------------------------------------------------------------*
$C$DW$149	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$149, DW_AT_low_pc(0x00)
	.dwattr $C$DW$149, DW_AT_name("put")
	.dwattr $C$DW$149, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |49| 
$C$RL10:   ; CALLP OCCURS {put} {0}          ; [] |49| 
	.dwpsn	file "t1.c",line 49,column 33,is_stmt,isa 0
$C$DW$150	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$150, DW_AT_low_pc(0x00)
	.dwattr $C$DW$150, DW_AT_name("__c6xabi_remi")
	.dwattr $C$DW$150, DW_AT_TI_call


           CALLP   .S2     __c6xabi_remi,B3  ; [B_Sb674] |49| 
||         MV      .L2     B7,B4             ; [B_L674] |49| 
||         MV      .L1     A9,A4             ; [A_L674] |49| 

$C$RL12:   ; CALLP OCCURS {__c6xabi_remi} {0}  ; [] |49| 
$C$DW$151	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$151, DW_AT_low_pc(0x00)
	.dwattr $C$DW$151, DW_AT_name("put")
	.dwattr $C$DW$151, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |49| 
$C$RL14:   ; CALLP OCCURS {put} {0}          ; [] |49| 
	.dwpsn	file "t1.c",line 49,column 57,is_stmt,isa 0
           SHRU    .S1     A7,A8,A3          ; [A_S674] |49| 
           MV      .L1     A16,A4            ; [A_L674] |49| 
           OR      .L2X    1,A3,B7           ; [B_L674] |49| 
$C$DW$152	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$152, DW_AT_low_pc(0x04)
	.dwattr $C$DW$152, DW_AT_name("__c6xabi_divu")
	.dwattr $C$DW$152, DW_AT_TI_call


           MV      .L2     B7,B4             ; [B_L674] |49| 
||         CALLP   .S2     __c6xabi_divu,B3  ; [B_Sb674] |49| 

$C$RL16:   ; CALLP OCCURS {__c6xabi_divu} {0}  ; [] |49| 
$C$DW$153	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$153, DW_AT_low_pc(0x00)
	.dwattr $C$DW$153, DW_AT_name("put")
	.dwattr $C$DW$153, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |49| 
$C$RL18:   ; CALLP OCCURS {put} {0}          ; [] |49| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 49,column 71,is_stmt,isa 0
$C$DW$154	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$154, DW_AT_low_pc(0x00)
	.dwattr $C$DW$154, DW_AT_name("__c6xabi_remu")
	.dwattr $C$DW$154, DW_AT_TI_call


           CALLP   .S2     __c6xabi_remu,B3  ; [B_Sb674] |49| 
||         MV      .L2     B7,B4             ; [B_L674] |49| 
||         MV      .L1     A16,A4            ; [A_L674] |49| 

$C$RL20:   ; CALLP OCCURS {__c6xabi_remu} {0}  ; [] |49| 
$C$DW$155	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$155, DW_AT_low_pc(0x00)
	.dwattr $C$DW$155, DW_AT_name("put")
	.dwattr $C$DW$155, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |49| 
$C$RL22:   ; CALLP OCCURS {put} {0}          ; [] |49| 
	.dwpsn	file "t1.c",line 50,column 9,is_stmt,isa 0
$C$DW$156	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$156, DW_AT_low_pc(0x00)
	.dwattr $C$DW$156, DW_AT_name("put")
	.dwattr $C$DW$156, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |50| 
||         SHR     .S1     A9,A8,A4          ; [A_S674] |50| 

$C$RL24:   ; CALLP OCCURS {put} {0}          ; [] |50| 
	.dwpsn	file "t1.c",line 50,column 41,is_stmt,isa 0
$C$DW$157	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$157, DW_AT_low_pc(0x00)
	.dwattr $C$DW$157, DW_AT_name("put")
	.dwattr $C$DW$157, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |50| 
||         SHRU    .S1     A16,A8,A4         ; [A_S674] |50| 

$C$RL26:   ; CALLP OCCURS {put} {0}          ; [] |50| 
	.dwpsn	file "t1.c",line 50,column 62,is_stmt,isa 0
$C$DW$158	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$158, DW_AT_low_pc(0x00)
	.dwattr $C$DW$158, DW_AT_name("put")
	.dwattr $C$DW$158, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |50| 
||         SHL     .S1     A9,A8,A4          ; [A_S674] |50| 

$C$RL28:   ; CALLP OCCURS {put} {0}          ; [] |50| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0

           LDW     .D2T1   *+DP(lcg),A4      ; [B_D64P] |17| 
||         ADD     .L1     1,A8,A8           ; [A_L674] |46| 

	.dwpsn	file "t1.c",line 46,column 17,is_stmt,isa 0
           MVK     .S2     20,B4             ; [B_Sb674] |46| 
           CMPLT   .L2X    A8,B4,B0          ; [B_L674] |46| 
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0

   [ B0]   MVKL    .S1     0x41c64e6d,A3     ; [A_S674] |17| 
|| [ B0]   MVKL    .S2     0x41c64e6d,B4     ; [B_Sb674] |47| 

   [ B0]   MVKH    .S1     0x41c64e6d,A3     ; [A_S674] |17| 
|| [ B0]   MVKH    .S2     0x41c64e6d,B4     ; [B_Sb674] |47| 

   [ B0]   BNOP            $C$L2,2           ; [] |46| 
||         MPY32   .M1     A3,A4,A3          ; [A_M674] |17| 

	.dwpsn	file "t1.c",line 47,column 31,is_stmt,isa 0
   [ B0]   MV      .L1X    B4,A4             ; [A_L674] |47| 
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0
           ADD     .L1     A12,A3,A9         ; [A_L674] |17| 
	.dwpsn	file "t1.c",line 47,column 31,is_stmt,isa 0

           MPY32   .M1X    B4,A9,A3          ; [A_M674] |47| 
|| [!B0]   MVK     .L2     10,B4             ; [B_L674] |53| 

	.dwpsn	file "t1.c",line 46,column 17,is_stmt,isa 0
           ; BRANCHCC OCCURS {$C$L2}         ; [] |46| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 54,column 21,is_stmt,isa 0
           LDW     .D2T1   *+DP(lcg),A3      ; [B_D64P] |54| 
           MVKL    .S1     0x41c64e6d,A4     ; [A_S674] |54| 
           ZERO    .L1     A30               ; [A_L674] |54| 
           ZERO    .L2     B11               ; [B_L674] 
           MVKH    .S1     0x41c64e6d,A4     ; [A_S674] |54| 
           MPY32   .M1     A4,A3,A3          ; [A_M674] |54| 
           ZERO    .L2     B10               ; [B_L674] 
           MV      .L1X    B4,A13            ; [A_L674] 
           MV      .L2X    A4,B4             ; [B_L674] |54| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 53
;*    Loop opening brace source line   : 53
;*    Loop closing brace source line   : 60
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains control code
;*    Disqualified loop: Bad loop structure
;*----------------------------------------------------------------------------*
$C$L3:    
           ADD     .L1     A12,A3,A14        ; [A_L674] |54| 
           MPY32   .M1X    B4,A14,A3         ; [A_M674] |54| 
           NOP             3                 ; [A_L674] 
           ADD     .L1     A12,A3,A3         ; [A_L674] |54| 
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0
           MPY32   .M1     A4,A3,A4          ; [A_M674] |17| 
	.dwpsn	file "t1.c",line 54,column 21,is_stmt,isa 0
           OR      .L1     A3,A30,A11        ; [A_L674] |54| 
           NOP             2                 ; [A_L674] 
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0
           ADD     .L1     A12,A4,A4         ; [A_L674] |17| 
	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0
           MPY32   .M1X    B4,A4,A5          ; [A_M674] |17| 
	.dwpsn	file "t1.c",line 57,column 9,is_stmt,isa 0
           SHRU    .S1     A4,3,A6           ; [A_S674] |57| 
           SHL     .S1     A6,20,A31         ; [A_S674] |57| 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0
           ADD     .L1     A12,A5,A7         ; [A_L674] |17| 
	.dwpsn	file "t1.c",line 57,column 9,is_stmt,isa 0
$C$DW$159	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$159, DW_AT_low_pc(0x04)
	.dwattr $C$DW$159, DW_AT_name("put")
	.dwattr $C$DW$159, DW_AT_TI_call


           OR      .L1     A7,A31,A8         ; [A_L674] |57| 
||         CALL    .S1     put               ; [A_S674] |57| 

           OR      .L1     1,A8,A3           ; [A_L674] |57| 
           MPY32   .M1     A11,A3,A4         ; [A_M674] |57| 
	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0
           STW     .D2T1   A7,*+DP(lcg)      ; [B_D64P] |17| 
	.dwpsn	file "t1.c",line 57,column 9,is_stmt,isa 0
           ADDKPC  .S2     $C$RL30,B3,1      ; [B_Sb674] |57| 
$C$RL30:   ; CALL OCCURS {put} {0}           ; [] |57| 
;** --------------------------------------------------------------------------*

           ZERO    .L2     B4                ; [B_L674] |57| 
||         SHRU    .S2X    A6,12,B5          ; [B_Sb674] |57| 

           SHL     .S2     B4,20,B4          ; [B_Sb674] |57| 
||         OR      .L1     A7,A31,A3         ; [A_L674] |57| 

           OR      .L2     B5,B4,B4          ; [B_L674] |57| 
	.dwpsn	file "t1.c",line 57,column 28,is_stmt,isa 0

           MV      .L2     B4,B13            ; [B_L674] |57| 
||         OR      .S2X    1,A3,B12          ; [B_Sb674] |57| 

           MPY32SU .M2X    B13,A11,B7:B6     ; [B_M674] |57| 
           MPY32SU .M2X    A14,B12,B5:B4     ; [B_M674] |57| 
           MPY32U  .M1X    A11,B12,A5:A4     ; [A_M674] |57| 
           NOP             2                 ; [A_L674] 
           ADD     .L2     B4,B6,B4          ; [B_L674] |57| 
           NOP             1                 ; [A_L674] 
$C$DW$160	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$160, DW_AT_low_pc(0x00)
	.dwattr $C$DW$160, DW_AT_name("put")
	.dwattr $C$DW$160, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |57| 
||         ADD     .L1X    A5,B4,A4          ; [A_L674] |57| 

$C$RL32:   ; CALLP OCCURS {put} {0}          ; [] |57| 
	.dwpsn	file "t1.c",line 58,column 9,is_stmt,isa 0
$C$DW$161	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$161, DW_AT_low_pc(0x08)
	.dwattr $C$DW$161, DW_AT_name("__c6xabi_divlli")
	.dwattr $C$DW$161, DW_AT_TI_call


           MV      .L2     B13,B5            ; [B_L674] |58| 
||         MV      .D2     B12,B4            ; [B_D64P] |58| 
||         CALLP   .S2     __c6xabi_divlli,B3 ; [B_Sb674] |58| 
||         MV      .L1     A11,A4            ; [A_L674] |58| 
||         MV      .S1     A14,A5            ; [A_S674] |58| 

$C$RL34:   ; CALLP OCCURS {__c6xabi_divlli} {0}  ; [] |58| 
$C$DW$162	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$162, DW_AT_low_pc(0x00)
	.dwattr $C$DW$162, DW_AT_name("put")
	.dwattr $C$DW$162, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |58| 
$C$RL36:   ; CALLP OCCURS {put} {0}          ; [] |58| 
$C$DW$163	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$163, DW_AT_low_pc(0x00)
	.dwattr $C$DW$163, DW_AT_name("put")
	.dwattr $C$DW$163, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |58| 
||         MV      .L1     A5,A4             ; [A_L674] |58| 

	.dwpsn	file "t1.c",line 58,column 28,is_stmt,isa 0
$C$RL38:   ; CALLP OCCURS {put} {0}          ; [] |58| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 59,column 9,is_stmt,isa 0
$C$DW$164	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$164, DW_AT_low_pc(0x00)
	.dwattr $C$DW$164, DW_AT_name("__c6xabi_remlli")
	.dwattr $C$DW$164, DW_AT_TI_call


           CALLP   .S2     __c6xabi_remlli,B3 ; [B_Sb674] |59| 
||         MV      .L2     B13,B5            ; [B_L674] |59| 
||         MV      .D2     B12,B4            ; [B_D64P] |59| 
||         MV      .L1     A14,A5            ; [A_L674] |59| 
||         MV      .S1     A11,A4            ; [A_S674] |59| 

$C$RL40:   ; CALLP OCCURS {__c6xabi_remlli} {0}  ; [] |59| 
$C$DW$165	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$165, DW_AT_low_pc(0x00)
	.dwattr $C$DW$165, DW_AT_name("put")
	.dwattr $C$DW$165, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |59| 
$C$RL42:   ; CALLP OCCURS {put} {0}          ; [] |59| 
	.dwpsn	file "t1.c",line 59,column 28,is_stmt,isa 0
$C$DW$166	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$166, DW_AT_low_pc(0x00)
	.dwattr $C$DW$166, DW_AT_name("__c6xabi_divull")
	.dwattr $C$DW$166, DW_AT_TI_call


           CALLP   .S2     __c6xabi_divull,B3 ; [B_Sb674] |59| 
||         MV      .L1     A11,A4            ; [A_L674] |59| 
||         MV      .L2     B13,B5            ; [B_L674] |59| 
||         MV      .D2     B12,B4            ; [B_D64P] |59| 
||         MV      .S1     A14,A5            ; [A_S674] |59| 

$C$RL44:   ; CALLP OCCURS {__c6xabi_divull} {0}  ; [] |59| 
$C$DW$167	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$167, DW_AT_low_pc(0x00)
	.dwattr $C$DW$167, DW_AT_name("put")
	.dwattr $C$DW$167, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |59| 
$C$RL46:   ; CALLP OCCURS {put} {0}          ; [] |59| 
	.dwpsn	file "t1.c",line 59,column 54,is_stmt,isa 0
$C$DW$168	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$168, DW_AT_low_pc(0x00)
	.dwattr $C$DW$168, DW_AT_name("__c6xabi_llshru")
	.dwattr $C$DW$168, DW_AT_TI_call


           CALLP   .S2     __c6xabi_llshru,B3 ; [B_Sb674] |59| 
||         MV      .L1     A11,A4            ; [A_L674] |59| 
||         MV      .L2     B10,B4            ; [B_L674] |59| 
||         MV      .S1     A14,A5            ; [A_S674] |59| 

$C$RL50:   ; CALLP OCCURS {__c6xabi_llshru} {0}  ; [] |59| 
$C$DW$169	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$169, DW_AT_low_pc(0x00)
	.dwattr $C$DW$169, DW_AT_name("__c6xabi_llshl")
	.dwattr $C$DW$169, DW_AT_TI_call


           CALLP   .S2     __c6xabi_llshl,B3 ; [B_Sb674] |59| 
||         MV      .L1     A11,A4            ; [A_L674] |59| 
||         MV      .S1     A4,A10            ; [A_S674] |59| 
||         MV      .L2     B11,B4            ; [B_L674] |59| 
||         MV      .D1     A14,A5            ; [A_D64P] |59| 

$C$RL48:   ; CALLP OCCURS {__c6xabi_llshl} {0}  ; [] |59| 
$C$DW$170	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$170, DW_AT_low_pc(0x00)
	.dwattr $C$DW$170, DW_AT_name("put")
	.dwattr $C$DW$170, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |59| 
||         XOR     .L1     A4,A10,A4         ; [A_L674] |59| 

$C$RL52:   ; CALLP OCCURS {put} {0}          ; [] |59| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 53,column 17,is_stmt,isa 0

           ADD     .L2     5,B10,B10         ; [B_L674] |53| 
||         ADD     .S2     3,B11,B11         ; [B_Sb674] |53| 
||         LDW     .D2T1   *+DP(lcg),A3      ; [B_D64P] |54| 
||         SUB     .L1     A13,1,A0          ; [A_L674] |53| 

	.dwpsn	file "t1.c",line 54,column 21,is_stmt,isa 0
   [ A0]   MVKL    .S1     0x41c64e6d,A4     ; [A_S674] |54| 
   [ A0]   MVKH    .S1     0x41c64e6d,A4     ; [A_S674] |54| 
	.dwpsn	file "t1.c",line 53,column 17,is_stmt,isa 0
   [ A0]   BNOP            $C$L3,1           ; [] |53| 
	.dwpsn	file "t1.c",line 54,column 21,is_stmt,isa 0
           MPY32   .M1     A4,A3,A3          ; [A_M674] |54| 
	.dwpsn	file "t1.c",line 53,column 17,is_stmt,isa 0
           SUB     .L1     A13,1,A13         ; [A_L674] |53| 
	.dwpsn	file "t1.c",line 54,column 21,is_stmt,isa 0
   [ A0]   ZERO    .L1     A30               ; [A_L674] |54| 
   [ A0]   MV      .L2X    A4,B4             ; [B_L674] |54| 
	.dwpsn	file "t1.c",line 53,column 17,is_stmt,isa 0
           ; BRANCHCC OCCURS {$C$L3}         ; [] |53| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0

           LDW     .D2T1   *+DP(lcg),A4      ; [B_D64P] |63| 
||         MVK     .L1     10,A3             ; [A_L674] |62| 
||         MVKL    .S1     0x41c64e6d,A31    ; [A_S674] |17| 
||         ZERO    .D1     A11               ; [A_D64P] |64| 
||         ZERO    .L2     B12               ; [B_L674] |64| 
||         ZERO    .S2     B5                ; [B_Sb674] |64| 

           STW     .D2T1   A3,*SP(532)       ; [B_D64P] |64| 
||         MVKL    .S1     0x41c64e6d,A3     ; [A_S674] |17| 
||         ZERO    .L2     B11               ; [B_L674] 
||         ZERO    .S2     B13               ; [B_Sb674] |64| 
||         ZERO    .L1     A10               ; [A_L674] |64| 

           MVKH    .S1     0x41c64e6d,A3     ; [A_S674] |17| 
||         ZERO    .L2     B10               ; [B_L674] 
||         MV      .D2     B12,B4            ; [B_D64P] |64| 
||         MVKH    .S2     0x40080000,B5     ; [B_Sb674] |64| 

           MVKH    .S1     0x41c64e6d,A31    ; [A_S674] |17| 
||         MVKH    .S2     0x3ff40000,B13    ; [B_Sb674] |64| 

           MVKH    .S2     0x3a800000,B11    ; [B_Sb674] 
	.dwpsn	file "t1.c",line 63,column 18,is_stmt,isa 0
           MPY32   .M1     A3,A4,A3          ; [A_M674] |63| 
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0
           MVKL    .S1     0x41c64e6d,A30    ; [A_S674] |17| 
           SET     .S2     B10,24,29,B10     ; [B_Sb674] 
           MVKH    .S1     0x41c64e6d,A30    ; [A_S674] |17| 
	.dwpsn	file "t1.c",line 63,column 18,is_stmt,isa 0
           ADD     .L1     A12,A3,A13        ; [A_L674] |63| 
	.dwpsn	file "t1.c",line 63,column 53,is_stmt,isa 0
           MPY32   .M1     A31,A13,A3        ; [A_M674] |63| 
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0
           MVKL    .S1     0x41c64e6d,A29    ; [A_S674] |17| 
           MVKH    .S1     0x41c64e6d,A29    ; [A_S674] |17| 
	.dwpsn	file "t1.c",line 64,column 51,is_stmt,isa 0
           SET     .S1     A11,20,29,A11     ; [A_S674] |64| 
	.dwpsn	file "t1.c",line 63,column 53,is_stmt,isa 0
           ADD     .L1     A12,A3,A14        ; [A_L674] |63| 
	.dwpsn	file "t1.c",line 64,column 19,is_stmt,isa 0
           MPY32   .M1     A30,A14,A3        ; [A_M674] |64| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 62
;*    Loop opening brace source line   : 62
;*    Loop closing brace source line   : 69
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*----------------------------------------------------------------------------*
$C$L4:    
           NOP             3                 ; [A_L674] 
           ADD     .L1     A12,A3,A15        ; [A_L674] |64| 
	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0
           MPY32   .M1     A29,A15,A3        ; [A_M674] |17| 
           NOP             3                 ; [A_L674] 
           ADD     .L1     A12,A3,A3         ; [A_L674] |17| 
	.dwpsn	file "t1.c",line 64,column 51,is_stmt,isa 0
           SHRU    .S1     A3,4,A4           ; [A_S674] |64| 
$C$DW$171	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$171, DW_AT_low_pc(0x00)
	.dwattr $C$DW$171, DW_AT_name("__c6xabi_divd")
	.dwattr $C$DW$171, DW_AT_TI_call

           CALL    .S1     __c6xabi_divd     ; [A_S674] |64| 
           INTDPU  .L1     A4,A5:A4          ; [A_L674] |64| 
	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0
           STW     .D2T1   A3,*+DP(lcg)      ; [B_D64P] |17| 
	.dwpsn	file "t1.c",line 64,column 51,is_stmt,isa 0
           ADDKPC  .S2     $C$RL54,B3,2      ; [B_Sb674] |64| 
$C$RL54:   ; CALL OCCURS {__c6xabi_divd} {0}  ; [] |64| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 63,column 53,is_stmt,isa 0
           SHRU    .S1     A14,8,A3          ; [A_S674] |63| 
	.dwpsn	file "t1.c",line 64,column 51,is_stmt,isa 0
           MV      .L1     A4,A6             ; [A_L674] |64| 
	.dwpsn	file "t1.c",line 63,column 53,is_stmt,isa 0
           INTSP   .L2X    A3,B4             ; [B_L674] |63| 
	.dwpsn	file "t1.c",line 63,column 18,is_stmt,isa 0
           INTSP   .L1     A13,A4            ; [A_L674] |63| 
           ZERO    .L1     A31               ; [A_L674] 
           MVKH    .S1     0x37800000,A31    ; [A_S674] 
	.dwpsn	file "t1.c",line 63,column 53,is_stmt,isa 0
           MPYSP   .M2     B11,B4,B4         ; [B_M674] |63| 
	.dwpsn	file "t1.c",line 63,column 18,is_stmt,isa 0
           MPYSP   .M1     A31,A4,A9         ; [A_M674] |63| 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           MVK     .S2     464,B31           ; [B_Sb674] |12| 
           MVK     .S2     468,B30           ; [B_Sb674] |12| 
	.dwpsn	file "t1.c",line 63,column 53,is_stmt,isa 0
           ADDSP   .L2     B10,B4,B7         ; [B_L674] |63| 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           ADD     .L2     SP,B31,B4         ; [B_L674] |12| 
           MVK     .S2     476,B29           ; [B_Sb674] |12| 
	.dwpsn	file "t1.c",line 64,column 51,is_stmt,isa 0
           MV      .L1     A5,A7             ; [A_L674] |64| 
	.dwpsn	file "t1.c",line 12,column 32,is_stmt,isa 0
           ADDSP   .L2X    B7,A9,B5          ; [B_L674] |12| 
	.dwpsn	file "t1.c",line 64,column 51,is_stmt,isa 0
           ADDDP   .L1     A11:A10,A7:A6,A7:A6 ; [A_L674] |64| 
           MVK     .S1     400,A30           ; [A_S674] 
           MVK     .S1     400,A8            ; [A_S674] 
	.dwpsn	file "t1.c",line 12,column 32,is_stmt,isa 0
           STW     .D2T2   B5,*SP(464)       ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           LDW     .D2T1   *B4(0),A3         ; [B_D64P] |12| 
           ADD     .L2     SP,B30,B4         ; [B_L674] |12| 
           MVK     .S1     488,A29           ; [A_S674] |12| 
           MVK     .S1     492,A28           ; [A_S674] |12| 
           NOP             1                 ; [A_L674] 
           STW     .D2T1   A3,*B4(0)         ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 65,column 9,is_stmt,isa 0
$C$DW$172	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$172, DW_AT_low_pc(0x00)
	.dwattr $C$DW$172, DW_AT_name("put")
	.dwattr $C$DW$172, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |65| 
||         LDW     .D2T1   *SP(468),A4       ; [B_D64P] |65| 

$C$RL56:   ; CALLP OCCURS {put} {0}          ; [] |65| 
	.dwpsn	file "t1.c",line 12,column 32,is_stmt,isa 0
           SUBSP   .L2X    A9,B7,B4          ; [B_L674] |12| 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           MVK     .S1     472,A3            ; [A_S674] |12| 
           ADD     .L1X    SP,A3,A3          ; [A_L674] |12| 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t1.c",line 12,column 32,is_stmt,isa 0
           STW     .D2T2   B4,*SP(472)       ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           LDW     .D1T2   *A3(0),B5         ; [A_D64P] |12| 
           ADD     .L2     SP,B29,B4         ; [B_L674] |12| 
           NOP             3                 ; [A_L674] 
           STW     .D2T2   B5,*B4(0)         ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 65,column 30,is_stmt,isa 0
$C$DW$173	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$173, DW_AT_low_pc(0x04)
	.dwattr $C$DW$173, DW_AT_name("put")
	.dwattr $C$DW$173, DW_AT_TI_call


           LDW     .D2T1   *SP(476),A4       ; [B_D64P] |65| 
||         CALLP   .S2     put,B3            ; [B_Sb674] |65| 

$C$RL58:   ; CALLP OCCURS {put} {0}          ; [] |65| 
	.dwpsn	file "t1.c",line 12,column 32,is_stmt,isa 0
           MPYSP   .M1X    B7,A9,A4          ; [A_M674] |12| 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           MVK     .S1     480,A3            ; [A_S674] |12| 
           ADD     .L1X    SP,A3,A3          ; [A_L674] |12| 
           MVK     .S2     484,B4            ; [B_Sb674] |12| 
	.dwpsn	file "t1.c",line 12,column 32,is_stmt,isa 0
           STW     .D2T1   A4,*SP(480)       ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           LDW     .D1T2   *A3(0),B5         ; [A_D64P] |12| 
           ADD     .L2     SP,B4,B4          ; [B_L674] |12| 
           NOP             3                 ; [A_L674] 
           STW     .D2T2   B5,*B4(0)         ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 65,column 51,is_stmt,isa 0
$C$DW$174	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$174, DW_AT_low_pc(0x00)
	.dwattr $C$DW$174, DW_AT_name("put")
	.dwattr $C$DW$174, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |65| 
||         LDW     .D2T1   *SP(484),A4       ; [B_D64P] |65| 

$C$RL60:   ; CALLP OCCURS {put} {0}          ; [] |65| 
	.dwpsn	file "t1.c",line 64,column 19,is_stmt,isa 0
           INTDP   .L2X    A15,B5:B4         ; [B_L674] |64| 
           NOP             3                 ; [A_L674] 
           MPYDP   .M2     B13:B12,B5:B4,B9:B8 ; [B_M674] |64| 
           NOP             9                 ; [A_L674] 
	.dwpsn	file "t1.c",line 66,column 9,is_stmt,isa 0
           ADDDP   .L1X    A7:A6,B9:B8,A5:A4 ; [A_L674] |66| 
           NOP             5                 ; [A_L674] 
$C$DW$175	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$175, DW_AT_low_pc(0x00)
	.dwattr $C$DW$175, DW_AT_name("putd")
	.dwattr $C$DW$175, DW_AT_TI_call

           CALLP   .S2     putd,B3           ; [B_Sb674] |66| 
$C$RL62:   ; CALLP OCCURS {putd} {0}         ; [] |66| 
	.dwpsn	file "t1.c",line 66,column 24,is_stmt,isa 0
           MPYDP   .M1X    A7:A6,B9:B8,A5:A4 ; [A_M674] |66| 
           NOP             5                 ; [A_L674] 
$C$DW$176	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$176, DW_AT_low_pc(0x00)
	.dwattr $C$DW$176, DW_AT_name("putd")
	.dwattr $C$DW$176, DW_AT_TI_call

           CALLP   .S2     putd,B3           ; [B_Sb674] |66| 
$C$RL64:   ; CALLP OCCURS {putd} {0}         ; [] |66| 
	.dwpsn	file "t1.c",line 66,column 39,is_stmt,isa 0
           SUBDP   .L2X    B9:B8,A7:A6,B5:B4 ; [B_L674] |66| 
           NOP             6                 ; [A_L674] 
           MV      .L1X    B4,A4             ; [A_L674] |66| 
$C$DW$177	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$177, DW_AT_low_pc(0x00)
	.dwattr $C$DW$177, DW_AT_name("putd")
	.dwattr $C$DW$177, DW_AT_TI_call


           CALLP   .S2     putd,B3           ; [B_Sb674] |66| 
||         MV      .L1X    B5,A5             ; [A_L674] |66| 

$C$RL66:   ; CALLP OCCURS {putd} {0}         ; [] |66| 
	.dwpsn	file "t1.c",line 11,column 31,is_stmt,isa 0

           LDW     .D2T1   *+DP(ri),A4       ; [B_D64P] |11| 
||         ZERO    .L1     A3                ; [A_L674] 

           MVKH    .S1     0x40400000,A3     ; [A_S674] 
	.dwpsn	file "t1.c",line 11,column 43,is_stmt,isa 0
           MPYSP   .M1     A3,A9,A5          ; [A_M674] |11| 
	.dwpsn	file "t1.c",line 12,column 32,is_stmt,isa 0
           DPSP    .L2     B9:B8,B4          ; [B_L674] |12| 
	.dwpsn	file "t1.c",line 11,column 43,is_stmt,isa 0
           DPTRUNC .L2     B9:B8,B5          ; [B_L674] |11| 
	.dwpsn	file "t1.c",line 11,column 31,is_stmt,isa 0
           CMPLT   .L1     A4,A30,A0         ; [A_L674] |11| 
	.dwpsn	file "t1.c",line 11,column 43,is_stmt,isa 0
   [ A0]   SPTRUNC .L1     A5,A16            ; [A_L674] |11| 
           MVKL    .S1     results,A5        ; [A_S674] 
           MVKH    .S1     results,A5        ; [A_S674] 
	.dwpsn	file "t1.c",line 11,column 31,is_stmt,isa 0
           MV      .S1     A4,A3             ; [A_S674] |11| 
	.dwpsn	file "t1.c",line 11,column 43,is_stmt,isa 0
   [ A0]   ADD     .L1     1,A4,A4           ; [A_L674] |11| 
	.dwpsn	file "t1.c",line 11,column 31,is_stmt,isa 0

   [ A0]   STW     .D1T1   A16,*+A5[A3]      ; [A_D64P] |11| 
||         MV      .S1     A5,A3             ; [A_S674] |12| 
||         CMPLT   .L1     A4,A8,A1          ; [A_L674] |11| 
||         STW     .D2T2   B4,*SP(488)       ; [B_D64P] |12| 

	.dwpsn	file "t1.c",line 11,column 43,is_stmt,isa 0

   [ A1]   STW     .D1T2   B5,*+A3[A4]       ; [A_D64P] |11| 
|| [ A0]   STW     .D2T1   A4,*+DP(ri)       ; [B_D64P] |11| 
|| [ A1]   ADD     .L1     1,A4,A4           ; [A_L674] |11| 

   [ A1]   STW     .D2T1   A4,*+DP(ri)       ; [B_D64P] |11| 
||         ADD     .L1X    SP,A29,A3         ; [A_L674] |12| 

	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           LDW     .D1T2   *A3(0),B4         ; [A_D64P] |12| 
           ADD     .L1X    SP,A28,A3         ; [A_L674] |12| 
	.dwpsn	file "t1.c",line 11,column 31,is_stmt,isa 0
           CMPLT   .L1     A4,A8,A0          ; [A_L674] |11| 
	.dwpsn	file "t1.c",line 11,column 43,is_stmt,isa 0
           ADD     .L1     1,A4,A27          ; [A_L674] |11| 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           STW     .D1T2   B4,*A3(0)         ; [A_D64P] |12| 
	.dwpsn	file "t1.c",line 11,column 43,is_stmt,isa 0
           LDW     .D2T1   *SP(492),A5       ; [B_D64P] |11| 
           MVKL    .S1     results,A3        ; [A_S674] 
           MVKH    .S1     results,A3        ; [A_S674] 
   [ A0]   STW     .D2T1   A27,*+DP(ri)      ; [B_D64P] |11| 
           NOP             1                 ; [A_L674] 

   [ A0]   STW     .D1T1   A5,*+A3[A4]       ; [A_D64P] |11| 
||         SPDP    .S1     A9,A5:A4          ; [A_S674] |67| 

	.dwpsn	file "t1.c",line 67,column 89,is_stmt,isa 0
$C$DW$178	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$178, DW_AT_low_pc(0x00)
	.dwattr $C$DW$178, DW_AT_name("putd")
	.dwattr $C$DW$178, DW_AT_TI_call

           CALLP   .S2     putd,B3           ; [B_Sb674] |67| 
$C$RL68:   ; CALLP OCCURS {putd} {0}         ; [] |67| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 11,column 31,is_stmt,isa 0

           LDW     .D2T1   *+DP(ri),A3       ; [B_D64P] |11| 
||         MVKL    .S1     results,A4        ; [A_S674] 

           LDW     .D2T1   *SP(532),A24      ; [B_D64P] 
           MVKH    .S1     results,A4        ; [A_S674] 
	.dwpsn	file "t1.c",line 11,column 43,is_stmt,isa 0
           CMPLTSP .S1X    A9,B7,A5          ; [A_S674] |11| 
           MVKL    .S1     results,A25       ; [A_S674] 
	.dwpsn	file "t1.c",line 11,column 31,is_stmt,isa 0

           CMPLT   .L1     A3,A8,A0          ; [A_L674] |11| 
||         CMPGTDP .S1X    B9:B8,A7:A6,A26   ; [A_S674] |11| 

	.dwpsn	file "t1.c",line 11,column 43,is_stmt,isa 0

   [ A0]   STW     .D1T1   A5,*+A4[A3]       ; [A_D64P] |11| 
|| [ A0]   ADD     .L1     1,A3,A3           ; [A_L674] |11| 

	.dwpsn	file "t1.c",line 11,column 31,is_stmt,isa 0

   [ A0]   STW     .D2T1   A3,*+DP(ri)       ; [B_D64P] |11| 
||         CMPLT   .L1     A3,A8,A0          ; [A_L674] |11| 
||         ADD     .D1     1,A3,A4           ; [A_D64P] |11| 
||         MVKH    .S1     results,A25       ; [A_S674] 

	.dwpsn	file "t1.c",line 11,column 43,is_stmt,isa 0
   [ A0]   STW     .D2T1   A4,*+DP(ri)       ; [B_D64P] |11| 
	.dwpsn	file "t1.c",line 63,column 18,is_stmt,isa 0
           LDW     .D2T1   *+DP(lcg),A4      ; [B_D64P] |63| 
	.dwpsn	file "t1.c",line 11,column 43,is_stmt,isa 0

   [ A0]   STW     .D1T1   A26,*+A25[A3]     ; [A_D64P] |11| 
||         SUB     .L1     A24,1,A3          ; [A_L674] |62| 
||         SUB     .S1     A24,1,A0          ; [A_S674] |62| 

           STW     .D2T1   A3,*SP(532)       ; [B_D64P] |11| 
|| [ A0]   MVKL    .S1     0x41c64e6d,A3     ; [A_S674] |17| 
|| [ A0]   ZERO    .L2     B5                ; [B_L674] |64| 
|| [ A0]   MV      .S2     B12,B4            ; [B_Sb674] |64| 

	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0

   [ A0]   MVKH    .S1     0x41c64e6d,A3     ; [A_S674] |17| 
|| [ A0]   MVKH    .S2     0x40080000,B5     ; [B_Sb674] |64| 

   [ A0]   MVKL    .S1     0x41c64e6d,A31    ; [A_S674] |17| 

           MPY32   .M1     A3,A4,A3          ; [A_M674] |63| 
|| [ A0]   MVKH    .S1     0x41c64e6d,A31    ; [A_S674] |17| 

   [ A0]   MVKL    .S1     0x41c64e6d,A30    ; [A_S674] |17| 
   [ A0]   MVKH    .S1     0x41c64e6d,A30    ; [A_S674] |17| 
   [ A0]   MVKL    .S1     0x41c64e6d,A29    ; [A_S674] |17| 

           ADD     .L1     A12,A3,A13        ; [A_L674] |63| 
|| [ A0]   MVKH    .S1     0x41c64e6d,A29    ; [A_S674] |17| 

	.dwpsn	file "t1.c",line 62,column 17,is_stmt,isa 0

   [ A0]   BNOP            $C$L4,3           ; [] |62| 
||         MPY32   .M1     A31,A13,A3        ; [A_M674] |63| 

	.dwpsn	file "t1.c",line 63,column 53,is_stmt,isa 0
           ADD     .L1     A12,A3,A14        ; [A_L674] |63| 
	.dwpsn	file "t1.c",line 64,column 19,is_stmt,isa 0
           MPY32   .M1     A30,A14,A3        ; [A_M674] |64| 
	.dwpsn	file "t1.c",line 62,column 17,is_stmt,isa 0
           ; BRANCHCC OCCURS {$C$L4}         ; [] |62| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 71,column 17,is_stmt,isa 0

           LDW     .D2T2   *+DP(lcg),B7      ; [B_D64P] |71| 
||         MVK     .S2     256,B4            ; [B_Sb674] |71| 

           SUB     .L2     B4,1,B4           ; [B_L674] 
           MVC     .S2     B4,ILC            ; [B_Sb674] 
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0
           MVKL    .S1     0x41c64e6d,A3     ; [A_S674] |17| 
           MVKH    .S1     0x41c64e6d,A3     ; [A_S674] |17| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 71
;*    Loop opening brace source line   : 71
;*    Loop closing brace source line   : 71
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 10 due to a loop-carried dependence.
;*
;*    Known Minimum Iteration Count    : 256
;*    Known Maximum Iteration Count    : 256
;*    Known Max Iteration Count Factor : 256
;*    Loop Carried Dependency Bound(^) : 10
;*    Partitioned Resource Bound(*)    : 3
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     2        0     
;*      .S units                     0        1     
;*      .D units                     2        2     
;*      .M units                     2        2     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           1        0     (.L or .S unit)
;*      Addition ops (.LSD)          3        2     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             2        1     
;*      Bound(.L .S .D .LS .LSD)     3*       2     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 10 Schedule found with 2 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C1440:
;*   0              MPY32   .M2     B16,B7,B6         ; [B_M674] |17|  ^ 
;*     ||           MPY     .M1     3,A7,A3           ; [A_M674] |71| 
;*     ||           AND     .L1     15,A7,A3          ; [A_L674] |71| 
;*   1              INTSP   .L1     A3,A3             ; [A_L674] |71| 
;*   2              ADD     .L1     A4,A3,A3          ; [A_L674] |71| 
;*   3              INTSP   .L1     A3,A3             ; [A_L674] |71| 
;*   4              ADD     .L2     B8,B6,B6          ; [B_L674] |17|  ^ 
;*   5              STH     .D2T2   B6,*B5++(2)       ; [B_D64P] |71| 
;*     ||           MPY32   .M2     B9,B6,B6          ; [B_M674] |17|  ^ 
;*     ||           ADDSP   .L1     A6,A3,A3          ; [A_L674] |71| 
;*   6              NOP     1       ; [A_L674] 
;*   7              MPYSP   .M1     A5,A3,A16         ; [A_M674] |71| 
;*   8              NOP     1       ; [A_L674] 
;*   9              ADD     .L2     B8,B6,B7          ; [B_L674] |17|  ^ 
;*     ||           STW     .D1T1   A3,*A8++(4)       ; [A_D64P] |71| 
;*     ||           ADD     .L1     1,A7,A7           ; [A_L674] |71| 
;*  10              SHRU    .S2     B7,3,B6           ; [B_Sb674] |71| 
;*  11              STH     .D2T2   B6,*B4++(2)       ; [B_D64P] |71| 
;*     ||           STW     .D1T1   A16,*A9++(4)      ; [A_D64P] |71| 
;*     ||           SPBR                              $C$C1440 ; [] 
;*  12              NOP     8       ; [A_L674] 
;*  20              ; BRANCHCC OCCURS {$C$C1440}      ; [] |71| 
;*----------------------------------------------------------------------------*
$C$L5:    ; PIPED LOOP PROLOG
	.dwpsn	file "t1.c",line 71,column 10,is_stmt,isa 0

           SPLOOPD         10                ;20 ; [A_L674] (P) 
||         MV      .S1     A10,A7            ; [A_S674] 
||         MV      .L2X    A3,B16            ; [B_L674] |71| 

;** --------------------------------------------------------------------------*
$C$L6:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MV      .L2X    A3,B9             ; [B_L674] |71| 
||         AND     .L1     15,A7,A3          ; [A_L674] |71| (P) <0,0> 
||         MPY32   .M2     B16,B7,B6         ; [B_M674] |17| (P) <0,0>  ^ 
||         MPY     .M1     3,A7,A3           ; [A_M674] |71| (P) <0,0> 

	.dwpsn	file "t1.c",line 71,column 122,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVK     .S1     -100,A4           ; [A_S674] 
||         INTSP   .L1     A3,A3             ; [A_L674] |71| (P) <0,1> 

	.dwpsn	file "t1.c",line 71,column 84,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVKL    .S2     sa,B17            ; [B_Sb674] 
||         ADD     .L1     A4,A3,A3          ; [A_L674] |71| (P) <0,2> 

           SPMASK                            ; [] 
||^        MVKL    .S1     fb,A18            ; [A_S674] 
||^        MV      .L2X    A12,B8            ; [B_L674] 
||^        MVKH    .S2     sa,B17            ; [B_Sb674] 
||         INTSP   .L1     A3,A3             ; [A_L674] |71| (P) <0,3> 

	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVKL    .S1     sb,A17            ; [A_S674] 
||^        MV      .D1X    B10,A6            ; [A_D64P] 
||^        MV      .S2     B17,B5            ; [B_Sb674] 
||         ADD     .L2     B8,B6,B6          ; [B_L674] |17| (P) <0,4>  ^ 

           SPMASK                            ; [] 
||^        ZERO    .D1     A5                ; [A_D64P] 
||^        MVKH    .S1     sb,A17            ; [A_S674] 
||         ADDSP   .L1     A6,A3,A3          ; [A_L674] |71| (P) <0,5> 
||         STH     .D2T2   B6,*B5++(2)       ; [B_D64P] |71| (P) <0,5> 
||         MPY32   .M2     B9,B6,B6          ; [B_M674] |17| (P) <0,5>  ^ 

           SPMASK                            ; [] 
||^        MVKL    .S2     fa,B19            ; [B_Sb674] 
||^        MVKH    .S1     0x3e800000,A5     ; [A_S674] 

	.dwpsn	file "t1.c",line 71,column 84,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVKH    .S1     fb,A18            ; [A_S674] 
||^        MVKH    .S2     fa,B19            ; [B_Sb674] 
||         MPYSP   .M1     A5,A3,A16         ; [A_M674] |71| (P) <0,7> 

           SPMASK                            ; [] 
||^        MV      .S1     A18,A8            ; [A_S674] 

	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MV      .S2X    A17,B4            ; [B_Sb674] 
||^        MV      .S1X    B19,A9            ; [A_S674] 
||         STW     .D1T1   A3,*A8++(4)       ; [A_D64P] |71| (P) <0,9> 
||         ADD     .L1     1,A7,A7           ; [A_L674] |71| (P) <0,9> 
||         ADD     .L2     B8,B6,B7          ; [B_L674] |17| (P) <0,9>  ^ 

	.dwpsn	file "t1.c",line 71,column 55,is_stmt,isa 0
           SHRU    .S2     B7,3,B6           ; [B_Sb674] |71| <0,10> 

           SPKERNEL        0,0               ; [] 
||         STH     .D2T2   B6,*B4++(2)       ; [B_D64P] |71| <0,11> 
||         STW     .D1T1   A16,*A9++(4)      ; [A_D64P] |71| <0,11> 

;** --------------------------------------------------------------------------*
$C$L7:    ; PIPED LOOP EPILOG
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0
           MVKL    .S1     0x41c64e6d,A4     ; [A_S674] |17| 
	.dwpsn	file "t1.c",line 72,column 17,is_stmt,isa 0

           MV      .L1X    B7,A6             ; [A_L674] 
||         MVKL    .S1     ia,A16            ; [A_S674] 
||         MVK     .S2     512,B5            ; [B_Sb674] |72| 

;** --------------------------------------------------------------------------*
           SUB     .L2     B5,1,B4           ; [B_L674] 
           MVC     .S2     B4,ILC            ; [B_Sb674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 72
;*    Loop opening brace source line   : 72
;*    Loop closing brace source line   : 72
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 5 due to a loop-carried dependence.
;*
;*    Known Minimum Iteration Count    : 512
;*    Known Maximum Iteration Count    : 512
;*    Known Max Iteration Count Factor : 512
;*    Loop Carried Dependency Bound(^) : 5
;*    Partitioned Resource Bound(*)    : 1
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     1*       0     
;*      .D units                     1*       0     
;*      .M units                     1*       0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          1        0     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1*       0     
;*      Bound(.L .S .D .LS .LSD)     1*       0     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 5  Schedule found with 2 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C1351:
;*   0              MPY32   .M1     A4,A6,A3          ; [A_M674] |17|  ^ 
;*   1              NOP     3       ; [A_L674] 
;*   4              ADD     .L1     A5,A3,A6          ; [A_L674] |17|  ^ 
;*   5              SHR     .S1     A6,4,A3           ; [A_S674] |72| 
;*   6              STW     .D1T1   A3,*A7++(4)       ; [A_D64P] |72| 
;*     ||           SPBR                              $C$C1351 ; [] 
;*   7              NOP     3       ; [A_L674] 
;*  10              ; BRANCHCC OCCURS {$C$C1351}      ; [] |72| 
;*----------------------------------------------------------------------------*
$C$L8:    ; PIPED LOOP PROLOG
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0

           SPLOOPD         5                 ;10 ; [A_L674] (P) 
||         MVKH    .S1     0x41c64e6d,A4     ; [A_S674] |17| 

;** --------------------------------------------------------------------------*
$C$L9:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0
           MPY32   .M1     A4,A6,A3          ; [A_M674] |17| (P) <0,0>  ^ 
           NOP             2                 ; [A_L674] 

           SPMASK                            ; [] 
||^        MVKH    .S1     ia,A16            ; [A_S674] 
||^        MV      .L1X    B8,A5             ; [A_L674] 

           SPMASK                            ; [] 
||^        MV      .S1     A16,A7            ; [A_S674] 
||         ADD     .L1     A5,A3,A6          ; [A_L674] |17| (P) <0,4>  ^ 

	.dwpsn	file "t1.c",line 72,column 33,is_stmt,isa 0
           SHR     .S1     A6,4,A3           ; [A_S674] |72| <0,5> 

           SPKERNEL        0,0               ; [] 
||         STW     .D1T1   A3,*A7++(4)       ; [A_D64P] |72| <0,6> 

;** --------------------------------------------------------------------------*
$C$L10:    ; PIPED LOOP EPILOG
	.dwpsn	file "t1.c",line 75,column 21,is_stmt,isa 0

           MV      .D2     B17,B4            ; [B_D64P] 
||         ZERO    .L2     B8                ; [B_L674] |75| 
||         MV      .L1     A5,A12            ; [A_L674] 
||         MVK     .S2     64,B5             ; [B_Sb674] |75| 

           ZERO    .L1     A6                ; [A_L674] |75| 
||         MV      .L2X    A6,B7             ; [B_L674] 
||         SUB     .S2     B5,4,B5           ; [B_Sb674] 

;** --------------------------------------------------------------------------*
           MVC     .S2     B5,ILC            ; [B_Sb674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 75
;*    Loop opening brace source line   : 75
;*    Loop closing brace source line   : 75
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*
;*    Loop Unroll Multiple             : 4x
;*    Known Minimum Iteration Count    : 64
;*    Known Maximum Iteration Count    : 64
;*    Known Max Iteration Count Factor : 64
;*    Loop Carried Dependency Bound(^) : 0
;*    Partitioned Resource Bound(*)    : 1
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     0        0     
;*      .D units                     1*       1*    
;*      .M units                     1*       1*    
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          1        1     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             0        0     
;*      Bound(.L .S .D .LS .LSD)     1*       1*    
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 1  Schedule found with 10 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    For further improvement on this loop, try option -mh8
;*
;*    Minimum safe iteration count    : 1 (after unrolling)
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C1286:
;*   0              LDDW    .D2T2   *B4++(8),B7:B6    ; [B_D64P] |75| 
;*     ||           LDDW    .D1T1   *A7++(8),A5:A4    ; [A_D64P] |75| 
;*   1              NOP     4       ; [A_L674] 
;*   5              DOTP2   .M2X    B6,A4,B5          ; [B_M674] |75| 
;*     ||           DOTP2   .M1X    B7,A5,A3          ; [A_M674] |75| 
;*   6              NOP     3       ; [A_L674] 
;*   9              ADD     .L2     B5,B8,B8          ; [B_L674] |75| 
;*     ||           ADD     .L1     A3,A6,A6          ; [A_L674] |75| 
;*     ||           SPBR                              $C$C1286 ; [] 
;*  10              ; BRANCHCC OCCURS {$C$C1286}      ; [] |75| 
;*----------------------------------------------------------------------------*
$C$L11:    ; PIPED LOOP PROLOG

           SPLOOPD         1                 ;10 ; [A_L674] (P) 
||         STW     .D2T2   B7,*+DP(lcg)      ; [B_D64P] 
||         MV      .S1     A17,A7            ; [A_S674] |75| 

;** --------------------------------------------------------------------------*
$C$L12:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 75,column 35,is_stmt,isa 0

           LDDW    .D2T2   *B4++(8),B7:B6    ; [B_D64P] |75| (P) <0,0> 
||         LDDW    .D1T1   *A7++(8),A5:A4    ; [A_D64P] |75| (P) <0,0> 

           NOP             4                 ; [A_L674] 

           DOTP2   .M2X    B6,A4,B5          ; [B_M674] |75| (P) <0,5> 
||         DOTP2   .M1X    B7,A5,A3          ; [A_M674] |75| (P) <0,5> 

           NOP             2                 ; [A_L674] 
           NOP             1                 ; [A_L674] 

           SPKERNEL        0,0               ; [] 
||         ADD     .L2     B5,B8,B8          ; [B_L674] |75| <0,9> 
||         ADD     .L1     A3,A6,A6          ; [A_L674] |75| <0,9> 

;** --------------------------------------------------------------------------*
$C$L13:    ; PIPED LOOP EPILOG
	.dwpsn	file "t1.c",line 76,column 9,is_stmt,isa 0

           MV      .D1     A16,A20           ; [A_D64P] |76| 
||         MVK     .S1     1,A9              ; [A_S674] |77| 

	.dwpsn	file "t1.c",line 74,column 38,is_stmt,isa 0
           ZERO    .S1     A8                ; [A_S674] |74| 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t1.c",line 76,column 9,is_stmt,isa 0
$C$DW$179	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$179, DW_AT_low_pc(0x00)
	.dwattr $C$DW$179, DW_AT_name("put")
	.dwattr $C$DW$179, DW_AT_TI_call

           CALL    .S1     put               ; [A_S674] |76| 
           ADDKPC  .S2     $C$RL70,B3,3      ; [B_Sb674] |76| 
	.dwpsn	file "t1.c",line 74,column 38,is_stmt,isa 0

           ZERO    .S1     A6                ; [A_S674] |74| 
||         ADD     .L1X    A6,B8,A4          ; [A_L674] |76| 

	.dwpsn	file "t1.c",line 76,column 9,is_stmt,isa 0
$C$RL70:   ; CALL OCCURS {put} {0}           ; [] |76| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 77,column 21,is_stmt,isa 0
           MVK     .S2     512,B4            ; [B_Sb674] |77| 
           SUB     .L2     B4,2,B4           ; [B_L674] 
           MVC     .S2     B4,ILC            ; [B_Sb674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 77
;*    Loop opening brace source line   : 77
;*    Loop closing brace source line   : 77
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 2 due to a loop-carried dependence.
;*
;*    Known Minimum Iteration Count    : 512
;*    Known Maximum Iteration Count    : 512
;*    Known Max Iteration Count Factor : 512
;*    Loop Carried Dependency Bound(^) : 2
;*    Partitioned Resource Bound(*)    : 2
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     1        0     
;*      .S units                     0        0     
;*      .D units                     1        0     
;*      .M units                     1        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          4        0     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1        0     
;*      Bound(.L .S .D .LS .LSD)     2*       0     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 2  Schedule found with 6 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    For further improvement on this loop, try option -mh4
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C1266:
;*   0              LDW     .D1T1   *A16++(4),A7      ; [A_D64P] |77| 
;*   1              NOP     4       ; [A_L674] 
;*   5              MPY32   .M1     A9,A7,A5:A4       ; [A_M674] |77| 
;*     ||           ADD     .D1     1,A9,A9           ; [A_D64P] |77| 
;*   6              NOP     3       ; [A_L674] 
;*   9              ADDU    .L1     A4,A6,A7:A6       ; [A_L674] |77|  ^ 
;*  10              ADD     .L1     A7,A5,A3          ; [A_L674] |77| 
;*  11              ADD     .S1     A3,A8,A8          ; [A_S674] |77| 
;*     ||           SPBR                              $C$C1266 ; [] 
;*  12              ; BRANCHCC OCCURS {$C$C1266}      ; [] |77| 
;*----------------------------------------------------------------------------*
$C$L14:    ; PIPED LOOP PROLOG
           SPLOOPD         2                 ;12 ; [A_L674] (P) 
;** --------------------------------------------------------------------------*
$C$L15:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 77,column 35,is_stmt,isa 0
           LDW     .D1T1   *A16++(4),A7      ; [A_D64P] |77| (P) <0,0> 
           NOP             4                 ; [A_L674] 
	.dwpsn	file "t1.c",line 77,column 21,is_stmt,isa 0

           ADD     .D1     1,A9,A9           ; [A_D64P] |77| (P) <0,5> 
||         MPY32   .M1     A9,A7,A5:A4       ; [A_M674] |77| (P) <0,5> 

           NOP             3                 ; [A_L674] 
	.dwpsn	file "t1.c",line 77,column 35,is_stmt,isa 0
           ADDU    .L1     A4,A6,A7:A6       ; [A_L674] |77| (P) <0,9>  ^ 
           ADD     .L1     A7,A5,A3          ; [A_L674] |77| <0,10> 

           SPKERNEL        0,0               ; [] 
||         ADD     .S1     A3,A8,A8          ; [A_S674] |77| <0,11> 

;** --------------------------------------------------------------------------*
$C$L16:    ; PIPED LOOP EPILOG
	.dwpsn	file "t1.c",line 79,column 21,is_stmt,isa 0

           ZERO    .D1     A16               ; [A_D64P] |79| 
||         ZERO    .L2     B18               ; [B_L674] |79| 
||         ZERO    .S2     B17               ; [B_Sb674] |79| 
||         MV      .D2     B19,B7            ; [B_D64P] 

           ZERO    .D2     B16               ; [B_D64P] |79| 
||         ZERO    .L2     B9                ; [B_L674] |79| 
||         ADDK    .S2     16,B7             ; [B_Sb674] 

           ADD     .L2     8,B19,B8          ; [B_L674] 
||         ZERO    .D1     A17               ; [A_D64P] |79| 

           NOP             1                 ; [A_L674] 
           ZERO    .D1     A9                ; [A_D64P] |79| 
           NOP             3                 ; [A_L674] 
           ADD     .D1     8,A18,A7          ; [A_D64P] 
	.dwpsn	file "t1.c",line 78,column 9,is_stmt,isa 0

           MV      .D1     A18,A6            ; [A_D64P] 
||         MV      .L1     A6,A4             ; [A_L674] |78| 

;** --------------------------------------------------------------------------*
$C$DW$180	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$180, DW_AT_low_pc(0x00)
	.dwattr $C$DW$180, DW_AT_name("put")
	.dwattr $C$DW$180, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |78| 
$C$RL72:   ; CALLP OCCURS {put} {0}          ; [] |78| 
	.dwpsn	file "t1.c",line 78,column 31,is_stmt,isa 0
$C$DW$181	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$181, DW_AT_low_pc(0x00)
	.dwattr $C$DW$181, DW_AT_name("put")
	.dwattr $C$DW$181, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |78| 
||         MV      .L1     A8,A4             ; [A_L674] |78| 

$C$RL74:   ; CALLP OCCURS {put} {0}          ; [] |78| 
	.dwpsn	file "t1.c",line 79,column 21,is_stmt,isa 0
           MVK     .S2     32,B4             ; [B_Sb674] |79| 
           SUB     .L2     B4,1,B4           ; [B_L674] 
           MVC     .S2     B4,ILC            ; [B_Sb674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 79
;*    Loop opening brace source line   : 79
;*    Loop closing brace source line   : 79
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 4 due to a loop-carried dependence and
;*        a resource limitation (partitioned resource bound).
;*
;*    Loop Unroll Multiple             : 8x
;*    Known Minimum Iteration Count    : 32
;*    Known Maximum Iteration Count    : 32
;*    Known Max Iteration Count Factor : 32
;*    Loop Carried Dependency Bound(^) : 4
;*    Partitioned Resource Bound(*)    : 4
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     0        0     
;*      .D units                     4*       4*    
;*      .M units                     4*       4*    
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           4        4     (.L or .S unit)
;*      Addition ops (.LSD)          0        0     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             2        2     
;*      Bound(.L .S .D .LS .LSD)     3        3     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 4  Schedule found with 4 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    For further improvement on this loop, try option -mh32
;*
;*    Minimum safe iteration count    : 1 (after unrolling)
;*----------------------------------------------------------------------------*
;*     SETUP CODE
;*
;*                MV      B19,B6  ; [] 
;*                ADDK    24,B6   ; [] 
;*                MV      B19,B7  ; [] 
;*                ADDK    16,B7   ; [] 
;*                MV      B19,B8  ; [] 
;*                ADD     8,B8,B8 ; [] 
;*                MV      A18,A3  ; [] 
;*                ADDK    24,A3   ; [] 
;*                MV      A18,A6  ; [] 
;*                ADDK    16,A6   ; [] 
;*                MV      A18,A7  ; [] 
;*                ADD     8,A7,A7 ; [] 
;*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C1153:
;*   0              LDDW    .D2T2   *B19++(32),B5:B4  ; [B_D64P] |79| 
;*     ||           LDDW    .D1T1   *A18++(32),A5:A4  ; [A_D64P] |79| 
;*   1              LDDW    .D2T2   *B8++(32),B5:B4   ; [B_D64P] |79| 
;*     ||           LDDW    .D1T1   *A7++(32),A5:A4   ; [A_D64P] |79| 
;*   2              LDDW    .D2T2   *B7++(32),B5:B4   ; [B_D64P] |79| 
;*     ||           LDDW    .D1T1   *A6++(32),A5:A4   ; [A_D64P] |79| 
;*   3              LDDW    .D2T2   *B6++(32),B5:B4   ; [B_D64P] |79| 
;*     ||           LDDW    .D1T1   *A3++(32),A5:A4   ; [A_D64P] |79| 
;*   4              NOP     1       ; [A_L674] 
;*   5              MPYSP   .M2X    A4,B4,B20         ; [B_M674] |79| 
;*     ||           MPYSP   .M1X    A5,B5,A19         ; [A_M674] |79| 
;*   6              MPYSP   .M2X    A4,B4,B17         ; [B_M674] |79| 
;*     ||           MPYSP   .M1X    A5,B5,A16         ; [A_M674] |79| 
;*   7              MPYSP   .M2X    A4,B4,B17         ; [B_M674] |79| 
;*     ||           MPYSP   .M1X    A5,B5,A16         ; [A_M674] |79| 
;*   8              MPYSP   .M2X    A4,B4,B9          ; [B_M674] |79| 
;*     ||           MPYSP   .M1X    A5,B5,A8          ; [A_M674] |79| 
;*   9              ADDSP   .L2     B20,B17,B17       ; [B_L674] |79|  ^ 
;*     ||           ADDSP   .L1     A19,A16,A16       ; [A_L674] |79|  ^ 
;*  10              ADDSP   .L2     B17,B18,B18       ; [B_L674] |79|  ^ 
;*     ||           ADDSP   .L1     A16,A17,A17       ; [A_L674] |79|  ^ 
;*  11              ADDSP   .L2     B17,B9,B9         ; [B_L674] |79|  ^ 
;*     ||           ADDSP   .L1     A16,A8,A8         ; [A_L674] |79|  ^ 
;*  12              ADDSP   .L2     B9,B16,B16        ; [B_L674] |79|  ^ 
;*     ||           ADDSP   .L1     A8,A9,A9          ; [A_L674] |79|  ^ 
;*     ||           SPBR                              $C$C1153 ; [] 
;*  13              NOP     3       ; [A_L674] 
;*  16              ; BRANCHCC OCCURS {$C$C1153}      ; [] |79| 
;*----------------------------------------------------------------------------*
$C$L17:    ; PIPED LOOP PROLOG
           SPLOOPD         4                 ;16 ; [A_L674] (P) 
;** --------------------------------------------------------------------------*
$C$L18:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 79,column 35,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MV      .L1     A18,A3            ; [A_L674] 
||^        MV      .L2     B19,B6            ; [B_L674] 
||         LDDW    .D2T2   *B19++(32),B5:B4  ; [B_D64P] |79| (P) <0,0> 
||         LDDW    .D1T1   *A18++(32),A5:A4  ; [A_D64P] |79| (P) <0,0> 

           SPMASK                            ; [] 
||^        ADDK    .S1     16,A6             ; [A_S674] 
||         LDDW    .D2T2   *B8++(32),B5:B4   ; [B_D64P] |79| (P) <0,1> 
||         LDDW    .D1T1   *A7++(32),A5:A4   ; [A_D64P] |79| (P) <0,1> 

           SPMASK                            ; [] 
||^        ADDK    .S1     24,A3             ; [A_S674] 
||^        ADDK    .S2     24,B6             ; [B_Sb674] 
||         LDDW    .D2T2   *B7++(32),B5:B4   ; [B_D64P] |79| (P) <0,2> 
||         LDDW    .D1T1   *A6++(32),A5:A4   ; [A_D64P] |79| (P) <0,2> 

           LDDW    .D2T2   *B6++(32),B5:B4   ; [B_D64P] |79| (P) <0,3> 
||         LDDW    .D1T1   *A3++(32),A5:A4   ; [A_D64P] |79| (P) <0,3> 

           NOP             1                 ; [A_L674] 

           MPYSP   .M2X    A4,B4,B20         ; [B_M674] |79| (P) <0,5> 
||         MPYSP   .M1X    A5,B5,A19         ; [A_M674] |79| (P) <0,5> 

           MPYSP   .M2X    A4,B4,B17         ; [B_M674] |79| (P) <0,6> 
||         MPYSP   .M1X    A5,B5,A16         ; [A_M674] |79| (P) <0,6> 

           MPYSP   .M2X    A4,B4,B17         ; [B_M674] |79| (P) <0,7> 
||         MPYSP   .M1X    A5,B5,A16         ; [A_M674] |79| (P) <0,7> 

	.dwpsn	file "t1.c",line 79,column 21,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .L1     A8                ; [A_L674] |79| 
||         MPYSP   .M2X    A4,B4,B9          ; [B_M674] |79| (P) <0,8> 
||         MPYSP   .M1X    A5,B5,A8          ; [A_M674] |79| (P) <0,8> 

	.dwpsn	file "t1.c",line 79,column 35,is_stmt,isa 0

           ADDSP   .L2     B20,B17,B17       ; [B_L674] |79| (P) <0,9>  ^ 
||         ADDSP   .L1     A19,A16,A16       ; [A_L674] |79| (P) <0,9>  ^ 

           ADDSP   .L2     B17,B18,B18       ; [B_L674] |79| (P) <0,10>  ^ 
||         ADDSP   .L1     A16,A17,A17       ; [A_L674] |79| (P) <0,10>  ^ 

           ADDSP   .L2     B17,B9,B9         ; [B_L674] |79| (P) <0,11>  ^ 
||         ADDSP   .L1     A16,A8,A8         ; [A_L674] |79| (P) <0,11>  ^ 

           SPKERNEL        0,0               ; [] 
||         ADDSP   .L2     B9,B16,B16        ; [B_L674] |79| <0,12>  ^ 
||         ADDSP   .L1     A8,A9,A9          ; [A_L674] |79| <0,12>  ^ 

;** --------------------------------------------------------------------------*
$C$L19:    ; PIPED LOOP EPILOG
           ZERO    .S1     A6                ; [A_S674] 
           NOP             3                 ; [A_L674] 
           MV      .S1     A20,A5            ; [A_S674] 
           MV      .S2X    A20,B8            ; [B_Sb674] 
           NOP             3                 ; [A_L674] 
;** --------------------------------------------------------------------------*
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t1.c",line 80,column 9,is_stmt,isa 0
           ADDSP   .L1X    B18,A17,A3        ; [A_L674] |80| 
           NOP             3                 ; [A_L674] 
           ADDSP   .L1     A16,A3,A3         ; [A_L674] |80| 
           NOP             3                 ; [A_L674] 
           ADDSP   .L1X    B17,A3,A3         ; [A_L674] |80| 
           NOP             3                 ; [A_L674] 
           ADDSP   .L1     A9,A3,A3          ; [A_L674] |80| 
           NOP             3                 ; [A_L674] 
           ADDSP   .L1X    B16,A3,A3         ; [A_L674] |80| 
           NOP             3                 ; [A_L674] 
           ADDSP   .L1     A8,A3,A3          ; [A_L674] |80| 
           NOP             3                 ; [A_L674] 
           ADDSP   .L1X    B9,A3,A4          ; [A_L674] |80| 
           NOP             2                 ; [A_L674] 
$C$DW$182	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$182, DW_AT_low_pc(0x00)
	.dwattr $C$DW$182, DW_AT_name("fbits")
	.dwattr $C$DW$182, DW_AT_TI_call

           CALLP   .S2     fbits,B3          ; [B_Sb674] |80| 
$C$RL76:   ; CALLP OCCURS {fbits} {0}        ; [] |80| 
$C$DW$183	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$183, DW_AT_low_pc(0x00)
	.dwattr $C$DW$183, DW_AT_name("put")
	.dwattr $C$DW$183, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |80| 
$C$RL78:   ; CALLP OCCURS {put} {0}          ; [] |80| 
	.dwpsn	file "t1.c",line 81,column 21,is_stmt,isa 0
           MVK     .S2     256,B4            ; [B_Sb674] |81| 
           SUB     .L2     B4,2,B4           ; [B_L674] 
           MVC     .S2     B4,ILC            ; [B_Sb674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 81
;*    Loop opening brace source line   : 81
;*    Loop closing brace source line   : 81
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 3 due to a resource limitation (partitioned resource bound).
;*
;*    Loop Unroll Multiple             : 2x
;*    Known Minimum Iteration Count    : 256
;*    Known Maximum Iteration Count    : 256
;*    Known Max Iteration Count Factor : 256
;*    Loop Carried Dependency Bound    : 1
;*    Partitioned Resource Bound(*)    : 3
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     3*       1     
;*      .D units                     2        2     
;*      .M units                     0        2     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          3        2     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             2        1     
;*      Bound(.L .S .D .LS .LSD)     3*       2     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 3  Schedule found with 5 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    For further improvement on this loop, try option -mh8
;*
;*    Minimum safe iteration count    : 1 (after unrolling)
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C1133:
;*   0              LDDW    .D2T2   *B8++(8),B23:B22  ; [B_D64P] |81| 
;*   1              NOP     1       ; [A_L674] 
;*   2              ADD     .L1     8,A6,A4           ; [A_L674] |81| 
;*   3              EXTU    .S1     A4,21,23,A3       ; [A_S674] |81| 
;*     ||           ADD     .L1     4,A6,A8           ; [A_L674] |81| 
;*   4              LDW     .D1T1   *+A5[A3],A3       ; [A_D64P] |81| 
;*     ||           EXTU    .S1     A8,21,23,A3       ; [A_S674] |81| 
;*     ||           ADD     .L1     8,A6,A6           ; [A_L674] |81| 
;*   5              LDW     .D1T1   *+A5[A3],A4       ; [A_D64P] |81| 
;*   6              MPYLI   .M2     B16,B23,B7:B6     ; [B_M674] |81| 
;*   7              MPYLI   .M2     B17,B22,B19:B18   ; [B_M674] |81| 
;*   8              NOP     1       ; [A_L674] 
;*   9              SHR     .S2X    A3,2,B20          ; [B_Sb674] |81| 
;*  10              NOP     1       ; [A_L674] 
;*  11              ADD     .L2     B20,B6,B5         ; [B_L674] |81| 
;*     ||           SHR     .S1     A4,2,A7           ; [A_S674] |81| 
;*  12              NOP     1       ; [A_L674] 
;*  13              ADD     .L2X    A7,B18,B4         ; [B_L674] |81| 
;*  14              STDW    .D2T2   B5:B4,*B9++(8)    ; [B_D64P] |81| 
;*     ||           SPBR                              $C$C1133 ; [] 
;*  15              ; BRANCHCC OCCURS {$C$C1133}      ; [] |81| 
;*----------------------------------------------------------------------------*
$C$L20:    ; PIPED LOOP PROLOG
           SPLOOPD         3                 ;15 ; [A_L674] (P) 
;** --------------------------------------------------------------------------*
$C$L21:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 81,column 35,is_stmt,isa 0
           LDDW    .D2T2   *B8++(8),B23:B22  ; [B_D64P] |81| (P) <0,0> 
           NOP             1                 ; [A_L674] 
           ADD     .L1     8,A6,A4           ; [A_L674] |81| (P) <0,2> 

           ADD     .L1     4,A6,A8           ; [A_L674] |81| (P) <0,3> 
||         EXTU    .S1     A4,21,23,A3       ; [A_S674] |81| (P) <0,3> 

	.dwpsn	file "t1.c",line 81,column 21,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVK     .L2     3,B17             ; [B_L674] |81| 
||         ADD     .L1     8,A6,A6           ; [A_L674] |81| (P) <0,4> 
||         LDW     .D1T1   *+A5[A3],A3       ; [A_D64P] |81| (P) <0,4> 
||         EXTU    .S1     A8,21,23,A3       ; [A_S674] |81| (P) <0,4> 

	.dwpsn	file "t1.c",line 81,column 35,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVKL    .S1     ib,A9             ; [A_S674] 
||^        MV      .L2     B17,B16           ; [B_L674] |81| 
||         LDW     .D1T1   *+A5[A3],A4       ; [A_D64P] |81| (P) <0,5> 

           MPYLI   .M2     B16,B23,B7:B6     ; [B_M674] |81| (P) <0,6> 
           MPYLI   .M2     B17,B22,B19:B18   ; [B_M674] |81| (P) <0,7> 

           SPMASK                            ; [] 
||^        MVKH    .S1     ib,A9             ; [A_S674] 

           SHR     .S2X    A3,2,B20          ; [B_Sb674] |81| (P) <0,9> 
           NOP             1                 ; [A_L674] 

           SPMASK                            ; [] 
||^        MV      .S2X    A9,B9             ; [B_Sb674] 
||         ADD     .L2     B20,B6,B5         ; [B_L674] |81| (P) <0,11> 
||         SHR     .S1     A4,2,A7           ; [A_S674] |81| (P) <0,11> 

           NOP             1                 ; [A_L674] 
           ADD     .L2X    A7,B18,B4         ; [B_L674] |81| <0,13> 

           SPKERNEL        0,0               ; [] 
||         STDW    .D2T2   B5:B4,*B9++(8)    ; [B_D64P] |81| <0,14> 

;** --------------------------------------------------------------------------*
$C$L22:    ; PIPED LOOP EPILOG
           MV      .D1     A5,A20            ; [A_D64P] 
	.dwpsn	file "t1.c",line 82,column 30,is_stmt,isa 0
           MVK     .S2     128,B8            ; [B_Sb674] |82| 
	.dwpsn	file "t1.c",line 82,column 23,is_stmt,isa 0

           ZERO    .L1     A6                ; [A_L674] |82| 
||         SUB     .S2     B8,2,B8           ; [B_Sb674] 

           ZERO    .L2     B16               ; [B_L674] |82| 
           MVC     .S2     B8,ILC            ; [B_Sb674] 
           ADD     .S2X    8,A9,B8           ; [B_Sb674] 
	.dwpsn	file "t1.c",line 82,column 30,is_stmt,isa 0
           MV      .L1     A9,A3             ; [A_L674] |82| 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t1.c",line 82,column 23,is_stmt,isa 0
           ZERO    .L1     A7                ; [A_L674] |82| 
           ZERO    .L2     B5                ; [B_L674] |82| 
;** --------------------------------------------------------------------------*
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 82
;*    Loop opening brace source line   : 82
;*    Loop closing brace source line   : 82
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 3 due to a resource limitation (partitioned resource bound).
;*
;*    Loop Unroll Multiple             : 4x
;*    Known Minimum Iteration Count    : 128
;*    Known Maximum Iteration Count    : 128
;*    Known Max Iteration Count Factor : 128
;*    Loop Carried Dependency Bound(^) : 2
;*    Partitioned Resource Bound(*)    : 3
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     0        0     
;*      .D units                     1        1     
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          5        7     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             0        0     
;*      Bound(.L .S .D .LS .LSD)     2        3*    
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 3  Schedule found with 3 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    For further improvement on this loop, try option -mh16
;*
;*    Minimum safe iteration count    : 1 (after unrolling)
;*----------------------------------------------------------------------------*
;*     SETUP CODE
;*
;*                MV      A3,B8   ; [] 
;*                ADD     8,B8,B8 ; [] 
;*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C1071:
;*   0              LDDW    .D2T2   *B8++(16),B7:B6   ; [B_D64P] |82| 
;*   1              LDDW    .D1T1   *A3++(16),A5:A4   ; [A_D64P] |82| 
;*   2              NOP     4       ; [A_L674] 
;*   6              ADD     .L1X    A5,B5,A5          ; [A_L674] |82|  ^ 
;*     ||           ADD     .L2     B6,B5,B4          ; [B_L674] |82| 
;*     ||           ADD     .S2     B7,B5,B6          ; [B_Sb674] |82| 
;*   7              ADD     .L1X    B5,A4,A5          ; [A_L674] |82|  ^ 
;*     ||           ADD     .S1     1,A5,A4           ; [A_S674] |82| 
;*     ||           ADD     .L2     2,B4,B4           ; [B_L674] |82| 
;*     ||           ADD     .D2     3,B6,B17          ; [B_D64P] |82| 
;*     ||           ADD     .S2     4,B5,B5           ; [B_Sb674] |82|  ^ 
;*   8              XOR     .S1     A5,A6,A6          ; [A_S674] |82| 
;*     ||           XOR     .L1     A4,A7,A7          ; [A_L674] |82| 
;*     ||           XOR     .L2     B4,B9,B9          ; [B_L674] |82| 
;*     ||           XOR     .S2     B17,B16,B16       ; [B_Sb674] |82| 
;*     ||           SPBR                              $C$C1071 ; [] 
;*   9              ; BRANCHCC OCCURS {$C$C1071}      ; [] |82| 
;*----------------------------------------------------------------------------*
$C$L23:    ; PIPED LOOP PROLOG
           SPLOOPD         3                 ;9 ; [A_L674] (P) 
;** --------------------------------------------------------------------------*
$C$L24:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 82,column 44,is_stmt,isa 0
           LDDW    .D2T2   *B8++(16),B7:B6   ; [B_D64P] |82| (P) <0,0> 
           LDDW    .D1T1   *A3++(16),A5:A4   ; [A_D64P] |82| (P) <0,1> 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t1.c",line 82,column 23,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .L2     B9                ; [B_L674] |82| 

	.dwpsn	file "t1.c",line 82,column 44,is_stmt,isa 0

           ADD     .L1X    A5,B5,A5          ; [A_L674] |82| <0,6>  ^ 
||         ADD     .L2     B6,B5,B4          ; [B_L674] |82| <0,6> 
||         ADD     .S2     B7,B5,B6          ; [B_Sb674] |82| <0,6> 

	.dwpsn	file "t1.c",line 82,column 30,is_stmt,isa 0

           ADD     .D2     3,B6,B17          ; [B_D64P] |82| <0,7> 
||         ADD     .L2     2,B4,B4           ; [B_L674] |82| <0,7> 
||         ADD     .S2     4,B5,B5           ; [B_Sb674] |82| <0,7>  ^ 
||         ADD     .L1X    B5,A4,A5          ; [A_L674] |82| <0,7>  ^ 
||         ADD     .S1     1,A5,A4           ; [A_S674] |82| <0,7> 

	.dwpsn	file "t1.c",line 82,column 44,is_stmt,isa 0

           SPKERNEL        0,0               ; [] 
||         XOR     .S1     A5,A6,A6          ; [A_S674] |82| <0,8> 
||         XOR     .L1     A4,A7,A7          ; [A_L674] |82| <0,8> 
||         XOR     .L2     B4,B9,B9          ; [B_L674] |82| <0,8> 
||         XOR     .S2     B17,B16,B16       ; [B_Sb674] |82| <0,8> 

;** --------------------------------------------------------------------------*
$C$L25:    ; PIPED LOOP EPILOG
	.dwpsn	file "t1.c",line 84,column 14,is_stmt,isa 0
           ZERO    .D2     B8                ; [B_D64P] |84| 
           NOP             5                 ; [A_L674] 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 83,column 9,is_stmt,isa 0
$C$DW$184	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$184, DW_AT_low_pc(0x00)
	.dwattr $C$DW$184, DW_AT_name("put")
	.dwattr $C$DW$184, DW_AT_TI_call


           CALL    .S1     put               ; [A_S674] |83| 
||         XOR     .L1     A6,A7,A3          ; [A_L674] |83| 
||         MVK     .S2     37,B7             ; [B_Sb674] 

           MV      .L1X    B16,A5            ; [A_L674] 
           MV      .L1X    B9,A4             ; [A_L674] 
           XOR     .L1     A5,A3,A3          ; [A_L674] |83| 
           XOR     .L1     A4,A3,A4          ; [A_L674] |83| 
           ADDKPC  .S2     $C$RL80,B3,0      ; [B_Sb674] |83| 
$C$RL80:   ; CALL OCCURS {put} {0}           ; [] |83| 
	.dwpsn	file "t1.c",line 84,column 76,is_stmt,isa 0
           MPY     .M2     B8,B7,B4          ; [B_M674] |84| 
           NOP             1                 ; [A_L674] 
           ADD     .L2     1,B4,B4           ; [B_L674] |84| 
           MVC     .S2     B4,RILC           ; [B_Sb674] 
           MVC     .S2     B4,ILC            ; [B_Sb674] 
           NOP             1                 ; [A_L674] 
;** --------------------------------------------------------------------------*
;**   BEGIN LOOP $C$L26
;** --------------------------------------------------------------------------*
$C$L26:    
           NOP             2                 ; [A_L674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 84
;*    Loop opening brace source line   : 84
;*    Loop closing brace source line   : 84
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Maximum Iteration Count    : 223
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound(^) : 0
;*    Partitioned Resource Bound(*)    : 1
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     1*       0     
;*      .D units                     1*       0     
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          1        0     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1*       0     
;*      Bound(.L .S .D .LS .LSD)     1*       0     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 1  Schedule found with 7 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C1009:
;*   0              LDW     .D1T1   *A6++(4),A4       ; [A_D64P] |84| 
;*   1              NOP     4       ; [A_L674] 
;*   5              EXTU    .S1     A4,24,24,A3       ; [A_S674] |84| 
;*   6              ADD     .L1     A3,A5,A5          ; [A_L674] |84| 
;*     ||           SPBR                              $C$C1009 ; [] 
;*   7              ; BRANCHCC OCCURS {$C$C1009}      ; [] |84| 
;*----------------------------------------------------------------------------*
$C$L27:    ; PIPED LOOP PROLOG

           SPLOOP          1                 ;7 ; [A_L674] (P) 
||         MV      .S1     A20,A6            ; [A_S674] 

;** --------------------------------------------------------------------------*
$C$L28:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 84,column 88,is_stmt,isa 0
           LDW     .D1T1   *A6++(4),A4       ; [A_D64P] |84| (P) <0,0> 
           NOP             4                 ; [A_L674] 
	.dwpsn	file "t1.c",line 84,column 55,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .L1     A5                ; [A_L674] |84| 
||         EXTU    .S1     A4,24,24,A3       ; [A_S674] |84| (P) <0,5> 

	.dwpsn	file "t1.c",line 84,column 88,is_stmt,isa 0

           SPKERNEL        0,0               ; [] 
||         ADD     .L1     A3,A5,A5          ; [A_L674] |84| <0,6> 

;** --------------------------------------------------------------------------*
$C$L29:    ; PIPED LOOP EPILOG
	.dwpsn	file "t1.c",line 84,column 21,is_stmt,isa 0
           ADD     .L2     1,B8,B8           ; [B_L674] |84| 
           CMPLT   .L2     B8,7,B0           ; [B_L674] |84| 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t1.c",line 84,column 109,is_stmt,isa 0
$C$DW$185	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$185, DW_AT_low_pc(0x00)
	.dwattr $C$DW$185, DW_AT_name("put")
	.dwattr $C$DW$185, DW_AT_TI_call

           CALL    .S1     put               ; [A_S674] |84| 

           MV      .L1     A5,A4             ; [A_L674] |84| 
||         ADDKPC  .S2     $C$RL82,B3,4      ; [B_Sb674] |84| 

$C$RL82:   ; CALL OCCURS {put} {0}           ; [] |84| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 84,column 21,is_stmt,isa 0

   [ B0]   B       .S1     $C$L26            ; [A_S674] |84| 
|| [ B0]   MPY     .M2     B8,B7,B4          ; [B_M674] |84| 
|| [!B0]   LDW     .D2T1   *+DP(lcg),A3      ; [B_D64P] |87| 
|| [!B0]   MVK     .S2     1024,B4           ; [B_Sb674] |87| 

	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0

   [!B0]   SUB     .L2     B4,1,B4           ; [B_L674] 
|| [!B0]   MVKL    .S1     0x41c64e6d,A4     ; [A_S674] |17| 

	.dwpsn	file "t1.c",line 84,column 76,is_stmt,isa 0
   [ B0]   ADD     .L2     1,B4,B4           ; [B_L674] |84| 
   [ B0]   MVC     .S2     B4,RILC           ; [B_Sb674] 
   [ B0]   MVC     .S2     B4,ILC            ; [B_Sb674] 
   [!B0]   MVC     .S2     B4,ILC            ; [B_Sb674] 
	.dwpsn	file "t1.c",line 84,column 21,is_stmt,isa 0
           ; BRANCHCC OCCURS {$C$L26}        ; [] |84| 
;** --------------------------------------------------------------------------*
           NOP             2                 ; [A_L674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 87
;*    Loop opening brace source line   : 87
;*    Loop closing brace source line   : 87
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 5 due to a loop-carried dependence.
;*
;*    Known Minimum Iteration Count    : 1024
;*    Known Maximum Iteration Count    : 1024
;*    Known Max Iteration Count Factor : 1024
;*    Loop Carried Dependency Bound(^) : 5
;*    Partitioned Resource Bound(*)    : 1
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     0        0     
;*      .D units                     1*       0     
;*      .M units                     1*       0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          1        0     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             0        0     
;*      Bound(.L .S .D .LS .LSD)     1*       0     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 5  Schedule found with 2 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C935:
;*   0              MPY32   .M1     A4,A3,A3          ; [A_M674] |17|  ^ 
;*   1              NOP     3       ; [A_L674] 
;*   4              ADD     .L1     A5,A3,A3          ; [A_L674] |17|  ^ 
;*   5              STB     .D1T1   A3,*A6++(1)       ; [A_D64P] |87| 
;*     ||           SPBR                              $C$C935 ; [] 
;*   6              NOP     4       ; [A_L674] 
;*  10              ; BRANCHCC OCCURS {$C$C935}       ; [] |87| 
;*----------------------------------------------------------------------------*
$C$L30:    ; PIPED LOOP PROLOG
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0

           SPLOOPD         5                 ;10 ; [A_L674] (P) 
||         MVKH    .S1     0x41c64e6d,A4     ; [A_S674] |17| 

;** --------------------------------------------------------------------------*
$C$L31:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVKL    .S2     bytes,B10         ; [B_Sb674] 
||         MPY32   .M1     A4,A3,A3          ; [A_M674] |17| (P) <0,0>  ^ 

           NOP             1                 ; [A_L674] 

           SPMASK                            ; [] 
||^        MVKH    .S2     bytes,B10         ; [B_Sb674] 

           SPMASK                            ; [] 
||^        MV      .L1     A12,A5            ; [A_L674] 

           SPMASK                            ; [] 
||^        MV      .S1X    B10,A6            ; [A_S674] 
||         ADD     .L1     A5,A3,A3          ; [A_L674] |17| (P) <0,4>  ^ 

	.dwpsn	file "t1.c",line 87,column 32,is_stmt,isa 0

           SPKERNEL        0,0               ; [] 
||         STB     .D1T1   A3,*A6++(1)       ; [A_D64P] |87| <0,5> 

;** --------------------------------------------------------------------------*
$C$L32:    ; PIPED LOOP EPILOG
	.dwpsn	file "t1.c",line 88,column 5,is_stmt,isa 0
$C$DW$186	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$186, DW_AT_low_pc(0x08)
	.dwattr $C$DW$186, DW_AT_name("memcpy")
	.dwattr $C$DW$186, DW_AT_TI_call


           MV      .L1     A5,A12            ; [A_L674] 
||         MVK     .S2     500,B4            ; [B_Sb674] |88| 
||         CALL    .S1     memcpy            ; [A_S674] |88| 

           STW     .D2T1   A3,*+DP(lcg)      ; [B_D64P] 
||         ADD     .L2     B4,B10,B4         ; [B_L674] |88| 
||         ADD     .L1X    3,B10,A4          ; [A_L674] |88| 
||         MVK     .S1     301,A6            ; [A_S674] |88| 
||         ADDKPC  .S2     $C$RL84,B3,4      ; [B_Sb674] |88| 

$C$RL84:   ; CALL OCCURS {memcpy} {0}        ; [] |88| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 89,column 5,is_stmt,isa 0

           MVK     .S2     90,B4             ; [B_Sb674] |89| 
||         MVK     .S1     700,A3            ; [A_S674] |89| 

$C$DW$187	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$187, DW_AT_low_pc(0x00)
	.dwattr $C$DW$187, DW_AT_name("memset")
	.dwattr $C$DW$187, DW_AT_TI_call


           CALLP   .S2     memset,B3         ; [B_Sb674] |89| 
||         ADD     .L1X    A3,B10,A4         ; [A_L674] |89| 
||         MVK     .S1     77,A6             ; [A_S674] |89| 

$C$RL86:   ; CALLP OCCURS {memset} {0}       ; [] |89| 
	.dwpsn	file "t1.c",line 90,column 5,is_stmt,isa 0
$C$DW$188	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$188, DW_AT_low_pc(0x00)
	.dwattr $C$DW$188, DW_AT_name("memmove")
	.dwattr $C$DW$188, DW_AT_TI_call


           CALLP   .S2     memmove,B3        ; [B_Sb674] |90| 
||         ADD     .L2     13,B10,B4         ; [B_L674] |90| 
||         MVK     .S1     200,A6            ; [A_S674] |90| 
||         ADD     .L1X    10,B10,A4         ; [A_L674] |90| 

$C$RL88:   ; CALLP OCCURS {memmove} {0}      ; [] |90| 
	.dwpsn	file "t1.c",line 91,column 35,is_stmt,isa 0
           MVK     .S2     256,B4            ; [B_Sb674] |91| 
           SUB     .L2     B4,1,B4           ; [B_L674] 
           MVC     .S2     B4,ILC            ; [B_Sb674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 91
;*    Loop opening brace source line   : 91
;*    Loop closing brace source line   : 91
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 8 due to a loop-carried dependence.
;*
;*    Loop Unroll Multiple             : 4x
;*    Known Minimum Iteration Count    : 256
;*    Known Maximum Iteration Count    : 256
;*    Known Max Iteration Count Factor : 256
;*    Loop Carried Dependency Bound(^) : 8
;*    Partitioned Resource Bound(*)    : 3
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     2        2     
;*      .D units                     1        0     
;*      .M units                     3*       1     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          4        1     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1        1     
;*      Bound(.L .S .D .LS .LSD)     3*       1     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 8  Schedule found with 2 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    For further improvement on this loop, try option -mh4
;*
;*    Minimum safe iteration count    : 1 (after unrolling)
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C849:
;*   0              LDW     .D1T1   *A5++(4),A3       ; [A_D64P] |91| 
;*   1              NOP     3       ; [A_L674] 
;*   4              MPY32   .M1     A4,A3,A3          ; [A_M674] |91|  ^ 
;*   5              MV      .L2X    A3,B4             ; [B_L674] |91| Define a twin register
;*     ||           EXTU    .S1     A3,24,24,A8       ; [A_S674] |91| 
;*   6              MPYU    .M1     A8,A6,A8          ; [A_M674] |91| 
;*     ||           EXTU    .S1     A3,16,24,A3       ; [A_S674] |91| 
;*     ||           EXTU    .S2     B4,8,24,B5        ; [B_Sb674] |91| 
;*   7              MPYU    .M1     A3,A7,A8          ; [A_M674] |91| 
;*     ||           MPYU    .M2     B5,B6,B4          ; [B_M674] |91| 
;*     ||           SHRU    .S2     B4,24,B5          ; [B_Sb674] |91| 
;*   8              ADD     .L1     A8,A3,A3          ; [A_L674] |91|  ^ 
;*   9              ADD     .L1     A8,A3,A3          ; [A_L674] |91|  ^ 
;*  10              ADD     .L1X    B4,A3,A3          ; [A_L674] |91|  ^ 
;*  11              ADD     .L1X    B5,A3,A3          ; [A_L674] |91|  ^ 
;*     ||           SPBR                              $C$C849 ; [] 
;*  12              NOP     4       ; [A_L674] 
;*  16              ; BRANCHCC OCCURS {$C$C849}       ; [] |91| 
;*----------------------------------------------------------------------------*
$C$L33:    ; PIPED LOOP PROLOG

           SPLOOPD         8                 ;16 ; [A_L674] (P) 
||         MV      .S1X    B10,A5            ; [A_S674] 

;** --------------------------------------------------------------------------*
$C$L34:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 91,column 18,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .L1     A3                ; [A_L674] |91| 
||         LDW     .D1T1   *A5++(4),A3       ; [A_D64P] |91| (P) <0,0> 

	.dwpsn	file "t1.c",line 91,column 50,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVK     .S1     961,A7            ; [A_S674] |91| 

           SPMASK                            ; [] 
||^        MVKL    .S1     0xe1781,A4        ; [A_S674] |91| 

           SPMASK                            ; [] 
||^        MVKH    .S1     0xe1781,A4        ; [A_S674] |91| 

           SPMASK                            ; [] 
||^        MVK     .S1     29791,A6          ; [A_S674] |91| 
||         MPY32   .M1     A4,A3,A3          ; [A_M674] |91| (P) <0,4>  ^ 

           SPMASK                            ; [] 
||^        MVK     .S2     31,B6             ; [B_Sb674] |91| 
||         MV      .L2X    A3,B4             ; [B_L674] |91| (P) <0,5> Define a twin register
||         EXTU    .S1     A3,24,24,A8       ; [A_S674] |91| (P) <0,5> 

           EXTU    .S1     A3,16,24,A3       ; [A_S674] |91| (P) <0,6> 
||         MPYU    .M1     A8,A6,A8          ; [A_M674] |91| (P) <0,6> 
||         EXTU    .S2     B4,8,24,B5        ; [B_Sb674] |91| (P) <0,6> 

           SHRU    .S2     B4,24,B5          ; [B_Sb674] |91| (P) <0,7> 
||         MPYU    .M1     A3,A7,A8          ; [A_M674] |91| (P) <0,7> 
||         MPYU    .M2     B5,B6,B4          ; [B_M674] |91| (P) <0,7> 

           ADD     .L1     A8,A3,A3          ; [A_L674] |91| <0,8>  ^ 
           ADD     .L1     A8,A3,A3          ; [A_L674] |91| <0,9>  ^ 
           ADD     .L1X    B4,A3,A3          ; [A_L674] |91| <0,10>  ^ 

           SPKERNEL        0,0               ; [] 
||         ADD     .L1X    B5,A3,A3          ; [A_L674] |91| <0,11>  ^ 

;** --------------------------------------------------------------------------*
$C$L35:    ; PIPED LOOP EPILOG
	.dwpsn	file "t1.c",line 91,column 73,is_stmt,isa 0
$C$DW$189	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$189, DW_AT_low_pc(0x04)
	.dwattr $C$DW$189, DW_AT_name("put")
	.dwattr $C$DW$189, DW_AT_TI_call


           MVK     .L2     -3,B7             ; [B_L674] |94| 
||         CALL    .S1     put               ; [A_S674] |91| 

           MVKL    .S1     0xee6b2800,A5     ; [A_S674] |94| 
||         ADDKPC  .S2     $C$RL90,B3,0      ; [B_Sb674] |91| 

	.dwpsn	file "t1.c",line 94,column 15,is_stmt,isa 0
           MVKH    .S1     0xee6b2800,A5     ; [A_S674] |94| 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t1.c",line 91,column 73,is_stmt,isa 0
           MV      .L1     A3,A4             ; [A_L674] |91| 
           NOP             1                 ; [A_L674] 
$C$RL90:   ; CALL OCCURS {put} {0}           ; [] |91| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 94,column 15,is_stmt,isa 0

           ADDAW   .D2     SP,12,B4          ; [B_D64P] |94| 
||         MVK     .S2     -12345,B5         ; [B_Sb674] |94| 

           STW     .D2T2   B5,*SP(8)         ; [B_D64P] |94| 
||         MVKL    .S2     0xb34fe916,B6     ; [B_Sb674] |94| 
||         MVKL    .S1     0xbeef,A4         ; [A_S674] |94| 

           STW     .D2T1   A5,*SP(12)        ; [B_D64P] |94| 
||         MVKH    .S1     0xbeef,A4         ; [A_S674] |94| 
||         MVKL    .S2     $C$SL2+0,B10      ; [B_Sb674] |94| 

           STW     .D2T1   A4,*SP(16)        ; [B_D64P] |94| 
||         MVKH    .S2     0xb34fe916,B6     ; [B_Sb674] |94| 

           STDW    .D2T2   B7:B6,*SP(32)     ; [B_D64P] |94| 
||         MVKH    .S2     $C$SL2+0,B10      ; [B_Sb674] |94| 
||         MVKL    .S1     $C$SL1+0,A3       ; [A_S674] |94| 

           STW     .D2T2   B10,*SP(20)       ; [B_D64P] |94| 
||         MVKH    .S1     $C$SL1+0,A3       ; [A_S674] |94| 

           STW     .D2T1   A3,*SP(4)         ; [B_D64P] |94| 
||         MVK     .S2     81,B5             ; [B_Sb674] |94| 

$C$DW$190	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$190, DW_AT_low_pc(0x00)
	.dwattr $C$DW$190, DW_AT_name("sprintf")
	.dwattr $C$DW$190, DW_AT_TI_call


           CALLP   .S2     sprintf,B3        ; [B_Sb674] |94| 
||         MV      .L1X    B4,A4             ; [A_L674] |94| 
||         STW     .D2T2   B5,*SP(24)        ; [B_D64P] |94| 

$C$RL92:   ; CALLP OCCURS {sprintf} {0}      ; [] |94| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 95,column 40,is_stmt,isa 0
           LDB     .D2T1   *SP(48),A0        ; [B_D64P] |95| 
           ADDAW   .D2     SP,12,B4          ; [B_D64P] 
           NOP             3                 ; [A_L674] 

   [!A0]   BNOP            $C$L39,5          ; [] |95| 
|| [ A0]   MVK     .L2     1,B0              ; [B_L674] 

           ; BRANCHCC OCCURS {$C$L39}        ; [] |95| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 95
;*    Loop opening brace source line   : 95
;*    Loop closing brace source line   : 95
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 3 due to a loop-carried dependence.
;*      - The compiler is having trouble finding a successful schedule
;*        at/near this variation's starting ii of 3 due to issues
;*        noted below in the "searching for..." section.
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound    : 3
;*    Partitioned Resource Bound(*)    : 1
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     1*       1*    
;*      .D units                     0        1*    
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          2        1     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1*       1*    
;*      Bound(.L .S .D .LS .LSD)     1*       1*    
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 4  Unsafe schedule for irregular loop
;*      ii = 4  Unsafe schedule for irregular loop
;*      ii = 4  Unsafe schedule for irregular loop
;*      ii = 4  Did not find schedule
;*      ii = 5  Unsafe schedule for irregular loop
;*      ii = 5  Unsafe schedule for irregular loop
;*      ii = 5  Unsafe schedule for irregular loop
;*      ii = 5  Did not find schedule
;*      ii = 6  Schedule found with 2 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    For further improvement on this loop, try option -mh14
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*     SETUP CODE
;*
;*                MVK     1,B0    ; [] 
;*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C676:
;*   0              SHL     .S1     A4,5,A3           ; [A_S674] |95| 
;*   1              ADD     .L1     A4,A3,A3          ; [A_L674] |95| 
;*     ||           EXTU    .S2     B5,24,24,B6       ; [B_Sb674] |95| 
;*   2      [ B0]   LDB     .D2T2   *++B4(1),B5       ; [B_D64P] |95| 
;*   3      [ B0]   ADD     .L1X    B6,A3,A4          ; [A_L674] |95| 
;*   4              NOP     3       ; [A_L674] 
;*   7              MV      .L2     B5,B0             ; [B_L674] |95| 
;*   8      [ B0]   SPWBR                             $C$C676 ; [] 
;*   9              NOP     3       ; [A_L674] 
;*  12              ; BRANCHCC OCCURS {$C$C676}       ; [] |95| 
;*----------------------------------------------------------------------------*
$C$L36:    ; PIPED LOOP PROLOG
   [ B0]   SPLOOPW         6                 ;12 ; [A_L674] (P) 
;** --------------------------------------------------------------------------*
$C$L37:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 95,column 60,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MV      .L2X    A0,B5             ; [B_L674] 
||         SHL     .S1     A4,5,A3           ; [A_S674] |95| (P) <0,0> 

           ADD     .L1     A4,A3,A3          ; [A_L674] |95| (P) <0,1> 
||         EXTU    .S2     B5,24,24,B6       ; [B_Sb674] |95| (P) <0,1> 

	.dwpsn	file "t1.c",line 95,column 55,is_stmt,isa 0
   [ B0]   LDB     .D2T2   *++B4(1),B5       ; [B_D64P] |95| (P) <0,2> 
	.dwpsn	file "t1.c",line 95,column 60,is_stmt,isa 0
   [ B0]   ADD     .L1X    B6,A3,A4          ; [A_L674] |95| (P) <0,3> 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t1.c",line 95,column 55,is_stmt,isa 0
           MV      .L2     B5,B0             ; [B_L674] |95| <0,7> 
           NOP             2                 ; [A_L674] 
           NOP             1                 ; [A_L674] 
           SPKERNEL        0,0               ; [] 
;** --------------------------------------------------------------------------*
$C$L38:    ; PIPED LOOP EPILOG
;** --------------------------------------------------------------------------*
$C$L39:    
	.dwpsn	file "t1.c",line 95,column 96,is_stmt,isa 0
$C$DW$191	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$191, DW_AT_low_pc(0x00)
	.dwattr $C$DW$191, DW_AT_name("put")
	.dwattr $C$DW$191, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |95| 
$C$RL94:   ; CALLP OCCURS {put} {0}          ; [] |95| 
	.dwpsn	file "t1.c",line 96,column 9,is_stmt,isa 0
           MVKL    .S2     0x40c81cd6,B9     ; [B_Sb674] |96| 

           MVKL    .S2     0xc8b43958,B8     ; [B_Sb674] |96| 
||         MVKL    .S1     0xbf202e7e,A5     ; [A_S674] |96| 

           MVKL    .S1     $C$SL3+0,A3       ; [A_S674] |96| 
||         MVKL    .S2     0x400921fb,B7     ; [B_Sb674] |96| 

           MVKH    .S1     0xbf202e7e,A5     ; [A_S674] |96| 
||         MVKH    .S2     0x40c81cd6,B9     ; [B_Sb674] |96| 

           MVKL    .S1     0xf70994dd,A4     ; [A_S674] |96| 
||         MVKH    .S2     0xc8b43958,B8     ; [B_Sb674] |96| 
||         ADDAW   .D2     SP,12,B16         ; [B_D64P] |96| 

           STDW    .D2T2   B9:B8,*SP(24)     ; [B_D64P] |96| 
||         MVKH    .S1     $C$SL3+0,A3       ; [A_S674] |96| 
||         MVKH    .S2     0x400921fb,B7     ; [B_Sb674] |96| 

           STW     .D2T1   A3,*SP(4)         ; [B_D64P] |96| 
||         MVKH    .S1     0xf70994dd,A4     ; [A_S674] |96| 
||         MVKL    .S2     0x53c8d4f1,B6     ; [B_Sb674] |96| 
||         ZERO    .L2     B5                ; [B_L674] |96| 

           STDW    .D2T1   A5:A4,*SP(16)     ; [B_D64P] |96| 
||         MVKH    .S2     0xc0040000,B5     ; [B_Sb674] |96| 
||         ZERO    .L2     B4                ; [B_L674] |96| 

           STDW    .D2T2   B5:B4,*SP(32)     ; [B_D64P] |96| 
||         MVKH    .S2     0x53c8d4f1,B6     ; [B_Sb674] |96| 

$C$DW$192	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$192, DW_AT_low_pc(0x00)
	.dwattr $C$DW$192, DW_AT_name("sprintf")
	.dwattr $C$DW$192, DW_AT_TI_call


           CALLP   .S2     sprintf,B3        ; [B_Sb674] |96| 
||         MV      .L1X    B16,A4            ; [A_L674] |96| 
||         STDW    .D2T2   B7:B6,*SP(8)      ; [B_D64P] |96| 

$C$RL96:   ; CALLP OCCURS {sprintf} {0}      ; [] |96| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 97,column 31,is_stmt,isa 0
           LDB     .D2T1   *SP(48),A0        ; [B_D64P] |97| 
           ADDAW   .D2     SP,12,B4          ; [B_D64P] 
           NOP             3                 ; [A_L674] 

   [!A0]   BNOP            $C$L43,5          ; [] |97| 
|| [ A0]   MVK     .L2     1,B0              ; [B_L674] 

           ; BRANCHCC OCCURS {$C$L43}        ; [] |97| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 97
;*    Loop opening brace source line   : 97
;*    Loop closing brace source line   : 97
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 3 due to a loop-carried dependence.
;*      - The compiler is having trouble finding a successful schedule
;*        at/near this variation's starting ii of 3 due to issues
;*        noted below in the "searching for..." section.
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound    : 3
;*    Partitioned Resource Bound(*)    : 1
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     1*       1*    
;*      .D units                     0        1*    
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          2        1     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1*       1*    
;*      Bound(.L .S .D .LS .LSD)     1*       1*    
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 4  Unsafe schedule for irregular loop
;*      ii = 4  Unsafe schedule for irregular loop
;*      ii = 4  Unsafe schedule for irregular loop
;*      ii = 4  Did not find schedule
;*      ii = 5  Unsafe schedule for irregular loop
;*      ii = 5  Unsafe schedule for irregular loop
;*      ii = 5  Unsafe schedule for irregular loop
;*      ii = 5  Did not find schedule
;*      ii = 6  Schedule found with 2 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    For further improvement on this loop, try option -mh14
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*     SETUP CODE
;*
;*                MVK     1,B0    ; [] 
;*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C500:
;*   0              SHL     .S1     A4,5,A3           ; [A_S674] |97| 
;*   1              ADD     .L1     A4,A3,A3          ; [A_L674] |97| 
;*     ||           EXTU    .S2     B5,24,24,B6       ; [B_Sb674] |97| 
;*   2      [ B0]   LDB     .D2T2   *++B4(1),B5       ; [B_D64P] |97| 
;*   3      [ B0]   ADD     .L1X    B6,A3,A4          ; [A_L674] |97| 
;*   4              NOP     3       ; [A_L674] 
;*   7              MV      .L2     B5,B0             ; [B_L674] |97| 
;*   8      [ B0]   SPWBR                             $C$C500 ; [] 
;*   9              NOP     3       ; [A_L674] 
;*  12              ; BRANCHCC OCCURS {$C$C500}       ; [] |97| 
;*----------------------------------------------------------------------------*
$C$L40:    ; PIPED LOOP PROLOG
   [ B0]   SPLOOPW         6                 ;12 ; [A_L674] (P) 
;** --------------------------------------------------------------------------*
$C$L41:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 97,column 51,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MV      .L2X    A0,B5             ; [B_L674] 
||         SHL     .S1     A4,5,A3           ; [A_S674] |97| (P) <0,0> 

           ADD     .L1     A4,A3,A3          ; [A_L674] |97| (P) <0,1> 
||         EXTU    .S2     B5,24,24,B6       ; [B_Sb674] |97| (P) <0,1> 

	.dwpsn	file "t1.c",line 97,column 46,is_stmt,isa 0
   [ B0]   LDB     .D2T2   *++B4(1),B5       ; [B_D64P] |97| (P) <0,2> 
	.dwpsn	file "t1.c",line 97,column 51,is_stmt,isa 0
   [ B0]   ADD     .L1X    B6,A3,A4          ; [A_L674] |97| (P) <0,3> 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t1.c",line 97,column 46,is_stmt,isa 0
           MV      .L2     B5,B0             ; [B_L674] |97| <0,7> 
           NOP             2                 ; [A_L674] 
           NOP             1                 ; [A_L674] 
           SPKERNEL        0,0               ; [] 
;** --------------------------------------------------------------------------*
$C$L42:    ; PIPED LOOP EPILOG
;** --------------------------------------------------------------------------*
$C$L43:    
	.dwpsn	file "t1.c",line 97,column 87,is_stmt,isa 0
$C$DW$193	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$193, DW_AT_low_pc(0x00)
	.dwattr $C$DW$193, DW_AT_name("put")
	.dwattr $C$DW$193, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |97| 
$C$RL98:   ; CALLP OCCURS {put} {0}          ; [] |97| 
	.dwpsn	file "t1.c",line 98,column 9,is_stmt,isa 0
$C$DW$194	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$194, DW_AT_low_pc(0x00)
	.dwattr $C$DW$194, DW_AT_name("put")
	.dwattr $C$DW$194, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |98| 
||         MVK     .L1     11,A4             ; [A_L674] |98| 

$C$RL100:  ; CALLP OCCURS {put} {0}          ; [] |98| 
           MV      .L2     B10,B4            ; [B_L674] |98| 
	.dwpsn	file "C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h",line 411,column 1,is_stmt,isa 0

           LDB     .D2T2   *B4++(1),B6       ; [B_D64P] |416| (P) <0,0> 
||         MVKL    .S1     $C$SL4+0,A4       ; [A_S674] |411| 

           MVKH    .S1     $C$SL4+0,A4       ; [A_S674] |411| 
||         ZERO    .L2     B0                ; [B_L674] 

	.dwpsn	file "C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h",line 417,column 8,is_stmt,isa 0
   [!B0]   LDBU    .D1T1   *A4++(1),A3       ; [A_D64P] |417| (P) <0,2> 
           DINT                               ; [B_Sb674] interrupts off
           NOP             1                 ; [A_L674] 
	.dwpsn	file "C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h",line 416,column 8,is_stmt,isa 0
           EXTU    .S2     B6,24,24,B5       ; [B_Sb674] |416| (P) <0,5> 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop inlined from                : C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h
;*    Loop source line                 : 414
;*    Loop opening brace source line   : 415
;*    Loop closing brace source line   : 420
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 2 due to a loop-carried dependence and
;*        a resource limitation (partitioned resource bound).
;*      - The compiler is having trouble finding a successful schedule
;*        at/near this variation's starting ii of 2 due to issues
;*        noted below in the "searching for..." section.
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound    : 2
;*    Partitioned Resource Bound(*)    : 2
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        1     
;*      .S units                     1        2*    
;*      .D units                     1        1     
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          0        2     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1        2*    
;*      Bound(.L .S .D .LS .LSD)     1        2*    
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 6  Unsafe schedule for irregular loop
;*      ii = 6  Unsafe schedule for irregular loop
;*      ii = 6  Unsafe schedule for irregular loop
;*      ii = 6  Did not find schedule
;*      ii = 7  Unsafe schedule for irregular loop
;*      ii = 7  Unsafe schedule for irregular loop
;*      ii = 7  Unsafe schedule for irregular loop
;*      ii = 7  Did not find schedule
;*      ii = 8  Unsafe schedule for irregular loop
;*      ii = 8  Unsafe schedule for irregular loop
;*      ii = 8  Unsafe schedule for irregular loop
;*      ii = 8  Did not find schedule
;*      ii = 9  Schedule found with 2 iterations in parallel
;*    Done
;*
;*    Minimum required memory pad   : 0 bytes
;*
;*    For further improvement on this loop, try option -mh14
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*     SETUP CODE
;*
;*                ZERO    B0      ; [] 
;*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C423:
;*   0      [!B0]   LDB     .D2T2   *B4++(1),B6       ; [B_D64P] |416| 
;*   1              NOP     1       ; [A_L674] 
;*   2      [!B0]   LDBU    .D1T1   *A4++(1),A3       ; [A_D64P] |417| 
;*   3              NOP     2       ; [A_L674] 
;*   5              EXTU    .S2     B6,24,24,B5       ; [B_Sb674] |416| 
;*   6              EXTU    .S2     B6,24,24,B7       ; [B_Sb674] |417| 
;*     ||           CMPEQ   .L2     B5,0,B5           ; [B_L674] |419| 
;*   7              SUB     .L2X    B7,A3,B7          ; [B_L674] |417| 
;*   8              OR      .L2     B7,B5,B0          ; [B_L674] |419| 
;*   9      [!B0]   B       .S1     $C$C423           ; [A_S674] |419| 
;*  10              NOP     5       ; [A_L674] 
;*  15              ; BRANCHCC OCCURS {$C$C423}       ; [] |419| 
;*----------------------------------------------------------------------------*
$C$L44:    ; PIPED LOOP PROLOG
;** --------------------------------------------------------------------------*
$C$L45:    ; PIPED LOOP KERNEL
	.dwpsn	file "C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h",line 417,column 8,is_stmt,isa 0

           CMPEQ   .L2     B5,0,B5           ; [B_L674] |419| <0,6> 
||         EXTU    .S2     B6,24,24,B7       ; [B_Sb674] |417| <0,6> 

           SUB     .L2X    B7,A3,B7          ; [B_L674] |417| <0,7> 
	.dwpsn	file "C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h",line 419,column 33,is_stmt,isa 0
           OR      .L2     B7,B5,B0          ; [B_L674] |419| <0,8> 
	.dwpsn	file "C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h",line 416,column 8,is_stmt,isa 0

   [!B0]   BNOP            $C$L45,1          ; [] |419| <0,9> 
|| [!B0]   LDB     .D2T2   *B4++(1),B6       ; [B_D64P] |416| <1,0> 

	.dwpsn	file "C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h",line 417,column 8,is_stmt,isa 0
   [!B0]   LDBU    .D1T1   *A4++(1),A3       ; [A_D64P] |417| <1,2> 
           NOP             2                 ; [A_L674] 
	.dwpsn	file "C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h",line 416,column 8,is_stmt,isa 0
           EXTU    .S2     B6,24,24,B5       ; [B_Sb674] |416| <1,5> 
;** --------------------------------------------------------------------------*
$C$L46:    ; PIPED LOOP EPILOG
;** --------------------------------------------------------------------------*
           RINT                               ; [B_Sb674] interrupts on
	.dwpsn	file "t1.c",line 98,column 47,is_stmt,isa 0
$C$DW$195	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$195, DW_AT_low_pc(0x00)
	.dwattr $C$DW$195, DW_AT_name("put")
	.dwattr $C$DW$195, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |98| 
||         MV      .L1X    B7,A4             ; [A_L674] 

$C$RL102:  ; CALLP OCCURS {put} {0}          ; [] |98| 
	.dwpsn	file "t1.c",line 98,column 84,is_stmt,isa 0
           MVKL    .S1     $C$SL5+0,A4       ; [A_S674] |98| 
$C$DW$196	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$196, DW_AT_low_pc(0x00)
	.dwattr $C$DW$196, DW_AT_name("atoi")
	.dwattr $C$DW$196, DW_AT_TI_call


           CALLP   .S2     atoi,B3           ; [B_Sb674] |98| 
||         MVKH    .S1     $C$SL5+0,A4       ; [A_S674] |98| 

$C$RL104:  ; CALLP OCCURS {atoi} {0}         ; [] |98| 
$C$DW$197	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$197, DW_AT_low_pc(0x00)
	.dwattr $C$DW$197, DW_AT_name("put")
	.dwattr $C$DW$197, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |98| 
$C$RL106:  ; CALLP OCCURS {put} {0}          ; [] |98| 
	.dwpsn	file "t1.c",line 99,column 9,is_stmt,isa 0
           MVK     .S1     16,A6             ; [A_S674] |99| 
           MVKL    .S1     $C$SL6+0,A4       ; [A_S674] |99| 
$C$DW$198	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$198, DW_AT_low_pc(0x00)
	.dwattr $C$DW$198, DW_AT_name("strtol")
	.dwattr $C$DW$198, DW_AT_TI_call


           CALLP   .S2     strtol,B3         ; [B_Sb674] |99| 
||         MVKH    .S1     $C$SL6+0,A4       ; [A_S674] |99| 
||         ZERO    .L2     B4                ; [B_L674] |99| 

$C$RL108:  ; CALLP OCCURS {strtol} {0}       ; [] |99| 
$C$DW$199	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$199, DW_AT_low_pc(0x00)
	.dwattr $C$DW$199, DW_AT_name("put")
	.dwattr $C$DW$199, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |99| 
$C$RL110:  ; CALLP OCCURS {put} {0}          ; [] |99| 
	.dwpsn	file "t1.c",line 102,column 33,is_stmt,isa 0
           LDW     .D2T1   *+DP(lcg),A9      ; [B_D64P] |102| 
           MVK     .S2     100,B8            ; [B_Sb674] 
           SUB     .L2     B8,1,B4           ; [B_L674] 
	.dwpsn	file "t1.c",line 17,column 63,is_stmt,isa 0

           MVC     .S2     B4,ILC            ; [B_Sb674] 
||         MVKL    .S1     0x41c64e6d,A7     ; [A_S674] |17| 

;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 102
;*    Loop opening brace source line   : 102
;*    Loop closing brace source line   : 102
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 5 due to a loop-carried dependence.
;*
;*    Known Minimum Iteration Count    : 100
;*    Known Maximum Iteration Count    : 100
;*    Known Max Iteration Count Factor : 100
;*    Loop Carried Dependency Bound(^) : 5
;*    Partitioned Resource Bound(*)    : 2
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        1     
;*      .S units                     1        0     
;*      .D units                     0        1     
;*      .M units                     2*       1     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          1        1     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1        1     
;*      Bound(.L .S .D .LS .LSD)     1        1     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 5  Schedule found with 4 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C269:
;*   0              MPY32   .M1     A7,A9,A4          ; [A_M674] |17|  ^ 
;*   1              NOP     3       ; [A_L674] 
;*   4              ADD     .L1     A8,A4,A9          ; [A_L674] |17|  ^ 
;*   5              NOP     1       ; [A_L674] 
;*   6              MPY32U  .M1     A6,A9,A5:A4       ; [A_M674] |102| 
;*   7              NOP     1       ; [A_L674] 
;*   8              MVD     .M1     A9,A3             ; [A_M674] |17| Split a long life
;*   9              NOP     1       ; [A_L674] 
;*  10              SHRU    .S1     A5,6,A4           ; [A_S674] |102| 
;*  11              NOP     1       ; [A_L674] 
;*  12              MPY32   .M2X    B5,A4,B4          ; [B_M674] |102| 
;*  13              NOP     3       ; [A_L674] 
;*  16              SUB     .L2X    A3,B4,B4          ; [B_L674] |102| 
;*  17              ADD     .L2     B6,B4,B4          ; [B_L674] |102| 
;*  18              STW     .D2T2   B4,*B7++(4)       ; [B_D64P] |102| 
;*     ||           SPBR                              $C$C269 ; [] 
;*  19              NOP     1       ; [A_L674] 
;*  20              ; BRANCHCC OCCURS {$C$C269}       ; [] |102| 
;*----------------------------------------------------------------------------*
$C$L47:    ; PIPED LOOP PROLOG

           SPLOOPD         5                 ;20 ; [A_L674] (P) 
||         MVKH    .S1     0x41c64e6d,A7     ; [A_S674] |17| 

;** --------------------------------------------------------------------------*
$C$L48:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0
           MPY32   .M1     A7,A9,A4          ; [A_M674] |17| (P) <0,0>  ^ 
           NOP             2                 ; [A_L674] 

           SPMASK                            ; [] 
||^        MV      .L1     A12,A8            ; [A_L674] 

           SPMASK                            ; [] 
||^        MVKL    .S1     0x10624dd3,A6     ; [A_S674] |102| 
||         ADD     .L1     A8,A4,A9          ; [A_L674] |17| (P) <0,4>  ^ 

	.dwpsn	file "t1.c",line 102,column 47,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVKH    .S1     0x10624dd3,A6     ; [A_S674] |102| 

           MPY32U  .M1     A6,A9,A5:A4       ; [A_M674] |102| (P) <0,6> 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t1.c",line 17,column 29,is_stmt,isa 0
           MVD     .M1     A9,A3             ; [A_M674] |17| (P) <0,8> Split a long life
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t1.c",line 102,column 47,is_stmt,isa 0
           SHRU    .S1     A5,6,A4           ; [A_S674] |102| (P) <0,10> 

           SPMASK                            ; [] 
||^        MVK     .S2     1000,B5           ; [B_Sb674] |102| 

           MPY32   .M2X    B5,A4,B4          ; [B_M674] |102| (P) <0,12> 
           NOP             1                 ; [A_L674] 

           SPMASK                            ; [] 
||^        ADDAW   .D2     SP,12,B7          ; [B_D64P] 
||^        MVK     .S2     -500,B6           ; [B_Sb674] 

           NOP             1                 ; [A_L674] 
           SUB     .L2X    A3,B4,B4          ; [B_L674] |102| <0,16> 
           ADD     .L2     B6,B4,B4          ; [B_L674] |102| <0,17> 

           SPKERNEL        0,0               ; [] 
||         STW     .D2T2   B4,*B7++(4)       ; [B_D64P] |102| <0,18> 

;** --------------------------------------------------------------------------*
$C$L49:    ; PIPED LOOP EPILOG
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t1.c",line 103,column 7,is_stmt,isa 0
           MVK     .L1     4,A6              ; [A_L674] |103| 
           NOP             5                 ; [A_L674] 
           ADDAW   .D2     SP,12,B5          ; [B_D64P] |103| 
$C$DW$200	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$200, DW_AT_low_pc(0x00)
	.dwattr $C$DW$200, DW_AT_name("qsort")
	.dwattr $C$DW$200, DW_AT_TI_call

           CALL    .S1     qsort             ; [A_S674] |103| 

           STW     .D2T1   A3,*+DP(lcg)      ; [B_D64P] 
||         MV      .L1X    B5,A4             ; [A_L674] |103| 
||         ADDKPC  .S2     $C$RL112,B3,2     ; [B_Sb674] |103| 

           MVKL    .S2     cmp_int,B6        ; [B_Sb674] |103| 

           MVKH    .S2     cmp_int,B6        ; [B_Sb674] |103| 
||         MV      .L2     B8,B4             ; [B_L674] |103| 

$C$RL112:  ; CALL OCCURS {qsort} {0}         ; [] |103| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 104,column 35,is_stmt,isa 0
           MVK     .S2     50,B4             ; [B_Sb674] |104| 
           SUB     .L2     B4,1,B4           ; [B_L674] 
           MVC     .S2     B4,ILC            ; [B_Sb674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 104
;*    Loop opening brace source line   : 104
;*    Loop closing brace source line   : 104
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 6 due to a loop-carried dependence.
;*
;*    Loop Unroll Multiple             : 2x
;*    Known Minimum Iteration Count    : 50
;*    Known Maximum Iteration Count    : 50
;*    Known Max Iteration Count Factor : 50
;*    Loop Carried Dependency Bound(^) : 6
;*    Partitioned Resource Bound(*)    : 2
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     2*       0     
;*      .D units                     0        1     
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          4        0     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1        0     
;*      Bound(.L .S .D .LS .LSD)     2*       1     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 6  Schedule found with 2 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    Minimum safe iteration count    : 1 (after unrolling)
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C183:
;*   0              LDDW    .D2T1   *B4++(8),A5:A4    ; [B_D64P] |104| 
;*   1              NOP     2       ; [A_L674] 
;*   3              SHL     .S1     A4,3,A3           ; [A_S674] |104|  ^ 
;*   4              SUB     .L1     A3,A4,A3          ; [A_L674] |104|  ^ 
;*   5              ADD     .L1     A4,A3,A4          ; [A_L674] |104|  ^ 
;*   6              SHL     .S1     A4,3,A3           ; [A_S674] |104|  ^ 
;*   7              SUB     .L1     A3,A4,A3          ; [A_L674] |104|  ^ 
;*   8              ADD     .L1     A5,A3,A4          ; [A_L674] |104|  ^ 
;*     ||           SPBR                              $C$C183 ; [] 
;*   9              NOP     3       ; [A_L674] 
;*  12              ; BRANCHCC OCCURS {$C$C183}       ; [] |104| 
;*----------------------------------------------------------------------------*
$C$L50:    ; PIPED LOOP PROLOG

           SPLOOPD         6                 ;12 ; [A_L674] (P) 
||         ADDAW   .D2     SP,12,B4          ; [B_D64P] 

;** --------------------------------------------------------------------------*
$C$L51:    ; PIPED LOOP KERNEL
	.dwpsn	file "t1.c",line 104,column 18,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .L1     A4                ; [A_L674] |104| 
||         LDDW    .D2T1   *B4++(8),A5:A4    ; [B_D64P] |104| (P) <0,0> 

           NOP             2                 ; [A_L674] 
	.dwpsn	file "t1.c",line 104,column 49,is_stmt,isa 0
           SHL     .S1     A4,3,A3           ; [A_S674] |104| (P) <0,3>  ^ 
           SUB     .L1     A3,A4,A3          ; [A_L674] |104| (P) <0,4>  ^ 
           ADD     .L1     A4,A3,A4          ; [A_L674] |104| (P) <0,5>  ^ 
           SHL     .S1     A4,3,A3           ; [A_S674] |104| <0,6>  ^ 
           SUB     .L1     A3,A4,A3          ; [A_L674] |104| <0,7>  ^ 

           SPKERNEL        0,0               ; [] 
||         ADD     .L1     A5,A3,A4          ; [A_L674] |104| <0,8>  ^ 

;** --------------------------------------------------------------------------*
$C$L52:    ; PIPED LOOP EPILOG
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t1.c",line 104,column 79,is_stmt,isa 0
$C$DW$201	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$201, DW_AT_low_pc(0x00)
	.dwattr $C$DW$201, DW_AT_name("put")
	.dwattr $C$DW$201, DW_AT_TI_call

           CALL    .S1     put               ; [A_S674] |104| 
           ADDKPC  .S2     $C$RL114,B3,4     ; [B_Sb674] |104| 
$C$RL114:  ; CALL OCCURS {put} {0}           ; [] |104| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 105,column 5,is_stmt,isa 0
$C$DW$202	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$202, DW_AT_low_pc(0x00)
	.dwattr $C$DW$202, DW_AT_name("fib")
	.dwattr $C$DW$202, DW_AT_TI_call


           CALLP   .S2     fib,B3            ; [B_Sb674] |105| 
||         MVK     .S1     20,A4             ; [A_S674] |105| 

$C$RL116:  ; CALLP OCCURS {fib} {0}          ; [] |105| 
$C$DW$203	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$203, DW_AT_low_pc(0x00)
	.dwattr $C$DW$203, DW_AT_name("put")
	.dwattr $C$DW$203, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |105| 
$C$RL118:  ; CALLP OCCURS {put} {0}          ; [] |105| 
	.dwpsn	file "t1.c",line 106,column 13,is_stmt,isa 0

           ZERO    .L1     A4                ; [A_L674] |106| 
||         ZERO    .L2     B5                ; [B_L674] |106| 
||         MVK     .S2     25,B0             ; [B_Sb674] |106| 

;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 26,column 5,is_stmt,isa 0
           MVK     .S2     21,B4             ; [B_Sb674] |26| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 106
;*    Loop opening brace source line   : 106
;*    Loop closing brace source line   : 106
;*    Disqualified loop: Loop contains control code
;*----------------------------------------------------------------------------*
$C$L53:    

           CMPGTU  .L2     B5,B4,B1          ; [B_L674] |26| 
||         MVKL    .S2     $C$SW1,B4         ; [B_Sb674] |26| 

   [ B1]   B       .S1     $C$L55            ; [A_S674] |26| 
||         MVKH    .S2     $C$SW1,B4         ; [B_Sb674] |26| 
|| [ B1]   MVK     .L1     -1,A6             ; [A_L674] |28| 

   [ B1]   BNOP            $C$L64,4          ; [] |28| 
|| [!B1]   LDW     .D2T1   *+B4[B5],A3       ; [B_D64P] |26| 

           ; BRANCHCC OCCURS {$C$L55} {-9}   ; [] |26| 
;** --------------------------------------------------------------------------*
           BNOP            A3,5              ; [] |26| 
           ; BRANCH OCCURS {A3}              ; [] |26| 
	.sect	".switch:main"
	.clink
$C$SW1:	.word	$C$L63	; 0
	.word	$C$L62	; 1
	.word	$C$L61	; 2
	.word	$C$L60	; 3
	.word	$C$L54	; 0
	.word	$C$L59	; 5
	.word	$C$L54	; 0
	.word	$C$L54	; 0
	.word	$C$L58	; 8
	.word	$C$L54	; 0
	.word	$C$L54	; 0
	.word	$C$L54	; 0
	.word	$C$L54	; 0
	.word	$C$L57	; 13
	.word	$C$L54	; 0
	.word	$C$L54	; 0
	.word	$C$L54	; 0
	.word	$C$L54	; 0
	.word	$C$L54	; 0
	.word	$C$L54	; 0
	.word	$C$L54	; 0
	.word	$C$L56	; 21
	.sect	".text"
;** --------------------------------------------------------------------------*
$C$L54:    
	.dwpsn	file "t1.c",line 28,column 75,is_stmt,isa 0

           BNOP            $C$L64,4          ; [] |28| 
||         MVK     .L1     -1,A6             ; [A_L674] |28| 

;** --------------------------------------------------------------------------*
$C$L55:    
	.dwpsn	file "t1.c",line 106,column 30,is_stmt,isa 0

           MVK     .L1     3,A3              ; [A_L674] |106| 
||         ADD     .L2     1,B5,B5           ; [B_L674] |106| 
||         SUB     .S2     B0,1,B0           ; [B_Sb674] |106| 

	.dwpsn	file "t1.c",line 28,column 75,is_stmt,isa 0
           ; BRANCH OCCURS {$C$L64}          ; [] |28| 
;** --------------------------------------------------------------------------*
$C$L56:    
	.dwpsn	file "t1.c",line 28,column 54,is_stmt,isa 0

           B       .S2     $C$L65            ; [B_Sb674] |28| 
||         MVK     .L1     3,A3              ; [A_L674] |106| 

	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           MPYLI   .M1     A3,A4,A5:A4       ; [A_M674] |106| 
	.dwpsn	file "t1.c",line 106,column 30,is_stmt,isa 0
           ADD     .L2     1,B5,B5           ; [B_L674] |106| 
           SUB     .L2     B0,1,B0           ; [B_L674] |106| 
	.dwpsn	file "t1.c",line 28,column 54,is_stmt,isa 0
           MVK     .S1     210,A6            ; [A_S674] |28| 
	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           ADD     .L1     A6,A4,A4          ; [A_L674] |106| 
	.dwpsn	file "t1.c",line 28,column 54,is_stmt,isa 0
           ; BRANCH OCCURS {$C$L65}          ; [] |28| 
;** --------------------------------------------------------------------------*
$C$L57:    
	.dwpsn	file "t1.c",line 28,column 33,is_stmt,isa 0

           B       .S2     $C$L65            ; [B_Sb674] |28| 
||         MVK     .L1     3,A3              ; [A_L674] |106| 

	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           MPYLI   .M1     A3,A4,A5:A4       ; [A_M674] |106| 
	.dwpsn	file "t1.c",line 106,column 30,is_stmt,isa 0
           SUB     .L2     B0,1,B0           ; [B_L674] |106| 
           ADD     .L2     1,B5,B5           ; [B_L674] |106| 
	.dwpsn	file "t1.c",line 28,column 33,is_stmt,isa 0
           MVK     .S1     130,A6            ; [A_S674] |28| 
	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           ADD     .L1     A6,A4,A4          ; [A_L674] |106| 
	.dwpsn	file "t1.c",line 28,column 33,is_stmt,isa 0
           ; BRANCH OCCURS {$C$L65}          ; [] |28| 
;** --------------------------------------------------------------------------*
$C$L58:    
	.dwpsn	file "t1.c",line 28,column 13,is_stmt,isa 0

           B       .S2     $C$L65            ; [B_Sb674] |28| 
||         MVK     .L1     3,A3              ; [A_L674] |106| 

	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           MPYLI   .M1     A3,A4,A5:A4       ; [A_M674] |106| 
	.dwpsn	file "t1.c",line 106,column 30,is_stmt,isa 0
           ADD     .L2     1,B5,B5           ; [B_L674] |106| 
           SUB     .L2     B0,1,B0           ; [B_L674] |106| 
	.dwpsn	file "t1.c",line 28,column 13,is_stmt,isa 0
           MVK     .S1     88,A6             ; [A_S674] |28| 
	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           ADD     .L1     A6,A4,A4          ; [A_L674] |106| 
	.dwpsn	file "t1.c",line 28,column 13,is_stmt,isa 0
           ; BRANCH OCCURS {$C$L65}          ; [] |28| 
;** --------------------------------------------------------------------------*
$C$L59:    
	.dwpsn	file "t1.c",line 27,column 89,is_stmt,isa 0

           B       .S2     $C$L65            ; [B_Sb674] |27| 
||         MVK     .L1     3,A3              ; [A_L674] |106| 

	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           MPYLI   .M1     A3,A4,A5:A4       ; [A_M674] |106| 
	.dwpsn	file "t1.c",line 106,column 30,is_stmt,isa 0
           SUB     .L2     B0,1,B0           ; [B_L674] |106| 
           ADD     .L2     1,B5,B5           ; [B_L674] |106| 
	.dwpsn	file "t1.c",line 27,column 89,is_stmt,isa 0
           MVK     .S1     55,A6             ; [A_S674] |27| 
	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           ADD     .L1     A6,A4,A4          ; [A_L674] |106| 
	.dwpsn	file "t1.c",line 27,column 89,is_stmt,isa 0
           ; BRANCH OCCURS {$C$L65}          ; [] |27| 
;** --------------------------------------------------------------------------*
$C$L60:    
	.dwpsn	file "t1.c",line 27,column 70,is_stmt,isa 0

           B       .S2     $C$L65            ; [B_Sb674] |27| 
||         MVK     .L1     3,A3              ; [A_L674] |106| 

	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           MPYLI   .M1     A3,A4,A5:A4       ; [A_M674] |106| 
	.dwpsn	file "t1.c",line 106,column 30,is_stmt,isa 0
           ADD     .L2     1,B5,B5           ; [B_L674] |106| 
           SUB     .L2     B0,1,B0           ; [B_L674] |106| 
	.dwpsn	file "t1.c",line 27,column 70,is_stmt,isa 0
           MVK     .S1     44,A6             ; [A_S674] |27| 
	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           ADD     .L1     A6,A4,A4          ; [A_L674] |106| 
	.dwpsn	file "t1.c",line 27,column 70,is_stmt,isa 0
           ; BRANCH OCCURS {$C$L65}          ; [] |27| 
;** --------------------------------------------------------------------------*
$C$L61:    
	.dwpsn	file "t1.c",line 27,column 51,is_stmt,isa 0

           B       .S2     $C$L65            ; [B_Sb674] |27| 
||         MVK     .L1     3,A3              ; [A_L674] |106| 

	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           MPYLI   .M1     A3,A4,A5:A4       ; [A_M674] |106| 
	.dwpsn	file "t1.c",line 106,column 30,is_stmt,isa 0
           SUB     .L2     B0,1,B0           ; [B_L674] |106| 
           ADD     .L2     1,B5,B5           ; [B_L674] |106| 
	.dwpsn	file "t1.c",line 27,column 51,is_stmt,isa 0
           MVK     .S1     33,A6             ; [A_S674] |27| 
	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           ADD     .L1     A6,A4,A4          ; [A_L674] |106| 
	.dwpsn	file "t1.c",line 27,column 51,is_stmt,isa 0
           ; BRANCH OCCURS {$C$L65}          ; [] |27| 
;** --------------------------------------------------------------------------*
$C$L62:    
	.dwpsn	file "t1.c",line 27,column 32,is_stmt,isa 0

           B       .S2     $C$L66            ; [B_Sb674] |27| 
||         SUB     .L2     B0,1,B0           ; [B_L674] |106| 
||         MVK     .L1     3,A3              ; [A_L674] |106| 
||         MVK     .S1     22,A6             ; [A_S674] |27| 
||         ADD     .D2     1,B5,B5           ; [B_D64P] |106| 

	.dwpsn	file "t1.c",line 106,column 30,is_stmt,isa 0

   [ B0]   BNOP            $C$L53,3          ; [] |106| 
||         MPYLI   .M1     A3,A4,A5:A4       ; [A_M674] |106| 

	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           ADD     .L1     A6,A4,A4          ; [A_L674] |106| 
	.dwpsn	file "t1.c",line 27,column 32,is_stmt,isa 0
           ; BRANCH OCCURS {$C$L66}          ; [] |27| 
;** --------------------------------------------------------------------------*
$C$L63:    
	.dwpsn	file "t1.c",line 27,column 13,is_stmt,isa 0

           ADD     .L2     1,B5,B5           ; [B_L674] |106| 
||         SUB     .S2     B0,1,B0           ; [B_Sb674] |106| 
||         MVK     .L1     11,A6             ; [A_L674] |27| 
||         MVK     .S1     3,A3              ; [A_S674] |106| 

;** --------------------------------------------------------------------------*
$C$L64:    
	.dwpsn	file "t1.c",line 106,column 43,is_stmt,isa 0
           MPYLI   .M1     A3,A4,A5:A4       ; [A_M674] |106| 
           NOP             3                 ; [A_L674] 
           ADD     .L1     A6,A4,A4          ; [A_L674] |106| 
;** --------------------------------------------------------------------------*
$C$L65:    
	.dwpsn	file "t1.c",line 106,column 30,is_stmt,isa 0
   [ B0]   BNOP            $C$L53,4          ; [] |106| 
;** --------------------------------------------------------------------------*
$C$L66:    
	.dwpsn	file "t1.c",line 26,column 5,is_stmt,isa 0
$C$DW$204	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$204, DW_AT_low_pc(0x04)
	.dwattr $C$DW$204, DW_AT_name("put")
	.dwattr $C$DW$204, DW_AT_TI_call


   [ B0]   MVK     .S2     21,B4             ; [B_Sb674] |26| 
|| [!B0]   CALL    .S1     put               ; [A_S674] |106| 

	.dwpsn	file "t1.c",line 106,column 30,is_stmt,isa 0
           ; BRANCHCC OCCURS {$C$L53}        ; [] |106| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 106,column 62,is_stmt,isa 0
           ADDKPC  .S2     $C$RL120,B3,4     ; [B_Sb674] |106| 
$C$RL120:  ; CALL OCCURS {put} {0}           ; [] |106| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 107,column 13,is_stmt,isa 0

           MVKL    .S1     op_add,A4         ; [A_S674] |107| 
||         ZERO    .L1     A11               ; [A_L674] 
||         MVK     .S2     56,B31            ; [B_Sb674] |107| 
||         ZERO    .D1     A10               ; [A_D64P] 

           MVKL    .S1     op_sub,A5         ; [A_S674] |107| 
||         MVK     .S2     448,B5            ; [B_Sb674] |107| 

           SHRU    .S1     A11,17,A3         ; [A_S674] |107| 
||         MVKL    .S2     op_mul,B4         ; [B_Sb674] |107| 
||         ADD     .L2     SP,B5,B5          ; [B_L674] |107| 

           MVKH    .S1     op_add,A4         ; [A_S674] |107| 
||         MVKH    .S2     op_mul,B4         ; [B_Sb674] |107| 

           MVKH    .S1     op_sub,A5         ; [A_S674] |107| 
||         STW     .D2T2   B4,*SP(456)       ; [B_D64P] |107| 
||         ZERO    .L2     B4                ; [B_L674] 

           STDW    .D2T1   A5:A4,*+SP[B31]   ; [B_D64P] |107| 
||         SHL     .S1     A3,3,A5           ; [A_S674] |107| 
||         MVK     .L1     1,A4              ; [A_L674] |107| 

	.dwpsn	file "t1.c",line 107,column 73,is_stmt,isa 0

           ADDAW   .D1     A5,A3,A3          ; [A_D64P] |107| 
||         MVKL    .S1     0xaaab,A13        ; [A_S674] |107| 

	.dwpsn	file "t1.c",line 107,column 86,is_stmt,isa 0
           SUB     .L1     A10,A3,A3         ; [A_L674] |107| 
	.dwpsn	file "t1.c",line 107,column 73,is_stmt,isa 0
           MVKH    .S1     0xaaab,A13        ; [A_S674] |107| 
	.dwpsn	file "t1.c",line 107,column 86,is_stmt,isa 0
           ADD     .L2X    B5,A3,B5          ; [B_L674] |107| 
           LDW     .D2T1   *B5(0),A3         ; [B_D64P] |107| 
	.dwpsn	file "t1.c",line 107,column 73,is_stmt,isa 0
           MVK     .S1     120,A12           ; [A_S674] |107| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t1.c
;*    Loop source line                 : 107
;*    Loop opening brace source line   : 107
;*    Loop closing brace source line   : 107
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*----------------------------------------------------------------------------*
$C$L67:    
	.dwpsn	file "t1.c",line 107,column 86,is_stmt,isa 0
           ADD     .L2     1,B4,B10          ; [B_L674] |107| 
           ADD     .L2     1,B4,B4           ; [B_L674] |107| 
           NOP             1                 ; [A_L674] 
$C$DW$205	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$205, DW_AT_low_pc(0x00)
	.dwattr $C$DW$205, DW_AT_TI_call
	.dwattr $C$DW$205, DW_AT_TI_indirect

           CALL    .S2     A3                ; [B_Sb674] |107| 
           ADDKPC  .S2     $C$RL122,B3,4     ; [B_Sb674] |107| 
$C$RL122:  ; CALL OCCURS  {0}                ; [] |107| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 107,column 73,is_stmt,isa 0

           ADD     .L1     A13,A11,A11       ; [A_L674] |107| 
||         ADD     .S1     4,A10,A10         ; [A_S674] |107| 

           SHRU    .S1     A11,17,A3         ; [A_S674] |107| 
||         CMPLT   .L1     A10,A12,A0        ; [A_L674] |107| 

	.dwpsn	file "t1.c",line 107,column 86,is_stmt,isa 0

           SHL     .S1     A3,3,A5           ; [A_S674] |107| 
|| [ A0]   MVK     .S2     448,B5            ; [B_Sb674] |107| 

	.dwpsn	file "t1.c",line 107,column 73,is_stmt,isa 0

           ADDAW   .D1     A5,A3,A3          ; [A_D64P] |107| 
|| [ A0]   B       .S1     $C$L67            ; [A_S674] |107| 

	.dwpsn	file "t1.c",line 107,column 86,is_stmt,isa 0
           SUB     .L1     A10,A3,A3         ; [A_L674] |107| 
   [ A0]   ADD     .L2     SP,B5,B5          ; [B_L674] |107| 
$C$DW$206	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$206, DW_AT_low_pc(0x00)
	.dwattr $C$DW$206, DW_AT_name("put")
	.dwattr $C$DW$206, DW_AT_TI_call


   [!A0]   CALL    .S2     put               ; [B_Sb674] |107| 
||         ADD     .L2X    B5,A3,B5          ; [B_L674] |107| 

   [ A0]   LDW     .D2T1   *B5(0),A3         ; [B_D64P] |107| 
	.dwpsn	file "t1.c",line 107,column 73,is_stmt,isa 0
           MV      .L2     B10,B4            ; [B_L674] |107| 
           ; BRANCHCC OCCURS {$C$L67}        ; [] |107| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 107,column 112,is_stmt,isa 0
           ADDKPC  .S2     $C$RL124,B3,2     ; [B_Sb674] |107| 
$C$RL124:  ; CALL OCCURS {put} {0}           ; [] |107| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 108,column 16,is_stmt,isa 0
           MVKL    .S1     $P$T0$1,A3        ; [A_S674] |108| 
           MVKH    .S1     $P$T0$1,A3        ; [A_S674] |108| 
           LDDW    .D1T2   *A3(0),B17:B16    ; [A_D64P] |108| 
           LDDW    .D1T2   *A3(8),B19:B18    ; [A_D64P] |108| 

           LDDW    .D1T2   *A3(16),B7:B6     ; [A_D64P] |108| 
||         ADDAW   .D2     SP,18,B4          ; [B_D64P] |108| 

	.dwpsn	file "t1.c",line 108,column 69,is_stmt,isa 0
           ADDAW   .D2     SP,18,B8          ; [B_D64P] |108| 
	.dwpsn	file "t1.c",line 108,column 16,is_stmt,isa 0
           MV      .L1X    B4,A4             ; [A_L674] |108| Define a twin register
           STDW    .D1T2   B17:B16,*A4(0)    ; [A_D64P] |108| 
           STDW    .D1T2   B19:B18,*A4(8)    ; [A_D64P] |108| 

           STDW    .D1T2   B7:B6,*A4(16)     ; [A_D64P] |108| 
||         MV      .L1X    B8,A31            ; [A_L674] |108| Define a twin register

	.dwpsn	file "t1.c",line 108,column 69,is_stmt,isa 0
           LDDW    .D1T2   *A31(0),B7:B6     ; [A_D64P] |108| 
           LDDW    .D1T2   *A31(8),B5:B4     ; [A_D64P] |108| 
           LDDW    .D2T1   *B8(16),A5:A4     ; [B_D64P] |108| 
	.dwpsn	file "t1.c",line 108,column 78,is_stmt,isa 0
           LDB     .D2T1   *SP(72),A6        ; [B_D64P] |108| 
	.dwpsn	file "t1.c",line 108,column 69,is_stmt,isa 0
           ADDAW   .D2     SP,12,B8          ; [B_D64P] |108| 
           STDW    .D2T2   B7:B6,*B8(0)      ; [B_D64P] |108| 
           STDW    .D2T2   B5:B4,*B8(8)      ; [B_D64P] |108| 
           STDW    .D2T1   A5:A4,*B8(16)     ; [B_D64P] |108| 
	.dwpsn	file "t1.c",line 108,column 78,is_stmt,isa 0
           LDW     .D2T1   *SP(52),A3        ; [B_D64P] |108| 
           NOP             4                 ; [A_L674] 
           ADD     .L1     A6,A3,A4          ; [A_L674] |108| 
$C$DW$207	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$207, DW_AT_low_pc(0x04)
	.dwattr $C$DW$207, DW_AT_name("put")
	.dwattr $C$DW$207, DW_AT_TI_call


           STW     .D2T1   A4,*SP(52)        ; [B_D64P] |108| 
||         CALLP   .S2     put,B3            ; [B_Sb674] |108| 

	.dwpsn	file "t1.c",line 108,column 92,is_stmt,isa 0
$C$RL126:  ; CALLP OCCURS {put} {0}          ; [] |108| 
	.dwpsn	file "t1.c",line 108,column 113,is_stmt,isa 0
$C$DW$208	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$208, DW_AT_low_pc(0x00)
	.dwattr $C$DW$208, DW_AT_name("put")
	.dwattr $C$DW$208, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |108| 
||         LDW     .D2T1   *SP(56),A4        ; [B_D64P] |108| 

$C$RL128:  ; CALLP OCCURS {put} {0}          ; [] |108| 
	.dwpsn	file "t1.c",line 108,column 135,is_stmt,isa 0
$C$DW$209	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$209, DW_AT_low_pc(0x00)
	.dwattr $C$DW$209, DW_AT_name("fbits")
	.dwattr $C$DW$209, DW_AT_TI_call


           CALLP   .S2     fbits,B3          ; [B_Sb674] |108| 
||         LDW     .D2T1   *SP(64),A4        ; [B_D64P] |108| 

$C$RL130:  ; CALLP OCCURS {fbits} {0}        ; [] |108| 
$C$DW$210	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$210, DW_AT_low_pc(0x00)
	.dwattr $C$DW$210, DW_AT_name("put")
	.dwattr $C$DW$210, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |108| 
$C$RL132:  ; CALLP OCCURS {put} {0}          ; [] |108| 
	.dwpsn	file "t1.c",line 108,column 153,is_stmt,isa 0
           LDH     .D2T1   *SP(50),A4        ; [B_D64P] |108| 
$C$DW$211	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$211, DW_AT_low_pc(0x00)
	.dwattr $C$DW$211, DW_AT_name("put")
	.dwattr $C$DW$211, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |108| 
$C$RL134:  ; CALLP OCCURS {put} {0}          ; [] |108| 
	.dwpsn	file "t1.c",line 12,column 32,is_stmt,isa 0
           ZERO    .L1     A10               ; [A_L674] |12| 
           SET     .S1     A10,30,30,A10     ; [A_S674] |12| 
$C$DW$212	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$212, DW_AT_low_pc(0x00)
	.dwattr $C$DW$212, DW_AT_name("sqrtf")
	.dwattr $C$DW$212, DW_AT_TI_call


           CALLP   .S2     sqrtf,B3          ; [B_Sb674] |12| 
||         MV      .L1     A10,A4            ; [A_L674] |12| 

$C$RL136:  ; CALLP OCCURS {sqrtf} {0}        ; [] |12| 

           MV      .L2X    A4,B4             ; [B_L674] |12| 
||         ADDAW   .D2     SP,124,B5         ; [B_D64P] |12| 

           STW     .D2T2   B4,*SP(496)       ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           LDW     .D2T1   *B5(0),A3         ; [B_D64P] |12| 
           ADDAW   .D2     SP,125,B4         ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 111,column 32,is_stmt,isa 0
           MV      .L1     A10,A5            ; [A_L674] |111| 
           NOP             2                 ; [A_L674] 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           STW     .D2T1   A3,*B4(0)         ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 111,column 7,is_stmt,isa 0
           LDW     .D2T1   *SP(500),A4       ; [B_D64P] |111| 
           NOP             2                 ; [A_L674] 
$C$DW$213	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$213, DW_AT_low_pc(0x00)
	.dwattr $C$DW$213, DW_AT_name("put")
	.dwattr $C$DW$213, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |111| 
$C$RL138:  ; CALLP OCCURS {put} {0}          ; [] |111| 
	.dwpsn	file "t1.c",line 111,column 32,is_stmt,isa 0
$C$DW$214	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$214, DW_AT_low_pc(0x00)
	.dwattr $C$DW$214, DW_AT_name("sqrt")
	.dwattr $C$DW$214, DW_AT_TI_call


           CALLP   .S2     sqrt,B3           ; [B_Sb674] |111| 
||         ZERO    .L1     A4                ; [A_L674] |111| 

$C$RL140:  ; CALLP OCCURS {sqrt} {0}         ; [] |111| 
$C$DW$215	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$215, DW_AT_low_pc(0x00)
	.dwattr $C$DW$215, DW_AT_name("putd")
	.dwattr $C$DW$215, DW_AT_TI_call

           CALLP   .S2     putd,B3           ; [B_Sb674] |111| 
$C$RL142:  ; CALLP OCCURS {putd} {0}         ; [] |111| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 111,column 49,is_stmt,isa 0
           MVKL    .S2     0x3f333333,B11    ; [B_Sb674] |111| 
           MVKH    .S2     0x3f333333,B11    ; [B_Sb674] |111| 
           NOP             1                 ; [A_L674] 
$C$DW$216	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$216, DW_AT_low_pc(0x00)
	.dwattr $C$DW$216, DW_AT_name("sinf")
	.dwattr $C$DW$216, DW_AT_TI_call


           CALLP   .S2     sinf,B3           ; [B_Sb674] |111| 
||         MV      .L1X    B11,A4            ; [A_L674] |111| 

$C$RL144:  ; CALLP OCCURS {sinf} {0}         ; [] |111| 
           MVKL    .S2     0x49742400,B10    ; [B_Sb674] |111| 
           MVKH    .S2     0x49742400,B10    ; [B_Sb674] |111| 
           MPYSP   .M2X    B10,A4,B4         ; [B_M674] |111| 
	.dwpsn	file "t1.c",line 111,column 87,is_stmt,isa 0
           MVKL    .S1     0x3ff4cccc,A5     ; [A_S674] |111| 
           MVKH    .S1     0x3ff4cccc,A5     ; [A_S674] |111| 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t1.c",line 111,column 49,is_stmt,isa 0
           SPTRUNC .L2     B4,B4             ; [B_L674] |111| 
           NOP             4                 ; [A_L674] 
$C$DW$217	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$217, DW_AT_low_pc(0x00)
	.dwattr $C$DW$217, DW_AT_name("put")
	.dwattr $C$DW$217, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |111| 
||         MV      .L1X    B4,A4             ; [A_L674] |111| 

$C$RL146:  ; CALLP OCCURS {put} {0}          ; [] |111| 
	.dwpsn	file "t1.c",line 111,column 87,is_stmt,isa 0
           MVKL    .S1     0xcccccccd,A4     ; [A_S674] |111| 
           MVKH    .S1     0xcccccccd,A4     ; [A_S674] |111| 
           NOP             1                 ; [A_L674] 
$C$DW$218	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$218, DW_AT_low_pc(0x00)
	.dwattr $C$DW$218, DW_AT_name("cos")
	.dwattr $C$DW$218, DW_AT_TI_call

           CALLP   .S2     cos,B3            ; [B_Sb674] |111| 
$C$RL148:  ; CALLP OCCURS {cos} {0}          ; [] |111| 

           MVKL    .S2     0x41cdcd65,B13    ; [B_Sb674] |111| 
||         ZERO    .L2     B12               ; [B_L674] |111| 
||         MV      .D2X    A4,B4             ; [B_D64P] |111| 

           MVKH    .S2     0x41cdcd65,B13    ; [B_Sb674] |111| 
||         MV      .L2X    A5,B5             ; [B_L674] |111| 
||         MPYDP   .M2     B13:B12,B5:B4,B5:B4 ; [B_M674] |111| 

           NOP             9                 ; [A_L674] 
           DPTRUNC .L2     B5:B4,B4          ; [B_L674] |111| 
           NOP             4                 ; [A_L674] 
$C$DW$219	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$219, DW_AT_low_pc(0x00)
	.dwattr $C$DW$219, DW_AT_name("put")
	.dwattr $C$DW$219, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |111| 
||         MV      .L1X    B4,A4             ; [A_L674] |111| 

$C$RL150:  ; CALLP OCCURS {put} {0}          ; [] |111| 
	.dwpsn	file "t1.c",line 111,column 49,is_stmt,isa 0
           MV      .L1X    B11,A4            ; [A_L674] |111| 
$C$DW$220	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$220, DW_AT_low_pc(0x00)
	.dwattr $C$DW$220, DW_AT_name("expf")
	.dwattr $C$DW$220, DW_AT_TI_call


           CALLP   .S2     expf,B3           ; [B_Sb674] |112| 
||         MV      .L1X    B11,A11           ; [A_L674] |111| 

	.dwpsn	file "t1.c",line 112,column 7,is_stmt,isa 0
$C$RL152:  ; CALLP OCCURS {expf} {0}         ; [] |112| 
           MPYSP   .M1X    B10,A4,A3         ; [A_M674] |112| 
	.dwpsn	file "t1.c",line 112,column 45,is_stmt,isa 0
           MVKL    .S1     0x3ff4cccc,A5     ; [A_S674] |112| 
           MVKH    .S1     0x3ff4cccc,A5     ; [A_S674] |112| 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t1.c",line 112,column 7,is_stmt,isa 0
           SPTRUNC .L1     A3,A4             ; [A_L674] |112| 
           NOP             2                 ; [A_L674] 
$C$DW$221	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$221, DW_AT_low_pc(0x00)
	.dwattr $C$DW$221, DW_AT_name("put")
	.dwattr $C$DW$221, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |112| 
$C$RL154:  ; CALLP OCCURS {put} {0}          ; [] |112| 
	.dwpsn	file "t1.c",line 112,column 45,is_stmt,isa 0
           MVKL    .S1     0xcccccccd,A4     ; [A_S674] |112| 
           MVKH    .S1     0xcccccccd,A4     ; [A_S674] |112| 
           NOP             1                 ; [A_L674] 
$C$DW$222	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$222, DW_AT_low_pc(0x00)
	.dwattr $C$DW$222, DW_AT_name("log")
	.dwattr $C$DW$222, DW_AT_TI_call

           CALLP   .S2     log,B3            ; [B_Sb674] |112| 
$C$RL156:  ; CALLP OCCURS {log} {0}          ; [] |112| 
           MV      .L2     B12,B4            ; [B_L674] |112| 

           MV      .L2     B13,B5            ; [B_L674] |112| 
||         MPYDP   .M2X    B5:B4,A5:A4,B5:B4 ; [B_M674] |112| 

           NOP             9                 ; [A_L674] 
           DPTRUNC .L2     B5:B4,B4          ; [B_L674] |112| 
           NOP             4                 ; [A_L674] 
$C$DW$223	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$223, DW_AT_low_pc(0x00)
	.dwattr $C$DW$223, DW_AT_name("put")
	.dwattr $C$DW$223, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |112| 
||         MV      .L1X    B4,A4             ; [A_L674] |112| 

$C$RL158:  ; CALLP OCCURS {put} {0}          ; [] |112| 
	.dwpsn	file "t1.c",line 111,column 49,is_stmt,isa 0
           MV      .L1X    B10,A10           ; [A_L674] |111| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t1.c",line 112,column 81,is_stmt,isa 0
           MVKL    .S2     0x3e99999a,B4     ; [B_Sb674] |112| 
           MVKH    .S2     0x3e99999a,B4     ; [B_Sb674] |112| 
$C$DW$224	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$224, DW_AT_low_pc(0x00)
	.dwattr $C$DW$224, DW_AT_name("atan2f")
	.dwattr $C$DW$224, DW_AT_TI_call


           CALLP   .S2     atan2f,B3         ; [B_Sb674] |112| 
||         MV      .L1     A11,A4            ; [A_L674] |112| 

$C$RL160:  ; CALLP OCCURS {atan2f} {0}       ; [] |112| 
           MPYSP   .M1     A10,A4,A3         ; [A_M674] |112| 
           NOP             3                 ; [A_L674] 
           SPTRUNC .L1     A3,A4             ; [A_L674] |112| 
           NOP             2                 ; [A_L674] 
$C$DW$225	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$225, DW_AT_low_pc(0x00)
	.dwattr $C$DW$225, DW_AT_name("put")
	.dwattr $C$DW$225, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |112| 
$C$RL162:  ; CALLP OCCURS {put} {0}          ; [] |112| 
	.dwpsn	file "t1.c",line 113,column 7,is_stmt,isa 0
           ZERO    .L2     B4                ; [B_L674] |113| 
           MVKH    .S2     0x40200000,B4     ; [B_Sb674] |113| 
$C$DW$226	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$226, DW_AT_low_pc(0x00)
	.dwattr $C$DW$226, DW_AT_name("powf")
	.dwattr $C$DW$226, DW_AT_TI_call


           CALLP   .S2     powf,B3           ; [B_Sb674] |113| 
||         MV      .L1     A11,A4            ; [A_L674] |113| 

$C$RL164:  ; CALLP OCCURS {powf} {0}         ; [] |113| 
           MPYSP   .M1     A10,A4,A3         ; [A_M674] |113| 
	.dwpsn	file "t1.c",line 113,column 76,is_stmt,isa 0
           MVKL    .S1     0x3fc24924,A5     ; [A_S674] |113| 
           MVKH    .S1     0x3fc24924,A5     ; [A_S674] |113| 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t1.c",line 113,column 7,is_stmt,isa 0
           SPTRUNC .L1     A3,A4             ; [A_L674] |113| 
           NOP             2                 ; [A_L674] 
$C$DW$227	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$227, DW_AT_low_pc(0x00)
	.dwattr $C$DW$227, DW_AT_name("put")
	.dwattr $C$DW$227, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |113| 
$C$RL166:  ; CALLP OCCURS {put} {0}          ; [] |113| 
	.dwpsn	file "t1.c",line 12,column 32,is_stmt,isa 0

           MVKL    .S2     0x3eaaaaab,B5     ; [B_Sb674] |12| 
||         ADDAW   .D2     SP,126,B4         ; [B_D64P] |12| 

           MVKH    .S2     0x3eaaaaab,B5     ; [B_Sb674] |12| 

           MV      .L1X    B4,A3             ; [A_L674] |12| Define a twin register
||         STW     .D2T2   B5,*SP(504)       ; [B_D64P] |12| 

	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           LDW     .D1T2   *A3(0),B4         ; [A_D64P] |12| 
           ADDAW   .D2     SP,127,B5         ; [B_D64P] |12| 
           NOP             3                 ; [A_L674] 
           STW     .D2T2   B4,*B5(0)         ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 113,column 51,is_stmt,isa 0
           LDW     .D2T1   *SP(508),A4       ; [B_D64P] |113| 
$C$DW$228	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$228, DW_AT_low_pc(0x00)
	.dwattr $C$DW$228, DW_AT_name("put")
	.dwattr $C$DW$228, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |113| 
$C$RL168:  ; CALLP OCCURS {put} {0}          ; [] |113| 
           NOP             2                 ; [A_L674] 
	.dwpsn	file "t1.c",line 113,column 76,is_stmt,isa 0
           MVKL    .S1     0x92492492,A4     ; [A_S674] |113| 
$C$DW$229	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$229, DW_AT_low_pc(0x04)
	.dwattr $C$DW$229, DW_AT_name("putd")
	.dwattr $C$DW$229, DW_AT_TI_call


           MVKH    .S1     0x92492492,A4     ; [A_S674] |113| 
||         CALLP   .S2     putd,B3           ; [B_Sb674] |113| 

$C$RL170:  ; CALLP OCCURS {putd} {0}         ; [] |113| 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           ADDAW   .D2     SP,128,B4         ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 12,column 32,is_stmt,isa 0
           STW     .D2T1   A11,*SP(512)      ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           MV      .L1X    B4,A3             ; [A_L674] |12| Define a twin register
           LDW     .D1T2   *A3(0),B4         ; [A_D64P] |12| 
           ADDAW   .D2     SP,129,B5         ; [B_D64P] |12| 
           NOP             3                 ; [A_L674] 
           STW     .D2T2   B4,*B5(0)         ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 113,column 93,is_stmt,isa 0
           LDW     .D2T1   *SP(516),A4       ; [B_D64P] |113| 
           NOP             2                 ; [A_L674] 
$C$DW$230	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$230, DW_AT_low_pc(0x00)
	.dwattr $C$DW$230, DW_AT_name("put")
	.dwattr $C$DW$230, DW_AT_TI_call

           CALLP   .S2     put,B3            ; [B_Sb674] |113| 
$C$RL172:  ; CALLP OCCURS {put} {0}          ; [] |113| 
	.dwpsn	file "C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/mathf.h",line 221,column 4,is_stmt,isa 0
           ZERO    .L1     A4                ; [A_L674] |221| 
$C$DW$231	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$231, DW_AT_low_pc(0x00)
	.dwattr $C$DW$231, DW_AT_name("modff")
	.dwattr $C$DW$231, DW_AT_TI_call


           CALLP   .S2     modff,B3          ; [B_Sb674] |221| 
||         ADDAW   .D2     SP,130,B4         ; [B_D64P] |221| 
||         MVKH    .S1     0xc0200000,A4     ; [A_S674] |221| 

$C$RL174:  ; CALLP OCCURS {modff} {0}        ; [] |221| 
           LDW     .D2T1   *SP(520),A5       ; [B_D64P] |221| 
           ZERO    .L2     B4                ; [B_L674] |221| 
           SET     .S2     B4,23,29,B4       ; [B_Sb674] |221| 
           MV      .L1X    B12,A3            ; [A_L674] |221| 
           CMPLTSP .S1     A4,A3,A0          ; [A_S674] |221| 
   [ A0]   SUBSP   .L1X    A5,B4,A5          ; [A_L674] |221| 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           ADDAW   .D2     SP,131,B4         ; [B_D64P] |12| 
           NOP             2                 ; [A_L674] 
	.dwpsn	file "t1.c",line 12,column 32,is_stmt,isa 0
           STW     .D2T1   A5,*SP(524)       ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 12,column 46,is_stmt,isa 0
           LDW     .D2T1   *B4(0),A3         ; [B_D64P] |12| 
           ADDAW   .D2     SP,132,B4         ; [B_D64P] |12| 
           NOP             3                 ; [A_L674] 
           STW     .D2T1   A3,*B4(0)         ; [B_D64P] |12| 
	.dwpsn	file "t1.c",line 113,column 116,is_stmt,isa 0
$C$DW$232	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$232, DW_AT_low_pc(0x04)
	.dwattr $C$DW$232, DW_AT_name("put")
	.dwattr $C$DW$232, DW_AT_TI_call


           LDW     .D2T1   *SP(528),A4       ; [B_D64P] |113| 
||         CALLP   .S2     put,B3            ; [B_Sb674] |113| 

$C$RL176:  ; CALLP OCCURS {put} {0}          ; [] |113| 
	.dwpsn	file "t1.c",line 115,column 5,is_stmt,isa 0
           LDW     .D2T1   *+DP(vzero),A3    ; [B_D64P] |115| 
           NOP             2                 ; [A_L674] 
           MVKL    .S1     0xc0ffee,A4       ; [A_S674] |115| 
           MVKH    .S1     0xc0ffee,A4       ; [A_S674] |115| 
$C$DW$233	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$233, DW_AT_low_pc(0x00)
	.dwattr $C$DW$233, DW_AT_name("put")
	.dwattr $C$DW$233, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |115| 
||         ADD     .L1     A4,A3,A4          ; [A_L674] |115| 

$C$RL178:  ; CALLP OCCURS {put} {0}          ; [] |115| 
	.dwpsn	file "t1.c",line 120,column 1,is_stmt,isa 0
           ADDAW   .D2     SP,134,SP         ; [B_D64P] |120| 
	.dwcfi	cfa_offset, 56
           LDW     .D2T2   *++SP(8),B3       ; [B_D64P] |120| 
	.dwcfi	cfa_offset, 48
	.dwcfi	restore_reg, 19
           LDDW    .D2T1   *++SP(8),A13:A12  ; [B_D64P] |120| 
	.dwcfi	cfa_offset, 40
	.dwcfi	restore_reg, 13
	.dwcfi	restore_reg, 12
           LDDW    .D2T1   *++SP(8),A15:A14  ; [B_D64P] |120| 
	.dwcfi	cfa_offset, 32
	.dwcfi	restore_reg, 15
	.dwcfi	restore_reg, 14
           LDDW    .D2T2   *++SP(8),B11:B10  ; [B_D64P] |120| 
	.dwcfi	cfa_offset, 24
	.dwcfi	restore_reg, 27
	.dwcfi	restore_reg, 26
	.dwpsn	file "t1.c",line 115,column 5,is_stmt,isa 0

           MV      .L1X    B12,A4            ; [A_L674] |115| 
||         LDDW    .D2T2   *++SP(8),B13:B12  ; [B_D64P] |120| 

	.dwcfi	cfa_offset, 16
	.dwcfi	restore_reg, 29
	.dwcfi	restore_reg, 28
	.dwpsn	file "t1.c",line 120,column 1,is_stmt,isa 0
$C$DW$234	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$234, DW_AT_low_pc(0x04)
	.dwattr $C$DW$234, DW_AT_TI_return


           LDW     .D2T1   *++SP(8),A10      ; [B_D64P] |120| 
||         RET     .S2     B3                ; [B_Sb674] |120| 

	.dwcfi	cfa_offset, 8
	.dwcfi	restore_reg, 10
           LDW     .D2T1   *++SP(8),A11      ; [B_D64P] |120| 
	.dwcfi	cfa_offset, 0
	.dwcfi	restore_reg, 11
           NOP             4                 ; [A_L674] 
           ; BRANCH OCCURS {B3}              ; [] |120| 
	.dwattr $C$DW$101, DW_AT_TI_end_file("t1.c")
	.dwattr $C$DW$101, DW_AT_TI_end_line(0x78)
	.dwattr $C$DW$101, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$101

;******************************************************************************
;* STRINGS                                                                    *
;******************************************************************************
	.sect	".const:.string"
$C$SL1:	.string	"x=%d u=%u h=%08x s=%s c=%c ld=%lld",0
$C$SL2:	.string	"abc",0
$C$SL3:	.string	"%.3f %e %g %10.4f",0
$C$SL4:	.string	"abd",0
$C$SL5:	.string	"-31337",0
$C$SL6:	.string	"7fffABC",0
;*****************************************************************************
;* UNDEFINED EXTERNAL REFERENCES                                             *
;*****************************************************************************
	.global	modff
	.global	memset
	.global	memmove
	.global	sprintf
	.global	atoi
	.global	strtol
	.global	qsort
	.global	sqrtf
	.global	sqrt
	.global	sinf
	.global	cos
	.global	expf
	.global	log
	.global	atan2f
	.global	powf
	.global	__c6xabi_divi
	.global	__c6xabi_remi
	.global	__c6xabi_divu
	.global	__c6xabi_remu
	.global	__c6xabi_divlli
	.global	__c6xabi_remlli
	.global	__c6xabi_divull
	.global	__c6xabi_llshru
	.global	__c6xabi_llshl
	.global	__c6xabi_divd
	.global	memcpy

;******************************************************************************
;* BUILD ATTRIBUTES                                                           *
;******************************************************************************
	.battr "TI", Tag_File, 1, Tag_Long_Precision_Bits(2)
	.battr "TI", Tag_File, 1, Tag_Bitfield_layout(2)
	.battr "TI", Tag_File, 1, Tag_ABI_enum_size(3)
	.battr "c6xabi", Tag_File, 1, Tag_ABI_wchar_t(1)
	.battr "c6xabi", Tag_File, 1, Tag_ABI_array_object_alignment(0)
	.battr "c6xabi", Tag_File, 1, Tag_ABI_array_object_align_expected(0)
	.battr "c6xabi", Tag_File, 1, Tag_ABI_PIC(0)
	.battr "c6xabi", Tag_File, 1, Tag_ABI_PID(0)
	.battr "c6xabi", Tag_File, 1, Tag_ABI_DSBT(0)
	.battr "c6xabi", Tag_File, 1, Tag_ABI_stack_align_needed(0)
	.battr "c6xabi", Tag_File, 1, Tag_ABI_stack_align_preserved(0)
	.battr "TI", Tag_File, 1, Tag_Tramps_Use_SOC(1)

;******************************************************************************
;* TYPE INFORMATION                                                           *
;******************************************************************************

$C$DW$T$31	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$31, DW_AT_byte_size(0x10)
$C$DW$235	.dwtag  DW_TAG_member
	.dwattr $C$DW$235, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$235, DW_AT_name("__max_align1")
	.dwattr $C$DW$235, DW_AT_TI_symbol_name("__max_align1")
	.dwattr $C$DW$235, DW_AT_data_member_location[DW_OP_plus_uconst 0x0]
	.dwattr $C$DW$235, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$235, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$235, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$235, DW_AT_decl_column(0x0c)

$C$DW$236	.dwtag  DW_TAG_member
	.dwattr $C$DW$236, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$236, DW_AT_name("__max_align2")
	.dwattr $C$DW$236, DW_AT_TI_symbol_name("__max_align2")
	.dwattr $C$DW$236, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$236, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$236, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$236, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$236, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$31, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$31, DW_AT_decl_line(0x7c)
	.dwattr $C$DW$T$31, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$T$31

$C$DW$T$45	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$45, DW_AT_name("__max_align_t")
	.dwattr $C$DW$T$45, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$T$45, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$45, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$45, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$T$45, DW_AT_decl_column(0x03)


$C$DW$T$32	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$32, DW_AT_byte_size(0x08)
$C$DW$237	.dwtag  DW_TAG_member
	.dwattr $C$DW$237, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$237, DW_AT_name("quot")
	.dwattr $C$DW$237, DW_AT_TI_symbol_name("quot")
	.dwattr $C$DW$237, DW_AT_data_member_location[DW_OP_plus_uconst 0x0]
	.dwattr $C$DW$237, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$237, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$237, DW_AT_decl_line(0x56)
	.dwattr $C$DW$237, DW_AT_decl_column(0x16)

$C$DW$238	.dwtag  DW_TAG_member
	.dwattr $C$DW$238, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$238, DW_AT_name("rem")
	.dwattr $C$DW$238, DW_AT_TI_symbol_name("rem")
	.dwattr $C$DW$238, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$238, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$238, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$238, DW_AT_decl_line(0x56)
	.dwattr $C$DW$238, DW_AT_decl_column(0x1c)

	.dwattr $C$DW$T$32, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$T$32, DW_AT_decl_line(0x56)
	.dwattr $C$DW$T$32, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$T$32

$C$DW$T$46	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$46, DW_AT_name("div_t")
	.dwattr $C$DW$T$46, DW_AT_type(*$C$DW$T$32)
	.dwattr $C$DW$T$46, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$46, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$T$46, DW_AT_decl_line(0x56)
	.dwattr $C$DW$T$46, DW_AT_decl_column(0x23)


$C$DW$T$33	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$33, DW_AT_byte_size(0x08)
$C$DW$239	.dwtag  DW_TAG_member
	.dwattr $C$DW$239, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$239, DW_AT_name("quot")
	.dwattr $C$DW$239, DW_AT_TI_symbol_name("quot")
	.dwattr $C$DW$239, DW_AT_data_member_location[DW_OP_plus_uconst 0x0]
	.dwattr $C$DW$239, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$239, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$239, DW_AT_decl_line(0x59)
	.dwattr $C$DW$239, DW_AT_decl_column(0x17)

$C$DW$240	.dwtag  DW_TAG_member
	.dwattr $C$DW$240, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$240, DW_AT_name("rem")
	.dwattr $C$DW$240, DW_AT_TI_symbol_name("rem")
	.dwattr $C$DW$240, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$240, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$240, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$240, DW_AT_decl_line(0x59)
	.dwattr $C$DW$240, DW_AT_decl_column(0x1d)

	.dwattr $C$DW$T$33, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$T$33, DW_AT_decl_line(0x59)
	.dwattr $C$DW$T$33, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$T$33

$C$DW$T$47	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$47, DW_AT_name("ldiv_t")
	.dwattr $C$DW$T$47, DW_AT_type(*$C$DW$T$33)
	.dwattr $C$DW$T$47, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$47, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$T$47, DW_AT_decl_line(0x59)
	.dwattr $C$DW$T$47, DW_AT_decl_column(0x24)


$C$DW$T$34	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$34, DW_AT_byte_size(0x10)
$C$DW$241	.dwtag  DW_TAG_member
	.dwattr $C$DW$241, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$241, DW_AT_name("quot")
	.dwattr $C$DW$241, DW_AT_TI_symbol_name("quot")
	.dwattr $C$DW$241, DW_AT_data_member_location[DW_OP_plus_uconst 0x0]
	.dwattr $C$DW$241, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$241, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$241, DW_AT_decl_line(0x64)
	.dwattr $C$DW$241, DW_AT_decl_column(0x1c)

$C$DW$242	.dwtag  DW_TAG_member
	.dwattr $C$DW$242, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$242, DW_AT_name("rem")
	.dwattr $C$DW$242, DW_AT_TI_symbol_name("rem")
	.dwattr $C$DW$242, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$242, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$242, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$242, DW_AT_decl_line(0x64)
	.dwattr $C$DW$242, DW_AT_decl_column(0x22)

	.dwattr $C$DW$T$34, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$T$34, DW_AT_decl_line(0x64)
	.dwattr $C$DW$T$34, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$T$34

$C$DW$T$48	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$48, DW_AT_name("lldiv_t")
	.dwattr $C$DW$T$48, DW_AT_type(*$C$DW$T$34)
	.dwattr $C$DW$T$48, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$48, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$T$48, DW_AT_decl_line(0x64)
	.dwattr $C$DW$T$48, DW_AT_decl_column(0x29)


$C$DW$T$36	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$36, DW_AT_name("S")
	.dwattr $C$DW$T$36, DW_AT_byte_size(0x18)
$C$DW$243	.dwtag  DW_TAG_member
	.dwattr $C$DW$243, DW_AT_type(*$C$DW$T$5)
	.dwattr $C$DW$243, DW_AT_name("c")
	.dwattr $C$DW$243, DW_AT_TI_symbol_name("c")
	.dwattr $C$DW$243, DW_AT_data_member_location[DW_OP_plus_uconst 0x0]
	.dwattr $C$DW$243, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$243, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$243, DW_AT_decl_line(0x16)
	.dwattr $C$DW$243, DW_AT_decl_column(0x11)

$C$DW$244	.dwtag  DW_TAG_member
	.dwattr $C$DW$244, DW_AT_type(*$C$DW$T$8)
	.dwattr $C$DW$244, DW_AT_name("s")
	.dwattr $C$DW$244, DW_AT_TI_symbol_name("s")
	.dwattr $C$DW$244, DW_AT_data_member_location[DW_OP_plus_uconst 0x2]
	.dwattr $C$DW$244, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$244, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$244, DW_AT_decl_line(0x16)
	.dwattr $C$DW$244, DW_AT_decl_column(0x1a)

$C$DW$245	.dwtag  DW_TAG_member
	.dwattr $C$DW$245, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$245, DW_AT_name("i")
	.dwattr $C$DW$245, DW_AT_TI_symbol_name("i")
	.dwattr $C$DW$245, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$245, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$245, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$245, DW_AT_decl_line(0x16)
	.dwattr $C$DW$245, DW_AT_decl_column(0x21)

$C$DW$246	.dwtag  DW_TAG_member
	.dwattr $C$DW$246, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$246, DW_AT_name("ll")
	.dwattr $C$DW$246, DW_AT_TI_symbol_name("ll")
	.dwattr $C$DW$246, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$246, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$246, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$246, DW_AT_decl_line(0x16)
	.dwattr $C$DW$246, DW_AT_decl_column(0x2e)

$C$DW$247	.dwtag  DW_TAG_member
	.dwattr $C$DW$247, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$247, DW_AT_name("f")
	.dwattr $C$DW$247, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$247, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$247, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$247, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$247, DW_AT_decl_line(0x16)
	.dwattr $C$DW$247, DW_AT_decl_column(0x38)

	.dwattr $C$DW$T$36, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$T$36, DW_AT_decl_line(0x16)
	.dwattr $C$DW$T$36, DW_AT_decl_column(0x08)
	.dwendtag $C$DW$T$36

$C$DW$T$49	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$49, DW_AT_type(*$C$DW$T$36)


$C$DW$T$37	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$37, DW_AT_name("S3_1")
	.dwattr $C$DW$T$37, DW_AT_declaration
	.dwendtag $C$DW$T$37


$C$DW$T$27	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$27, DW_AT_name("S3_4")
	.dwattr $C$DW$T$27, DW_AT_declaration
	.dwendtag $C$DW$T$27


$C$DW$T$39	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$39, DW_AT_name("S3_5")
	.dwattr $C$DW$T$39, DW_AT_declaration
	.dwendtag $C$DW$T$39


$C$DW$T$41	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$41, DW_AT_name("S3_7")
	.dwattr $C$DW$T$41, DW_AT_declaration
	.dwendtag $C$DW$T$41


$C$DW$T$42	.dwtag  DW_TAG_union_type
	.dwattr $C$DW$T$42, DW_AT_name("U3_0")
	.dwattr $C$DW$T$42, DW_AT_declaration
	.dwendtag $C$DW$T$42

$C$DW$T$2	.dwtag  DW_TAG_unspecified_type
	.dwattr $C$DW$T$2, DW_AT_name("void")

$C$DW$T$3	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$3, DW_AT_type(*$C$DW$T$2)
	.dwattr $C$DW$T$3, DW_AT_address_class(0x20)

$C$DW$T$51	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$51, DW_AT_type(*$C$DW$T$2)

$C$DW$T$52	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$52, DW_AT_type(*$C$DW$T$51)
	.dwattr $C$DW$T$52, DW_AT_address_class(0x20)

$C$DW$T$60	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$60, DW_AT_type(*$C$DW$T$52)


$C$DW$T$70	.dwtag  DW_TAG_subroutine_type
	.dwattr $C$DW$T$70, DW_AT_language(DW_LANG_C)
	.dwendtag $C$DW$T$70

$C$DW$T$71	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$71, DW_AT_type(*$C$DW$T$70)
	.dwattr $C$DW$T$71, DW_AT_address_class(0x20)

$C$DW$T$72	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$72, DW_AT_name("__TI_atexit_fn")
	.dwattr $C$DW$T$72, DW_AT_type(*$C$DW$T$71)
	.dwattr $C$DW$T$72, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$72, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$T$72, DW_AT_decl_line(0xd0)
	.dwattr $C$DW$T$72, DW_AT_decl_column(0x14)

$C$DW$T$4	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$4, DW_AT_encoding(DW_ATE_boolean)
	.dwattr $C$DW$T$4, DW_AT_name("bool")
	.dwattr $C$DW$T$4, DW_AT_byte_size(0x01)

$C$DW$T$5	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$5, DW_AT_encoding(DW_ATE_signed_char)
	.dwattr $C$DW$T$5, DW_AT_name("signed char")
	.dwattr $C$DW$T$5, DW_AT_byte_size(0x01)


$C$DW$T$40	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$40, DW_AT_type(*$C$DW$T$5)
	.dwattr $C$DW$T$40, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$40, DW_AT_byte_size(0xc8)
$C$DW$248	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$248, DW_AT_upper_bound(0xc7)

	.dwendtag $C$DW$T$40

$C$DW$T$81	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$81, DW_AT_name("__int8_t")
	.dwattr $C$DW$T$81, DW_AT_type(*$C$DW$T$5)
	.dwattr $C$DW$T$81, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$81, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$81, DW_AT_decl_line(0x5e)
	.dwattr $C$DW$T$81, DW_AT_decl_column(0x16)

$C$DW$T$82	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$82, DW_AT_name("__int_least8_t")
	.dwattr $C$DW$T$82, DW_AT_type(*$C$DW$T$81)
	.dwattr $C$DW$T$82, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$82, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$82, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$T$82, DW_AT_decl_column(0x12)

$C$DW$T$6	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$6, DW_AT_encoding(DW_ATE_unsigned_char)
	.dwattr $C$DW$T$6, DW_AT_name("unsigned char")
	.dwattr $C$DW$T$6, DW_AT_byte_size(0x01)

$C$DW$T$43	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$43, DW_AT_type(*$C$DW$T$6)
	.dwattr $C$DW$T$43, DW_AT_address_class(0x20)


$C$DW$T$83	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$83, DW_AT_type(*$C$DW$T$6)
	.dwattr $C$DW$T$83, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$83, DW_AT_byte_size(0x400)
$C$DW$249	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$249, DW_AT_upper_bound(0x3ff)

	.dwendtag $C$DW$T$83

$C$DW$T$86	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$86, DW_AT_name("__uint8_t")
	.dwattr $C$DW$T$86, DW_AT_type(*$C$DW$T$6)
	.dwattr $C$DW$T$86, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$86, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$86, DW_AT_decl_line(0x5f)
	.dwattr $C$DW$T$86, DW_AT_decl_column(0x18)

$C$DW$T$87	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$87, DW_AT_name("__sa_family_t")
	.dwattr $C$DW$T$87, DW_AT_type(*$C$DW$T$86)
	.dwattr $C$DW$T$87, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$87, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$87, DW_AT_decl_line(0x47)
	.dwattr $C$DW$T$87, DW_AT_decl_column(0x13)

$C$DW$T$88	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$88, DW_AT_name("__uint_least8_t")
	.dwattr $C$DW$T$88, DW_AT_type(*$C$DW$T$86)
	.dwattr $C$DW$T$88, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$88, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$88, DW_AT_decl_line(0x92)
	.dwattr $C$DW$T$88, DW_AT_decl_column(0x13)

$C$DW$T$7	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$7, DW_AT_encoding(DW_ATE_signed_char)
	.dwattr $C$DW$T$7, DW_AT_name("wchar_t")
	.dwattr $C$DW$T$7, DW_AT_byte_size(0x02)

$C$DW$T$8	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$8, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$8, DW_AT_name("short")
	.dwattr $C$DW$T$8, DW_AT_byte_size(0x02)


$C$DW$T$89	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$89, DW_AT_type(*$C$DW$T$8)
	.dwattr $C$DW$T$89, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$89, DW_AT_byte_size(0x200)
$C$DW$250	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$250, DW_AT_upper_bound(0xff)

	.dwendtag $C$DW$T$89

$C$DW$T$94	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$94, DW_AT_name("__int16_t")
	.dwattr $C$DW$T$94, DW_AT_type(*$C$DW$T$8)
	.dwattr $C$DW$T$94, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$94, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$94, DW_AT_decl_line(0x60)
	.dwattr $C$DW$T$94, DW_AT_decl_column(0x11)

$C$DW$T$95	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$95, DW_AT_name("__int_least16_t")
	.dwattr $C$DW$T$95, DW_AT_type(*$C$DW$T$94)
	.dwattr $C$DW$T$95, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$95, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$95, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$T$95, DW_AT_decl_column(0x13)

$C$DW$T$9	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$9, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$9, DW_AT_name("unsigned short")
	.dwattr $C$DW$T$9, DW_AT_byte_size(0x02)

$C$DW$T$96	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$96, DW_AT_name("___wchar_t")
	.dwattr $C$DW$T$96, DW_AT_type(*$C$DW$T$9)
	.dwattr $C$DW$T$96, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$96, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$96, DW_AT_decl_line(0x9b)
	.dwattr $C$DW$T$96, DW_AT_decl_column(0x1a)

$C$DW$T$97	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$97, DW_AT_name("__uint16_t")
	.dwattr $C$DW$T$97, DW_AT_type(*$C$DW$T$9)
	.dwattr $C$DW$T$97, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$97, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$97, DW_AT_decl_line(0x61)
	.dwattr $C$DW$T$97, DW_AT_decl_column(0x19)

$C$DW$T$98	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$98, DW_AT_name("__mode_t")
	.dwattr $C$DW$T$98, DW_AT_type(*$C$DW$T$97)
	.dwattr $C$DW$T$98, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$98, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$98, DW_AT_decl_line(0x3a)
	.dwattr $C$DW$T$98, DW_AT_decl_column(0x14)

$C$DW$T$99	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$99, DW_AT_name("__uint_least16_t")
	.dwattr $C$DW$T$99, DW_AT_type(*$C$DW$T$97)
	.dwattr $C$DW$T$99, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$99, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$99, DW_AT_decl_line(0x93)
	.dwattr $C$DW$T$99, DW_AT_decl_column(0x14)

$C$DW$T$100	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$100, DW_AT_name("__char16_t")
	.dwattr $C$DW$T$100, DW_AT_type(*$C$DW$T$99)
	.dwattr $C$DW$T$100, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$100, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$100, DW_AT_decl_line(0x73)
	.dwattr $C$DW$T$100, DW_AT_decl_column(0x1a)

$C$DW$T$101	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$101, DW_AT_name("wchar_t")
	.dwattr $C$DW$T$101, DW_AT_type(*$C$DW$T$9)
	.dwattr $C$DW$T$101, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$101, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$T$101, DW_AT_decl_line(0x84)
	.dwattr $C$DW$T$101, DW_AT_decl_column(0x1a)

$C$DW$T$10	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$10, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$10, DW_AT_name("int")
	.dwattr $C$DW$T$10, DW_AT_byte_size(0x04)

$C$DW$T$102	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$102, DW_AT_name("_Mbstatet")
	.dwattr $C$DW$T$102, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$102, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$102, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$102, DW_AT_decl_line(0x91)
	.dwattr $C$DW$T$102, DW_AT_decl_column(0x0d)

$C$DW$T$103	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$103, DW_AT_name("__mbstate_t")
	.dwattr $C$DW$T$103, DW_AT_type(*$C$DW$T$102)
	.dwattr $C$DW$T$103, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$103, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$103, DW_AT_decl_line(0x94)
	.dwattr $C$DW$T$103, DW_AT_decl_column(0x13)

$C$DW$T$104	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$104, DW_AT_name("__accmode_t")
	.dwattr $C$DW$T$104, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$104, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$104, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$104, DW_AT_decl_line(0x3b)
	.dwattr $C$DW$T$104, DW_AT_decl_column(0x0e)


$C$DW$T$38	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$38, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$38, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$38, DW_AT_byte_size(0x190)
$C$DW$251	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$251, DW_AT_upper_bound(0x63)

	.dwendtag $C$DW$T$38


$C$DW$T$61	.dwtag  DW_TAG_subroutine_type
	.dwattr $C$DW$T$61, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$61, DW_AT_language(DW_LANG_C)
$C$DW$252	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$252, DW_AT_type(*$C$DW$T$52)

$C$DW$253	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$253, DW_AT_type(*$C$DW$T$52)

	.dwendtag $C$DW$T$61

$C$DW$T$62	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$62, DW_AT_type(*$C$DW$T$61)
	.dwattr $C$DW$T$62, DW_AT_address_class(0x20)

$C$DW$T$63	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$63, DW_AT_name("__TI_compar_fn")
	.dwattr $C$DW$T$63, DW_AT_type(*$C$DW$T$62)
	.dwattr $C$DW$T$63, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$63, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdlib.h")
	.dwattr $C$DW$T$63, DW_AT_decl_line(0xd3)
	.dwattr $C$DW$T$63, DW_AT_decl_column(0x13)


$C$DW$T$121	.dwtag  DW_TAG_subroutine_type
	.dwattr $C$DW$T$121, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$121, DW_AT_language(DW_LANG_C)
$C$DW$254	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$254, DW_AT_type(*$C$DW$T$10)

$C$DW$255	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$255, DW_AT_type(*$C$DW$T$10)

	.dwendtag $C$DW$T$121

$C$DW$T$122	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$122, DW_AT_type(*$C$DW$T$121)
	.dwattr $C$DW$T$122, DW_AT_address_class(0x20)

$C$DW$T$125	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$125, DW_AT_name("binop")
	.dwattr $C$DW$T$125, DW_AT_type(*$C$DW$T$122)
	.dwattr $C$DW$T$125, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$125, DW_AT_decl_file("t1.c")
	.dwattr $C$DW$T$125, DW_AT_decl_line(0x25)
	.dwattr $C$DW$T$125, DW_AT_decl_column(0x0f)


$C$DW$T$126	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$126, DW_AT_type(*$C$DW$T$125)
	.dwattr $C$DW$T$126, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$126, DW_AT_byte_size(0x0c)
$C$DW$256	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$256, DW_AT_upper_bound(0x02)

	.dwendtag $C$DW$T$126

$C$DW$T$128	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$128, DW_AT_type(*$C$DW$T$10)


$C$DW$T$129	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$129, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$129, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$129, DW_AT_byte_size(0x800)
$C$DW$257	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$257, DW_AT_upper_bound(0x1ff)

	.dwendtag $C$DW$T$129

$C$DW$T$130	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$130, DW_AT_type(*$C$DW$T$10)

$C$DW$T$135	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$135, DW_AT_name("__cpulevel_t")
	.dwattr $C$DW$T$135, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$135, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$135, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$135, DW_AT_decl_line(0x50)
	.dwattr $C$DW$T$135, DW_AT_decl_column(0x0e)

$C$DW$T$136	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$136, DW_AT_name("__cpusetid_t")
	.dwattr $C$DW$T$136, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$136, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$136, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$136, DW_AT_decl_line(0x51)
	.dwattr $C$DW$T$136, DW_AT_decl_column(0x0e)

$C$DW$T$137	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$137, DW_AT_name("__cpuwhich_t")
	.dwattr $C$DW$T$137, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$137, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$137, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$137, DW_AT_decl_line(0x4f)
	.dwattr $C$DW$T$137, DW_AT_decl_column(0x0e)

$C$DW$T$138	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$138, DW_AT_name("__ct_rune_t")
	.dwattr $C$DW$T$138, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$138, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$138, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$138, DW_AT_decl_line(0x6b)
	.dwattr $C$DW$T$138, DW_AT_decl_column(0x0e)

$C$DW$T$139	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$139, DW_AT_name("__rune_t")
	.dwattr $C$DW$T$139, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$139, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$139, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$139, DW_AT_decl_line(0x6e)
	.dwattr $C$DW$T$139, DW_AT_decl_column(0x15)

$C$DW$T$140	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$140, DW_AT_name("__wint_t")
	.dwattr $C$DW$T$140, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$140, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$140, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$140, DW_AT_decl_line(0x6f)
	.dwattr $C$DW$T$140, DW_AT_decl_column(0x15)

$C$DW$T$141	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$141, DW_AT_name("__int32_t")
	.dwattr $C$DW$T$141, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$141, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$141, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$141, DW_AT_decl_line(0x62)
	.dwattr $C$DW$T$141, DW_AT_decl_column(0x0f)

$C$DW$T$142	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$142, DW_AT_name("__blksize_t")
	.dwattr $C$DW$T$142, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$142, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$142, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$142, DW_AT_decl_line(0x2f)
	.dwattr $C$DW$T$142, DW_AT_decl_column(0x13)

$C$DW$T$143	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$143, DW_AT_name("__clockid_t")
	.dwattr $C$DW$T$143, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$143, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$143, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$143, DW_AT_decl_line(0x31)
	.dwattr $C$DW$T$143, DW_AT_decl_column(0x13)

$C$DW$T$144	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$144, DW_AT_name("__critical_t")
	.dwattr $C$DW$T$144, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$144, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$144, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$144, DW_AT_decl_line(0x73)
	.dwattr $C$DW$T$144, DW_AT_decl_column(0x13)

$C$DW$T$145	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$145, DW_AT_name("__int_fast16_t")
	.dwattr $C$DW$T$145, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$145, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$145, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$145, DW_AT_decl_line(0x7a)
	.dwattr $C$DW$T$145, DW_AT_decl_column(0x13)

$C$DW$T$146	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$146, DW_AT_name("__int_fast32_t")
	.dwattr $C$DW$T$146, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$146, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$146, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$146, DW_AT_decl_line(0x7b)
	.dwattr $C$DW$T$146, DW_AT_decl_column(0x13)

$C$DW$T$147	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$147, DW_AT_name("__int_fast8_t")
	.dwattr $C$DW$T$147, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$147, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$147, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$147, DW_AT_decl_line(0x79)
	.dwattr $C$DW$T$147, DW_AT_decl_column(0x13)

$C$DW$T$148	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$148, DW_AT_name("__int_least32_t")
	.dwattr $C$DW$T$148, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$148, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$148, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$148, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$T$148, DW_AT_decl_column(0x13)

$C$DW$T$149	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$149, DW_AT_name("__intfptr_t")
	.dwattr $C$DW$T$149, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$149, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$149, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$149, DW_AT_decl_line(0x76)
	.dwattr $C$DW$T$149, DW_AT_decl_column(0x13)

$C$DW$T$150	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$150, DW_AT_name("__intptr_t")
	.dwattr $C$DW$T$150, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$150, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$150, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$150, DW_AT_decl_line(0x78)
	.dwattr $C$DW$T$150, DW_AT_decl_column(0x13)

$C$DW$T$151	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$151, DW_AT_name("__lwpid_t")
	.dwattr $C$DW$T$151, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$151, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$151, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$151, DW_AT_decl_line(0x39)
	.dwattr $C$DW$T$151, DW_AT_decl_column(0x13)

$C$DW$T$152	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$152, DW_AT_name("__pid_t")
	.dwattr $C$DW$T$152, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$152, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$152, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$152, DW_AT_decl_line(0x40)
	.dwattr $C$DW$T$152, DW_AT_decl_column(0x13)

$C$DW$T$153	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$153, DW_AT_name("__ptrdiff_t")
	.dwattr $C$DW$T$153, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$153, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$153, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$153, DW_AT_decl_line(0x81)
	.dwattr $C$DW$T$153, DW_AT_decl_column(0x13)

$C$DW$T$154	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$154, DW_AT_name("__register_t")
	.dwattr $C$DW$T$154, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$154, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$154, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$154, DW_AT_decl_line(0x82)
	.dwattr $C$DW$T$154, DW_AT_decl_column(0x13)

$C$DW$T$155	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$155, DW_AT_name("__segsz_t")
	.dwattr $C$DW$T$155, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$155, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$155, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$155, DW_AT_decl_line(0x83)
	.dwattr $C$DW$T$155, DW_AT_decl_column(0x13)

$C$DW$T$156	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$156, DW_AT_name("__ssize_t")
	.dwattr $C$DW$T$156, DW_AT_type(*$C$DW$T$141)
	.dwattr $C$DW$T$156, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$156, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$156, DW_AT_decl_line(0x85)
	.dwattr $C$DW$T$156, DW_AT_decl_column(0x13)

$C$DW$T$157	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$157, DW_AT_name("__key_t")
	.dwattr $C$DW$T$157, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$157, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$157, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$157, DW_AT_decl_line(0x38)
	.dwattr $C$DW$T$157, DW_AT_decl_column(0x0f)

$C$DW$T$158	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$158, DW_AT_name("__nl_item")
	.dwattr $C$DW$T$158, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$158, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$158, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$158, DW_AT_decl_line(0x3c)
	.dwattr $C$DW$T$158, DW_AT_decl_column(0x0e)

$C$DW$T$159	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$159, DW_AT_name("__suseconds_t")
	.dwattr $C$DW$T$159, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$159, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$159, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$159, DW_AT_decl_line(0x4a)
	.dwattr $C$DW$T$159, DW_AT_decl_column(0x0f)

$C$DW$T$160	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$160, DW_AT_name("_off_t")
	.dwattr $C$DW$T$160, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$160, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$160, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$160, DW_AT_decl_line(0xab)
	.dwattr $C$DW$T$160, DW_AT_decl_column(0x0d)

$C$DW$T$161	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$161, DW_AT_name("__off_t")
	.dwattr $C$DW$T$161, DW_AT_type(*$C$DW$T$160)
	.dwattr $C$DW$T$161, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$161, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$161, DW_AT_decl_line(0x3e)
	.dwattr $C$DW$T$161, DW_AT_decl_column(0x18)

$C$DW$T$162	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$162, DW_AT_name("fpos_t")
	.dwattr $C$DW$T$162, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$162, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$162, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$T$162, DW_AT_decl_line(0x76)
	.dwattr $C$DW$T$162, DW_AT_decl_column(0x0d)

$C$DW$T$163	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$163, DW_AT_name("off_t")
	.dwattr $C$DW$T$163, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$163, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$163, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$T$163, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$T$163, DW_AT_decl_column(0x0d)

$C$DW$T$11	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$11, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$11, DW_AT_name("unsigned int")
	.dwattr $C$DW$T$11, DW_AT_byte_size(0x04)

$C$DW$T$165	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$165, DW_AT_type(*$C$DW$T$11)


$C$DW$T$169	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$169, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$169, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$169, DW_AT_byte_size(0x640)
$C$DW$258	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$258, DW_AT_upper_bound(0x18f)

	.dwendtag $C$DW$T$169

$C$DW$T$171	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$171, DW_AT_name("__uint32_t")
	.dwattr $C$DW$T$171, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$171, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$171, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$171, DW_AT_decl_line(0x63)
	.dwattr $C$DW$T$171, DW_AT_decl_column(0x17)

$C$DW$T$172	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$172, DW_AT_name("__clock_t")
	.dwattr $C$DW$T$172, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$172, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$172, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$172, DW_AT_decl_line(0x72)
	.dwattr $C$DW$T$172, DW_AT_decl_column(0x14)

$C$DW$T$173	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$173, DW_AT_name("__fflags_t")
	.dwattr $C$DW$T$173, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$173, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$173, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$173, DW_AT_decl_line(0x32)
	.dwattr $C$DW$T$173, DW_AT_decl_column(0x14)

$C$DW$T$174	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$174, DW_AT_name("__fixpt_t")
	.dwattr $C$DW$T$174, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$174, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$174, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$174, DW_AT_decl_line(0x83)
	.dwattr $C$DW$T$174, DW_AT_decl_column(0x14)

$C$DW$T$175	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$175, DW_AT_name("__gid_t")
	.dwattr $C$DW$T$175, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$175, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$175, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$175, DW_AT_decl_line(0x35)
	.dwattr $C$DW$T$175, DW_AT_decl_column(0x14)

$C$DW$T$176	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$176, DW_AT_name("__size_t")
	.dwattr $C$DW$T$176, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$176, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$176, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$176, DW_AT_decl_line(0x84)
	.dwattr $C$DW$T$176, DW_AT_decl_column(0x14)

$C$DW$T$177	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$177, DW_AT_name("__socklen_t")
	.dwattr $C$DW$T$177, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$177, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$177, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$177, DW_AT_decl_line(0x49)
	.dwattr $C$DW$T$177, DW_AT_decl_column(0x14)

$C$DW$T$178	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$178, DW_AT_name("__time_t")
	.dwattr $C$DW$T$178, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$178, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$178, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$178, DW_AT_decl_line(0x89)
	.dwattr $C$DW$T$178, DW_AT_decl_column(0x19)

$C$DW$T$179	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$179, DW_AT_name("__u_register_t")
	.dwattr $C$DW$T$179, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$179, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$179, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$179, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$179, DW_AT_decl_column(0x14)

$C$DW$T$180	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$180, DW_AT_name("__uid_t")
	.dwattr $C$DW$T$180, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$180, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$180, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$180, DW_AT_decl_line(0x4d)
	.dwattr $C$DW$T$180, DW_AT_decl_column(0x14)

$C$DW$T$181	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$181, DW_AT_name("__uint_fast16_t")
	.dwattr $C$DW$T$181, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$181, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$181, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$181, DW_AT_decl_line(0x8f)
	.dwattr $C$DW$T$181, DW_AT_decl_column(0x14)

$C$DW$T$182	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$182, DW_AT_name("__uint_fast32_t")
	.dwattr $C$DW$T$182, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$182, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$182, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$182, DW_AT_decl_line(0x90)
	.dwattr $C$DW$T$182, DW_AT_decl_column(0x14)

$C$DW$T$183	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$183, DW_AT_name("__uint_fast8_t")
	.dwattr $C$DW$T$183, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$183, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$183, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$183, DW_AT_decl_line(0x8e)
	.dwattr $C$DW$T$183, DW_AT_decl_column(0x14)

$C$DW$T$184	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$184, DW_AT_name("__uint_least32_t")
	.dwattr $C$DW$T$184, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$184, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$184, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$184, DW_AT_decl_line(0x94)
	.dwattr $C$DW$T$184, DW_AT_decl_column(0x14)

$C$DW$T$185	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$185, DW_AT_name("__char32_t")
	.dwattr $C$DW$T$185, DW_AT_type(*$C$DW$T$184)
	.dwattr $C$DW$T$185, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$185, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$185, DW_AT_decl_line(0x74)
	.dwattr $C$DW$T$185, DW_AT_decl_column(0x1a)

$C$DW$T$186	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$186, DW_AT_name("__uintfptr_t")
	.dwattr $C$DW$T$186, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$186, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$186, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$186, DW_AT_decl_line(0x8b)
	.dwattr $C$DW$T$186, DW_AT_decl_column(0x14)

$C$DW$T$187	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$187, DW_AT_name("__uintptr_t")
	.dwattr $C$DW$T$187, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$187, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$187, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$187, DW_AT_decl_line(0x8d)
	.dwattr $C$DW$T$187, DW_AT_decl_column(0x14)

$C$DW$T$188	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$188, DW_AT_name("__vm_offset_t")
	.dwattr $C$DW$T$188, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$188, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$188, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$188, DW_AT_decl_line(0x97)
	.dwattr $C$DW$T$188, DW_AT_decl_column(0x14)

$C$DW$T$189	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$189, DW_AT_name("__vm_paddr_t")
	.dwattr $C$DW$T$189, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$189, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$189, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$189, DW_AT_decl_line(0x98)
	.dwattr $C$DW$T$189, DW_AT_decl_column(0x14)

$C$DW$T$190	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$190, DW_AT_name("__vm_size_t")
	.dwattr $C$DW$T$190, DW_AT_type(*$C$DW$T$171)
	.dwattr $C$DW$T$190, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$190, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$190, DW_AT_decl_line(0x99)
	.dwattr $C$DW$T$190, DW_AT_decl_column(0x14)

$C$DW$T$191	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$191, DW_AT_name("__useconds_t")
	.dwattr $C$DW$T$191, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$191, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$191, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$191, DW_AT_decl_line(0x4e)
	.dwattr $C$DW$T$191, DW_AT_decl_column(0x16)

$C$DW$T$53	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$53, DW_AT_name("size_t")
	.dwattr $C$DW$T$53, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$53, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$53, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h")
	.dwattr $C$DW$T$53, DW_AT_decl_line(0x44)
	.dwattr $C$DW$T$53, DW_AT_decl_column(0x19)

$C$DW$T$12	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$12, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$12, DW_AT_name("__int40_t")
	.dwattr $C$DW$T$12, DW_AT_byte_size(0x08)
	.dwattr $C$DW$T$12, DW_AT_bit_size(0x28)
	.dwattr $C$DW$T$12, DW_AT_bit_offset(0x18)

$C$DW$T$13	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$13, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$13, DW_AT_name("unsigned __int40_t")
	.dwattr $C$DW$T$13, DW_AT_byte_size(0x08)
	.dwattr $C$DW$T$13, DW_AT_bit_size(0x28)
	.dwattr $C$DW$T$13, DW_AT_bit_offset(0x18)

$C$DW$T$14	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$14, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$14, DW_AT_name("long")
	.dwattr $C$DW$T$14, DW_AT_byte_size(0x04)

$C$DW$T$15	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$15, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$15, DW_AT_name("unsigned long")
	.dwattr $C$DW$T$15, DW_AT_byte_size(0x04)

$C$DW$T$16	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$16, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$16, DW_AT_name("long long")
	.dwattr $C$DW$T$16, DW_AT_byte_size(0x08)

$C$DW$T$194	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$194, DW_AT_name("__int64_t")
	.dwattr $C$DW$T$194, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$T$194, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$194, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$194, DW_AT_decl_line(0x68)
	.dwattr $C$DW$T$194, DW_AT_decl_column(0x14)

$C$DW$T$195	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$195, DW_AT_name("__blkcnt_t")
	.dwattr $C$DW$T$195, DW_AT_type(*$C$DW$T$194)
	.dwattr $C$DW$T$195, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$195, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$195, DW_AT_decl_line(0x30)
	.dwattr $C$DW$T$195, DW_AT_decl_column(0x13)

$C$DW$T$196	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$196, DW_AT_name("__id_t")
	.dwattr $C$DW$T$196, DW_AT_type(*$C$DW$T$194)
	.dwattr $C$DW$T$196, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$196, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$196, DW_AT_decl_line(0x36)
	.dwattr $C$DW$T$196, DW_AT_decl_column(0x13)

$C$DW$T$197	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$197, DW_AT_name("__int_fast64_t")
	.dwattr $C$DW$T$197, DW_AT_type(*$C$DW$T$194)
	.dwattr $C$DW$T$197, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$197, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$197, DW_AT_decl_line(0x7c)
	.dwattr $C$DW$T$197, DW_AT_decl_column(0x13)

$C$DW$T$198	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$198, DW_AT_name("__int_least64_t")
	.dwattr $C$DW$T$198, DW_AT_type(*$C$DW$T$194)
	.dwattr $C$DW$T$198, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$198, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$198, DW_AT_decl_line(0x80)
	.dwattr $C$DW$T$198, DW_AT_decl_column(0x13)

$C$DW$T$199	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$199, DW_AT_name("__intmax_t")
	.dwattr $C$DW$T$199, DW_AT_type(*$C$DW$T$194)
	.dwattr $C$DW$T$199, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$199, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$199, DW_AT_decl_line(0x77)
	.dwattr $C$DW$T$199, DW_AT_decl_column(0x13)

$C$DW$T$200	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$200, DW_AT_name("__off64_t")
	.dwattr $C$DW$T$200, DW_AT_type(*$C$DW$T$194)
	.dwattr $C$DW$T$200, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$200, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$200, DW_AT_decl_line(0x3f)
	.dwattr $C$DW$T$200, DW_AT_decl_column(0x13)

$C$DW$T$201	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$201, DW_AT_name("__rlim_t")
	.dwattr $C$DW$T$201, DW_AT_type(*$C$DW$T$194)
	.dwattr $C$DW$T$201, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$201, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$201, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$201, DW_AT_decl_column(0x13)

$C$DW$T$17	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$17, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$17, DW_AT_name("unsigned long long")
	.dwattr $C$DW$T$17, DW_AT_byte_size(0x08)

$C$DW$T$203	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$203, DW_AT_name("__uint64_t")
	.dwattr $C$DW$T$203, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$203, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$203, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$203, DW_AT_decl_line(0x6d)
	.dwattr $C$DW$T$203, DW_AT_decl_column(0x1c)

$C$DW$T$204	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$204, DW_AT_name("__dev_t")
	.dwattr $C$DW$T$204, DW_AT_type(*$C$DW$T$203)
	.dwattr $C$DW$T$204, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$204, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$204, DW_AT_decl_line(0x81)
	.dwattr $C$DW$T$204, DW_AT_decl_column(0x14)

$C$DW$T$205	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$205, DW_AT_name("__fsblkcnt_t")
	.dwattr $C$DW$T$205, DW_AT_type(*$C$DW$T$203)
	.dwattr $C$DW$T$205, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$205, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$205, DW_AT_decl_line(0x33)
	.dwattr $C$DW$T$205, DW_AT_decl_column(0x14)

$C$DW$T$206	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$206, DW_AT_name("__fsfilcnt_t")
	.dwattr $C$DW$T$206, DW_AT_type(*$C$DW$T$203)
	.dwattr $C$DW$T$206, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$206, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$206, DW_AT_decl_line(0x34)
	.dwattr $C$DW$T$206, DW_AT_decl_column(0x14)

$C$DW$T$207	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$207, DW_AT_name("__ino_t")
	.dwattr $C$DW$T$207, DW_AT_type(*$C$DW$T$203)
	.dwattr $C$DW$T$207, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$207, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$207, DW_AT_decl_line(0x37)
	.dwattr $C$DW$T$207, DW_AT_decl_column(0x14)

$C$DW$T$208	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$208, DW_AT_name("__nlink_t")
	.dwattr $C$DW$T$208, DW_AT_type(*$C$DW$T$203)
	.dwattr $C$DW$T$208, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$208, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$208, DW_AT_decl_line(0x3d)
	.dwattr $C$DW$T$208, DW_AT_decl_column(0x14)

$C$DW$T$209	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$209, DW_AT_name("__uint_fast64_t")
	.dwattr $C$DW$T$209, DW_AT_type(*$C$DW$T$203)
	.dwattr $C$DW$T$209, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$209, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$209, DW_AT_decl_line(0x91)
	.dwattr $C$DW$T$209, DW_AT_decl_column(0x14)

$C$DW$T$210	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$210, DW_AT_name("__uint_least64_t")
	.dwattr $C$DW$T$210, DW_AT_type(*$C$DW$T$203)
	.dwattr $C$DW$T$210, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$210, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$210, DW_AT_decl_line(0x95)
	.dwattr $C$DW$T$210, DW_AT_decl_column(0x14)

$C$DW$T$211	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$211, DW_AT_name("__uintmax_t")
	.dwattr $C$DW$T$211, DW_AT_type(*$C$DW$T$203)
	.dwattr $C$DW$T$211, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$211, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$211, DW_AT_decl_line(0x8c)
	.dwattr $C$DW$T$211, DW_AT_decl_column(0x14)

$C$DW$T$212	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$212, DW_AT_name("__rman_res_t")
	.dwattr $C$DW$T$212, DW_AT_type(*$C$DW$T$211)
	.dwattr $C$DW$T$212, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$212, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$212, DW_AT_decl_line(0x9c)
	.dwattr $C$DW$T$212, DW_AT_decl_column(0x19)

$C$DW$T$18	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$18, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$18, DW_AT_name("float")
	.dwattr $C$DW$T$18, DW_AT_byte_size(0x04)

$C$DW$T$217	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$217, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$217, DW_AT_address_class(0x20)


$C$DW$T$220	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$220, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$220, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$220, DW_AT_byte_size(0x400)
$C$DW$259	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$259, DW_AT_upper_bound(0xff)

	.dwendtag $C$DW$T$220

$C$DW$T$221	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$221, DW_AT_type(*$C$DW$T$18)

$C$DW$T$224	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$224, DW_AT_name("__float_t")
	.dwattr $C$DW$T$224, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$224, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$224, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$224, DW_AT_decl_line(0x75)
	.dwattr $C$DW$T$224, DW_AT_decl_column(0x10)

$C$DW$T$225	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$225, DW_AT_name("float_t")
	.dwattr $C$DW$T$225, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$225, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$225, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/_bsdmath.h")
	.dwattr $C$DW$T$225, DW_AT_decl_line(0xa8)
	.dwattr $C$DW$T$225, DW_AT_decl_column(0x0f)

$C$DW$T$19	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$19, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$19, DW_AT_name("double")
	.dwattr $C$DW$T$19, DW_AT_byte_size(0x08)

$C$DW$T$230	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$230, DW_AT_name("__double_t")
	.dwattr $C$DW$T$230, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$T$230, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$230, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$230, DW_AT_decl_line(0x74)
	.dwattr $C$DW$T$230, DW_AT_decl_column(0x11)

$C$DW$T$231	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$231, DW_AT_name("double_t")
	.dwattr $C$DW$T$231, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$T$231, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$231, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/_bsdmath.h")
	.dwattr $C$DW$T$231, DW_AT_decl_line(0xa7)
	.dwattr $C$DW$T$231, DW_AT_decl_column(0x10)

$C$DW$T$20	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$20, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$20, DW_AT_name("long double")
	.dwattr $C$DW$T$20, DW_AT_byte_size(0x08)

$C$DW$T$21	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$21, DW_AT_encoding(DW_ATE_TI_complex_signed)
	.dwattr $C$DW$T$21, DW_AT_name("cchar")
	.dwattr $C$DW$T$21, DW_AT_byte_size(0x02)

$C$DW$T$22	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$22, DW_AT_encoding(DW_ATE_TI_complex_signed)
	.dwattr $C$DW$T$22, DW_AT_name("cshort")
	.dwattr $C$DW$T$22, DW_AT_byte_size(0x04)

$C$DW$T$23	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$23, DW_AT_encoding(DW_ATE_TI_complex_signed)
	.dwattr $C$DW$T$23, DW_AT_name("cint")
	.dwattr $C$DW$T$23, DW_AT_byte_size(0x08)

$C$DW$T$24	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$24, DW_AT_encoding(DW_ATE_TI_complex_signed)
	.dwattr $C$DW$T$24, DW_AT_name("clonglong")
	.dwattr $C$DW$T$24, DW_AT_byte_size(0x10)

$C$DW$T$25	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$25, DW_AT_encoding(DW_ATE_TI_complex_float)
	.dwattr $C$DW$T$25, DW_AT_name("cfloat")
	.dwattr $C$DW$T$25, DW_AT_byte_size(0x08)

$C$DW$T$26	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$26, DW_AT_encoding(DW_ATE_TI_complex_float)
	.dwattr $C$DW$T$26, DW_AT_name("cdouble")
	.dwattr $C$DW$T$26, DW_AT_byte_size(0x10)

$C$DW$T$105	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$105, DW_AT_type(*$C$DW$T$5)

$C$DW$T$106	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$106, DW_AT_type(*$C$DW$T$105)
	.dwattr $C$DW$T$106, DW_AT_address_class(0x20)

$C$DW$T$110	.dwtag  DW_TAG_restrict_type
	.dwattr $C$DW$T$110, DW_AT_type(*$C$DW$T$106)

$C$DW$T$108	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$108, DW_AT_type(*$C$DW$T$5)
	.dwattr $C$DW$T$108, DW_AT_address_class(0x20)

$C$DW$T$109	.dwtag  DW_TAG_restrict_type
	.dwattr $C$DW$T$109, DW_AT_type(*$C$DW$T$108)

$C$DW$T$115	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$115, DW_AT_type(*$C$DW$T$108)
	.dwattr $C$DW$T$115, DW_AT_address_class(0x20)

$C$DW$T$116	.dwtag  DW_TAG_restrict_type
	.dwattr $C$DW$T$116, DW_AT_type(*$C$DW$T$115)

$C$DW$T$232	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$232, DW_AT_name("__va_list")
	.dwattr $C$DW$T$232, DW_AT_type(*$C$DW$T$108)
	.dwattr $C$DW$T$232, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$232, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$232, DW_AT_decl_line(0xb4)
	.dwattr $C$DW$T$232, DW_AT_decl_column(0x13)

$C$DW$T$233	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$233, DW_AT_name("va_list")
	.dwattr $C$DW$T$233, DW_AT_type(*$C$DW$T$232)
	.dwattr $C$DW$T$233, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$233, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdarg.h")
	.dwattr $C$DW$T$233, DW_AT_decl_line(0x33)
	.dwattr $C$DW$T$233, DW_AT_decl_column(0x17)


$C$DW$T$28	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$28, DW_AT_name("__mq")
	.dwattr $C$DW$T$28, DW_AT_declaration
	.dwattr $C$DW$T$28, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$28, DW_AT_decl_line(0x4c)
	.dwattr $C$DW$T$28, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$T$28

$C$DW$T$234	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$234, DW_AT_type(*$C$DW$T$28)
	.dwattr $C$DW$T$234, DW_AT_address_class(0x20)

$C$DW$T$235	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$235, DW_AT_name("__mqd_t")
	.dwattr $C$DW$T$235, DW_AT_type(*$C$DW$T$234)
	.dwattr $C$DW$T$235, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$235, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$235, DW_AT_decl_line(0x4c)
	.dwattr $C$DW$T$235, DW_AT_decl_column(0x16)


$C$DW$T$44	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$44, DW_AT_name("__sFILE")
	.dwattr $C$DW$T$44, DW_AT_byte_size(0x18)
$C$DW$260	.dwtag  DW_TAG_member
	.dwattr $C$DW$260, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$260, DW_AT_name("fd")
	.dwattr $C$DW$260, DW_AT_TI_symbol_name("fd")
	.dwattr $C$DW$260, DW_AT_data_member_location[DW_OP_plus_uconst 0x0]
	.dwattr $C$DW$260, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$260, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$260, DW_AT_decl_line(0x5f)
	.dwattr $C$DW$260, DW_AT_decl_column(0x0b)

$C$DW$261	.dwtag  DW_TAG_member
	.dwattr $C$DW$261, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$261, DW_AT_name("buf")
	.dwattr $C$DW$261, DW_AT_TI_symbol_name("buf")
	.dwattr $C$DW$261, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$261, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$261, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$261, DW_AT_decl_line(0x60)
	.dwattr $C$DW$261, DW_AT_decl_column(0x16)

$C$DW$262	.dwtag  DW_TAG_member
	.dwattr $C$DW$262, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$262, DW_AT_name("pos")
	.dwattr $C$DW$262, DW_AT_TI_symbol_name("pos")
	.dwattr $C$DW$262, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$262, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$262, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$262, DW_AT_decl_line(0x61)
	.dwattr $C$DW$262, DW_AT_decl_column(0x16)

$C$DW$263	.dwtag  DW_TAG_member
	.dwattr $C$DW$263, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$263, DW_AT_name("bufend")
	.dwattr $C$DW$263, DW_AT_TI_symbol_name("bufend")
	.dwattr $C$DW$263, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$263, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$263, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$263, DW_AT_decl_line(0x62)
	.dwattr $C$DW$263, DW_AT_decl_column(0x16)

$C$DW$264	.dwtag  DW_TAG_member
	.dwattr $C$DW$264, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$264, DW_AT_name("buff_stop")
	.dwattr $C$DW$264, DW_AT_TI_symbol_name("buff_stop")
	.dwattr $C$DW$264, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$264, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$264, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$264, DW_AT_decl_line(0x63)
	.dwattr $C$DW$264, DW_AT_decl_column(0x16)

$C$DW$265	.dwtag  DW_TAG_member
	.dwattr $C$DW$265, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$265, DW_AT_name("flags")
	.dwattr $C$DW$265, DW_AT_TI_symbol_name("flags")
	.dwattr $C$DW$265, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$265, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$265, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$265, DW_AT_decl_line(0x64)
	.dwattr $C$DW$265, DW_AT_decl_column(0x16)

	.dwattr $C$DW$T$44, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$T$44, DW_AT_decl_line(0x5e)
	.dwattr $C$DW$T$44, DW_AT_decl_column(0x08)
	.dwendtag $C$DW$T$44

$C$DW$T$236	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$236, DW_AT_name("FILE")
	.dwattr $C$DW$T$236, DW_AT_type(*$C$DW$T$44)
	.dwattr $C$DW$T$236, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$236, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$T$236, DW_AT_decl_line(0x69)
	.dwattr $C$DW$T$236, DW_AT_decl_column(0x18)


$C$DW$T$29	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$29, DW_AT_name("__timer")
	.dwattr $C$DW$T$29, DW_AT_declaration
	.dwattr $C$DW$T$29, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$29, DW_AT_decl_line(0x4b)
	.dwattr $C$DW$T$29, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$T$29

$C$DW$T$237	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$237, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$T$237, DW_AT_address_class(0x20)

$C$DW$T$238	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$238, DW_AT_name("__timer_t")
	.dwattr $C$DW$T$238, DW_AT_type(*$C$DW$T$237)
	.dwattr $C$DW$T$238, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$238, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$238, DW_AT_decl_line(0x4b)
	.dwattr $C$DW$T$238, DW_AT_decl_column(0x19)


$C$DW$T$30	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$30, DW_AT_name("_xlocale")
	.dwattr $C$DW$T$30, DW_AT_declaration
	.dwattr $C$DW$T$30, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/xlocale/_string.h")
	.dwattr $C$DW$T$30, DW_AT_decl_line(0x21)
	.dwattr $C$DW$T$30, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$T$30

$C$DW$T$239	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$239, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$T$239, DW_AT_address_class(0x20)

$C$DW$T$240	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$240, DW_AT_name("locale_t")
	.dwattr $C$DW$T$240, DW_AT_type(*$C$DW$T$239)
	.dwattr $C$DW$T$240, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$240, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/xlocale/_string.h")
	.dwattr $C$DW$T$240, DW_AT_decl_line(0x21)
	.dwattr $C$DW$T$240, DW_AT_decl_column(0x1a)

	.dwattr $C$DW$CU, DW_AT_language(DW_LANG_C)

;***************************************************************
;* DWARF CIE ENTRIES                                           *
;***************************************************************

$C$DW$CIE	.dwcie 19
	.dwcfi	cfa_register, 31
	.dwcfi	cfa_offset, 0
	.dwcfi	same_value, 10
	.dwcfi	same_value, 11
	.dwcfi	same_value, 12
	.dwcfi	same_value, 13
	.dwcfi	same_value, 14
	.dwcfi	same_value, 15
	.dwcfi	same_value, 26
	.dwcfi	same_value, 27
	.dwcfi	same_value, 28
	.dwcfi	same_value, 29
	.dwcfi	same_value, 30
	.dwcfi	same_value, 31
	.dwendentry

;***************************************************************
;* DWARF REGISTER MAP                                          *
;***************************************************************

$C$DW$266	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$266, DW_AT_name("A0")
	.dwattr $C$DW$266, DW_AT_location[DW_OP_reg0]

$C$DW$267	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$267, DW_AT_name("A1")
	.dwattr $C$DW$267, DW_AT_location[DW_OP_reg1]

$C$DW$268	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$268, DW_AT_name("A2")
	.dwattr $C$DW$268, DW_AT_location[DW_OP_reg2]

$C$DW$269	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$269, DW_AT_name("A3")
	.dwattr $C$DW$269, DW_AT_location[DW_OP_reg3]

$C$DW$270	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$270, DW_AT_name("A4")
	.dwattr $C$DW$270, DW_AT_location[DW_OP_reg4]

$C$DW$271	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$271, DW_AT_name("A5")
	.dwattr $C$DW$271, DW_AT_location[DW_OP_reg5]

$C$DW$272	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$272, DW_AT_name("A6")
	.dwattr $C$DW$272, DW_AT_location[DW_OP_reg6]

$C$DW$273	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$273, DW_AT_name("A7")
	.dwattr $C$DW$273, DW_AT_location[DW_OP_reg7]

$C$DW$274	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$274, DW_AT_name("A8")
	.dwattr $C$DW$274, DW_AT_location[DW_OP_reg8]

$C$DW$275	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$275, DW_AT_name("A9")
	.dwattr $C$DW$275, DW_AT_location[DW_OP_reg9]

$C$DW$276	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$276, DW_AT_name("A10")
	.dwattr $C$DW$276, DW_AT_location[DW_OP_reg10]

$C$DW$277	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$277, DW_AT_name("A11")
	.dwattr $C$DW$277, DW_AT_location[DW_OP_reg11]

$C$DW$278	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$278, DW_AT_name("A12")
	.dwattr $C$DW$278, DW_AT_location[DW_OP_reg12]

$C$DW$279	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$279, DW_AT_name("A13")
	.dwattr $C$DW$279, DW_AT_location[DW_OP_reg13]

$C$DW$280	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$280, DW_AT_name("A14")
	.dwattr $C$DW$280, DW_AT_location[DW_OP_reg14]

$C$DW$281	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$281, DW_AT_name("A15")
	.dwattr $C$DW$281, DW_AT_location[DW_OP_reg15]

$C$DW$282	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$282, DW_AT_name("FP")
	.dwattr $C$DW$282, DW_AT_location[DW_OP_regx 0x20]

$C$DW$283	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$283, DW_AT_name("A16")
	.dwattr $C$DW$283, DW_AT_location[DW_OP_regx 0x25]

$C$DW$284	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$284, DW_AT_name("A17")
	.dwattr $C$DW$284, DW_AT_location[DW_OP_regx 0x26]

$C$DW$285	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$285, DW_AT_name("A18")
	.dwattr $C$DW$285, DW_AT_location[DW_OP_regx 0x27]

$C$DW$286	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$286, DW_AT_name("A19")
	.dwattr $C$DW$286, DW_AT_location[DW_OP_regx 0x28]

$C$DW$287	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$287, DW_AT_name("A20")
	.dwattr $C$DW$287, DW_AT_location[DW_OP_regx 0x29]

$C$DW$288	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$288, DW_AT_name("A21")
	.dwattr $C$DW$288, DW_AT_location[DW_OP_regx 0x2a]

$C$DW$289	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$289, DW_AT_name("A22")
	.dwattr $C$DW$289, DW_AT_location[DW_OP_regx 0x2b]

$C$DW$290	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$290, DW_AT_name("A23")
	.dwattr $C$DW$290, DW_AT_location[DW_OP_regx 0x2c]

$C$DW$291	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$291, DW_AT_name("A24")
	.dwattr $C$DW$291, DW_AT_location[DW_OP_regx 0x2d]

$C$DW$292	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$292, DW_AT_name("A25")
	.dwattr $C$DW$292, DW_AT_location[DW_OP_regx 0x2e]

$C$DW$293	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$293, DW_AT_name("A26")
	.dwattr $C$DW$293, DW_AT_location[DW_OP_regx 0x2f]

$C$DW$294	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$294, DW_AT_name("A27")
	.dwattr $C$DW$294, DW_AT_location[DW_OP_regx 0x30]

$C$DW$295	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$295, DW_AT_name("A28")
	.dwattr $C$DW$295, DW_AT_location[DW_OP_regx 0x31]

$C$DW$296	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$296, DW_AT_name("A29")
	.dwattr $C$DW$296, DW_AT_location[DW_OP_regx 0x32]

$C$DW$297	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$297, DW_AT_name("A30")
	.dwattr $C$DW$297, DW_AT_location[DW_OP_regx 0x33]

$C$DW$298	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$298, DW_AT_name("A31")
	.dwattr $C$DW$298, DW_AT_location[DW_OP_regx 0x34]

$C$DW$299	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$299, DW_AT_name("B0")
	.dwattr $C$DW$299, DW_AT_location[DW_OP_reg16]

$C$DW$300	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$300, DW_AT_name("B1")
	.dwattr $C$DW$300, DW_AT_location[DW_OP_reg17]

$C$DW$301	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$301, DW_AT_name("B2")
	.dwattr $C$DW$301, DW_AT_location[DW_OP_reg18]

$C$DW$302	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$302, DW_AT_name("B3")
	.dwattr $C$DW$302, DW_AT_location[DW_OP_reg19]

$C$DW$303	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$303, DW_AT_name("B4")
	.dwattr $C$DW$303, DW_AT_location[DW_OP_reg20]

$C$DW$304	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$304, DW_AT_name("B5")
	.dwattr $C$DW$304, DW_AT_location[DW_OP_reg21]

$C$DW$305	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$305, DW_AT_name("B6")
	.dwattr $C$DW$305, DW_AT_location[DW_OP_reg22]

$C$DW$306	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$306, DW_AT_name("B7")
	.dwattr $C$DW$306, DW_AT_location[DW_OP_reg23]

$C$DW$307	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$307, DW_AT_name("B8")
	.dwattr $C$DW$307, DW_AT_location[DW_OP_reg24]

$C$DW$308	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$308, DW_AT_name("B9")
	.dwattr $C$DW$308, DW_AT_location[DW_OP_reg25]

$C$DW$309	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$309, DW_AT_name("B10")
	.dwattr $C$DW$309, DW_AT_location[DW_OP_reg26]

$C$DW$310	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$310, DW_AT_name("B11")
	.dwattr $C$DW$310, DW_AT_location[DW_OP_reg27]

$C$DW$311	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$311, DW_AT_name("B12")
	.dwattr $C$DW$311, DW_AT_location[DW_OP_reg28]

$C$DW$312	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$312, DW_AT_name("B13")
	.dwattr $C$DW$312, DW_AT_location[DW_OP_reg29]

$C$DW$313	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$313, DW_AT_name("DP")
	.dwattr $C$DW$313, DW_AT_location[DW_OP_reg30]

$C$DW$314	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$314, DW_AT_name("SP")
	.dwattr $C$DW$314, DW_AT_location[DW_OP_reg31]

$C$DW$315	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$315, DW_AT_name("B16")
	.dwattr $C$DW$315, DW_AT_location[DW_OP_regx 0x35]

$C$DW$316	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$316, DW_AT_name("B17")
	.dwattr $C$DW$316, DW_AT_location[DW_OP_regx 0x36]

$C$DW$317	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$317, DW_AT_name("B18")
	.dwattr $C$DW$317, DW_AT_location[DW_OP_regx 0x37]

$C$DW$318	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$318, DW_AT_name("B19")
	.dwattr $C$DW$318, DW_AT_location[DW_OP_regx 0x38]

$C$DW$319	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$319, DW_AT_name("B20")
	.dwattr $C$DW$319, DW_AT_location[DW_OP_regx 0x39]

$C$DW$320	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$320, DW_AT_name("B21")
	.dwattr $C$DW$320, DW_AT_location[DW_OP_regx 0x3a]

$C$DW$321	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$321, DW_AT_name("B22")
	.dwattr $C$DW$321, DW_AT_location[DW_OP_regx 0x3b]

$C$DW$322	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$322, DW_AT_name("B23")
	.dwattr $C$DW$322, DW_AT_location[DW_OP_regx 0x3c]

$C$DW$323	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$323, DW_AT_name("B24")
	.dwattr $C$DW$323, DW_AT_location[DW_OP_regx 0x3d]

$C$DW$324	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$324, DW_AT_name("B25")
	.dwattr $C$DW$324, DW_AT_location[DW_OP_regx 0x3e]

$C$DW$325	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$325, DW_AT_name("B26")
	.dwattr $C$DW$325, DW_AT_location[DW_OP_regx 0x3f]

$C$DW$326	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$326, DW_AT_name("B27")
	.dwattr $C$DW$326, DW_AT_location[DW_OP_regx 0x40]

$C$DW$327	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$327, DW_AT_name("B28")
	.dwattr $C$DW$327, DW_AT_location[DW_OP_regx 0x41]

$C$DW$328	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$328, DW_AT_name("B29")
	.dwattr $C$DW$328, DW_AT_location[DW_OP_regx 0x42]

$C$DW$329	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$329, DW_AT_name("B30")
	.dwattr $C$DW$329, DW_AT_location[DW_OP_regx 0x43]

$C$DW$330	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$330, DW_AT_name("B31")
	.dwattr $C$DW$330, DW_AT_location[DW_OP_regx 0x44]

$C$DW$331	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$331, DW_AT_name("PC")
	.dwattr $C$DW$331, DW_AT_location[DW_OP_regx 0x21]

$C$DW$332	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$332, DW_AT_name("PCE1")
	.dwattr $C$DW$332, DW_AT_location[DW_OP_regx 0x21]

$C$DW$333	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$333, DW_AT_name("IRP")
	.dwattr $C$DW$333, DW_AT_location[DW_OP_regx 0x22]

$C$DW$334	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$334, DW_AT_name("IFR")
	.dwattr $C$DW$334, DW_AT_location[DW_OP_regx 0x23]

$C$DW$335	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$335, DW_AT_name("NRP")
	.dwattr $C$DW$335, DW_AT_location[DW_OP_regx 0x24]

$C$DW$336	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$336, DW_AT_name("CSR")
	.dwattr $C$DW$336, DW_AT_location[DW_OP_regx 0x46]

$C$DW$337	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$337, DW_AT_name("CSR")
	.dwattr $C$DW$337, DW_AT_location[DW_OP_regx 0x46]

$C$DW$338	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$338, DW_AT_name("SSR")
	.dwattr $C$DW$338, DW_AT_location[DW_OP_regx 0x5b]

$C$DW$339	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$339, DW_AT_name("CSR")
	.dwattr $C$DW$339, DW_AT_location[DW_OP_regx 0x46]

$C$DW$340	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$340, DW_AT_name("AMR")
	.dwattr $C$DW$340, DW_AT_location[DW_OP_regx 0x45]

$C$DW$341	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$341, DW_AT_name("ISR")
	.dwattr $C$DW$341, DW_AT_location[DW_OP_regx 0x47]

$C$DW$342	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$342, DW_AT_name("ICR")
	.dwattr $C$DW$342, DW_AT_location[DW_OP_regx 0x48]

$C$DW$343	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$343, DW_AT_name("IER")
	.dwattr $C$DW$343, DW_AT_location[DW_OP_regx 0x49]

$C$DW$344	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$344, DW_AT_name("ISTP")
	.dwattr $C$DW$344, DW_AT_location[DW_OP_regx 0x4a]

$C$DW$345	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$345, DW_AT_name("IN")
	.dwattr $C$DW$345, DW_AT_location[DW_OP_regx 0x4b]

$C$DW$346	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$346, DW_AT_name("OUT")
	.dwattr $C$DW$346, DW_AT_location[DW_OP_regx 0x4c]

$C$DW$347	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$347, DW_AT_name("ACR")
	.dwattr $C$DW$347, DW_AT_location[DW_OP_regx 0x4d]

$C$DW$348	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$348, DW_AT_name("ADR")
	.dwattr $C$DW$348, DW_AT_location[DW_OP_regx 0x4e]

$C$DW$349	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$349, DW_AT_name("FADCR")
	.dwattr $C$DW$349, DW_AT_location[DW_OP_regx 0x4f]

$C$DW$350	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$350, DW_AT_name("FAUCR")
	.dwattr $C$DW$350, DW_AT_location[DW_OP_regx 0x50]

$C$DW$351	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$351, DW_AT_name("FMCR")
	.dwattr $C$DW$351, DW_AT_location[DW_OP_regx 0x51]

$C$DW$352	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$352, DW_AT_name("GFPGFR")
	.dwattr $C$DW$352, DW_AT_location[DW_OP_regx 0x52]

$C$DW$353	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$353, DW_AT_name("DIER")
	.dwattr $C$DW$353, DW_AT_location[DW_OP_regx 0x53]

$C$DW$354	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$354, DW_AT_name("REP")
	.dwattr $C$DW$354, DW_AT_location[DW_OP_regx 0x54]

$C$DW$355	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$355, DW_AT_name("TSCL")
	.dwattr $C$DW$355, DW_AT_location[DW_OP_regx 0x55]

$C$DW$356	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$356, DW_AT_name("TSCH")
	.dwattr $C$DW$356, DW_AT_location[DW_OP_regx 0x56]

$C$DW$357	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$357, DW_AT_name("ARP")
	.dwattr $C$DW$357, DW_AT_location[DW_OP_regx 0x57]

$C$DW$358	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$358, DW_AT_name("ILC")
	.dwattr $C$DW$358, DW_AT_location[DW_OP_regx 0x58]

$C$DW$359	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$359, DW_AT_name("RILC")
	.dwattr $C$DW$359, DW_AT_location[DW_OP_regx 0x59]

$C$DW$360	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$360, DW_AT_name("DNUM")
	.dwattr $C$DW$360, DW_AT_location[DW_OP_regx 0x5a]

$C$DW$361	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$361, DW_AT_name("GPLYA")
	.dwattr $C$DW$361, DW_AT_location[DW_OP_regx 0x5c]

$C$DW$362	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$362, DW_AT_name("GPLYB")
	.dwattr $C$DW$362, DW_AT_location[DW_OP_regx 0x5d]

$C$DW$363	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$363, DW_AT_name("TSR")
	.dwattr $C$DW$363, DW_AT_location[DW_OP_regx 0x5e]

$C$DW$364	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$364, DW_AT_name("ITSR")
	.dwattr $C$DW$364, DW_AT_location[DW_OP_regx 0x5f]

$C$DW$365	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$365, DW_AT_name("NTSR")
	.dwattr $C$DW$365, DW_AT_location[DW_OP_regx 0x60]

$C$DW$366	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$366, DW_AT_name("EFR")
	.dwattr $C$DW$366, DW_AT_location[DW_OP_regx 0x61]

$C$DW$367	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$367, DW_AT_name("ECR")
	.dwattr $C$DW$367, DW_AT_location[DW_OP_regx 0x62]

$C$DW$368	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$368, DW_AT_name("IERR")
	.dwattr $C$DW$368, DW_AT_location[DW_OP_regx 0x63]

$C$DW$369	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$369, DW_AT_name("DMSG")
	.dwattr $C$DW$369, DW_AT_location[DW_OP_regx 0x64]

$C$DW$370	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$370, DW_AT_name("CMSG")
	.dwattr $C$DW$370, DW_AT_location[DW_OP_regx 0x65]

$C$DW$371	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$371, DW_AT_name("DT_DMA_ADDR")
	.dwattr $C$DW$371, DW_AT_location[DW_OP_regx 0x66]

$C$DW$372	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$372, DW_AT_name("DT_DMA_DATA")
	.dwattr $C$DW$372, DW_AT_location[DW_OP_regx 0x67]

$C$DW$373	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$373, DW_AT_name("DT_DMA_CNTL")
	.dwattr $C$DW$373, DW_AT_location[DW_OP_regx 0x68]

$C$DW$374	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$374, DW_AT_name("TCU_CNTL")
	.dwattr $C$DW$374, DW_AT_location[DW_OP_regx 0x69]

$C$DW$375	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$375, DW_AT_name("RTDX_REC_CNTL")
	.dwattr $C$DW$375, DW_AT_location[DW_OP_regx 0x6a]

$C$DW$376	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$376, DW_AT_name("RTDX_XMT_CNTL")
	.dwattr $C$DW$376, DW_AT_location[DW_OP_regx 0x6b]

$C$DW$377	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$377, DW_AT_name("RTDX_CFG")
	.dwattr $C$DW$377, DW_AT_location[DW_OP_regx 0x6c]

$C$DW$378	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$378, DW_AT_name("RTDX_RDATA")
	.dwattr $C$DW$378, DW_AT_location[DW_OP_regx 0x6d]

$C$DW$379	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$379, DW_AT_name("RTDX_WDATA")
	.dwattr $C$DW$379, DW_AT_location[DW_OP_regx 0x6e]

$C$DW$380	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$380, DW_AT_name("RTDX_RADDR")
	.dwattr $C$DW$380, DW_AT_location[DW_OP_regx 0x6f]

$C$DW$381	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$381, DW_AT_name("RTDX_WADDR")
	.dwattr $C$DW$381, DW_AT_location[DW_OP_regx 0x70]

$C$DW$382	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$382, DW_AT_name("MFREG0")
	.dwattr $C$DW$382, DW_AT_location[DW_OP_regx 0x71]

$C$DW$383	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$383, DW_AT_name("DBG_STAT")
	.dwattr $C$DW$383, DW_AT_location[DW_OP_regx 0x72]

$C$DW$384	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$384, DW_AT_name("BRK_EN")
	.dwattr $C$DW$384, DW_AT_location[DW_OP_regx 0x73]

$C$DW$385	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$385, DW_AT_name("HWBP0_CNT")
	.dwattr $C$DW$385, DW_AT_location[DW_OP_regx 0x74]

$C$DW$386	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$386, DW_AT_name("HWBP0")
	.dwattr $C$DW$386, DW_AT_location[DW_OP_regx 0x75]

$C$DW$387	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$387, DW_AT_name("HWBP1")
	.dwattr $C$DW$387, DW_AT_location[DW_OP_regx 0x76]

$C$DW$388	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$388, DW_AT_name("HWBP2")
	.dwattr $C$DW$388, DW_AT_location[DW_OP_regx 0x77]

$C$DW$389	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$389, DW_AT_name("HWBP3")
	.dwattr $C$DW$389, DW_AT_location[DW_OP_regx 0x78]

$C$DW$390	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$390, DW_AT_name("OVERLAY")
	.dwattr $C$DW$390, DW_AT_location[DW_OP_regx 0x79]

$C$DW$391	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$391, DW_AT_name("PC_PROF")
	.dwattr $C$DW$391, DW_AT_location[DW_OP_regx 0x7a]

$C$DW$392	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$392, DW_AT_name("ATSR")
	.dwattr $C$DW$392, DW_AT_location[DW_OP_regx 0x7b]

$C$DW$393	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$393, DW_AT_name("TRR")
	.dwattr $C$DW$393, DW_AT_location[DW_OP_regx 0x7c]

$C$DW$394	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$394, DW_AT_name("TCRR")
	.dwattr $C$DW$394, DW_AT_location[DW_OP_regx 0x7d]

$C$DW$395	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$395, DW_AT_name("DESR")
	.dwattr $C$DW$395, DW_AT_location[DW_OP_regx 0x7e]

$C$DW$396	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$396, DW_AT_name("DETR")
	.dwattr $C$DW$396, DW_AT_location[DW_OP_regx 0x7f]

	.dwendtag $C$DW$CU

