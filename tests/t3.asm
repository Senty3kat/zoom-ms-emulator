;******************************************************************************
;* TMS320C6x G3 C/C++ Codegen                                                PC v8.5.0.LTS *
;* Date/Time created: Tue Oct 27 04:37:43 2026                                *
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
	.dwattr $C$DW$CU, DW_AT_name("t3.c")
	.dwattr $C$DW$CU, DW_AT_producer("TI TMS320C6x G3 C/C++ Codegen PC v8.5.0.LTS Copyright (c) 1996-2018 Texas Instruments Incorporated")
	.dwattr $C$DW$CU, DW_AT_TI_version(0x01)
	.dwattr $C$DW$CU, DW_AT_comp_dir("tests")
	.global	results
	.farcommon	results,8000,8
$C$DW$1	.dwtag  DW_TAG_variable
	.dwattr $C$DW$1, DW_AT_name("results")
	.dwattr $C$DW$1, DW_AT_TI_symbol_name("results")
	.dwattr $C$DW$1, DW_AT_location[DW_OP_addr results]
	.dwattr $C$DW$1, DW_AT_type(*$C$DW$T$136)
	.dwattr $C$DW$1, DW_AT_external
	.dwattr $C$DW$1, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$1, DW_AT_decl_line(0x07)
	.dwattr $C$DW$1, DW_AT_decl_column(0x0a)

	.bss	ri,4,4
$C$DW$2	.dwtag  DW_TAG_variable
	.dwattr $C$DW$2, DW_AT_name("restrict int")
	.dwattr $C$DW$2, DW_AT_TI_symbol_name("ri")
	.dwattr $C$DW$2, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$2, DW_AT_location[DW_OP_addr ri]
	.dwattr $C$DW$2, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$2, DW_AT_decl_line(0x08)
	.dwattr $C$DW$2, DW_AT_decl_column(0x0c)

	.global	xa
	.farcommon	xa,256,8
$C$DW$3	.dwtag  DW_TAG_variable
	.dwattr $C$DW$3, DW_AT_name("xa")
	.dwattr $C$DW$3, DW_AT_TI_symbol_name("xa")
	.dwattr $C$DW$3, DW_AT_location[DW_OP_addr xa]
	.dwattr $C$DW$3, DW_AT_type(*$C$DW$T$184)
	.dwattr $C$DW$3, DW_AT_external
	.dwattr $C$DW$3, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$3, DW_AT_decl_line(0x0c)
	.dwattr $C$DW$3, DW_AT_decl_column(0x07)

	.global	xb
	.farcommon	xb,256,8
$C$DW$4	.dwtag  DW_TAG_variable
	.dwattr $C$DW$4, DW_AT_name("xb")
	.dwattr $C$DW$4, DW_AT_TI_symbol_name("xb")
	.dwattr $C$DW$4, DW_AT_location[DW_OP_addr xb]
	.dwattr $C$DW$4, DW_AT_type(*$C$DW$T$184)
	.dwattr $C$DW$4, DW_AT_external
	.dwattr $C$DW$4, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$4, DW_AT_decl_line(0x0c)
	.dwattr $C$DW$4, DW_AT_decl_column(0x0f)

	.global	xc
	.farcommon	xc,256,8
$C$DW$5	.dwtag  DW_TAG_variable
	.dwattr $C$DW$5, DW_AT_name("xc")
	.dwattr $C$DW$5, DW_AT_TI_symbol_name("xc")
	.dwattr $C$DW$5, DW_AT_location[DW_OP_addr xc]
	.dwattr $C$DW$5, DW_AT_type(*$C$DW$T$184)
	.dwattr $C$DW$5, DW_AT_external
	.dwattr $C$DW$5, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$5, DW_AT_decl_line(0x0c)
	.dwattr $C$DW$5, DW_AT_decl_column(0x17)

	.global	ia
	.farcommon	ia,256,8
$C$DW$6	.dwtag  DW_TAG_variable
	.dwattr $C$DW$6, DW_AT_name("ia")
	.dwattr $C$DW$6, DW_AT_TI_symbol_name("ia")
	.dwattr $C$DW$6, DW_AT_location[DW_OP_addr ia]
	.dwattr $C$DW$6, DW_AT_type(*$C$DW$T$99)
	.dwattr $C$DW$6, DW_AT_external
	.dwattr $C$DW$6, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$6, DW_AT_decl_line(0x0d)
	.dwattr $C$DW$6, DW_AT_decl_column(0x05)

	.global	ib
	.farcommon	ib,256,8
$C$DW$7	.dwtag  DW_TAG_variable
	.dwattr $C$DW$7, DW_AT_name("ib")
	.dwattr $C$DW$7, DW_AT_TI_symbol_name("ib")
	.dwattr $C$DW$7, DW_AT_location[DW_OP_addr ib]
	.dwattr $C$DW$7, DW_AT_type(*$C$DW$T$99)
	.dwattr $C$DW$7, DW_AT_external
	.dwattr $C$DW$7, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$7, DW_AT_decl_line(0x0d)
	.dwattr $C$DW$7, DW_AT_decl_column(0x0d)

	.global	sa
	.farcommon	sa,128,8
$C$DW$8	.dwtag  DW_TAG_variable
	.dwattr $C$DW$8, DW_AT_name("sa")
	.dwattr $C$DW$8, DW_AT_TI_symbol_name("sa")
	.dwattr $C$DW$8, DW_AT_location[DW_OP_addr sa]
	.dwattr $C$DW$8, DW_AT_type(*$C$DW$T$72)
	.dwattr $C$DW$8, DW_AT_external
	.dwattr $C$DW$8, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$8, DW_AT_decl_line(0x0e)
	.dwattr $C$DW$8, DW_AT_decl_column(0x07)

	.global	vn
	.farcommon	vn,128,8
$C$DW$9	.dwtag  DW_TAG_variable
	.dwattr $C$DW$9, DW_AT_name("vn")
	.dwattr $C$DW$9, DW_AT_TI_symbol_name("vn")
	.dwattr $C$DW$9, DW_AT_location[DW_OP_addr vn]
	.dwattr $C$DW$9, DW_AT_type(*$C$DW$T$101)
	.dwattr $C$DW$9, DW_AT_external
	.dwattr $C$DW$9, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$9, DW_AT_decl_line(0x0f)
	.dwattr $C$DW$9, DW_AT_decl_column(0x0e)

	.sect	".const:$P$T0$1"
	.align	8
	.elfsym	$P$T0$1,SYM_SIZE(8)
$P$T0$1:
	.word	03c23d70ah		; $P$T0$1[0] @ 0
	.word	0bca3d70ah		; $P$T0$1[1] @ 32

$C$DW$10	.dwtag  DW_TAG_variable
	.dwattr $C$DW$10, DW_AT_name("$P$T0$1")
	.dwattr $C$DW$10, DW_AT_TI_symbol_name("$P$T0$1")
	.dwattr $C$DW$10, DW_AT_type(*$C$DW$T$181)
	.dwattr $C$DW$10, DW_AT_location[DW_OP_addr $P$T0$1]
	.dwattr $C$DW$10, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$10, DW_AT_decl_line(0x6c)
	.dwattr $C$DW$10, DW_AT_decl_column(0x0f)


$C$DW$11	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$11, DW_AT_name("memset")
	.dwattr $C$DW$11, DW_AT_TI_symbol_name("memset")
	.dwattr $C$DW$11, DW_AT_type(*$C$DW$T$3)
	.dwattr $C$DW$11, DW_AT_declaration
	.dwattr $C$DW$11, DW_AT_external
	.dwattr $C$DW$11, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h")
	.dwattr $C$DW$11, DW_AT_decl_line(0x88)
	.dwattr $C$DW$11, DW_AT_decl_column(0x16)
$C$DW$12	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$12, DW_AT_type(*$C$DW$T$3)

$C$DW$13	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$13, DW_AT_type(*$C$DW$T$10)

$C$DW$14	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$14, DW_AT_type(*$C$DW$T$34)

	.dwendtag $C$DW$11

	.sect	".text"
	.clink

$C$DW$15	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$15, DW_AT_name("put")
	.dwattr $C$DW$15, DW_AT_low_pc(put)
	.dwattr $C$DW$15, DW_AT_high_pc(0x00)
	.dwattr $C$DW$15, DW_AT_TI_symbol_name("put")
	.dwattr $C$DW$15, DW_AT_TI_begin_file("t3.c")
	.dwattr $C$DW$15, DW_AT_TI_begin_line(0x09)
	.dwattr $C$DW$15, DW_AT_TI_begin_column(0x0d)
	.dwattr $C$DW$15, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$15, DW_AT_decl_line(0x09)
	.dwattr $C$DW$15, DW_AT_decl_column(0x0d)
	.dwattr $C$DW$15, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t3.c",line 9,column 29,is_stmt,address put,isa 0

	.dwfde $C$DW$CIE, put
$C$DW$16	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$16, DW_AT_name("v")
	.dwattr $C$DW$16, DW_AT_TI_symbol_name("v")
	.dwattr $C$DW$16, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$16, DW_AT_location[DW_OP_reg4]


;******************************************************************************
;* FUNCTION NAME: put                                                         *
;*                                                                            *
;*   Regs Modified     : A0,A3,B4,B5,B6                                       *
;*   Regs Used         : A0,A3,A4,B3,B4,B5,B6,DP                              *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
put:
;** --------------------------------------------------------------------------*
$C$DW$17	.dwtag  DW_TAG_variable
	.dwattr $C$DW$17, DW_AT_name("v")
	.dwattr $C$DW$17, DW_AT_TI_symbol_name("v")
	.dwattr $C$DW$17, DW_AT_type(*$C$DW$T$134)
	.dwattr $C$DW$17, DW_AT_location[DW_OP_reg4]

	.dwcfi	cfa_offset, 0
	.dwpsn	file "t3.c",line 9,column 31,is_stmt,isa 0
           LDW     .D2T2   *+DP(ri),B4       ; [B_D64P] |9| 
           MVK     .S1     2000,A3           ; [A_S674] |9| 
	.dwpsn	file "t3.c",line 9,column 62,is_stmt,isa 0
$C$DW$18	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$18, DW_AT_low_pc(0x00)
	.dwattr $C$DW$18, DW_AT_TI_return

           RETNOP          B3,2              ; [] |9| 
	.dwpsn	file "t3.c",line 9,column 31,is_stmt,isa 0

           MVKL    .S2     results,B6        ; [B_Sb674] |9| 
||         CMPLT   .L1X    B4,A3,A0          ; [A_L674] |9| 
||         ADD     .L2     1,B4,B5           ; [B_L674] |9| 

	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0

           MVKH    .S2     results,B6        ; [B_Sb674] |9| 
|| [ A0]   STW     .D2T2   B5,*+DP(ri)       ; [B_D64P] |9| 

   [ A0]   STW     .D2T1   A4,*+B6[B4]       ; [B_D64P] |9| 
	.dwpsn	file "t3.c",line 9,column 62,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |9| 
	.dwattr $C$DW$15, DW_AT_TI_end_file("t3.c")
	.dwattr $C$DW$15, DW_AT_TI_end_line(0x09)
	.dwattr $C$DW$15, DW_AT_TI_end_column(0x3e)
	.dwendentry
	.dwendtag $C$DW$15

;**	Parameter deleted: b == &xb;
;**	Parameter deleted: a == &xa;
	.sect	".text"
	.clink

$C$DW$19	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$19, DW_AT_name("fmac")
	.dwattr $C$DW$19, DW_AT_low_pc(fmac)
	.dwattr $C$DW$19, DW_AT_high_pc(0x00)
	.dwattr $C$DW$19, DW_AT_TI_symbol_name("fmac")
	.dwattr $C$DW$19, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$19, DW_AT_TI_begin_file("t3.c")
	.dwattr $C$DW$19, DW_AT_TI_begin_line(0x12)
	.dwattr $C$DW$19, DW_AT_TI_begin_column(0x0e)
	.dwattr $C$DW$19, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$19, DW_AT_decl_line(0x12)
	.dwattr $C$DW$19, DW_AT_decl_column(0x0e)
	.dwattr $C$DW$19, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t3.c",line 19,column 1,is_stmt,address fmac,isa 0

	.dwfde $C$DW$CIE, fmac
$C$DW$20	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$20, DW_AT_name("n")
	.dwattr $C$DW$20, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$20, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$20, DW_AT_location[DW_OP_reg4]


;******************************************************************************
;* FUNCTION NAME: fmac                                                        *
;*                                                                            *
;*   Regs Modified     : A0,A3,A4,A5,A6,B4,B5,B6                              *
;*   Regs Used         : A0,A3,A4,A5,A6,B3,B4,B5,B6                           *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
fmac:
;** --------------------------------------------------------------------------*
$C$DW$21	.dwtag  DW_TAG_variable
	.dwattr $C$DW$21, DW_AT_name("n")
	.dwattr $C$DW$21, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$21, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$21, DW_AT_location[DW_OP_reg4]

$C$DW$22	.dwtag  DW_TAG_variable
	.dwattr $C$DW$22, DW_AT_name("s")
	.dwattr $C$DW$22, DW_AT_TI_symbol_name("s")
	.dwattr $C$DW$22, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$22, DW_AT_location[DW_OP_reg5]

	.dwcfi	cfa_offset, 0
	.dwpsn	file "t3.c",line 20,column 13,is_stmt,isa 0

           MVKL    .S2     xa,B5             ; [B_Sb674] 
||         ZERO    .S1     A5                ; [A_S674] |20| 
||         CMPGT   .L1     A4,0,A0           ; [A_L674] |22| 

	.dwpsn	file "t3.c",line 22,column 17,is_stmt,isa 0

   [!A0]   BNOP            $C$L4,1           ; [] |22| 
|| [ A0]   SUB     .L2X    A4,1,B6           ; [B_L674] 

   [ A0]   MVC     .S2     B6,ILC            ; [B_Sb674] 
           MVKH    .S2     xa,B5             ; [B_Sb674] 
           MVKL    .S1     xb,A6             ; [A_S674] 
           MVKH    .S1     xb,A6             ; [A_S674] 
           ; BRANCHCC OCCURS {$C$L4}         ; [] |22| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 22
;*    Loop opening brace source line   : 22
;*    Loop closing brace source line   : 22
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 4 due to a loop-carried dependence.
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Maximum Iteration Count    : 64
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound(^) : 4
;*    Partitioned Resource Bound(*)    : 1
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     0        0     
;*      .D units                     1*       1*    
;*      .M units                     1*       0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           1        0     (.L or .S unit)
;*      Addition ops (.LSD)          0        0     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1*       0     
;*      Bound(.L .S .D .LS .LSD)     1*       1*    
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 4  Schedule found with 3 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C53:
;*   0              LDW     .D2T2   *B5++(4),B4       ; [B_D64P] |22| 
;*     ||           LDW     .D1T1   *A6++(4),A4       ; [A_D64P] |22| 
;*   1              NOP     4       ; [A_L674] 
;*   5              MPYSP   .M1X    A4,B4,A3          ; [A_M674] |22| 
;*   6              NOP     3       ; [A_L674] 
;*   9              ADDSP   .L1     A3,A5,A5          ; [A_L674] |22|  ^ 
;*     ||           SPBR                              $C$C53 ; [] 
;*  10              NOP     2       ; [A_L674] 
;*  12              ; BRANCHCC OCCURS {$C$C53}        ; [] |22| 
;*----------------------------------------------------------------------------*
$C$L1:    ; PIPED LOOP PROLOG
           SPLOOPD         4                 ;12 ; [A_L674] (P) 
;** --------------------------------------------------------------------------*
$C$L2:    ; PIPED LOOP KERNEL
	.dwpsn	file "t3.c",line 22,column 29,is_stmt,isa 0

           LDW     .D2T2   *B5++(4),B4       ; [B_D64P] |22| (P) <0,0> 
||         LDW     .D1T1   *A6++(4),A4       ; [A_D64P] |22| (P) <0,0> 

           NOP             4                 ; [A_L674] 
           MPYSP   .M1X    A4,B4,A3          ; [A_M674] |22| (P) <0,5> 
           NOP             2                 ; [A_L674] 
           NOP             1                 ; [A_L674] 

           SPKERNEL        1,0               ; [] 
||         ADDSP   .L1     A3,A5,A5          ; [A_L674] |22| <0,9>  ^ 

;** --------------------------------------------------------------------------*
$C$L3:    ; PIPED LOOP EPILOG
           NOP             2                 ; [A_L674] 
;** --------------------------------------------------------------------------*
$C$L4:    
	.dwpsn	file "t3.c",line 24,column 1,is_stmt,isa 0
$C$DW$23	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$23, DW_AT_low_pc(0x00)
	.dwattr $C$DW$23, DW_AT_TI_return

           RETNOP          B3,4              ; [] |24| 
	.dwpsn	file "t3.c",line 23,column 5,is_stmt,isa 0
           MV      .L1     A5,A4             ; [A_L674] |23| 
	.dwpsn	file "t3.c",line 24,column 1,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |24| 
	.dwattr $C$DW$19, DW_AT_TI_end_file("t3.c")
	.dwattr $C$DW$19, DW_AT_TI_end_line(0x18)
	.dwattr $C$DW$19, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$19

;**	Parameter deleted: g == 0.75F;
;**	Parameter deleted: a == &xa;
;**	Parameter deleted: d == &xc;
	.sect	".text"
	.clink

$C$DW$24	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$24, DW_AT_name("fscale")
	.dwattr $C$DW$24, DW_AT_low_pc(fscale)
	.dwattr $C$DW$24, DW_AT_high_pc(0x00)
	.dwattr $C$DW$24, DW_AT_TI_symbol_name("fscale")
	.dwattr $C$DW$24, DW_AT_TI_begin_file("t3.c")
	.dwattr $C$DW$24, DW_AT_TI_begin_line(0x1b)
	.dwattr $C$DW$24, DW_AT_TI_begin_column(0x0d)
	.dwattr $C$DW$24, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$24, DW_AT_decl_line(0x1b)
	.dwattr $C$DW$24, DW_AT_decl_column(0x0d)
	.dwattr $C$DW$24, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t3.c",line 28,column 1,is_stmt,address fscale,isa 0

	.dwfde $C$DW$CIE, fscale
$C$DW$25	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$25, DW_AT_name("n")
	.dwattr $C$DW$25, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$25, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$25, DW_AT_location[DW_OP_reg4]


;******************************************************************************
;* FUNCTION NAME: fscale                                                      *
;*                                                                            *
;*   Regs Modified     : A0,A3,A4,A5,A6,A7,B4,B5,B6,B7                        *
;*   Regs Used         : A0,A3,A4,A5,A6,A7,B3,B4,B5,B6,B7                     *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
fscale:
;** --------------------------------------------------------------------------*
$C$DW$26	.dwtag  DW_TAG_variable
	.dwattr $C$DW$26, DW_AT_name("n")
	.dwattr $C$DW$26, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$26, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$26, DW_AT_location[DW_OP_reg4]

	.dwcfi	cfa_offset, 0
	.dwpsn	file "t3.c",line 30,column 17,is_stmt,isa 0

           CMPGT   .L1     A4,0,A0           ; [A_L674] |30| 
||         MVKL    .S2     xc,B6             ; [B_Sb674] 
||         ZERO    .S1     A7                ; [A_S674] 
||         ZERO    .L2     B4                ; [B_L674] 

   [!A0]   B       .S1     $C$L8             ; [A_S674] |30| 
|| [ A0]   MV      .L2X    A4,B7             ; [B_L674] 
||         MVKL    .S2     xa,B5             ; [B_Sb674] 

   [ A0]   MVC     .S2     B7,ILC            ; [B_Sb674] 
           MVKH    .S2     xc,B6             ; [B_Sb674] 
           MVKH    .S2     xa,B5             ; [B_Sb674] 
           MVKH    .S1     0x3e800000,A7     ; [A_S674] 
           MVKH    .S2     0x3f400000,B4     ; [B_Sb674] 
           ; BRANCHCC OCCURS {$C$L8}         ; [] |30| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 30
;*    Loop opening brace source line   : 30
;*    Loop closing brace source line   : 30
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound    : 0
;*    Partitioned Resource Bound(*)    : 1
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     0        0     
;*      .D units                     1*       1*    
;*      .M units                     1*       0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           1        0     (.L or .S unit)
;*      Addition ops (.LSD)          0        0     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1*       0     
;*      Bound(.L .S .D .LS .LSD)     1*       1*    
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 1  Schedule found with 14 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C169:
;*   0              LDW     .D2T2   *B5++(4),B4       ; [B_D64P] |30| 
;*   1              NOP     4       ; [A_L674] 
;*   5              MPYSP   .M1X    A6,B4,A4          ; [A_M674] |30| 
;*   6              NOP     3       ; [A_L674] 
;*   9              ADDSP   .L1     A7,A4,A3          ; [A_L674] |30| 
;*  10              NOP     3       ; [A_L674] 
;*  13              STW     .D1T1   A3,*A5++(4)       ; [A_D64P] |30| 
;*     ||           SPBR                              $C$C169 ; [] 
;*  14              ; BRANCHCC OCCURS {$C$C169}       ; [] |30| 
;*----------------------------------------------------------------------------*
$C$L5:    ; PIPED LOOP PROLOG
           SPLOOP          1                 ;14 ; [A_L674] (P) 
;** --------------------------------------------------------------------------*
$C$L6:    ; PIPED LOOP KERNEL
	.dwpsn	file "t3.c",line 30,column 29,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MV      .L1X    B4,A6             ; [A_L674] 
||         LDW     .D2T2   *B5++(4),B4       ; [B_D64P] |30| (P) <0,0> 

           NOP             3                 ; [A_L674] 

           SPMASK                            ; [] 
||^        MV      .L1X    B6,A5             ; [A_L674] 

           MPYSP   .M1X    A6,B4,A4          ; [A_M674] |30| (P) <0,5> 
           NOP             3                 ; [A_L674] 
           ADDSP   .L1     A7,A4,A3          ; [A_L674] |30| (P) <0,9> 
           NOP             2                 ; [A_L674] 
           NOP             1                 ; [A_L674] 

           SPKERNEL        13,0              ; [] 
||         STW     .D1T1   A3,*A5++(4)       ; [A_D64P] |30| <0,13> 

;** --------------------------------------------------------------------------*
$C$L7:    ; PIPED LOOP EPILOG
;** --------------------------------------------------------------------------*
$C$L8:    
	.dwpsn	file "t3.c",line 31,column 1,is_stmt,isa 0
$C$DW$27	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$27, DW_AT_low_pc(0x00)
	.dwattr $C$DW$27, DW_AT_TI_return

           RETNOP          B3,5              ; [] |31| 
           ; BRANCH OCCURS {B3}              ; [] |31| 
	.dwattr $C$DW$24, DW_AT_TI_end_file("t3.c")
	.dwattr $C$DW$24, DW_AT_TI_end_line(0x1f)
	.dwattr $C$DW$24, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$24

;**	Parameter deleted: x == &xa;
;**	Parameter deleted: y == &xc;
	.sect	".text"
	.clink

$C$DW$28	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$28, DW_AT_name("fbiquad")
	.dwattr $C$DW$28, DW_AT_low_pc(fbiquad)
	.dwattr $C$DW$28, DW_AT_high_pc(0x00)
	.dwattr $C$DW$28, DW_AT_TI_symbol_name("fbiquad")
	.dwattr $C$DW$28, DW_AT_TI_begin_file("t3.c")
	.dwattr $C$DW$28, DW_AT_TI_begin_line(0x22)
	.dwattr $C$DW$28, DW_AT_TI_begin_column(0x0d)
	.dwattr $C$DW$28, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$28, DW_AT_decl_line(0x22)
	.dwattr $C$DW$28, DW_AT_decl_column(0x0d)
	.dwattr $C$DW$28, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t3.c",line 35,column 1,is_stmt,address fbiquad,isa 0

	.dwfde $C$DW$CIE, fbiquad
$C$DW$29	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$29, DW_AT_name("n")
	.dwattr $C$DW$29, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$29, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$29, DW_AT_location[DW_OP_reg4]

$C$DW$30	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$30, DW_AT_name("st")
	.dwattr $C$DW$30, DW_AT_TI_symbol_name("st")
	.dwattr $C$DW$30, DW_AT_type(*$C$DW$T$41)
	.dwattr $C$DW$30, DW_AT_location[DW_OP_reg20]


;******************************************************************************
;* FUNCTION NAME: fbiquad                                                     *
;*                                                                            *
;*   Regs Modified     : A0,A3,A4,A5,A6,A7,A8,A9,A16,B0,B4,B5,B6,B7,B8        *
;*   Regs Used         : A0,A3,A4,A5,A6,A7,A8,A9,A16,B0,B3,B4,B5,B6,B7,B8,DP, *
;*                           SP                                               *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
fbiquad:
;** --------------------------------------------------------------------------*
$C$DW$31	.dwtag  DW_TAG_variable
	.dwattr $C$DW$31, DW_AT_name("st")
	.dwattr $C$DW$31, DW_AT_TI_symbol_name("st")
	.dwattr $C$DW$31, DW_AT_type(*$C$DW$T$179)
	.dwattr $C$DW$31, DW_AT_location[DW_OP_reg24]

$C$DW$32	.dwtag  DW_TAG_variable
	.dwattr $C$DW$32, DW_AT_name("z1")
	.dwattr $C$DW$32, DW_AT_TI_symbol_name("z1")
	.dwattr $C$DW$32, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$32, DW_AT_location[DW_OP_reg8]

$C$DW$33	.dwtag  DW_TAG_variable
	.dwattr $C$DW$33, DW_AT_name("z2")
	.dwattr $C$DW$33, DW_AT_TI_symbol_name("z2")
	.dwattr $C$DW$33, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$33, DW_AT_location[DW_OP_reg7]

$C$DW$34	.dwtag  DW_TAG_variable
	.dwattr $C$DW$34, DW_AT_name("o")
	.dwattr $C$DW$34, DW_AT_TI_symbol_name("o")
	.dwattr $C$DW$34, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$34, DW_AT_location[DW_OP_reg3]

	.dwcfi	cfa_offset, 0

           CMPGT   .L1     A4,0,A0           ; [A_L674] |39| 
||         MV      .L2     B4,B8             ; [B_L674] |35| 
||         MVKL    .S2     xc,B6             ; [B_Sb674] 
||         MVKL    .S1     0x3ecccccd,A8     ; [A_S674] 
||         ZERO    .D2     B5                ; [B_D64P] 

	.dwpsn	file "t3.c",line 37,column 14,is_stmt,isa 0

   [!A0]   B       .S1     $C$L12            ; [A_S674] |39| 
||         LDDW    .D2T1   *B8(0),A7:A6      ; [B_D64P] |37| 
||         MVKH    .S2     xc,B6             ; [B_Sb674] 

           MVKH    .S1     0x3ecccccd,A8     ; [A_S674] 
||         MVKL    .S2     0x3e4ccccd,B4     ; [B_Sb674] 

           MVKL    .S1     0x3dcccccd,A3     ; [A_S674] 
||         MV      .L1     A8,A16            ; [A_L674] 
||         MV      .D1X    B6,A9             ; [A_D64P] 
||         MVKH    .S2     0x3e4ccccd,B4     ; [B_Sb674] 

           MVKL    .S1     xa,A5             ; [A_S674] 
||         MVKH    .S2     0xbf000000,B5     ; [B_Sb674] 

           MVKH    .S1     0x3dcccccd,A3     ; [A_S674] 

           MV      .L1     A6,A8             ; [A_L674] |37| 
||         MVKH    .S1     xa,A5             ; [A_S674] 

	.dwpsn	file "t3.c",line 39,column 17,is_stmt,isa 0
           ; BRANCHCC OCCURS {$C$L12}        ; [] |39| 
;** --------------------------------------------------------------------------*

           SUB     .L2X    A4,1,B0           ; [B_L674] 
||         MV      .L1X    B5,A4             ; [A_L674] 
||         MVK     .S1     1,A0              ; [A_S674] init prolog collapse predicate
||         DINT                               ; [B_Sb674] interrupts off

           MV      .L2X    A9,B5             ; [B_L674] 
||         MV      .L1X    B4,A6             ; [A_L674] 

           MV      .L2X    A16,B7            ; [B_L674] 
           MV      .L2X    A3,B6             ; [B_L674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 39
;*    Loop opening brace source line   : 39
;*    Loop closing brace source line   : 44
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 16 due to a loop-carried dependence.
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound(^) : 16
;*    Partitioned Resource Bound(*)    : 2
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     0        1     
;*      .D units                     1        1     
;*      .M units                     2*       2*    
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           4        0     (.L or .S unit)
;*      Addition ops (.LSD)          0        0     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             2*       1     
;*      Bound(.L .S .D .LS .LSD)     2*       1     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 16 Schedule found with 2 iterations in parallel
;*    Done
;*
;*    Minimum required memory pad   : 0 bytes
;*
;*    For further improvement on this loop, try option -mh4
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*     SETUP CODE
;*
;*                SUB     B0,1,B0 ; [] 
;*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C317:
;*   0              LDW     .D1T1   *A5++(4),A9       ; [A_D64P] |40| 
;*   1              NOP     4       ; [A_L674] 
;*   5              MPYSP   .M1     A6,A9,A9          ; [A_M674] |40| 
;*     ||           MPYSP   .M2X    B7,A9,B4          ; [B_M674] |41| 
;*   6              NOP     3       ; [A_L674] 
;*   9              ADDSP   .L1     A8,A9,A3          ; [A_L674] |40|  ^ 
;*  10              NOP     3       ; [A_L674] 
;*  13              MPYSP   .M1     A4,A3,A3          ; [A_M674] |41|  ^ 
;*     ||           STW     .D2T1   A3,*B5++(4)       ; [B_D64P] |43| 
;*  14              MPYSP   .M2X    B6,A3,B4          ; [B_M674] |42| 
;*  15              NOP     2       ; [A_L674] 
;*  17              SUBSP   .L1X    B4,A3,A3          ; [A_L674] |41|  ^ 
;*  18              NOP     1       ; [A_L674] 
;*  19              SUBSP   .L1X    A9,B4,A7          ; [A_L674] |42| 
;*     ||   [ B0]   BDEC    .S2     $C$C317,B0        ; [B_Sb674] |39| 
;*  20              NOP     1       ; [A_L674] 
;*  21              ADDSP   .L1     A7,A3,A8          ; [A_L674] |41|  ^ 
;*  22              NOP     3       ; [A_L674] 
;*  25              ; BRANCHCC OCCURS {$C$C317}       ; [] |39| 
;*----------------------------------------------------------------------------*
$C$L9:    ; PIPED LOOP PROLOG
;** --------------------------------------------------------------------------*
$C$L10:    ; PIPED LOOP KERNEL
	.dwpsn	file "t3.c",line 40,column 17,is_stmt,isa 0
           ADDSP   .L1     A8,A9,A3          ; [A_L674] |40| <0,9>  ^ 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t3.c",line 41,column 9,is_stmt,isa 0

   [!A0]   STW     .D2T1   A3,*B5++(4)       ; [B_D64P] |43| <0,13> 
||         MPYSP   .M1     A4,A3,A3          ; [A_M674] |41| <0,13>  ^ 

	.dwpsn	file "t3.c",line 42,column 9,is_stmt,isa 0
           MPYSP   .M2X    B6,A3,B4          ; [B_M674] |42| <0,14> 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t3.c",line 40,column 17,is_stmt,isa 0
           LDW     .D1T1   *A5++(4),A9       ; [A_D64P] |40| <1,0> 
	.dwpsn	file "t3.c",line 41,column 9,is_stmt,isa 0
           SUBSP   .L1X    B4,A3,A3          ; [A_L674] |41| <0,17>  ^ 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t3.c",line 39,column 17,is_stmt,isa 0

   [!A0]   SUBSP   .L1X    A9,B4,A7          ; [A_L674] |42| <0,19> 
|| [ B0]   BDEC    .S2     $C$L10,B0         ; [B_Sb674] |39| <0,19> 

           NOP             1                 ; [A_L674] 
	.dwpsn	file "t3.c",line 40,column 17,is_stmt,isa 0

   [!A0]   ADDSP   .L1     A7,A3,A8          ; [A_L674] |41| <0,21>  ^ 
||         MPYSP   .M2X    B7,A9,B4          ; [B_M674] |41| <1,5> 
||         MPYSP   .M1     A6,A9,A9          ; [A_M674] |40| <1,5> 

           NOP             2                 ; [A_L674] 
   [ A0]   SUB     .S1     A0,1,A0           ; [A_S674] <0,24> 
;** --------------------------------------------------------------------------*
$C$L11:    ; PIPED LOOP EPILOG
           ADDSP   .L1     A8,A9,A3          ; [A_L674] |40| (E) <1,9>  ^ 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t3.c",line 41,column 9,is_stmt,isa 0

           STW     .D2T1   A3,*B5++(4)       ; [B_D64P] |43| (E) <1,13> 
||         MPYSP   .M1     A4,A3,A3          ; [A_M674] |41| (E) <1,13>  ^ 

	.dwpsn	file "t3.c",line 42,column 9,is_stmt,isa 0
           MPYSP   .M2X    B6,A3,B4          ; [B_M674] |42| (E) <1,14> 
           NOP             2                 ; [A_L674] 
	.dwpsn	file "t3.c",line 41,column 9,is_stmt,isa 0
           SUBSP   .L1X    B4,A3,A3          ; [A_L674] |41| (E) <1,17>  ^ 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t3.c",line 42,column 9,is_stmt,isa 0
           SUBSP   .L1X    A9,B4,A7          ; [A_L674] |42| (E) <1,19> 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t3.c",line 41,column 9,is_stmt,isa 0
           ADDSP   .L1     A7,A3,A8          ; [A_L674] |41| (E) <1,21>  ^ 
;** --------------------------------------------------------------------------*
           RINT                               ; [B_Sb674] interrupts on
           NOP             2                 ; [A_L674] 
;** --------------------------------------------------------------------------*
$C$L12:    
	.dwpsn	file "t3.c",line 46,column 1,is_stmt,isa 0
$C$DW$35	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$35, DW_AT_low_pc(0x00)
	.dwattr $C$DW$35, DW_AT_TI_return

           RETNOP          B3,3              ; [] |46| 
	.dwpsn	file "t3.c",line 45,column 17,is_stmt,isa 0
           MV      .L1     A8,A6             ; [A_L674] |45| 
           STNDW   .D2T1   A7:A6,*B8(0)      ; [B_D64P] |45| 
	.dwpsn	file "t3.c",line 46,column 1,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |46| 
	.dwattr $C$DW$28, DW_AT_TI_end_file("t3.c")
	.dwattr $C$DW$28, DW_AT_TI_end_line(0x2e)
	.dwattr $C$DW$28, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$28

;**	Parameter deleted: a == &ia;
	.sect	".text"
	.clink

$C$DW$36	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$36, DW_AT_name("isum")
	.dwattr $C$DW$36, DW_AT_low_pc(isum)
	.dwattr $C$DW$36, DW_AT_high_pc(0x00)
	.dwattr $C$DW$36, DW_AT_TI_symbol_name("isum")
	.dwattr $C$DW$36, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$36, DW_AT_TI_begin_file("t3.c")
	.dwattr $C$DW$36, DW_AT_TI_begin_line(0x31)
	.dwattr $C$DW$36, DW_AT_TI_begin_column(0x0c)
	.dwattr $C$DW$36, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$36, DW_AT_decl_line(0x31)
	.dwattr $C$DW$36, DW_AT_decl_column(0x0c)
	.dwattr $C$DW$36, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t3.c",line 50,column 1,is_stmt,address isum,isa 0

	.dwfde $C$DW$CIE, isum
$C$DW$37	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$37, DW_AT_name("n")
	.dwattr $C$DW$37, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$37, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$37, DW_AT_location[DW_OP_reg4]


;******************************************************************************
;* FUNCTION NAME: isum                                                        *
;*                                                                            *
;*   Regs Modified     : A0,A3,A4,A5,A6,A7,A8,B4,B5,B6                        *
;*   Regs Used         : A0,A3,A4,A5,A6,A7,A8,B3,B4,B5,B6                     *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
isum:
;** --------------------------------------------------------------------------*
$C$DW$38	.dwtag  DW_TAG_variable
	.dwattr $C$DW$38, DW_AT_name("n")
	.dwattr $C$DW$38, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$38, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$38, DW_AT_location[DW_OP_reg4]

$C$DW$39	.dwtag  DW_TAG_variable
	.dwattr $C$DW$39, DW_AT_name("s")
	.dwattr $C$DW$39, DW_AT_TI_symbol_name("s")
	.dwattr $C$DW$39, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$39, DW_AT_location[DW_OP_reg7]

$C$DW$40	.dwtag  DW_TAG_variable
	.dwattr $C$DW$40, DW_AT_name("i")
	.dwattr $C$DW$40, DW_AT_TI_symbol_name("i")
	.dwattr $C$DW$40, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$40, DW_AT_location[DW_OP_reg21]

	.dwcfi	cfa_offset, 0
	.dwpsn	file "t3.c",line 52,column 17,is_stmt,isa 0
           CMPGT   .L1     A4,0,A0           ; [A_L674] |52| 

   [!A0]   B       .S1     $C$L16            ; [A_S674] |52| 
|| [ A0]   MV      .L2X    A4,B6             ; [B_L674] 

   [ A0]   MVC     .S2     B6,ILC            ; [B_Sb674] 
           MVKL    .S2     ia,B4             ; [B_Sb674] 
	.dwpsn	file "t3.c",line 51,column 11,is_stmt,isa 0
           ZERO    .L1     A7                ; [A_L674] |51| 
	.dwpsn	file "t3.c",line 52,column 10,is_stmt,isa 0
           MVK     .L2     3,B5              ; [B_L674] |52| 
           MVKH    .S2     ia,B4             ; [B_Sb674] 
	.dwpsn	file "t3.c",line 52,column 17,is_stmt,isa 0
           ; BRANCHCC OCCURS {$C$L16}        ; [] |52| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 52
;*    Loop opening brace source line   : 52
;*    Loop closing brace source line   : 52
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Maximum Iteration Count    : 64
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound(^) : 1
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
;*      Addition ops (.LSD)          2        0     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             0        0     
;*      Bound(.L .S .D .LS .LSD)     1*       0     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 1  Schedule found with 10 iterations in parallel
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
;*      $C$C415:
;*   0              LDW     .D1T1   *A8++(4),A3       ; [A_D64P] |52| 
;*   1              NOP     4       ; [A_L674] 
;*   5              MPYLI   .M1     A6,A3,A5:A4       ; [A_M674] |52|  ^ 
;*     ||           ADD     .L1     1,A6,A6           ; [A_L674] |52|  ^ 
;*   6              NOP     3       ; [A_L674] 
;*   9              ADD     .S1     A4,A7,A7          ; [A_S674] |52| 
;*     ||           SPBR                              $C$C415 ; [] 
;*  10              ; BRANCHCC OCCURS {$C$C415}       ; [] |52| 
;*----------------------------------------------------------------------------*
$C$L13:    ; PIPED LOOP PROLOG

           SPLOOP          1                 ;10 ; [A_L674] (P) 
||         MV      .S1X    B4,A8             ; [A_S674] 

;** --------------------------------------------------------------------------*
$C$L14:    ; PIPED LOOP KERNEL
	.dwpsn	file "t3.c",line 52,column 29,is_stmt,isa 0
           LDW     .D1T1   *A8++(4),A3       ; [A_D64P] |52| (P) <0,0> 
           NOP             3                 ; [A_L674] 

           SPMASK                            ; [] 
||^        MV      .L1X    B5,A6             ; [A_L674] 

	.dwpsn	file "t3.c",line 52,column 24,is_stmt,isa 0

           ADD     .L1     1,A6,A6           ; [A_L674] |52| (P) <0,5>  ^ 
||         MPYLI   .M1     A6,A3,A5:A4       ; [A_M674] |52| (P) <0,5>  ^ 

           NOP             2                 ; [A_L674] 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t3.c",line 52,column 29,is_stmt,isa 0

           SPKERNEL        9,0               ; [] 
||         ADD     .S1     A4,A7,A7          ; [A_S674] |52| <0,9> 

;** --------------------------------------------------------------------------*
$C$L15:    ; PIPED LOOP EPILOG
;** --------------------------------------------------------------------------*
$C$L16:    
	.dwpsn	file "t3.c",line 54,column 1,is_stmt,isa 0
$C$DW$41	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$41, DW_AT_low_pc(0x00)
	.dwattr $C$DW$41, DW_AT_TI_return

           RETNOP          B3,4              ; [] |54| 
	.dwpsn	file "t3.c",line 53,column 5,is_stmt,isa 0
           MV      .L1     A7,A4             ; [A_L674] |53| 
	.dwpsn	file "t3.c",line 54,column 1,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |54| 
	.dwattr $C$DW$36, DW_AT_TI_end_file("t3.c")
	.dwattr $C$DW$36, DW_AT_TI_end_line(0x36)
	.dwattr $C$DW$36, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$36

;**	Parameter deleted: s == &ia;
;**	Parameter deleted: d == &ib;
	.sect	".text"
	.clink

$C$DW$42	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$42, DW_AT_name("icopy")
	.dwattr $C$DW$42, DW_AT_low_pc(icopy)
	.dwattr $C$DW$42, DW_AT_high_pc(0x00)
	.dwattr $C$DW$42, DW_AT_TI_symbol_name("icopy")
	.dwattr $C$DW$42, DW_AT_TI_begin_file("t3.c")
	.dwattr $C$DW$42, DW_AT_TI_begin_line(0x39)
	.dwattr $C$DW$42, DW_AT_TI_begin_column(0x0d)
	.dwattr $C$DW$42, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$42, DW_AT_decl_line(0x39)
	.dwattr $C$DW$42, DW_AT_decl_column(0x0d)
	.dwattr $C$DW$42, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t3.c",line 58,column 1,is_stmt,address icopy,isa 0

	.dwfde $C$DW$CIE, icopy
$C$DW$43	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$43, DW_AT_name("n")
	.dwattr $C$DW$43, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$43, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$43, DW_AT_location[DW_OP_reg4]


;******************************************************************************
;* FUNCTION NAME: icopy                                                       *
;*                                                                            *
;*   Regs Modified     : A0,A3,B4,B5,B6,B7,B8                                 *
;*   Regs Used         : A0,A3,A4,B3,B4,B5,B6,B7,B8                           *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
icopy:
;** --------------------------------------------------------------------------*
$C$DW$44	.dwtag  DW_TAG_variable
	.dwattr $C$DW$44, DW_AT_name("n")
	.dwattr $C$DW$44, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$44, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$44, DW_AT_location[DW_OP_reg4]

$C$DW$45	.dwtag  DW_TAG_variable
	.dwattr $C$DW$45, DW_AT_name("i")
	.dwattr $C$DW$45, DW_AT_TI_symbol_name("i")
	.dwattr $C$DW$45, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$45, DW_AT_location[DW_OP_reg3]

	.dwcfi	cfa_offset, 0
	.dwpsn	file "t3.c",line 60,column 17,is_stmt,isa 0

           CMPGT   .L1     A4,0,A0           ; [A_L674] |60| 
||         MVKL    .S2     ib,B7             ; [B_Sb674] 

   [!A0]   B       .S1     $C$L20            ; [A_S674] |60| 
|| [ A0]   MV      .L2X    A4,B6             ; [B_L674] 

   [ A0]   MVC     .S2     B6,ILC            ; [B_Sb674] 
           MVKL    .S2     ia,B8             ; [B_Sb674] 
           MVKH    .S2     ia,B8             ; [B_Sb674] 
	.dwpsn	file "t3.c",line 60,column 10,is_stmt,isa 0
           ZERO    .L1     A3                ; [A_L674] |60| 
           MVKH    .S2     ib,B7             ; [B_Sb674] 
	.dwpsn	file "t3.c",line 60,column 17,is_stmt,isa 0
           ; BRANCHCC OCCURS {$C$L20}        ; [] |60| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 60
;*    Loop opening brace source line   : 60
;*    Loop closing brace source line   : 60
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 2 due to a resource limitation (partitioned resource bound).
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound(^) : 1
;*    Partitioned Resource Bound(*)    : 2
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     0        1     
;*      .D units                     0        2*    
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          0        2     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             0        1     
;*      Bound(.L .S .D .LS .LSD)     0        2*    
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 2  Schedule found with 4 iterations in parallel
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
;*      $C$C572:
;*   0              LDW     .D2T2   *B8++(4),B5       ; [B_D64P] |60| 
;*   1              NOP     4       ; [A_L674] 
;*   5              SHL     .S2     B6,4,B4           ; [B_Sb674] |60|  ^ 
;*   6              XOR     .L2     B4,B5,B4          ; [B_L674] |60| 
;*     ||           ADD     .S2     1,B6,B6           ; [B_Sb674] |60|  ^ 
;*   7              STW     .D2T2   B4,*B7++(4)       ; [B_D64P] |60| 
;*     ||           SPBR                              $C$C572 ; [] 
;*   8              ; BRANCHCC OCCURS {$C$C572}       ; [] |60| 
;*----------------------------------------------------------------------------*
$C$L17:    ; PIPED LOOP PROLOG
           SPLOOP          2                 ;8 ; [A_L674] (P) 
;** --------------------------------------------------------------------------*
$C$L18:    ; PIPED LOOP KERNEL
	.dwpsn	file "t3.c",line 60,column 29,is_stmt,isa 0
           LDW     .D2T2   *B8++(4),B5       ; [B_D64P] |60| (P) <0,0> 
           NOP             3                 ; [A_L674] 

           SPMASK                            ; [] 
||^        MV      .L2X    A3,B6             ; [B_L674] 

           SHL     .S2     B6,4,B4           ; [B_Sb674] |60| (P) <0,5>  ^ 
	.dwpsn	file "t3.c",line 60,column 24,is_stmt,isa 0

           ADD     .S2     1,B6,B6           ; [B_Sb674] |60| <0,6>  ^ 
||         XOR     .L2     B4,B5,B4          ; [B_L674] |60| <0,6> 

	.dwpsn	file "t3.c",line 60,column 29,is_stmt,isa 0

           SPKERNEL        3,0               ; [] 
||         STW     .D2T2   B4,*B7++(4)       ; [B_D64P] |60| <0,7> 

;** --------------------------------------------------------------------------*
$C$L19:    ; PIPED LOOP EPILOG
;** --------------------------------------------------------------------------*
$C$L20:    
	.dwpsn	file "t3.c",line 61,column 1,is_stmt,isa 0
$C$DW$46	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$46, DW_AT_low_pc(0x00)
	.dwattr $C$DW$46, DW_AT_TI_return

           RETNOP          B3,5              ; [] |61| 
           ; BRANCH OCCURS {B3}              ; [] |61| 
	.dwattr $C$DW$42, DW_AT_TI_end_file("t3.c")
	.dwattr $C$DW$42, DW_AT_TI_end_line(0x3d)
	.dwattr $C$DW$42, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$42

;**	Parameter deleted: s == &ia;
;**	Parameter deleted: d == &sa;
	.sect	".text"
	.clink

$C$DW$47	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$47, DW_AT_name("ssat")
	.dwattr $C$DW$47, DW_AT_low_pc(ssat)
	.dwattr $C$DW$47, DW_AT_high_pc(0x00)
	.dwattr $C$DW$47, DW_AT_TI_symbol_name("ssat")
	.dwattr $C$DW$47, DW_AT_TI_begin_file("t3.c")
	.dwattr $C$DW$47, DW_AT_TI_begin_line(0x40)
	.dwattr $C$DW$47, DW_AT_TI_begin_column(0x0d)
	.dwattr $C$DW$47, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$47, DW_AT_decl_line(0x40)
	.dwattr $C$DW$47, DW_AT_decl_column(0x0d)
	.dwattr $C$DW$47, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t3.c",line 65,column 1,is_stmt,address ssat,isa 0

	.dwfde $C$DW$CIE, ssat
$C$DW$48	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$48, DW_AT_name("n")
	.dwattr $C$DW$48, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$48, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$48, DW_AT_location[DW_OP_reg4]


;******************************************************************************
;* FUNCTION NAME: ssat                                                        *
;*                                                                            *
;*   Regs Modified     : A0,A3,A4,A5,B0,B4,B5,B6,B7,B8                        *
;*   Regs Used         : A0,A3,A4,A5,B0,B3,B4,B5,B6,B7,B8                     *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
ssat:
;** --------------------------------------------------------------------------*
$C$DW$49	.dwtag  DW_TAG_variable
	.dwattr $C$DW$49, DW_AT_name("n")
	.dwattr $C$DW$49, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$49, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$49, DW_AT_location[DW_OP_reg4]

	.dwcfi	cfa_offset, 0
	.dwpsn	file "t3.c",line 67,column 17,is_stmt,isa 0

           MVKL    .S2     sa,B4             ; [B_Sb674] 
||         CMPGT   .L1     A4,0,A0           ; [A_L674] |67| 

           MVKH    .S2     sa,B4             ; [B_Sb674] 
|| [!A0]   B       .S1     $C$L24            ; [A_S674] |67| 

           MV      .L2     B4,B7             ; [B_L674] 
||         MV      .D2X    A4,B4             ; [B_D64P] 
||         MVKL    .S2     ia,B6             ; [B_Sb674] 

   [ A0]   MVC     .S2     B4,ILC            ; [B_Sb674] 
           MVK     .S2     -32768,B5         ; [B_Sb674] 
           MVKH    .S2     ia,B6             ; [B_Sb674] 
           MVK     .S1     32767,A3          ; [A_S674] 
           ; BRANCHCC OCCURS {$C$L24}        ; [] |67| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 67
;*    Loop opening brace source line   : 67
;*    Loop closing brace source line   : 67
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 3 due to a resource limitation (partitioned resource bound).
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound(^) : 1
;*    Partitioned Resource Bound(*)    : 3
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     1        1     
;*      .S units                     1        3*    
;*      .D units                     1        1     
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          1        0     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1        2     
;*      Bound(.L .S .D .LS .LSD)     2        2     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 3  Schedule found with 5 iterations in parallel
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
;*      $C$C839:
;*   0              LDW     .D2T2   *B6++(4),B8       ; [B_D64P] |67| 
;*   1              NOP     4       ; [A_L674] 
;*   5              SHR     .S2     B8,3,B8           ; [B_Sb674] |67| 
;*   6              MVD     .M2     B8,B7             ; [B_M674] |67| Split a long life
;*   7              CMPLT   .L2     B8,B5,B0          ; [B_L674] |67| 
;*   8              NOP     1       ; [A_L674] 
;*   9      [ B0]   EXT     .S2     B5,16,16,B4       ; [B_Sb674] |67|  ^ 
;*  10      [!B0]   EXT     .S2     B7,16,16,B4       ; [B_Sb674] |67|  ^ 
;*  11              CMPGT   .L1X    B7,A4,A0          ; [A_L674] |67| 
;*  12      [!A0]   MV      .L1X    B4,A5             ; [A_L674] |67|  ^ 
;*     ||   [ A0]   EXT     .S1     A4,16,16,A5       ; [A_S674] |67|  ^ 
;*  13              STH     .D1T1   A5,*A3++(2)       ; [A_D64P] |67| 
;*     ||           SPBR                              $C$C839 ; [] 
;*  14              NOP     1       ; [A_L674] 
;*  15              ; BRANCHCC OCCURS {$C$C839}       ; [] |67| 
;*----------------------------------------------------------------------------*
$C$L21:    ; PIPED LOOP PROLOG
           SPLOOP          3                 ;15 ; [A_L674] (P) 
;** --------------------------------------------------------------------------*
$C$L22:    ; PIPED LOOP KERNEL
	.dwpsn	file "t3.c",line 67,column 50,is_stmt,isa 0
           LDW     .D2T2   *B6++(4),B8       ; [B_D64P] |67| (P) <0,0> 
           NOP             4                 ; [A_L674] 
           SHR     .S2     B8,3,B8           ; [B_Sb674] |67| (P) <0,5> 

           SPMASK                            ; [] 
||^        MV      .S1     A3,A4             ; [A_S674] 
||^        MV      .L1X    B7,A3             ; [A_L674] 
||         MVD     .M2     B8,B7             ; [B_M674] |67| (P) <0,6> Split a long life

           CMPLT   .L2     B8,B5,B0          ; [B_L674] |67| (P) <0,7> 
           NOP             1                 ; [A_L674] 
   [ B0]   EXT     .S2     B5,16,16,B4       ; [B_Sb674] |67| (P) <0,9>  ^ 
   [!B0]   EXT     .S2     B7,16,16,B4       ; [B_Sb674] |67| (P) <0,10>  ^ 
           CMPGT   .L1X    B7,A4,A0          ; [A_L674] |67| (P) <0,11> 

   [ A0]   EXT     .S1     A4,16,16,A5       ; [A_S674] |67| <0,12>  ^ 
|| [!A0]   MV      .L1X    B4,A5             ; [A_L674] |67| <0,12>  ^ 

           SPKERNEL        3,0               ; [] 
||         STH     .D1T1   A5,*A3++(2)       ; [A_D64P] |67| <0,13> 

;** --------------------------------------------------------------------------*
$C$L23:    ; PIPED LOOP EPILOG
           NOP             2                 ; [A_L674] 
;** --------------------------------------------------------------------------*
$C$L24:    
	.dwpsn	file "t3.c",line 68,column 1,is_stmt,isa 0
$C$DW$50	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$50, DW_AT_low_pc(0x00)
	.dwattr $C$DW$50, DW_AT_TI_return

           RETNOP          B3,5              ; [] |68| 
           ; BRANCH OCCURS {B3}              ; [] |68| 
	.dwattr $C$DW$47, DW_AT_TI_end_file("t3.c")
	.dwattr $C$DW$47, DW_AT_TI_end_line(0x44)
	.dwattr $C$DW$47, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$47

;**	Parameter deleted: a == &ia;
	.sect	".text"
	.clink

$C$DW$51	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$51, DW_AT_name("find")
	.dwattr $C$DW$51, DW_AT_low_pc(find)
	.dwattr $C$DW$51, DW_AT_high_pc(0x00)
	.dwattr $C$DW$51, DW_AT_TI_symbol_name("find")
	.dwattr $C$DW$51, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$51, DW_AT_TI_begin_file("t3.c")
	.dwattr $C$DW$51, DW_AT_TI_begin_line(0x4f)
	.dwattr $C$DW$51, DW_AT_TI_begin_column(0x0c)
	.dwattr $C$DW$51, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$51, DW_AT_decl_line(0x4f)
	.dwattr $C$DW$51, DW_AT_decl_column(0x0c)
	.dwattr $C$DW$51, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t3.c",line 80,column 1,is_stmt,address find,isa 0

	.dwfde $C$DW$CIE, find
$C$DW$52	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$52, DW_AT_name("n")
	.dwattr $C$DW$52, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$52, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$52, DW_AT_location[DW_OP_reg4]

$C$DW$53	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$53, DW_AT_name("key")
	.dwattr $C$DW$53, DW_AT_TI_symbol_name("key")
	.dwattr $C$DW$53, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$53, DW_AT_location[DW_OP_reg20]


;******************************************************************************
;* FUNCTION NAME: find                                                        *
;*                                                                            *
;*   Regs Modified     : A0,A3,A4,B0,B5,B6,B7,B8,B9                           *
;*   Regs Used         : A0,A3,A4,B0,B3,B4,B5,B6,B7,B8,B9,DP,SP               *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
find:
;** --------------------------------------------------------------------------*
$C$DW$54	.dwtag  DW_TAG_variable
	.dwattr $C$DW$54, DW_AT_name("key")
	.dwattr $C$DW$54, DW_AT_TI_symbol_name("key")
	.dwattr $C$DW$54, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$54, DW_AT_location[DW_OP_reg20]

$C$DW$55	.dwtag  DW_TAG_variable
	.dwattr $C$DW$55, DW_AT_name("i")
	.dwattr $C$DW$55, DW_AT_TI_symbol_name("i")
	.dwattr $C$DW$55, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$55, DW_AT_location[DW_OP_reg3]

	.dwcfi	cfa_offset, 0
	.dwpsn	file "t3.c",line 82,column 51,is_stmt,isa 0
           MVKL    .S2     ia,B6             ; [B_Sb674] |82| 
           MVKH    .S2     ia,B6             ; [B_Sb674] |82| 
           SUB     .L2     B6,4,B6           ; [B_L674] |82| 
	.dwpsn	file "t3.c",line 82,column 10,is_stmt,isa 0
           LDW     .D2T2   *++B6(4),B9       ; [B_D64P] |82| (P) <0,0> 
           CMPGT   .L1     A4,0,A0           ; [A_L674] 
	.dwpsn	file "t3.c",line 80,column 1,is_stmt,isa 0
           MV      .L2X    A4,B5             ; [B_L674] |80| 
   [!A0]   MVK     .L2     1,B5              ; [B_L674] 
	.dwpsn	file "t3.c",line 81,column 11,is_stmt,isa 0
           MVK     .L1     -1,A3             ; [A_L674] |81| 
	.dwpsn	file "t3.c",line 82,column 10,is_stmt,isa 0

           DINT                               ; [B_Sb674] interrupts off
||         CMPEQ   .L2     B9,B4,B8          ; [B_L674] |82| (P) <0,5> 

;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 82
;*    Loop opening brace source line   : 82
;*    Loop closing brace source line   : 82
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 2 due to a resource limitation (partitioned resource bound).
;*      - The compiler is having trouble finding a successful schedule
;*        at/near this variation's starting ii of 2 due to issues
;*        noted below in the "searching for..." section.
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Maximum Iteration Count    : 64
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound    : 1
;*    Partitioned Resource Bound(*)    : 2
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        1     
;*      .S units                     1        0     
;*      .D units                     0        1     
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          1        3     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1        1     
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
;*      ii = 8  Schedule found with 2 iterations in parallel
;*    Done
;*
;*    Minimum required memory pad   : 0 bytes
;*
;*    For further improvement on this loop, try option -mh56
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*     SETUP CODE
;*
;*                MVK     1,B0    ; [] 
;*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C978:
;*   0      [ B0]   LDW     .D2T2   *++B6(4),B9       ; [B_D64P] |82| 
;*   1              NOP     4       ; [A_L674] 
;*   5              CMPEQ   .L2     B9,B4,B8          ; [B_L674] |82| 
;*   6              SUB     .L2     B8,1,B7           ; [B_L674] |82| 
;*     ||           SUB     .S2     B5,1,B5           ; [B_Sb674] |82| 
;*   7              AND     .L2     B7,B5,B0          ; [B_L674] |82| 
;*   8      [ B0]   B       .S1     $C$C978           ; [A_S674] |82| 
;*   9              NOP     4       ; [A_L674] 
;*  13              ADD     .L1     1,A3,A3           ; [A_L674] |82| 
;*  14              ; BRANCHCC OCCURS {$C$C978}       ; [] |82| 
;*----------------------------------------------------------------------------*
$C$L25:    ; PIPED LOOP PROLOG
;** --------------------------------------------------------------------------*
$C$L26:    ; PIPED LOOP KERNEL

           SUB     .S2     B5,1,B5           ; [B_Sb674] |82| <0,6> 
||         SUB     .L2     B8,1,B7           ; [B_L674] |82| <0,6> 

	.dwpsn	file "t3.c",line 82,column 51,is_stmt,isa 0
           AND     .L2     B7,B5,B0          ; [B_L674] |82| <0,7> 
	.dwpsn	file "t3.c",line 82,column 10,is_stmt,isa 0

   [ B0]   BNOP            $C$L26,4          ; [] |82| <0,8> 
|| [ B0]   LDW     .D2T2   *++B6(4),B9       ; [B_D64P] |82| <1,0> 

           ADD     .L1     1,A3,A3           ; [A_L674] |82| <0,13> 
||         CMPEQ   .L2     B9,B4,B8          ; [B_L674] |82| <1,5> 

;** --------------------------------------------------------------------------*
$C$L27:    ; PIPED LOOP EPILOG
;** --------------------------------------------------------------------------*
	.dwpsn	file "t3.c",line 84,column 1,is_stmt,isa 0
$C$DW$56	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$56, DW_AT_low_pc(0x00)
	.dwattr $C$DW$56, DW_AT_TI_return

           RETNOP          B3,3              ; [] |84| 
	.dwpsn	file "t3.c",line 83,column 5,is_stmt,isa 0

           MV      .L2     B7,B0             ; [B_L674] 
||         MVK     .L1     -1,A4             ; [A_L674] |83| 

   [!B0]   MV      .L1     A3,A4             ; [A_L674] |83| 
||         RINT                               ; [B_Sb674] interrupts on

	.dwpsn	file "t3.c",line 84,column 1,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |84| 
	.dwattr $C$DW$51, DW_AT_TI_end_file("t3.c")
	.dwattr $C$DW$51, DW_AT_TI_end_line(0x54)
	.dwattr $C$DW$51, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$51

	.sect	".text"
	.clink

$C$DW$57	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$57, DW_AT_name("nested")
	.dwattr $C$DW$57, DW_AT_low_pc(nested)
	.dwattr $C$DW$57, DW_AT_high_pc(0x00)
	.dwattr $C$DW$57, DW_AT_TI_symbol_name("nested")
	.dwattr $C$DW$57, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$57, DW_AT_TI_begin_file("t3.c")
	.dwattr $C$DW$57, DW_AT_TI_begin_line(0x57)
	.dwattr $C$DW$57, DW_AT_TI_begin_column(0x0c)
	.dwattr $C$DW$57, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$57, DW_AT_decl_line(0x57)
	.dwattr $C$DW$57, DW_AT_decl_column(0x0c)
	.dwattr $C$DW$57, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t3.c",line 88,column 1,is_stmt,address nested,isa 0

	.dwfde $C$DW$CIE, nested
$C$DW$58	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$58, DW_AT_name("r")
	.dwattr $C$DW$58, DW_AT_TI_symbol_name("r")
	.dwattr $C$DW$58, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$58, DW_AT_location[DW_OP_reg4]

$C$DW$59	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$59, DW_AT_name("c")
	.dwattr $C$DW$59, DW_AT_TI_symbol_name("c")
	.dwattr $C$DW$59, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$59, DW_AT_location[DW_OP_reg20]


;******************************************************************************
;* FUNCTION NAME: nested                                                      *
;*                                                                            *
;*   Regs Modified     : A0,A1,A3,A4,A5,A6,A7,A8,B0,B4,B5,B6,B7,B8            *
;*   Regs Used         : A0,A1,A3,A4,A5,A6,A7,A8,B0,B3,B4,B5,B6,B7,B8         *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
nested:
;** --------------------------------------------------------------------------*
$C$DW$60	.dwtag  DW_TAG_variable
	.dwattr $C$DW$60, DW_AT_name("c")
	.dwattr $C$DW$60, DW_AT_TI_symbol_name("c")
	.dwattr $C$DW$60, DW_AT_type(*$C$DW$T$52)
	.dwattr $C$DW$60, DW_AT_location[DW_OP_reg23]

$C$DW$61	.dwtag  DW_TAG_variable
	.dwattr $C$DW$61, DW_AT_name("i")
	.dwattr $C$DW$61, DW_AT_TI_symbol_name("i")
	.dwattr $C$DW$61, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$61, DW_AT_location[DW_OP_reg22]

$C$DW$62	.dwtag  DW_TAG_variable
	.dwattr $C$DW$62, DW_AT_name("j")
	.dwattr $C$DW$62, DW_AT_TI_symbol_name("j")
	.dwattr $C$DW$62, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$62, DW_AT_location[DW_OP_reg6]

$C$DW$63	.dwtag  DW_TAG_variable
	.dwattr $C$DW$63, DW_AT_name("s")
	.dwattr $C$DW$63, DW_AT_TI_symbol_name("s")
	.dwattr $C$DW$63, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$63, DW_AT_location[DW_OP_reg7]

	.dwcfi	cfa_offset, 0

           CMPGT   .L1     A4,0,A1           ; [A_L674] |90| 
||         MV      .L2     B4,B7             ; [B_L674] |88| 
||         MV      .S1     A4,A0             ; [A_S674] |88| 
||         ZERO    .S2     B6                ; [B_Sb674] |90| 
||         ZERO    .D1     A7                ; [A_D64P] |90| 

	.dwpsn	file "t3.c",line 90,column 17,is_stmt,isa 0

   [!A1]   BNOP            $C$L33,5          ; [] |90| 
|| [ A1]   CMPGT   .L2     B7,0,B0           ; [B_L674] |91| 

           ; BRANCHCC OCCURS {$C$L33}        ; [] |90| 
;** --------------------------------------------------------------------------*

   [ B0]   MVKL    .S1     ia,A8             ; [A_S674] 
|| [ B0]   MPY     .M2     B6,B7,B4          ; [B_M674] 

	.dwpsn	file "t3.c",line 91,column 21,is_stmt,isa 0
   [!B0]   B       .S1     $C$L32            ; [A_S674] |91| 
   [ B0]   MVKH    .S1     ia,A8             ; [A_S674] 
;** --------------------------------------------------------------------------*
;**   BEGIN LOOP $C$L28
;** --------------------------------------------------------------------------*
$C$L28:    
   [ B0]   MVC     .S2     B7,ILC            ; [B_Sb674] 
           NOP             3                 ; [A_L674] 
           ; BRANCHCC OCCURS {$C$L32}        ; [] |91| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 91
;*    Loop opening brace source line   : 92
;*    Loop closing brace source line   : 92
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 2 due to a resource limitation (partitioned resource bound).
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound(^) : 1
;*    Partitioned Resource Bound(*)    : 2
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     1        0     
;*      .D units                     1        0     
;*      .M units                     1        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          3        2     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1        0     
;*      Bound(.L .S .D .LS .LSD)     2*       1     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 2  Schedule found with 6 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    Minimum safe iteration count    : 1
;*----------------------------------------------------------------------------*
;*     SETUP CODE
;*
;*                MV      A4,B5   ; [] Define a LI twin register
;*                MV      A6,B4   ; [] Define a LI twin register
;*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C1071:
;*   0              EXTU    .S1     A4,24,26,A3       ; [A_S674] |92|  ^ 
;*   1              LDW     .D1T1   *+A8[A3],A3       ; [A_D64P] |92| 
;*     ||           ADD     .L1     4,A4,A4           ; [A_L674] |91|  ^ Define a twin register
;*   2              NOP     4       ; [A_L674] 
;*   6              MPY32   .M1     A6,A3,A5          ; [A_M674] |92|  ^ 
;*   7              ADD     .S1     1,A6,A6           ; [A_S674] |91|  ^ Define a twin register
;*   8              NOP     2       ; [A_L674] 
;*  10              ADD     .L1     A5,A7,A7          ; [A_L674] |92| 
;*     ||           ADD     .S2     4,B5,B5           ; [B_Sb674] |91| 
;*     ||           ADD     .L2     1,B4,B4           ; [B_L674] |91| 
;*     ||           SPBR                              $C$C1071 ; [] 
;*  11              NOP     1       ; [A_L674] 
;*  12              ; BRANCHCC OCCURS {$C$C1071}      ; [] |91| 
;*----------------------------------------------------------------------------*
$C$L29:    ; PIPED LOOP PROLOG

           SPLOOP          2                 ;12 ; [A_L674] (P) 
||         SHL     .S1X    B4,2,A4           ; [A_S674] 

;** --------------------------------------------------------------------------*
$C$L30:    ; PIPED LOOP KERNEL
	.dwpsn	file "t3.c",line 92,column 13,is_stmt,isa 0
           EXTU    .S1     A4,24,26,A3       ; [A_S674] |92| (P) <0,0>  ^ 
	.dwpsn	file "t3.c",line 91,column 28,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MV      .L2X    A4,B5             ; [B_L674] Define a LI twin register
||         ADD     .L1     4,A4,A4           ; [A_L674] |91| (P) <0,1>  ^ Define a twin register
||         LDW     .D1T1   *+A8[A3],A3       ; [A_D64P] |92| (P) <0,1> 

           NOP             1                 ; [A_L674] 

           SPMASK                            ; [] 
||^        MPY32   .M2     B7,B6,B8          ; [B_M674] 

           NOP             1                 ; [A_L674] 
	.dwpsn	file "t3.c",line 91,column 14,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVK     .S1     1,A6              ; [A_S674] |91| 

	.dwpsn	file "t3.c",line 92,column 13,is_stmt,isa 0
           MPY32   .M1     A6,A3,A5          ; [A_M674] |92| (P) <0,6>  ^ 
	.dwpsn	file "t3.c",line 91,column 28,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MV      .L2X    A6,B4             ; [B_L674] Define a LI twin register
||         ADD     .S1     1,A6,A6           ; [A_S674] |91| (P) <0,7>  ^ Define a twin register

           SPMASK                            ; [] 
||^        SUB     .L1X    A7,B8,A7          ; [A_L674] 

           NOP             1                 ; [A_L674] 

           SPKERNEL        4,0               ; [] 
||         ADD     .S2     4,B5,B5           ; [B_Sb674] |91| <0,10> 
||         ADD     .L2     1,B4,B4           ; [B_L674] |91| <0,10> 
||         ADD     .L1     A5,A7,A7          ; [A_L674] |92| <0,10> 

;** --------------------------------------------------------------------------*
$C$L31:    ; PIPED LOOP EPILOG
           NOP             1                 ; [A_L674] 
;** --------------------------------------------------------------------------*
$C$L32:    
	.dwpsn	file "t3.c",line 90,column 17,is_stmt,isa 0

           SUB     .L1     A0,1,A0           ; [A_L674] |90| 
||         ADD     .L2     1,B6,B6           ; [B_L674] |90| 

   [ A0]   B       .S1     $C$L28            ; [A_S674] |90| 
|| [!A0]   MVK     .L2     1,B0              ; [B_L674] nullify predicate

   [ B0]   MPY     .M2     B6,B7,B4          ; [B_M674] 
   [ B0]   MVKL    .S1     ia,A8             ; [A_S674] 
   [ B0]   MVKH    .S1     ia,A8             ; [A_S674] 
	.dwpsn	file "t3.c",line 91,column 21,is_stmt,isa 0
   [!B0]   BNOP            $C$L32,1          ; [] |91| 
	.dwpsn	file "t3.c",line 90,column 17,is_stmt,isa 0
           ; BRANCHCC OCCURS {$C$L28}        ; [] |90| 
;** --------------------------------------------------------------------------*
$C$L33:    
	.dwpsn	file "t3.c",line 94,column 1,is_stmt,isa 0
$C$DW$64	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$64, DW_AT_low_pc(0x00)
	.dwattr $C$DW$64, DW_AT_TI_return

           RETNOP          B3,4              ; [] |94| 
	.dwpsn	file "t3.c",line 93,column 5,is_stmt,isa 0
           MV      .L1     A7,A4             ; [A_L674] |93| 
	.dwpsn	file "t3.c",line 94,column 1,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |94| 
	.dwattr $C$DW$57, DW_AT_TI_end_file("t3.c")
	.dwattr $C$DW$57, DW_AT_TI_end_line(0x5e)
	.dwattr $C$DW$57, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$57

	.sect	".text"
	.clink

$C$DW$65	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$65, DW_AT_name("slen")
	.dwattr $C$DW$65, DW_AT_low_pc(slen)
	.dwattr $C$DW$65, DW_AT_high_pc(0x00)
	.dwattr $C$DW$65, DW_AT_TI_symbol_name("slen")
	.dwattr $C$DW$65, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$65, DW_AT_TI_begin_file("t3.c")
	.dwattr $C$DW$65, DW_AT_TI_begin_line(0x47)
	.dwattr $C$DW$65, DW_AT_TI_begin_column(0x0c)
	.dwattr $C$DW$65, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$65, DW_AT_decl_line(0x47)
	.dwattr $C$DW$65, DW_AT_decl_column(0x0c)
	.dwattr $C$DW$65, DW_AT_TI_max_frame_size(0x00)
	.dwpsn	file "t3.c",line 72,column 1,is_stmt,address slen,isa 0

	.dwfde $C$DW$CIE, slen
$C$DW$66	.dwtag  DW_TAG_formal_parameter
	.dwattr $C$DW$66, DW_AT_name("p")
	.dwattr $C$DW$66, DW_AT_TI_symbol_name("p")
	.dwattr $C$DW$66, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$66, DW_AT_location[DW_OP_reg4]


;******************************************************************************
;* FUNCTION NAME: slen                                                        *
;*                                                                            *
;*   Regs Modified     : A0,A3,A4,B0,B4,B5                                    *
;*   Regs Used         : A0,A3,A4,B0,B3,B4,B5                                 *
;*   Local Frame Size  : 0 Args + 0 Auto + 0 Save = 0 byte                    *
;******************************************************************************
slen:
;** --------------------------------------------------------------------------*
$C$DW$67	.dwtag  DW_TAG_variable
	.dwattr $C$DW$67, DW_AT_name("p")
	.dwattr $C$DW$67, DW_AT_TI_symbol_name("p")
	.dwattr $C$DW$67, DW_AT_type(*$C$DW$T$191)
	.dwattr $C$DW$67, DW_AT_location[DW_OP_reg4]

$C$DW$68	.dwtag  DW_TAG_variable
	.dwattr $C$DW$68, DW_AT_name("q")
	.dwattr $C$DW$68, DW_AT_TI_symbol_name("q")
	.dwattr $C$DW$68, DW_AT_type(*$C$DW$T$91)
	.dwattr $C$DW$68, DW_AT_location[DW_OP_reg3]

	.dwcfi	cfa_offset, 0
           MV      .L1     A4,A3             ; [A_L674] |72| 
	.dwpsn	file "t3.c",line 74,column 5,is_stmt,isa 0
           LDB     .D1T1   *A3(0),A0         ; [A_D64P] |74| 
           NOP             4                 ; [A_L674] 

   [!A0]   BNOP            $C$L37,5          ; [] |74| 
|| [ A0]   MVK     .L2     1,B0              ; [B_L674] 

           ; BRANCHCC OCCURS {$C$L37}        ; [] |74| 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 74
;*    Loop opening brace source line   : 74
;*    Loop closing brace source line   : 74
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 1 due to a loop-carried dependence and
;*        a resource limitation (partitioned resource bound).
;*      - The compiler is having trouble finding a successful schedule
;*        at/near this variation's starting ii of 1 due to issues
;*        noted below in the "searching for..." section.
;*
;*    Known Minimum Iteration Count    : 1
;*    Known Max Iteration Count Factor : 1
;*    Loop Carried Dependency Bound    : 1
;*    Partitioned Resource Bound(*)    : 1
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     0        0     
;*      .D units                     0        1*    
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          0        1     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             0        0     
;*      Bound(.L .S .D .LS .LSD)     0        1*    
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
;*      $C$C1280:
;*   2      [ B0]   LDB     .D2T2   *++B5(1),B4       ; [B_D64P] |74| 
;*   3              NOP     4       ; [A_L674] 
;*   7              MV      .L2     B4,B0             ; [B_L674] |74| 
;*   8      [ B0]   SPWBR                             $C$C1280 ; [] 
;*   9              NOP     3       ; [A_L674] 
;*  12              ; BRANCHCC OCCURS {$C$C1280}      ; [] |74| 
;*----------------------------------------------------------------------------*
$C$L34:    ; PIPED LOOP PROLOG
   [ B0]   SPLOOPW         6                 ;12 ; [A_L674] (P) 
;** --------------------------------------------------------------------------*
$C$L35:    ; PIPED LOOP KERNEL
           NOP             1                 ; [A_L674] 

           SPMASK                            ; [] 
||^        MV      .L2X    A3,B5             ; [B_L674] 

	.dwpsn	file "t3.c",line 74,column 16,is_stmt,isa 0
   [ B0]   LDB     .D2T2   *++B5(1),B4       ; [B_D64P] |74| (P) <0,2> 
           NOP             4                 ; [A_L674] 
           MV      .L2     B4,B0             ; [B_L674] |74| <0,7> 
           NOP             2                 ; [A_L674] 
           NOP             1                 ; [A_L674] 
           SPKERNEL        0,0               ; [] 
;** --------------------------------------------------------------------------*
$C$L36:    ; PIPED LOOP EPILOG
;** --------------------------------------------------------------------------*
           MV      .L1X    B5,A3             ; [A_L674] 
;** --------------------------------------------------------------------------*
$C$L37:    
	.dwpsn	file "t3.c",line 76,column 1,is_stmt,isa 0
$C$DW$69	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$69, DW_AT_low_pc(0x00)
	.dwattr $C$DW$69, DW_AT_TI_return

           RETNOP          B3,4              ; [] |76| 
	.dwpsn	file "t3.c",line 75,column 5,is_stmt,isa 0
           SUB     .L1     A3,A4,A4          ; [A_L674] |75| 
	.dwpsn	file "t3.c",line 76,column 1,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |76| 
	.dwattr $C$DW$65, DW_AT_TI_end_file("t3.c")
	.dwattr $C$DW$65, DW_AT_TI_end_line(0x4c)
	.dwattr $C$DW$65, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$65

	.sect	".text"
	.clink
	.global	main

$C$DW$70	.dwtag  DW_TAG_subprogram
	.dwattr $C$DW$70, DW_AT_name("main")
	.dwattr $C$DW$70, DW_AT_low_pc(main)
	.dwattr $C$DW$70, DW_AT_high_pc(0x00)
	.dwattr $C$DW$70, DW_AT_TI_symbol_name("main")
	.dwattr $C$DW$70, DW_AT_external
	.dwattr $C$DW$70, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$70, DW_AT_TI_begin_file("t3.c")
	.dwattr $C$DW$70, DW_AT_TI_begin_line(0x60)
	.dwattr $C$DW$70, DW_AT_TI_begin_column(0x05)
	.dwattr $C$DW$70, DW_AT_decl_file("t3.c")
	.dwattr $C$DW$70, DW_AT_decl_line(0x60)
	.dwattr $C$DW$70, DW_AT_decl_column(0x05)
	.dwattr $C$DW$70, DW_AT_TI_max_frame_size(0xc0)
	.dwpsn	file "t3.c",line 97,column 1,is_stmt,address main,isa 0

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
;*   Local Frame Size  : 0 Args + 136 Auto + 56 Save = 192 byte               *
;******************************************************************************
main:
;** --------------------------------------------------------------------------*
$C$DW$71	.dwtag  DW_TAG_variable
	.dwattr $C$DW$71, DW_AT_name("s")
	.dwattr $C$DW$71, DW_AT_TI_symbol_name("s")
	.dwattr $C$DW$71, DW_AT_type(*$C$DW$T$192)
	.dwattr $C$DW$71, DW_AT_location[DW_OP_breg31 8]

$C$DW$72	.dwtag  DW_TAG_variable
	.dwattr $C$DW$72, DW_AT_name("st")
	.dwattr $C$DW$72, DW_AT_TI_symbol_name("st")
	.dwattr $C$DW$72, DW_AT_type(*$C$DW$T$185)
	.dwattr $C$DW$72, DW_AT_location[DW_OP_breg31 88]

$C$DW$73	.dwtag  DW_TAG_variable
	.dwattr $C$DW$73, DW_AT_name("f")
	.dwattr $C$DW$73, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$73, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$73, DW_AT_location[DW_OP_breg31 96]

$C$DW$74	.dwtag  DW_TAG_variable
	.dwattr $C$DW$74, DW_AT_name("u")
	.dwattr $C$DW$74, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$74, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$74, DW_AT_location[DW_OP_breg31 100]

$C$DW$75	.dwtag  DW_TAG_variable
	.dwattr $C$DW$75, DW_AT_name("f")
	.dwattr $C$DW$75, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$75, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$75, DW_AT_location[DW_OP_breg31 104]

$C$DW$76	.dwtag  DW_TAG_variable
	.dwattr $C$DW$76, DW_AT_name("u")
	.dwattr $C$DW$76, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$76, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$76, DW_AT_location[DW_OP_breg31 108]

$C$DW$77	.dwtag  DW_TAG_variable
	.dwattr $C$DW$77, DW_AT_name("f")
	.dwattr $C$DW$77, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$77, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$77, DW_AT_location[DW_OP_breg31 112]

$C$DW$78	.dwtag  DW_TAG_variable
	.dwattr $C$DW$78, DW_AT_name("u")
	.dwattr $C$DW$78, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$78, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$78, DW_AT_location[DW_OP_breg31 116]

$C$DW$79	.dwtag  DW_TAG_variable
	.dwattr $C$DW$79, DW_AT_name("f")
	.dwattr $C$DW$79, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$79, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$79, DW_AT_location[DW_OP_breg31 120]

$C$DW$80	.dwtag  DW_TAG_variable
	.dwattr $C$DW$80, DW_AT_name("u")
	.dwattr $C$DW$80, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$80, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$80, DW_AT_location[DW_OP_breg31 124]

$C$DW$81	.dwtag  DW_TAG_variable
	.dwattr $C$DW$81, DW_AT_name("f")
	.dwattr $C$DW$81, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$81, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$81, DW_AT_location[DW_OP_breg31 128]

$C$DW$82	.dwtag  DW_TAG_variable
	.dwattr $C$DW$82, DW_AT_name("u")
	.dwattr $C$DW$82, DW_AT_TI_symbol_name("u")
	.dwattr $C$DW$82, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$82, DW_AT_location[DW_OP_breg31 132]

$C$DW$83	.dwtag  DW_TAG_variable
	.dwattr $C$DW$83, DW_AT_name("n")
	.dwattr $C$DW$83, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$83, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$83, DW_AT_location[DW_OP_reg10]

$C$DW$84	.dwtag  DW_TAG_variable
	.dwattr $C$DW$84, DW_AT_name("n")
	.dwattr $C$DW$84, DW_AT_TI_symbol_name("n")
	.dwattr $C$DW$84, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$84, DW_AT_location[DW_OP_breg31 136]

$C$DW$85	.dwtag  DW_TAG_variable
	.dwattr $C$DW$85, DW_AT_name("i")
	.dwattr $C$DW$85, DW_AT_TI_symbol_name("i")
	.dwattr $C$DW$85, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$85, DW_AT_location[DW_OP_reg20]

$C$DW$86	.dwtag  DW_TAG_variable
	.dwattr $C$DW$86, DW_AT_name("lcg")
	.dwattr $C$DW$86, DW_AT_TI_symbol_name("lcg")
	.dwattr $C$DW$86, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$86, DW_AT_location[DW_OP_regx 0x2b]

$C$DW$87	.dwtag  DW_TAG_variable
	.dwattr $C$DW$87, DW_AT_name("h")
	.dwattr $C$DW$87, DW_AT_TI_symbol_name("h")
	.dwattr $C$DW$87, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$87, DW_AT_location[DW_OP_reg3]

$C$DW$88	.dwtag  DW_TAG_variable
	.dwattr $C$DW$88, DW_AT_name("h")
	.dwattr $C$DW$88, DW_AT_TI_symbol_name("h")
	.dwattr $C$DW$88, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$88, DW_AT_location[DW_OP_reg3]

$C$DW$89	.dwtag  DW_TAG_variable
	.dwattr $C$DW$89, DW_AT_name("h")
	.dwattr $C$DW$89, DW_AT_TI_symbol_name("h")
	.dwattr $C$DW$89, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$89, DW_AT_location[DW_OP_reg4]

$C$DW$90	.dwtag  DW_TAG_variable
	.dwattr $C$DW$90, DW_AT_name("h")
	.dwattr $C$DW$90, DW_AT_TI_symbol_name("h")
	.dwattr $C$DW$90, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$90, DW_AT_location[DW_OP_reg4]

$C$DW$91	.dwtag  DW_TAG_variable
	.dwattr $C$DW$91, DW_AT_name("f")
	.dwattr $C$DW$91, DW_AT_TI_symbol_name("f")
	.dwattr $C$DW$91, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$91, DW_AT_location[DW_OP_reg20]

$C$DW$92	.dwtag  DW_TAG_variable
	.dwattr $C$DW$92, DW_AT_name("v")
	.dwattr $C$DW$92, DW_AT_TI_symbol_name("v")
	.dwattr $C$DW$92, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$92, DW_AT_location[DW_OP_reg4]

$C$DW$93	.dwtag  DW_TAG_variable
	.dwattr $C$DW$93, DW_AT_name("v")
	.dwattr $C$DW$93, DW_AT_TI_symbol_name("v")
	.dwattr $C$DW$93, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$93, DW_AT_location[DW_OP_reg4]

$C$DW$94	.dwtag  DW_TAG_variable
	.dwattr $C$DW$94, DW_AT_name("v")
	.dwattr $C$DW$94, DW_AT_TI_symbol_name("v")
	.dwattr $C$DW$94, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$94, DW_AT_location[DW_OP_reg4]

$C$DW$95	.dwtag  DW_TAG_variable
	.dwattr $C$DW$95, DW_AT_name("v")
	.dwattr $C$DW$95, DW_AT_TI_symbol_name("v")
	.dwattr $C$DW$95, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$95, DW_AT_location[DW_OP_reg20]

	.dwcfi	cfa_offset, 0
	.dwpsn	file "t3.c",line 100,column 17,is_stmt,isa 0

           MVK     .S2     31,B4             ; [B_Sb674] |100| 
||         MVKL    .S1     0x19660d,A18      ; [A_S674] |101| 

	.dwpsn	file "t3.c",line 101,column 9,is_stmt,isa 0

           MVKH    .S1     0x19660d,A18      ; [A_S674] |101| 
||         MVC     .S2     B4,ILC            ; [B_Sb674] 

;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 100
;*    Loop opening brace source line   : 100
;*    Loop closing brace source line   : 106
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 10 due to a loop-carried dependence.
;*
;*    Loop Unroll Multiple             : 2x
;*    Known Minimum Iteration Count    : 32
;*    Known Maximum Iteration Count    : 32
;*    Known Max Iteration Count Factor : 32
;*    Loop Carried Dependency Bound(^) : 10
;*    Partitioned Resource Bound(*)    : 6
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     2        2     
;*      .S units                     2        4     
;*      .D units                     4        2     
;*      .M units                     4        5     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           2        2     (.L or .S unit)
;*      Addition ops (.LSD)          5        6     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             3        4     
;*      Bound(.L .S .D .LS .LSD)     5        6*    
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 10 Schedule found with 3 iterations in parallel
;*    Done
;*
;*    Loop will be splooped
;*    Minimum required memory pad   : 0 bytes
;*
;*    Minimum safe iteration count    : 1 (after unrolling)
;*----------------------------------------------------------------------------*
;*     SETUP CODE
;*
;*                MV      A5,A23  ; [] 
;*                ADD     12,A23,A23 ; [] 
;*                ADD     8,A5,A5 ; [] 
;*                MV      A4,B5   ; [] 
;*                ADD     12,B5,B5 ; [] 
;*                ADD     8,A4,A4 ; [] 
;*                MV      B4,A17  ; [] Define a LI twin register
;*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C1824:
;*   0              MPY32   .M1     A19,A22,A3        ; [A_M674] |101|  ^ 
;*   1              NOP     3       ; [A_L674] 
;*   4              ADD     .S1     A8,A3,A16         ; [A_S674] |101|  ^ 
;*     ||           MPY     .M2     B4,B17,B7         ; [B_M674] |103| 
;*   5              MPY32   .M1     A18,A16,A22       ; [A_M674] |101|  ^ 
;*   6              ADD     .L2     B17,B7,B6         ; [B_L674] |103| 
;*     ||           SHR     .S2     B7,1,B7           ; [B_Sb674] |103| 
;*   7              MVD     .M1     A16,A25           ; [A_M674] |101| Split a long life
;*     ||           SHR     .S2     B6,1,B6           ; [B_Sb674] |103| 
;*     ||           MPYHL   .M2     B7,B9,B7          ; [B_M674] |103| 
;*   8              SHRU    .S1     A16,20,A16        ; [A_S674] |102| 
;*     ||           MPYHL   .M2     B6,B8,B21         ; [B_M674] |103| 
;*   9              INTSP   .L1     A16,A16           ; [A_L674] |102| 
;*     ||           ADD     .D1     A8,A22,A22        ; [A_D64P] |101|  ^ 
;*     ||           SUB     .L2     B4,B7,B23         ; [B_L674] |103| 
;*  10              SHRU    .S1     A22,20,A16        ; [A_S674] |102| 
;*     ||           SUB     .D2     B4,B21,B7         ; [B_D64P] |103| 
;*  11              MVD     .M1     A22,A24           ; [A_M674] |101| Split a long life
;*     ||           INTSP   .L1     A16,A3            ; [A_L674] |102| 
;*     ||           ADD     .D2     1,B7,B7           ; [B_D64P] |103| 
;*     ||           INTSP   .L2     B23,B6            ; [B_L674] |103| 
;*  12              INTSP   .L2     B7,B6             ; [B_L674] |103| 
;*     ||           ADD     .D2     2,B4,B4           ; [B_D64P] |100| Define a twin register
;*  13              NOP     1       ; [A_L674] 
;*  14              MPYSP   .M1     A6,A16,A3         ; [A_M674] |102| 
;*  15              MPYSP   .M2     B18,B6,B22        ; [B_M674] |103| 
;*  16              MPYSP   .M1     A6,A3,A3          ; [A_M674] |102| 
;*     ||           MPYSP   .M2     B18,B6,B7         ; [B_M674] |103| 
;*  17              NOP     1       ; [A_L674] 
;*  18              SHRU    .S2X    A25,8,B6          ; [B_Sb674] |104| 
;*  19              SUBSP   .S1     A3,A7,A3          ; [A_S674] |102| 
;*  20              MV      .D1X    B6,A3             ; [A_D64P] |104| Define a twin register
;*     ||           SUBSP   .L1     A3,A7,A24         ; [A_L674] |102| 
;*     ||           SUBSP   .S2     B7,B19,B7         ; [B_Sb674] |103| 
;*     ||           SUBSP   .L2     B22,B19,B6        ; [B_L674] |103| 
;*  21              ADD     .S1X    B20,A3,A3         ; [A_S674] |104| 
;*     ||           STDW    .D1T1   A21:A20,*A9++(8)  ; [A_D64P] |105| 
;*     ||           SHRU    .S2X    A24,8,B6          ; [B_Sb674] |104| 
;*  22              STW     .D1T1   A3,*A4++(8)       ; [A_D64P] |104| 
;*     ||           ADD     .S2     B20,B6,B6         ; [B_Sb674] |104| 
;*  23              STW     .D1T1   A3,*A5++(8)       ; [A_D64P] |102| 
;*     ||           STW     .D2T2   B6,*B5++(8)       ; [B_D64P] |104| 
;*     ||           ADD     .S1     2,A17,A17         ; [A_S674] |100| 
;*  24              STW     .D1T1   A24,*A23++(8)     ; [A_D64P] |102| 
;*     ||           STDW    .D2T2   B7:B6,*B16++(8)   ; [B_D64P] |103| 
;*     ||           SPBR                              $C$C1824 ; [] 
;*  25              NOP     5       ; [A_L674] 
;*  30              ; BRANCHCC OCCURS {$C$C1824}      ; [] |100| 
;*----------------------------------------------------------------------------*
$C$L38:    ; PIPED LOOP PROLOG
	.dwpsn	file "t3.c",line 97,column 1,is_stmt,isa 0

           SPLOOPD         10                ;30 ; [A_L674] (P) 
||         MVK     .D1     1,A22             ; [A_D64P] |99| 
||         MVKL    .S2     xa,B4             ; [B_Sb674] 
||         STW     .D2T1   A11,*SP++(-8)     ; [B_D64P] |97| 
||         MV      .S1     A18,A19           ; [A_S674] 

	.dwcfi	cfa_offset, 8
	.dwcfi	save_reg_to_mem, 11, 0
;** --------------------------------------------------------------------------*
$C$L39:    ; PIPED LOOP KERNEL

           SPMASK                            ; [] 
||^        STW     .D2T1   A10,*SP++(-8)     ; [B_D64P] |97| 
||^        MVKH    .S2     xa,B4             ; [B_Sb674] 
||         MPY32   .M1     A19,A22,A3        ; [A_M674] |101| (P) <0,0>  ^ 
	.dwcfi	cfa_offset, 16
	.dwcfi	save_reg_to_mem, 10, -8

           SPMASK                            ; [] 
||^        STDW    .D2T2   B13:B12,*SP++(-8) ; [B_D64P] |97| 
	.dwcfi	cfa_offset, 24
	.dwcfi	save_reg_to_mem, 29, -12
	.dwcfi	save_reg_to_mem, 28, -16

           SPMASK                            ; [] 
||^        MVKL    .S1     0x3c6ef35f,A8     ; [A_S674] 
||^        MV      .L1X    B4,A5             ; [A_L674] 
||^        STDW    .D2T2   B11:B10,*SP++(-8) ; [B_D64P] |97| 
||^        MVK     .S2     18725,B11         ; [B_Sb674] 

	.dwcfi	cfa_offset, 32
	.dwcfi	save_reg_to_mem, 27, -20
	.dwcfi	save_reg_to_mem, 26, -24
	.dwpsn	file "t3.c",line 105,column 9,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVKH    .S1     0x3c6ef35f,A8     ; [A_S674] 
||^        ADD     .L1X    4,B4,A23          ; [A_L674] 
||^        ZERO    .L2     B4                ; [B_L674] |105| 
||^        MV      .S2     B11,B17           ; [B_Sb674] 

	.dwpsn	file "t3.c",line 101,column 9,is_stmt,isa 0

           MPY     .M2     B4,B17,B7         ; [B_M674] |103| (P) <0,4> 
||         ADD     .S1     A8,A3,A16         ; [A_S674] |101| (P) <0,4>  ^ 

           SPMASK                            ; [] 
||^        MVKL    .S2     0x3e99999a,B19    ; [B_Sb674] 
||^        MVK     .L2     7,B8              ; [B_L674] |103| 
||         MPY32   .M1     A18,A16,A22       ; [A_M674] |101| (P) <0,5>  ^ 

	.dwpsn	file "t3.c",line 103,column 9,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MV      .D2     B8,B9             ; [B_D64P] |103| 
||         ADD     .L2     B17,B7,B6         ; [B_L674] |103| (P) <0,6> 
||         SHR     .S2     B7,1,B7           ; [B_Sb674] |103| (P) <0,6> 

	.dwpsn	file "t3.c",line 101,column 9,is_stmt,isa 0

           MVD     .M1     A16,A25           ; [A_M674] |101| (P) <0,7> Split a long life
||         SHR     .S2     B6,1,B6           ; [B_Sb674] |103| (P) <0,7> 
||         MPYHL   .M2     B7,B9,B7          ; [B_M674] |103| (P) <0,7> 

	.dwpsn	file "t3.c",line 102,column 9,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVKL    .S2     xb,B16            ; [B_Sb674] 
||         MPYHL   .M2     B6,B8,B21         ; [B_M674] |103| (P) <0,8> 
||         SHRU    .S1     A16,20,A16        ; [A_S674] |102| (P) <0,8> 

	.dwpsn	file "t3.c",line 97,column 1,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .S2     B20               ; [B_Sb674] 
||^        STDW    .D2T1   A15:A14,*SP++(-8) ; [B_D64P] |97| 
||         SUB     .L2     B4,B7,B23         ; [B_L674] |103| (P) <0,9> 
||         INTSP   .L1     A16,A16           ; [A_L674] |102| (P) <0,9> 
||         ADD     .D1     A8,A22,A22        ; [A_D64P] |101| (P) <0,9>  ^ 

	.dwcfi	cfa_offset, 40
	.dwcfi	save_reg_to_mem, 15, -28
	.dwcfi	save_reg_to_mem, 14, -32
	.dwpsn	file "t3.c",line 102,column 9,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .L2     B5                ; [B_L674] 
||^        MVKH    .S2     0xffc00000,B20    ; [B_Sb674] 
||         SHRU    .S1     A22,20,A16        ; [A_S674] |102| (P) <0,10> 
||         SUB     .D2     B4,B21,B7         ; [B_D64P] |103| (P) <0,10> 

	.dwpsn	file "t3.c",line 101,column 9,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .S1     A4                ; [A_S674] 
||^        MVKH    .S2     0x3b000000,B5     ; [B_Sb674] 
||         MVD     .M1     A22,A24           ; [A_M674] |101| (P) <0,11> Split a long life
||         INTSP   .L1     A16,A3            ; [A_L674] |102| (P) <0,11> 
||         INTSP   .L2     B23,B6            ; [B_L674] |103| (P) <0,11> 
||         ADD     .D2     1,B7,B7           ; [B_D64P] |103| (P) <0,11> 

	.dwpsn	file "t3.c",line 100,column 17,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MVKH    .S2     xb,B16            ; [B_Sb674] 
||^        SET     .S1     A4,23,29,A7       ; [A_S674] 
||         ADD     .D2     2,B4,B4           ; [B_D64P] |100| (P) <0,12> Define a twin register
||         INTSP   .L2     B7,B6             ; [B_L674] |103| (P) <0,12> 

	.dwpsn	file "t3.c",line 97,column 1,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .L2     B5                ; [B_L674] 
||^        MVKH    .S2     0x3e99999a,B19    ; [B_Sb674] 
||^        MV      .L1X    B5,A6             ; [A_L674] 
||^        STDW    .D2T1   A13:A12,*SP++(-8) ; [B_D64P] |97| 
||^        MVKL    .S1     ib,A12            ; [A_S674] 
	.dwcfi	cfa_offset, 48
	.dwcfi	save_reg_to_mem, 13, -36
	.dwcfi	save_reg_to_mem, 12, -40

           SPMASK                            ; [] 
||^        SET     .S2     B5,25,29,B18      ; [B_Sb674] 
||^        STW     .D2T2   B3,*SP++(-8)      ; [B_D64P] |97| 
||         MPYSP   .M1     A6,A16,A3         ; [A_M674] |102| (P) <0,14> 
	.dwcfi	cfa_offset, 56
	.dwcfi	save_reg_to_mem, 19, -48

           SPMASK                            ; [] 
||^        MVKL    .S1     ia,A13            ; [A_S674] 
||^        ADDK    .S2     -136,SP           ; [B_Sb674] |97| 
||         MPYSP   .M2     B18,B6,B22        ; [B_M674] |103| (P) <0,15> 

	.dwcfi	cfa_offset, 192
	.dwpsn	file "t3.c",line 102,column 9,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .L1     A21               ; [A_L674] |105| 
||^        MVKH    .S1     ia,A13            ; [A_S674] 
||         MPYSP   .M1     A6,A3,A3          ; [A_M674] |102| (P) <0,16> 
||         MPYSP   .M2     B18,B6,B7         ; [B_M674] |103| (P) <0,16> 

	.dwpsn	file "t3.c",line 105,column 9,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .D1     A17               ; [A_D64P] |105| 
||^        ZERO    .L1     A20               ; [A_L674] |105| 
||^        MVKH    .S1     ib,A12            ; [A_S674] 

	.dwpsn	file "t3.c",line 104,column 9,is_stmt,isa 0

           SPMASK                            ; [] 
||^        MV      .D1     A12,A9            ; [A_D64P] 
||^        MV      .L1     A13,A4            ; [A_L674] 
||         SHRU    .S2X    A25,8,B6          ; [B_Sb674] |104| (P) <0,18> 

	.dwpsn	file "t3.c",line 102,column 9,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ADD     .S2X    4,A13,B5          ; [B_Sb674] 
||         SUBSP   .S1     A3,A7,A3          ; [A_S674] |102| (P) <0,19> 

           MV      .D1X    B6,A3             ; [A_D64P] |104| <0,20> Define a twin register
||         SUBSP   .L2     B22,B19,B6        ; [B_L674] |103| <0,20> 
||         SUBSP   .S2     B7,B19,B7         ; [B_Sb674] |103| <0,20> 
||         SUBSP   .L1     A3,A7,A24         ; [A_L674] |102| <0,20> 

	.dwpsn	file "t3.c",line 104,column 9,is_stmt,isa 0

           STDW    .D1T1   A21:A20,*A9++(8)  ; [A_D64P] |105| <0,21> 
||         ADD     .S1X    B20,A3,A3         ; [A_S674] |104| <0,21> 
||         SHRU    .S2X    A24,8,B6          ; [B_Sb674] |104| <0,21> 

           STW     .D1T1   A3,*A4++(8)       ; [A_D64P] |104| <0,22> 
||         ADD     .S2     B20,B6,B6         ; [B_Sb674] |104| <0,22> 

	.dwpsn	file "t3.c",line 100,column 17,is_stmt,isa 0

           ADD     .S1     2,A17,A17         ; [A_S674] |100| <0,23> 
||         STW     .D2T2   B6,*B5++(8)       ; [B_D64P] |104| <0,23> 
||         STW     .D1T1   A3,*A5++(8)       ; [A_D64P] |102| <0,23> 

	.dwpsn	file "t3.c",line 102,column 9,is_stmt,isa 0

           SPKERNEL        0,0               ; [] 
||         STDW    .D2T2   B7:B6,*B16++(8)   ; [B_D64P] |103| <0,24> 
||         STW     .D1T1   A24,*A23++(8)     ; [A_D64P] |102| <0,24> 

;** --------------------------------------------------------------------------*
$C$L40:    ; PIPED LOOP EPILOG
           NOP             4                 ; [A_L674] 

           MVKL    .S2     results,B12       ; [B_Sb674] 
||         MVKL    .S1     sa,A11            ; [A_S674] 

	.dwpsn	file "t3.c",line 107,column 10,is_stmt,isa 0

           MV      .D2     B17,B11           ; [B_D64P] 
||         MVKH    .S2     results,B12       ; [B_Sb674] 
||         ZERO    .L1     A8                ; [A_L674] |107| 
||         MVKL    .S1     0xcccd,A15        ; [A_S674] 

           MVK     .S2     2000,B13          ; [B_Sb674] 
||         STW     .D2T1   A8,*SP(136)       ; [B_D64P] |107| 
||         MVKH    .S1     0xcccd,A15        ; [A_S674] 

           MVKH    .S1     sa,A11            ; [A_S674] 
           MVK     .S1     256,A14           ; [A_S674] 
           NOP             5                 ; [A_L674] 
           MVKL    .S1     xc,A5             ; [A_S674] 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t3.c",line 108,column 15,is_stmt,isa 0
           MVKL    .S1     $P$T0$1,A3        ; [A_S674] |108| 
           MVKH    .S1     $P$T0$1,A3        ; [A_S674] |108| 
	.dwpsn	file "t3.c",line 10,column 29,is_stmt,isa 0
$C$DW$96	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$96, DW_AT_low_pc(0x04)
	.dwattr $C$DW$96, DW_AT_name("fmac")
	.dwattr $C$DW$96, DW_AT_TI_call


           LDDW    .D1T2   *A3(0),B5:B4      ; [A_D64P] |108| 
||         CALL    .S1     fmac              ; [A_S674] |10| 

	.dwpsn	file "t3.c",line 108,column 15,is_stmt,isa 0
           LDW     .D2T1   *SP(136),A4       ; [B_D64P] |108| 
           MVKH    .S1     xc,A5             ; [A_S674] 
           MV      .L1     A5,A10            ; [A_L674] 
;** --------------------------------------------------------------------------*
;**   BEGIN LOOP $C$L41
;** --------------------------------------------------------------------------*
$C$L41:    
	.dwpsn	file "t3.c",line 10,column 29,is_stmt,isa 0
           ADDKPC  .S2     $C$RL0,B3,0       ; [B_Sb674] |10| 
	.dwpsn	file "t3.c",line 108,column 15,is_stmt,isa 0
           STDW    .D2T2   B5:B4,*SP(88)     ; [B_D64P] |108| 
	.dwpsn	file "t3.c",line 10,column 29,is_stmt,isa 0
$C$RL0:    ; CALL OCCURS {fmac} {0}          ; [] |10| 
;** --------------------------------------------------------------------------*

           MV      .L2X    A4,B4             ; [B_L674] |10| 
||         ADDAW   .D2     SP,24,B5          ; [B_D64P] |10| 

           STW     .D2T2   B4,*SP(96)        ; [B_D64P] |10| 
	.dwpsn	file "t3.c",line 10,column 43,is_stmt,isa 0
           LDW     .D2T1   *B5(0),A3         ; [B_D64P] |10| 
           ADDAW   .D2     SP,25,B4          ; [B_D64P] |10| 
           NOP             3                 ; [A_L674] 
           STW     .D2T1   A3,*B4(0)         ; [B_D64P] |10| 
	.dwpsn	file "t3.c",line 109,column 9,is_stmt,isa 0
$C$DW$97	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$97, DW_AT_low_pc(0x00)
	.dwattr $C$DW$97, DW_AT_name("put")
	.dwattr $C$DW$97, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |109| 
||         LDW     .D2T1   *SP(100),A4       ; [B_D64P] |109| 

$C$RL2:    ; CALLP OCCURS {put} {0}          ; [] |109| 
	.dwpsn	file "t3.c",line 110,column 9,is_stmt,isa 0
$C$DW$98	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$98, DW_AT_low_pc(0x00)
	.dwattr $C$DW$98, DW_AT_name("fscale")
	.dwattr $C$DW$98, DW_AT_TI_call


           CALLP   .S2     fscale,B3         ; [B_Sb674] |110| 
||         LDW     .D2T1   *SP(136),A4       ; [B_D64P] |110| 

$C$RL4:    ; CALLP OCCURS {fscale} {0}       ; [] |110| 
	.dwpsn	file "t3.c",line 111,column 39,is_stmt,isa 0
           MVK     .S2     64,B4             ; [B_Sb674] |111| 
           SUB     .L2     B4,1,B4           ; [B_L674] 
           MVC     .S2     B4,ILC            ; [B_Sb674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 111
;*    Loop opening brace source line   : 111
;*    Loop closing brace source line   : 111
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 12 due to a loop-carried dependence.
;*
;*    Known Minimum Iteration Count    : 64
;*    Known Maximum Iteration Count    : 64
;*    Known Max Iteration Count Factor : 64
;*    Loop Carried Dependency Bound(^) : 12
;*    Partitioned Resource Bound(*)    : 4
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     1        2     
;*      .D units                     1        4*    
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          2        2     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1        1     
;*      Bound(.L .S .D .LS .LSD)     2        3     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 12 Schedule found with 2 iterations in parallel
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
;*      $C$C1738:
;*   0              LDW     .D1T1   *A5++(4),A4       ; [A_D64P] |10|  ^ 
;*   1              NOP     3       ; [A_L674] 
;*   4              MVK     .S2     104,B5            ; [B_Sb674] |10| 
;*   5              STW     .D2T1   A4,*SP(104)       ; [B_D64P] |10|  ^ 
;*     ||           ADD     .L2     SP,B5,B4          ; [B_L674] |10| 
;*   6              LDW     .D2T2   *B4(0),B5         ; [B_D64P] |10|  ^ 
;*     ||           SHL     .S1     A3,5,A4           ; [A_S674] |111| 
;*   7              SUB     .L1     A4,A3,A3          ; [A_L674] |111| 
;*   8              NOP     1       ; [A_L674] 
;*   9              MVK     .S2     108,B4            ; [B_Sb674] |10| 
;*  10              ADD     .L2     SP,B4,B4          ; [B_L674] |10| 
;*  11              STW     .D2T2   B5,*B4(0)         ; [B_D64P] |10|  ^ 
;*  12              LDW     .D2T2   *SP(108),B4       ; [B_D64P] |111| 
;*  13              NOP     4       ; [A_L674] 
;*  17              ADD     .L1X    B4,A3,A3          ; [A_L674] |111| 
;*     ||           SPBR                              $C$C1738 ; [] 
;*  18              NOP     6       ; [A_L674] 
;*  24              ; BRANCHCC OCCURS {$C$C1738}      ; [] |111| 
;*----------------------------------------------------------------------------*
$C$L42:    ; PIPED LOOP PROLOG

           SPLOOPD         12                ;24 ; [A_L674] (P) 
||         MV      .S1     A10,A5            ; [A_S674] 

;** --------------------------------------------------------------------------*
$C$L43:    ; PIPED LOOP KERNEL
	.dwpsn	file "t3.c",line 10,column 29,is_stmt,isa 0
           LDW     .D1T1   *A5++(4),A4       ; [A_D64P] |10| (P) <0,0>  ^ 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t3.c",line 10,column 43,is_stmt,isa 0
           MVK     .S2     104,B5            ; [B_Sb674] |10| (P) <0,4> 
	.dwpsn	file "t3.c",line 10,column 29,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .L1     A3                ; [A_L674] |111| 
||         ADD     .L2     SP,B5,B4          ; [B_L674] |10| (P) <0,5> 
||         STW     .D2T1   A4,*SP(104)       ; [B_D64P] |10| (P) <0,5>  ^ 

	.dwpsn	file "t3.c",line 10,column 43,is_stmt,isa 0

           SHL     .S1     A3,5,A4           ; [A_S674] |111| (P) <0,6> 
||         LDW     .D2T2   *B4(0),B5         ; [B_D64P] |10| (P) <0,6>  ^ 

	.dwpsn	file "t3.c",line 111,column 52,is_stmt,isa 0
           SUB     .L1     A4,A3,A3          ; [A_L674] |111| (P) <0,7> 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t3.c",line 10,column 43,is_stmt,isa 0
           MVK     .S2     108,B4            ; [B_Sb674] |10| (P) <0,9> 
           ADD     .L2     SP,B4,B4          ; [B_L674] |10| (P) <0,10> 
           STW     .D2T2   B5,*B4(0)         ; [B_D64P] |10| (P) <0,11>  ^ 
	.dwpsn	file "t3.c",line 111,column 52,is_stmt,isa 0
           LDW     .D2T2   *SP(108),B4       ; [B_D64P] |111| <0,12> 
           NOP             3                 ; [A_L674] 
           NOP             1                 ; [A_L674] 

           SPKERNEL        0,0               ; [] 
||         ADD     .L1X    B4,A3,A3          ; [A_L674] |111| <0,17> 

;** --------------------------------------------------------------------------*
$C$L44:    ; PIPED LOOP EPILOG
	.dwpsn	file "t3.c",line 112,column 9,is_stmt,isa 0
           MV      .L1     A14,A6            ; [A_L674] |112| 
	.dwpsn	file "t3.c",line 111,column 76,is_stmt,isa 0
$C$DW$99	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$99, DW_AT_low_pc(0x00)
	.dwattr $C$DW$99, DW_AT_name("put")
	.dwattr $C$DW$99, DW_AT_TI_call

           CALL    .S1     put               ; [A_S674] |111| 
           ADDKPC  .S2     $C$RL6,B3,3       ; [B_Sb674] |111| 
           MV      .L1     A3,A4             ; [A_L674] |111| 
$C$RL6:    ; CALL OCCURS {put} {0}           ; [] |111| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t3.c",line 112,column 9,is_stmt,isa 0
$C$DW$100	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$100, DW_AT_low_pc(0x00)
	.dwattr $C$DW$100, DW_AT_name("memset")
	.dwattr $C$DW$100, DW_AT_TI_call


           CALLP   .S2     memset,B3         ; [B_Sb674] |112| 
||         ZERO    .L2     B4                ; [B_L674] |112| 
||         MV      .L1     A10,A4            ; [A_L674] |112| 

$C$RL8:    ; CALLP OCCURS {memset} {0}       ; [] |112| 
	.dwpsn	file "t3.c",line 113,column 9,is_stmt,isa 0
           ADDAW   .D2     SP,22,B4          ; [B_D64P] |113| 
	.dwpsn	file "t3.c",line 112,column 9,is_stmt,isa 0
$C$DW$101	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$101, DW_AT_low_pc(0x00)
	.dwattr $C$DW$101, DW_AT_name("fbiquad")
	.dwattr $C$DW$101, DW_AT_TI_call


           CALLP   .S2     fbiquad,B3        ; [B_Sb674] |113| 
||         LDW     .D2T1   *SP(136),A4       ; [B_D64P] |112| 

	.dwpsn	file "t3.c",line 113,column 9,is_stmt,isa 0
$C$RL10:   ; CALLP OCCURS {fbiquad} {0}      ; [] |113| 
	.dwpsn	file "t3.c",line 114,column 39,is_stmt,isa 0
           MVK     .S2     64,B4             ; [B_Sb674] |114| 
           SUB     .L2     B4,1,B4           ; [B_L674] 
           MVC     .S2     B4,ILC            ; [B_Sb674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 114
;*    Loop opening brace source line   : 114
;*    Loop closing brace source line   : 114
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 12 due to a loop-carried dependence.
;*
;*    Known Minimum Iteration Count    : 64
;*    Known Maximum Iteration Count    : 64
;*    Known Max Iteration Count Factor : 64
;*    Loop Carried Dependency Bound(^) : 12
;*    Partitioned Resource Bound(*)    : 4
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     1        2     
;*      .D units                     1        4*    
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          2        2     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             1        1     
;*      Bound(.L .S .D .LS .LSD)     2        3     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 12 Schedule found with 2 iterations in parallel
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
;*      $C$C1652:
;*   0              LDW     .D1T1   *A5++(4),A4       ; [A_D64P] |10|  ^ 
;*   1              NOP     3       ; [A_L674] 
;*   4              MVK     .S2     112,B5            ; [B_Sb674] |10| 
;*   5              STW     .D2T1   A4,*SP(112)       ; [B_D64P] |10|  ^ 
;*     ||           ADD     .L2     SP,B5,B4          ; [B_L674] |10| 
;*   6              LDW     .D2T2   *B4(0),B5         ; [B_D64P] |10|  ^ 
;*     ||           SHL     .S1     A3,5,A4           ; [A_S674] |114| 
;*   7              SUB     .L1     A4,A3,A3          ; [A_L674] |114| 
;*   8              NOP     1       ; [A_L674] 
;*   9              MVK     .S2     116,B4            ; [B_Sb674] |10| 
;*  10              ADD     .L2     SP,B4,B4          ; [B_L674] |10| 
;*  11              STW     .D2T2   B5,*B4(0)         ; [B_D64P] |10|  ^ 
;*  12              LDW     .D2T2   *SP(116),B4       ; [B_D64P] |114| 
;*  13              NOP     4       ; [A_L674] 
;*  17              ADD     .L1X    B4,A3,A3          ; [A_L674] |114| 
;*     ||           SPBR                              $C$C1652 ; [] 
;*  18              NOP     6       ; [A_L674] 
;*  24              ; BRANCHCC OCCURS {$C$C1652}      ; [] |114| 
;*----------------------------------------------------------------------------*
$C$L45:    ; PIPED LOOP PROLOG

           SPLOOPD         12                ;24 ; [A_L674] (P) 
||         MV      .S1     A10,A5            ; [A_S674] 

;** --------------------------------------------------------------------------*
$C$L46:    ; PIPED LOOP KERNEL
	.dwpsn	file "t3.c",line 10,column 29,is_stmt,isa 0
           LDW     .D1T1   *A5++(4),A4       ; [A_D64P] |10| (P) <0,0>  ^ 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t3.c",line 10,column 43,is_stmt,isa 0
           MVK     .S2     112,B5            ; [B_Sb674] |10| (P) <0,4> 
	.dwpsn	file "t3.c",line 10,column 29,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .L1     A3                ; [A_L674] |114| 
||         ADD     .L2     SP,B5,B4          ; [B_L674] |10| (P) <0,5> 
||         STW     .D2T1   A4,*SP(112)       ; [B_D64P] |10| (P) <0,5>  ^ 

	.dwpsn	file "t3.c",line 10,column 43,is_stmt,isa 0

           SHL     .S1     A3,5,A4           ; [A_S674] |114| (P) <0,6> 
||         LDW     .D2T2   *B4(0),B5         ; [B_D64P] |10| (P) <0,6>  ^ 

	.dwpsn	file "t3.c",line 114,column 52,is_stmt,isa 0
           SUB     .L1     A4,A3,A3          ; [A_L674] |114| (P) <0,7> 
           NOP             1                 ; [A_L674] 
	.dwpsn	file "t3.c",line 10,column 43,is_stmt,isa 0
           MVK     .S2     116,B4            ; [B_Sb674] |10| (P) <0,9> 
           ADD     .L2     SP,B4,B4          ; [B_L674] |10| (P) <0,10> 
           STW     .D2T2   B5,*B4(0)         ; [B_D64P] |10| (P) <0,11>  ^ 
	.dwpsn	file "t3.c",line 114,column 52,is_stmt,isa 0
           LDW     .D2T2   *SP(116),B4       ; [B_D64P] |114| <0,12> 
           NOP             3                 ; [A_L674] 
           NOP             1                 ; [A_L674] 

           SPKERNEL        0,0               ; [] 
||         ADD     .L1X    B4,A3,A3          ; [A_L674] |114| <0,17> 

;** --------------------------------------------------------------------------*
$C$L47:    ; PIPED LOOP EPILOG
	.dwpsn	file "t3.c",line 115,column 9,is_stmt,isa 0
           MV      .L1     A14,A6            ; [A_L674] |115| 
	.dwpsn	file "t3.c",line 10,column 43,is_stmt,isa 0
$C$DW$102	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$102, DW_AT_low_pc(0x04)
	.dwattr $C$DW$102, DW_AT_name("put")
	.dwattr $C$DW$102, DW_AT_TI_call


           ADDAW   .D2     SP,33,B31         ; [B_D64P] |10| 
||         CALL    .S1     put               ; [A_S674] |114| 

	.dwpsn	file "t3.c",line 114,column 76,is_stmt,isa 0
           ADDKPC  .S2     $C$RL12,B3,3      ; [B_Sb674] |114| 
           MV      .L1     A3,A4             ; [A_L674] |114| 
$C$RL12:   ; CALL OCCURS {put} {0}           ; [] |114| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t3.c",line 10,column 29,is_stmt,isa 0
           LDW     .D2T2   *SP(88),B5        ; [B_D64P] |10| 
	.dwpsn	file "t3.c",line 10,column 43,is_stmt,isa 0
           ADDAW   .D2     SP,30,B4          ; [B_D64P] |10| 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t3.c",line 10,column 29,is_stmt,isa 0

           STW     .D2T2   B5,*SP(120)       ; [B_D64P] |10| 
||         MV      .L1X    B4,A3             ; [A_L674] |10| Define a twin register

	.dwpsn	file "t3.c",line 10,column 43,is_stmt,isa 0
           LDW     .D1T1   *A3(0),A3         ; [A_D64P] |10| 
           ADDAW   .D2     SP,31,B4          ; [B_D64P] |10| 
           NOP             3                 ; [A_L674] 
           STW     .D2T1   A3,*B4(0)         ; [B_D64P] |10| 
	.dwpsn	file "t3.c",line 114,column 84,is_stmt,isa 0
$C$DW$103	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$103, DW_AT_low_pc(0x00)
	.dwattr $C$DW$103, DW_AT_name("put")
	.dwattr $C$DW$103, DW_AT_TI_call


           CALLP   .S2     put,B3            ; [B_Sb674] |114| 
||         LDW     .D2T1   *SP(124),A4       ; [B_D64P] |114| 

$C$RL14:   ; CALLP OCCURS {put} {0}          ; [] |114| 
	.dwpsn	file "t3.c",line 10,column 29,is_stmt,isa 0
           LDW     .D2T2   *SP(92),B5        ; [B_D64P] |10| 
	.dwpsn	file "t3.c",line 10,column 43,is_stmt,isa 0
           ADDAW   .D2     SP,32,B4          ; [B_D64P] |10| 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t3.c",line 10,column 29,is_stmt,isa 0
           STW     .D2T2   B5,*SP(128)       ; [B_D64P] |10| 
	.dwpsn	file "t3.c",line 10,column 43,is_stmt,isa 0
           LDW     .D2T1   *B4(0),A3         ; [B_D64P] |10| 
           MV      .L1X    B31,A4            ; [A_L674] |10| Define a twin register
           NOP             3                 ; [A_L674] 
           STW     .D1T1   A3,*A4(0)         ; [A_D64P] |10| 
	.dwpsn	file "t3.c",line 9,column 31,is_stmt,isa 0
           LDW     .D2T2   *+DP(ri),B10      ; [B_D64P] |9| 
	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0
           LDW     .D2T2   *SP(132),B4       ; [B_D64P] |9| 
	.dwpsn	file "t3.c",line 115,column 9,is_stmt,isa 0
           MV      .L1     A10,A4            ; [A_L674] |115| 
           NOP             2                 ; [A_L674] 
	.dwpsn	file "t3.c",line 9,column 31,is_stmt,isa 0
           CMPLT   .L2     B10,B13,B0        ; [B_L674] |9| 
	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0

   [ B0]   STW     .D2T2   B4,*+B12[B10]     ; [B_D64P] |9| 
|| [ B0]   ADD     .L2     1,B10,B10         ; [B_L674] |9| 

$C$DW$104	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$104, DW_AT_low_pc(0x00)
	.dwattr $C$DW$104, DW_AT_name("memset")
	.dwattr $C$DW$104, DW_AT_TI_call


           CALLP   .S2     memset,B3         ; [B_Sb674] |115| 
|| [ B0]   STW     .D2T2   B10,*+DP(ri)      ; [B_D64P] |9| 
||         ZERO    .L2     B4                ; [B_L674] |115| 

	.dwpsn	file "t3.c",line 115,column 9,is_stmt,isa 0
$C$RL16:   ; CALLP OCCURS {memset} {0}       ; [] |115| 
	.dwpsn	file "t3.c",line 9,column 29,is_stmt,isa 0
$C$DW$105	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$105, DW_AT_low_pc(0x00)
	.dwattr $C$DW$105, DW_AT_name("isum")
	.dwattr $C$DW$105, DW_AT_TI_call


           CALLP   .S2     isum,B3           ; [B_Sb674] |9| 
||         LDW     .D2T1   *SP(136),A4       ; [B_D64P] |115| 

$C$RL18:   ; CALLP OCCURS {isum} {0}         ; [] |9| 
	.dwpsn	file "t3.c",line 9,column 31,is_stmt,isa 0
           CMPLT   .L2     B10,B13,B0        ; [B_L674] |9| 
	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0
   [ B0]   STW     .D2T1   A4,*+B12[B10]     ; [B_D64P] |9| 

   [ B0]   ADD     .L2     1,B10,B10         ; [B_L674] |9| 
||         LDW     .D2T1   *SP(136),A4       ; [B_D64P] |117| 

$C$DW$106	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$106, DW_AT_low_pc(0x04)
	.dwattr $C$DW$106, DW_AT_name("icopy")
	.dwattr $C$DW$106, DW_AT_TI_call


   [ B0]   STW     .D2T2   B10,*+DP(ri)      ; [B_D64P] |9| 
||         CALLP   .S2     icopy,B3          ; [B_Sb674] |117| 

	.dwpsn	file "t3.c",line 117,column 9,is_stmt,isa 0
$C$RL20:   ; CALLP OCCURS {icopy} {0}        ; [] |117| 
	.dwpsn	file "t3.c",line 118,column 39,is_stmt,isa 0
           MVK     .S2     32,B5             ; [B_Sb674] |118| 
           SUB     .L2     B5,1,B5           ; [B_L674] 
           MVC     .S2     B5,ILC            ; [B_Sb674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 118
;*    Loop opening brace source line   : 118
;*    Loop closing brace source line   : 118
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 6 due to a loop-carried dependence.
;*
;*    Loop Unroll Multiple             : 2x
;*    Known Minimum Iteration Count    : 32
;*    Known Maximum Iteration Count    : 32
;*    Known Max Iteration Count Factor : 32
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
;*    For further improvement on this loop, try option -mh8
;*
;*    Minimum safe iteration count    : 1 (after unrolling)
;*----------------------------------------------------------------------------*
;*      SINGLE SCHEDULED ITERATION
;*
;*      $C$C1566:
;*   0              LDDW    .D2T1   *B4++(8),A5:A4    ; [B_D64P] |118| 
;*   1              NOP     2       ; [A_L674] 
;*   3              SHL     .S1     A4,5,A3           ; [A_S674] |118|  ^ 
;*   4              SUB     .L1     A3,A4,A3          ; [A_L674] |118|  ^ 
;*   5              ADD     .L1     A4,A3,A4          ; [A_L674] |118|  ^ 
;*   6              SHL     .S1     A4,5,A3           ; [A_S674] |118|  ^ 
;*   7              SUB     .L1     A3,A4,A3          ; [A_L674] |118|  ^ 
;*   8              ADD     .L1     A5,A3,A4          ; [A_L674] |118|  ^ 
;*     ||           SPBR                              $C$C1566 ; [] 
;*   9              NOP     3       ; [A_L674] 
;*  12              ; BRANCHCC OCCURS {$C$C1566}      ; [] |118| 
;*----------------------------------------------------------------------------*
$C$L48:    ; PIPED LOOP PROLOG

           SPLOOPD         6                 ;12 ; [A_L674] (P) 
||         MV      .L2X    A12,B4            ; [B_L674] 

;** --------------------------------------------------------------------------*
$C$L49:    ; PIPED LOOP KERNEL
	.dwpsn	file "t3.c",line 118,column 22,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .L1     A4                ; [A_L674] |118| 
||         LDDW    .D2T1   *B4++(8),A5:A4    ; [B_D64P] |118| (P) <0,0> 

           NOP             2                 ; [A_L674] 
	.dwpsn	file "t3.c",line 118,column 52,is_stmt,isa 0
           SHL     .S1     A4,5,A3           ; [A_S674] |118| (P) <0,3>  ^ 
           SUB     .L1     A3,A4,A3          ; [A_L674] |118| (P) <0,4>  ^ 
           ADD     .L1     A4,A3,A4          ; [A_L674] |118| (P) <0,5>  ^ 
           SHL     .S1     A4,5,A3           ; [A_S674] |118| <0,6>  ^ 
           SUB     .L1     A3,A4,A3          ; [A_L674] |118| <0,7>  ^ 

           SPKERNEL        0,0               ; [] 
||         ADD     .L1     A5,A3,A4          ; [A_L674] |118| <0,8>  ^ 

;** --------------------------------------------------------------------------*
$C$L50:    ; PIPED LOOP EPILOG
	.dwpsn	file "t3.c",line 9,column 31,is_stmt,isa 0

           ZERO    .S2     B4                ; [B_Sb674] |119| 
||         MV      .L1     A14,A6            ; [A_L674] |119| 
||         CMPLT   .L2     B10,B13,B0        ; [B_L674] |9| 

	.dwpsn	file "t3.c",line 119,column 9,is_stmt,isa 0
$C$DW$107	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$107, DW_AT_low_pc(0x00)
	.dwattr $C$DW$107, DW_AT_name("memset")
	.dwattr $C$DW$107, DW_AT_TI_call

           CALL    .S1     memset            ; [A_S674] |119| 
           ADDKPC  .S2     $C$RL22,B3,0      ; [B_Sb674] |119| 
	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0

           MV      .L1     A12,A4            ; [A_L674] |119| 
|| [ B0]   ADD     .L2     1,B10,B10         ; [B_L674] |9| 
|| [ B0]   STW     .D2T1   A4,*+B12[B10]     ; [B_D64P] |9| 

   [ B0]   STW     .D2T2   B10,*+DP(ri)      ; [B_D64P] |9| 
           NOP             2                 ; [A_L674] 
	.dwpsn	file "t3.c",line 119,column 9,is_stmt,isa 0
$C$RL22:   ; CALL OCCURS {memset} {0}        ; [] |119| 
;** --------------------------------------------------------------------------*
$C$DW$108	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$108, DW_AT_low_pc(0x00)
	.dwattr $C$DW$108, DW_AT_name("ssat")
	.dwattr $C$DW$108, DW_AT_TI_call


           CALLP   .S2     ssat,B3           ; [B_Sb674] |120| 
||         LDW     .D2T1   *SP(136),A4       ; [B_D64P] |119| 

	.dwpsn	file "t3.c",line 120,column 9,is_stmt,isa 0
$C$RL24:   ; CALLP OCCURS {ssat} {0}         ; [] |120| 
	.dwpsn	file "t3.c",line 121,column 39,is_stmt,isa 0
           MVK     .S2     32,B4             ; [B_Sb674] |121| 
           SUB     .L2     B4,1,B4           ; [B_L674] 
           MVC     .S2     B4,ILC            ; [B_Sb674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 121
;*    Loop opening brace source line   : 121
;*    Loop closing brace source line   : 121
;*
;*    Summary:
;*      - The compiler successfully software pipelined this loop.
;*      - The compiler cannot start scheduling attempts at an ii lower
;*        than 6 due to a loop-carried dependence.
;*
;*    Loop Unroll Multiple             : 2x
;*    Known Minimum Iteration Count    : 32
;*    Known Maximum Iteration Count    : 32
;*    Known Max Iteration Count Factor : 32
;*    Loop Carried Dependency Bound(^) : 6
;*    Partitioned Resource Bound(*)    : 3
;*    Resource Partition:
;*                                A-side   B-side
;*      .L units                     0        0     
;*      .S units                     3*       1     
;*      .D units                     1        0     
;*      .M units                     0        0     
;*      .X cross paths               0        0     
;*      .T address paths             0        0     
;*      Logical  ops (.LS)           0        0     (.L or .S unit)
;*      Addition ops (.LSD)          4        0     (.L or .S or .D unit)
;*      Bound(.L .S .LS)             2        1     
;*      Bound(.L .S .D .LS .LSD)     3*       1     
;*
;*    Searching for software pipeline schedule at ...
;*      ii = 6  Schedule found with 2 iterations in parallel
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
;*      $C$C1480:
;*   0              LDW     .D1T1   *A5++(4),A3       ; [A_D64P] |121| 
;*   1              NOP     3       ; [A_L674] 
;*   4              SHL     .S1     A4,5,A6           ; [A_S674] |121|  ^ 
;*   5              SHRU    .S2X    A3,16,B4          ; [B_Sb674] |121| 
;*     ||           EXTU    .S1     A3,16,16,A4       ; [A_S674] |121| 
;*     ||           SUB     .L1     A6,A4,A3          ; [A_L674] |121|  ^ 
;*   6              ADD     .L1     A4,A3,A4          ; [A_L674] |121|  ^ 
;*   7              SHL     .S1     A4,5,A3           ; [A_S674] |121|  ^ 
;*   8              SUB     .L1     A3,A4,A3          ; [A_L674] |121|  ^ 
;*   9              ADD     .L1X    B4,A3,A4          ; [A_L674] |121|  ^ 
;*     ||           SPBR                              $C$C1480 ; [] 
;*  10              NOP     2       ; [A_L674] 
;*  12              ; BRANCHCC OCCURS {$C$C1480}      ; [] |121| 
;*----------------------------------------------------------------------------*
$C$L51:    ; PIPED LOOP PROLOG

           SPLOOPD         6                 ;12 ; [A_L674] (P) 
||         MV      .S1     A11,A5            ; [A_S674] 

;** --------------------------------------------------------------------------*
$C$L52:    ; PIPED LOOP KERNEL
	.dwpsn	file "t3.c",line 121,column 52,is_stmt,isa 0
           LDW     .D1T1   *A5++(4),A3       ; [A_D64P] |121| (P) <0,0> 
           NOP             2                 ; [A_L674] 
	.dwpsn	file "t3.c",line 121,column 22,is_stmt,isa 0

           SPMASK                            ; [] 
||^        ZERO    .L1     A4                ; [A_L674] |121| 

	.dwpsn	file "t3.c",line 121,column 52,is_stmt,isa 0
           SHL     .S1     A4,5,A6           ; [A_S674] |121| (P) <0,4>  ^ 

           SHRU    .S2X    A3,16,B4          ; [B_Sb674] |121| (P) <0,5> 
||         SUB     .L1     A6,A4,A3          ; [A_L674] |121| (P) <0,5>  ^ 
||         EXTU    .S1     A3,16,16,A4       ; [A_S674] |121| (P) <0,5> 

           ADD     .L1     A4,A3,A4          ; [A_L674] |121| <0,6>  ^ 
           SHL     .S1     A4,5,A3           ; [A_S674] |121| <0,7>  ^ 
           SUB     .L1     A3,A4,A3          ; [A_L674] |121| <0,8>  ^ 

           SPKERNEL        0,0               ; [] 
||         ADD     .L1X    B4,A3,A4          ; [A_L674] |121| <0,9>  ^ 

;** --------------------------------------------------------------------------*
$C$L53:    ; PIPED LOOP EPILOG
	.dwpsn	file "t3.c",line 9,column 31,is_stmt,isa 0
$C$DW$109	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$109, DW_AT_low_pc(0x08)
	.dwattr $C$DW$109, DW_AT_name("memset")
	.dwattr $C$DW$109, DW_AT_TI_call


           MVK     .S1     128,A6            ; [A_S674] 
||         CMPLT   .L2     B10,B13,B0        ; [B_L674] |9| 
||         CALL    .S2     memset            ; [B_Sb674] |122| 

	.dwpsn	file "t3.c",line 122,column 9,is_stmt,isa 0
           ADDKPC  .S2     $C$RL26,B3,1      ; [B_Sb674] |122| 
           ZERO    .L2     B4                ; [B_L674] |122| 
	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0

           MV      .L1     A11,A4            ; [A_L674] |122| 
|| [ B0]   ADD     .L2     1,B10,B10         ; [B_L674] |9| 
|| [ B0]   STW     .D2T1   A4,*+B12[B10]     ; [B_D64P] |9| 

   [ B0]   STW     .D2T2   B10,*+DP(ri)      ; [B_D64P] |9| 
	.dwpsn	file "t3.c",line 122,column 9,is_stmt,isa 0
$C$RL26:   ; CALL OCCURS {memset} {0}        ; [] |122| 
;** --------------------------------------------------------------------------*
           LDW     .D2T1   *SP(136),A3       ; [B_D64P] |122| 
	.dwpsn	file "t3.c",line 9,column 29,is_stmt,isa 0
           LDW     .D2T1   *SP(136),A0       ; [B_D64P] |9| 
           MVK     .L1     5,A5              ; [A_L674] |9| 
           MVK     .L2     7,B31             ; [B_L674] |9| 
	.dwpsn	file "t3.c",line 107,column 17,is_stmt,isa 0
           MVK     .S1     41,A31            ; [A_S674] |107| 
	.dwpsn	file "t3.c",line 9,column 29,is_stmt,isa 0
           EXT     .S1     A3,1,2,A3         ; [A_S674] |9| 
$C$DW$110	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$110, DW_AT_low_pc(0x00)
	.dwattr $C$DW$110, DW_AT_name("find")
	.dwattr $C$DW$110, DW_AT_TI_call


           CALLP   .S2     find,B3           ; [B_Sb674] |9| 
||         LDW     .D1T2   *+A13[A3],B4      ; [A_D64P] |9| 
|| [ A0]   MV      .L1     A0,A4             ; [A_L674] |9| 
|| [!A0]   MVK     .S1     1,A4              ; [A_S674] |9| 

$C$RL28:   ; CALLP OCCURS {find} {0}         ; [] |9| 
           LDW     .D2T1   *SP(136),A3       ; [B_D64P] |9| 
	.dwpsn	file "t3.c",line 9,column 31,is_stmt,isa 0
           CMPLT   .L2     B10,B13,B0        ; [B_L674] |9| 
	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0
   [ B0]   STW     .D2T1   A4,*+B12[B10]     ; [B_D64P] |9| 
   [ B0]   ADD     .L2     1,B10,B10         ; [B_L674] |9| 
   [ B0]   STW     .D2T2   B10,*+DP(ri)      ; [B_D64P] |9| 
	.dwpsn	file "t3.c",line 9,column 29,is_stmt,isa 0

           MPY     .M2X    A3,B11,B4         ; [B_M674] |9| 
||         MPYUS   .M1     A15,A3,A3         ; [A_M674] |9| 

           NOP             1                 ; [A_L674] 
           SHRU    .S1     A3,2,A3           ; [A_S674] |9| 

           MPYHL   .M1     A3,A5,A5          ; [A_M674] |9| 
||         LDW     .D2T1   *SP(136),A3       ; [B_D64P] |9| 

           SHR     .S2     B4,1,B5           ; [B_Sb674] |9| 
           MPYHL   .M2     B5,B31,B4         ; [B_M674] |9| 
           NOP             2                 ; [A_L674] 

           SUB     .L1X    A3,B4,A4          ; [A_L674] |9| 
||         SUB     .S1     A3,A5,A3          ; [A_S674] |9| 

           ADD     .L1     1,A4,A4           ; [A_L674] |9| 
$C$DW$111	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$111, DW_AT_low_pc(0x04)
	.dwattr $C$DW$111, DW_AT_name("nested")
	.dwattr $C$DW$111, DW_AT_TI_call


           ADD     .L2X    1,A3,B4           ; [B_L674] |9| 
||         CALLP   .S2     nested,B3         ; [B_Sb674] |9| 

$C$RL30:   ; CALLP OCCURS {nested} {0}       ; [] |9| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t3.c",line 9,column 31,is_stmt,isa 0
           LDW     .D2T1   *SP(136),A3       ; [B_D64P] |9| 
           CMPLT   .L2     B10,B13,B0        ; [B_L674] |9| 
	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0
   [ B0]   STW     .D2T1   A4,*+B12[B10]     ; [B_D64P] |9| 
   [ B0]   ADD     .L2     1,B10,B10         ; [B_L674] |9| 
   [ B0]   STW     .D2T2   B10,*+DP(ri)      ; [B_D64P] |9| 
	.dwpsn	file "t3.c",line 107,column 17,is_stmt,isa 0
           ADD     .L1     1,A3,A3           ; [A_L674] |107| 
	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0

           CMPLT   .L1     A3,A31,A0         ; [A_L674] |107| 
||         STW     .D2T1   A3,*SP(136)       ; [B_D64P] |9| 
||         MVKL    .S1     $P$T0$1,A3        ; [A_S674] |108| 

	.dwpsn	file "t3.c",line 107,column 17,is_stmt,isa 0

   [!A0]   MVK     .S2     97,B11            ; [B_Sb674] 
|| [!A0]   ADD     .L1X    8,SP,A11          ; [A_L674] 
|| [!A0]   ZERO    .D1     A13               ; [A_D64P] |128| 
|| [ A0]   B       .S1     $C$L41            ; [A_S674] |107| 

	.dwpsn	file "t3.c",line 108,column 15,is_stmt,isa 0
           MVKH    .S1     $P$T0$1,A3        ; [A_S674] |108| 
	.dwpsn	file "t3.c",line 10,column 29,is_stmt,isa 0
$C$DW$112	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$112, DW_AT_low_pc(0x00)
	.dwattr $C$DW$112, DW_AT_name("fmac")
	.dwattr $C$DW$112, DW_AT_TI_call


   [ A0]   CALL    .S1     fmac              ; [A_S674] |10| 
|| [ A0]   LDDW    .D1T2   *A3(0),B5:B4      ; [A_D64P] |108| 

	.dwpsn	file "t3.c",line 108,column 15,is_stmt,isa 0
   [ A0]   LDW     .D2T1   *SP(136),A4       ; [B_D64P] |108| 
	.dwpsn	file "t3.c",line 128,column 14,is_stmt,isa 0
   [!A0]   ZERO    .L1     A10               ; [A_L674] |128| 
	.dwpsn	file "t3.c",line 128,column 21,is_stmt,isa 0
   [!A0]   MVK     .S1     70,A12            ; [A_S674] |128| 
	.dwpsn	file "t3.c",line 107,column 17,is_stmt,isa 0
           ; BRANCHCC OCCURS {$C$L41}        ; [] |107| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t3.c",line 128,column 39,is_stmt,isa 0
$C$DW$113	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$113, DW_AT_low_pc(0x00)
	.dwattr $C$DW$113, DW_AT_name("memset")
	.dwattr $C$DW$113, DW_AT_TI_call

           CALL    .S1     memset            ; [A_S674] |128| 
           ADD     .L1X    8,SP,A4           ; [A_L674] |128| 
           MV      .L2     B11,B4            ; [B_L674] |128| 
           MV      .L1     A10,A6            ; [A_L674] |128| 
           NOP             1                 ; [A_L674] 
;*----------------------------------------------------------------------------*
;*  SOFTWARE PIPELINE INFORMATION
;*    Loop found in file               : t3.c
;*    Loop source line                 : 128
;*    Loop opening brace source line   : 128
;*    Loop closing brace source line   : 128
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*    Disqualified loop: Loop contains a call
;*    Disqualified loop: Loop contains non-pipelinable instructions
;*----------------------------------------------------------------------------*
$C$L54:    
           ADDKPC  .S2     $C$RL32,B3,0      ; [B_Sb674] |128| 
$C$RL32:   ; CALL OCCURS {memset} {0}        ; [] |128| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t3.c",line 9,column 29,is_stmt,isa 0
$C$DW$114	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$114, DW_AT_low_pc(0x00)
	.dwattr $C$DW$114, DW_AT_name("slen")
	.dwattr $C$DW$114, DW_AT_TI_call


           CALLP   .S2     slen,B3           ; [B_Sb674] |9| 
||         STB     .D1T1   A13,*A11++(3)     ; [A_D64P] |128| 
||         ADD     .L1X    8,SP,A4           ; [A_L674] |9| 

$C$RL34:   ; CALLP OCCURS {slen} {0}         ; [] |9| 
;** --------------------------------------------------------------------------*

           ADD     .L1     3,A10,A10         ; [A_L674] |128| 
||         CMPLT   .L2     B10,B13,B0        ; [B_L674] |9| 
||         MV      .S2X    A4,B4             ; [B_Sb674] |9| 

	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0

           CMPLT   .L1     A10,A12,A0        ; [A_L674] |128| 
|| [ B0]   STW     .D2T2   B4,*+B12[B10]     ; [B_D64P] |9| 
|| [ B0]   ADD     .L2     1,B10,B10         ; [B_L674] |9| 

	.dwpsn	file "t3.c",line 128,column 21,is_stmt,isa 0
   [ A0]   B       .S1     $C$L54            ; [A_S674] |128| 
	.dwpsn	file "t3.c",line 128,column 39,is_stmt,isa 0
$C$DW$115	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$115, DW_AT_low_pc(0x00)
	.dwattr $C$DW$115, DW_AT_name("memset")
	.dwattr $C$DW$115, DW_AT_TI_call

   [ A0]   CALL    .S1     memset            ; [A_S674] |128| 
	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0
   [ B0]   STW     .D2T2   B10,*+DP(ri)      ; [B_D64P] |9| 
	.dwpsn	file "t3.c",line 128,column 39,is_stmt,isa 0
   [ A0]   MV      .L2     B11,B4            ; [B_L674] |128| 
   [ A0]   ADD     .L1X    8,SP,A4           ; [A_L674] |128| 
   [ A0]   MV      .L1     A10,A6            ; [A_L674] |128| 
	.dwpsn	file "t3.c",line 128,column 21,is_stmt,isa 0
           ; BRANCHCC OCCURS {$C$L54}        ; [] |128| 
;** --------------------------------------------------------------------------*
	.dwpsn	file "t3.c",line 9,column 31,is_stmt,isa 0

           ADDAW   .D2     SP,34,SP          ; [B_D64P] |135| 
||         MV      .L1     A13,A4            ; [A_L674] |9| 
||         MVKL    .S2     0x600df00d,B4     ; [B_Sb674] |9| 
||         CMPLT   .L2     B10,B13,B0        ; [B_L674] |9| 

	.dwcfi	cfa_offset, 56
	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0

           LDW     .D2T2   *++SP(8),B3       ; [B_D64P] |135| 
||         MVKH    .S2     0x600df00d,B4     ; [B_Sb674] |9| 

	.dwcfi	cfa_offset, 48
	.dwcfi	restore_reg, 19
	.dwpsn	file "t3.c",line 135,column 1,is_stmt,isa 0
           LDDW    .D2T1   *++SP(8),A13:A12  ; [B_D64P] |135| 
	.dwcfi	cfa_offset, 40
	.dwcfi	restore_reg, 13
	.dwcfi	restore_reg, 12
           LDDW    .D2T1   *++SP(8),A15:A14  ; [B_D64P] |135| 
	.dwcfi	cfa_offset, 32
	.dwcfi	restore_reg, 15
	.dwcfi	restore_reg, 14
	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0

   [ B0]   STW     .D2T2   B4,*+B12[B10]     ; [B_D64P] |9| 
||         ADD     .L2     1,B10,B4          ; [B_L674] |9| 

	.dwpsn	file "t3.c",line 135,column 1,is_stmt,isa 0
           LDDW    .D2T2   *++SP(8),B11:B10  ; [B_D64P] |135| 
	.dwcfi	cfa_offset, 24
	.dwcfi	restore_reg, 27
	.dwcfi	restore_reg, 26
           LDDW    .D2T2   *++SP(8),B13:B12  ; [B_D64P] |135| 
	.dwcfi	cfa_offset, 16
	.dwcfi	restore_reg, 29
	.dwcfi	restore_reg, 28
$C$DW$116	.dwtag  DW_TAG_TI_branch
	.dwattr $C$DW$116, DW_AT_low_pc(0x04)
	.dwattr $C$DW$116, DW_AT_TI_return


           LDW     .D2T1   *++SP(8),A10      ; [B_D64P] |135| 
||         RET     .S2     B3                ; [B_Sb674] |135| 

	.dwcfi	cfa_offset, 8
	.dwcfi	restore_reg, 10
           LDW     .D2T1   *++SP(8),A11      ; [B_D64P] |135| 
	.dwcfi	cfa_offset, 0
	.dwcfi	restore_reg, 11
	.dwpsn	file "t3.c",line 9,column 43,is_stmt,isa 0
   [ B0]   STW     .D2T2   B4,*+DP(ri)       ; [B_D64P] |9| 
           NOP             3                 ; [A_L674] 
	.dwpsn	file "t3.c",line 135,column 1,is_stmt,isa 0
           ; BRANCH OCCURS {B3}              ; [] |135| 
	.dwattr $C$DW$70, DW_AT_TI_end_file("t3.c")
	.dwattr $C$DW$70, DW_AT_TI_end_line(0x87)
	.dwattr $C$DW$70, DW_AT_TI_end_column(0x01)
	.dwendentry
	.dwendtag $C$DW$70

;*****************************************************************************
;* UNDEFINED EXTERNAL REFERENCES                                             *
;*****************************************************************************
	.global	memset

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

$C$DW$T$30	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$30, DW_AT_byte_size(0x10)
$C$DW$117	.dwtag  DW_TAG_member
	.dwattr $C$DW$117, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$117, DW_AT_name("__max_align1")
	.dwattr $C$DW$117, DW_AT_TI_symbol_name("__max_align1")
	.dwattr $C$DW$117, DW_AT_data_member_location[DW_OP_plus_uconst 0x0]
	.dwattr $C$DW$117, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$117, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$117, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$117, DW_AT_decl_column(0x0c)

$C$DW$118	.dwtag  DW_TAG_member
	.dwattr $C$DW$118, DW_AT_type(*$C$DW$T$20)
	.dwattr $C$DW$118, DW_AT_name("__max_align2")
	.dwattr $C$DW$118, DW_AT_TI_symbol_name("__max_align2")
	.dwattr $C$DW$118, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$118, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$118, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$118, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$118, DW_AT_decl_column(0x0e)

	.dwattr $C$DW$T$30, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$30, DW_AT_decl_line(0x7c)
	.dwattr $C$DW$T$30, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$T$30

$C$DW$T$33	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$33, DW_AT_name("__max_align_t")
	.dwattr $C$DW$T$33, DW_AT_type(*$C$DW$T$30)
	.dwattr $C$DW$T$33, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$33, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$33, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$T$33, DW_AT_decl_column(0x03)

$C$DW$T$2	.dwtag  DW_TAG_unspecified_type
	.dwattr $C$DW$T$2, DW_AT_name("void")

$C$DW$T$3	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$3, DW_AT_type(*$C$DW$T$2)
	.dwattr $C$DW$T$3, DW_AT_address_class(0x20)

$C$DW$T$4	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$4, DW_AT_encoding(DW_ATE_boolean)
	.dwattr $C$DW$T$4, DW_AT_name("bool")
	.dwattr $C$DW$T$4, DW_AT_byte_size(0x01)

$C$DW$T$5	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$5, DW_AT_encoding(DW_ATE_signed_char)
	.dwattr $C$DW$T$5, DW_AT_name("signed char")
	.dwattr $C$DW$T$5, DW_AT_byte_size(0x01)

$C$DW$T$66	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$66, DW_AT_name("__int8_t")
	.dwattr $C$DW$T$66, DW_AT_type(*$C$DW$T$5)
	.dwattr $C$DW$T$66, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$66, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$66, DW_AT_decl_line(0x5e)
	.dwattr $C$DW$T$66, DW_AT_decl_column(0x16)

$C$DW$T$67	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$67, DW_AT_name("__int_least8_t")
	.dwattr $C$DW$T$67, DW_AT_type(*$C$DW$T$66)
	.dwattr $C$DW$T$67, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$67, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$67, DW_AT_decl_line(0x7d)
	.dwattr $C$DW$T$67, DW_AT_decl_column(0x12)

$C$DW$T$6	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$6, DW_AT_encoding(DW_ATE_unsigned_char)
	.dwattr $C$DW$T$6, DW_AT_name("unsigned char")
	.dwattr $C$DW$T$6, DW_AT_byte_size(0x01)

$C$DW$T$31	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$31, DW_AT_type(*$C$DW$T$6)
	.dwattr $C$DW$T$31, DW_AT_address_class(0x20)

$C$DW$T$68	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$68, DW_AT_name("__uint8_t")
	.dwattr $C$DW$T$68, DW_AT_type(*$C$DW$T$6)
	.dwattr $C$DW$T$68, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$68, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$68, DW_AT_decl_line(0x5f)
	.dwattr $C$DW$T$68, DW_AT_decl_column(0x18)

$C$DW$T$69	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$69, DW_AT_name("__sa_family_t")
	.dwattr $C$DW$T$69, DW_AT_type(*$C$DW$T$68)
	.dwattr $C$DW$T$69, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$69, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$69, DW_AT_decl_line(0x47)
	.dwattr $C$DW$T$69, DW_AT_decl_column(0x13)

$C$DW$T$70	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$70, DW_AT_name("__uint_least8_t")
	.dwattr $C$DW$T$70, DW_AT_type(*$C$DW$T$68)
	.dwattr $C$DW$T$70, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$70, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$70, DW_AT_decl_line(0x92)
	.dwattr $C$DW$T$70, DW_AT_decl_column(0x13)

$C$DW$T$7	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$7, DW_AT_encoding(DW_ATE_signed_char)
	.dwattr $C$DW$T$7, DW_AT_name("wchar_t")
	.dwattr $C$DW$T$7, DW_AT_byte_size(0x02)

$C$DW$T$8	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$8, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$8, DW_AT_name("short")
	.dwattr $C$DW$T$8, DW_AT_byte_size(0x02)


$C$DW$T$72	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$72, DW_AT_type(*$C$DW$T$8)
	.dwattr $C$DW$T$72, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$72, DW_AT_byte_size(0x80)
$C$DW$119	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$119, DW_AT_upper_bound(0x3f)

	.dwendtag $C$DW$T$72

$C$DW$T$75	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$75, DW_AT_name("__int16_t")
	.dwattr $C$DW$T$75, DW_AT_type(*$C$DW$T$8)
	.dwattr $C$DW$T$75, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$75, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$75, DW_AT_decl_line(0x60)
	.dwattr $C$DW$T$75, DW_AT_decl_column(0x11)

$C$DW$T$76	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$76, DW_AT_name("__int_least16_t")
	.dwattr $C$DW$T$76, DW_AT_type(*$C$DW$T$75)
	.dwattr $C$DW$T$76, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$76, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$76, DW_AT_decl_line(0x7e)
	.dwattr $C$DW$T$76, DW_AT_decl_column(0x13)

$C$DW$T$9	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$9, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$9, DW_AT_name("unsigned short")
	.dwattr $C$DW$T$9, DW_AT_byte_size(0x02)

$C$DW$T$77	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$77, DW_AT_name("___wchar_t")
	.dwattr $C$DW$T$77, DW_AT_type(*$C$DW$T$9)
	.dwattr $C$DW$T$77, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$77, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$77, DW_AT_decl_line(0x9b)
	.dwattr $C$DW$T$77, DW_AT_decl_column(0x1a)

$C$DW$T$78	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$78, DW_AT_name("__uint16_t")
	.dwattr $C$DW$T$78, DW_AT_type(*$C$DW$T$9)
	.dwattr $C$DW$T$78, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$78, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$78, DW_AT_decl_line(0x61)
	.dwattr $C$DW$T$78, DW_AT_decl_column(0x19)

$C$DW$T$79	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$79, DW_AT_name("__mode_t")
	.dwattr $C$DW$T$79, DW_AT_type(*$C$DW$T$78)
	.dwattr $C$DW$T$79, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$79, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$79, DW_AT_decl_line(0x3a)
	.dwattr $C$DW$T$79, DW_AT_decl_column(0x14)

$C$DW$T$80	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$80, DW_AT_name("__uint_least16_t")
	.dwattr $C$DW$T$80, DW_AT_type(*$C$DW$T$78)
	.dwattr $C$DW$T$80, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$80, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$80, DW_AT_decl_line(0x93)
	.dwattr $C$DW$T$80, DW_AT_decl_column(0x14)

$C$DW$T$81	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$81, DW_AT_name("__char16_t")
	.dwattr $C$DW$T$81, DW_AT_type(*$C$DW$T$80)
	.dwattr $C$DW$T$81, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$81, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$81, DW_AT_decl_line(0x73)
	.dwattr $C$DW$T$81, DW_AT_decl_column(0x1a)

$C$DW$T$10	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$10, DW_AT_encoding(DW_ATE_signed)
	.dwattr $C$DW$T$10, DW_AT_name("int")
	.dwattr $C$DW$T$10, DW_AT_byte_size(0x04)

$C$DW$T$82	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$82, DW_AT_name("_Mbstatet")
	.dwattr $C$DW$T$82, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$82, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$82, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$82, DW_AT_decl_line(0x91)
	.dwattr $C$DW$T$82, DW_AT_decl_column(0x0d)

$C$DW$T$83	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$83, DW_AT_name("__mbstate_t")
	.dwattr $C$DW$T$83, DW_AT_type(*$C$DW$T$82)
	.dwattr $C$DW$T$83, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$83, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$83, DW_AT_decl_line(0x94)
	.dwattr $C$DW$T$83, DW_AT_decl_column(0x13)

$C$DW$T$84	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$84, DW_AT_name("__accmode_t")
	.dwattr $C$DW$T$84, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$84, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$84, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$84, DW_AT_decl_line(0x3b)
	.dwattr $C$DW$T$84, DW_AT_decl_column(0x0e)

$C$DW$T$52	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$52, DW_AT_type(*$C$DW$T$10)


$C$DW$T$99	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$99, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$99, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$99, DW_AT_byte_size(0x100)
$C$DW$120	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$120, DW_AT_upper_bound(0x3f)

	.dwendtag $C$DW$T$99

$C$DW$T$100	.dwtag  DW_TAG_volatile_type
	.dwattr $C$DW$T$100, DW_AT_type(*$C$DW$T$10)


$C$DW$T$101	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$101, DW_AT_type(*$C$DW$T$100)
	.dwattr $C$DW$T$101, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$101, DW_AT_byte_size(0x80)
$C$DW$121	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$121, DW_AT_upper_bound(0x1f)

	.dwendtag $C$DW$T$101

$C$DW$T$104	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$104, DW_AT_name("__cpulevel_t")
	.dwattr $C$DW$T$104, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$104, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$104, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$104, DW_AT_decl_line(0x50)
	.dwattr $C$DW$T$104, DW_AT_decl_column(0x0e)

$C$DW$T$105	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$105, DW_AT_name("__cpusetid_t")
	.dwattr $C$DW$T$105, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$105, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$105, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$105, DW_AT_decl_line(0x51)
	.dwattr $C$DW$T$105, DW_AT_decl_column(0x0e)

$C$DW$T$106	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$106, DW_AT_name("__cpuwhich_t")
	.dwattr $C$DW$T$106, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$106, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$106, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$106, DW_AT_decl_line(0x4f)
	.dwattr $C$DW$T$106, DW_AT_decl_column(0x0e)

$C$DW$T$107	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$107, DW_AT_name("__ct_rune_t")
	.dwattr $C$DW$T$107, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$107, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$107, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$107, DW_AT_decl_line(0x6b)
	.dwattr $C$DW$T$107, DW_AT_decl_column(0x0e)

$C$DW$T$108	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$108, DW_AT_name("__rune_t")
	.dwattr $C$DW$T$108, DW_AT_type(*$C$DW$T$107)
	.dwattr $C$DW$T$108, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$108, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$108, DW_AT_decl_line(0x6e)
	.dwattr $C$DW$T$108, DW_AT_decl_column(0x15)

$C$DW$T$109	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$109, DW_AT_name("__wint_t")
	.dwattr $C$DW$T$109, DW_AT_type(*$C$DW$T$107)
	.dwattr $C$DW$T$109, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$109, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$109, DW_AT_decl_line(0x6f)
	.dwattr $C$DW$T$109, DW_AT_decl_column(0x15)

$C$DW$T$110	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$110, DW_AT_name("__int32_t")
	.dwattr $C$DW$T$110, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$110, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$110, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$110, DW_AT_decl_line(0x62)
	.dwattr $C$DW$T$110, DW_AT_decl_column(0x0f)

$C$DW$T$111	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$111, DW_AT_name("__blksize_t")
	.dwattr $C$DW$T$111, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$111, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$111, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$111, DW_AT_decl_line(0x2f)
	.dwattr $C$DW$T$111, DW_AT_decl_column(0x13)

$C$DW$T$112	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$112, DW_AT_name("__clockid_t")
	.dwattr $C$DW$T$112, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$112, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$112, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$112, DW_AT_decl_line(0x31)
	.dwattr $C$DW$T$112, DW_AT_decl_column(0x13)

$C$DW$T$113	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$113, DW_AT_name("__critical_t")
	.dwattr $C$DW$T$113, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$113, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$113, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$113, DW_AT_decl_line(0x73)
	.dwattr $C$DW$T$113, DW_AT_decl_column(0x13)

$C$DW$T$114	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$114, DW_AT_name("__int_fast16_t")
	.dwattr $C$DW$T$114, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$114, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$114, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$114, DW_AT_decl_line(0x7a)
	.dwattr $C$DW$T$114, DW_AT_decl_column(0x13)

$C$DW$T$115	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$115, DW_AT_name("__int_fast32_t")
	.dwattr $C$DW$T$115, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$115, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$115, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$115, DW_AT_decl_line(0x7b)
	.dwattr $C$DW$T$115, DW_AT_decl_column(0x13)

$C$DW$T$116	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$116, DW_AT_name("__int_fast8_t")
	.dwattr $C$DW$T$116, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$116, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$116, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$116, DW_AT_decl_line(0x79)
	.dwattr $C$DW$T$116, DW_AT_decl_column(0x13)

$C$DW$T$117	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$117, DW_AT_name("__int_least32_t")
	.dwattr $C$DW$T$117, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$117, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$117, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$117, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$T$117, DW_AT_decl_column(0x13)

$C$DW$T$118	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$118, DW_AT_name("__intfptr_t")
	.dwattr $C$DW$T$118, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$118, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$118, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$118, DW_AT_decl_line(0x76)
	.dwattr $C$DW$T$118, DW_AT_decl_column(0x13)

$C$DW$T$119	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$119, DW_AT_name("__intptr_t")
	.dwattr $C$DW$T$119, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$119, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$119, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$119, DW_AT_decl_line(0x78)
	.dwattr $C$DW$T$119, DW_AT_decl_column(0x13)

$C$DW$T$120	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$120, DW_AT_name("__lwpid_t")
	.dwattr $C$DW$T$120, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$120, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$120, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$120, DW_AT_decl_line(0x39)
	.dwattr $C$DW$T$120, DW_AT_decl_column(0x13)

$C$DW$T$121	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$121, DW_AT_name("__pid_t")
	.dwattr $C$DW$T$121, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$121, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$121, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$121, DW_AT_decl_line(0x40)
	.dwattr $C$DW$T$121, DW_AT_decl_column(0x13)

$C$DW$T$122	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$122, DW_AT_name("__ptrdiff_t")
	.dwattr $C$DW$T$122, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$122, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$122, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$122, DW_AT_decl_line(0x81)
	.dwattr $C$DW$T$122, DW_AT_decl_column(0x13)

$C$DW$T$123	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$123, DW_AT_name("__register_t")
	.dwattr $C$DW$T$123, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$123, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$123, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$123, DW_AT_decl_line(0x82)
	.dwattr $C$DW$T$123, DW_AT_decl_column(0x13)

$C$DW$T$124	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$124, DW_AT_name("__segsz_t")
	.dwattr $C$DW$T$124, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$124, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$124, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$124, DW_AT_decl_line(0x83)
	.dwattr $C$DW$T$124, DW_AT_decl_column(0x13)

$C$DW$T$125	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$125, DW_AT_name("__ssize_t")
	.dwattr $C$DW$T$125, DW_AT_type(*$C$DW$T$110)
	.dwattr $C$DW$T$125, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$125, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$125, DW_AT_decl_line(0x85)
	.dwattr $C$DW$T$125, DW_AT_decl_column(0x13)

$C$DW$T$126	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$126, DW_AT_name("__key_t")
	.dwattr $C$DW$T$126, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$126, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$126, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$126, DW_AT_decl_line(0x38)
	.dwattr $C$DW$T$126, DW_AT_decl_column(0x0f)

$C$DW$T$127	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$127, DW_AT_name("__nl_item")
	.dwattr $C$DW$T$127, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$127, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$127, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$127, DW_AT_decl_line(0x3c)
	.dwattr $C$DW$T$127, DW_AT_decl_column(0x0e)

$C$DW$T$128	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$128, DW_AT_name("__suseconds_t")
	.dwattr $C$DW$T$128, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$128, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$128, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$128, DW_AT_decl_line(0x4a)
	.dwattr $C$DW$T$128, DW_AT_decl_column(0x0f)

$C$DW$T$129	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$129, DW_AT_name("_off_t")
	.dwattr $C$DW$T$129, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$129, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$129, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$129, DW_AT_decl_line(0xab)
	.dwattr $C$DW$T$129, DW_AT_decl_column(0x0d)

$C$DW$T$130	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$130, DW_AT_name("__off_t")
	.dwattr $C$DW$T$130, DW_AT_type(*$C$DW$T$129)
	.dwattr $C$DW$T$130, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$130, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$130, DW_AT_decl_line(0x3e)
	.dwattr $C$DW$T$130, DW_AT_decl_column(0x18)

$C$DW$T$131	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$131, DW_AT_name("fpos_t")
	.dwattr $C$DW$T$131, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$131, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$131, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$T$131, DW_AT_decl_line(0x76)
	.dwattr $C$DW$T$131, DW_AT_decl_column(0x0d)

$C$DW$T$132	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$132, DW_AT_name("off_t")
	.dwattr $C$DW$T$132, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$T$132, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$132, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$T$132, DW_AT_decl_line(0x7f)
	.dwattr $C$DW$T$132, DW_AT_decl_column(0x0d)

$C$DW$T$11	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$11, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$11, DW_AT_name("unsigned int")
	.dwattr $C$DW$T$11, DW_AT_byte_size(0x04)

$C$DW$T$134	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$134, DW_AT_type(*$C$DW$T$11)


$C$DW$T$136	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$136, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$136, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$136, DW_AT_byte_size(0x1f40)
$C$DW$122	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$122, DW_AT_upper_bound(0x7cf)

	.dwendtag $C$DW$T$136

$C$DW$T$138	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$138, DW_AT_name("__uint32_t")
	.dwattr $C$DW$T$138, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$138, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$138, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$138, DW_AT_decl_line(0x63)
	.dwattr $C$DW$T$138, DW_AT_decl_column(0x17)

$C$DW$T$139	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$139, DW_AT_name("__clock_t")
	.dwattr $C$DW$T$139, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$139, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$139, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$139, DW_AT_decl_line(0x72)
	.dwattr $C$DW$T$139, DW_AT_decl_column(0x14)

$C$DW$T$140	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$140, DW_AT_name("__fflags_t")
	.dwattr $C$DW$T$140, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$140, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$140, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$140, DW_AT_decl_line(0x32)
	.dwattr $C$DW$T$140, DW_AT_decl_column(0x14)

$C$DW$T$141	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$141, DW_AT_name("__fixpt_t")
	.dwattr $C$DW$T$141, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$141, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$141, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$141, DW_AT_decl_line(0x83)
	.dwattr $C$DW$T$141, DW_AT_decl_column(0x14)

$C$DW$T$142	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$142, DW_AT_name("__gid_t")
	.dwattr $C$DW$T$142, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$142, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$142, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$142, DW_AT_decl_line(0x35)
	.dwattr $C$DW$T$142, DW_AT_decl_column(0x14)

$C$DW$T$143	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$143, DW_AT_name("__size_t")
	.dwattr $C$DW$T$143, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$143, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$143, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$143, DW_AT_decl_line(0x84)
	.dwattr $C$DW$T$143, DW_AT_decl_column(0x14)

$C$DW$T$144	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$144, DW_AT_name("__socklen_t")
	.dwattr $C$DW$T$144, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$144, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$144, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$144, DW_AT_decl_line(0x49)
	.dwattr $C$DW$T$144, DW_AT_decl_column(0x14)

$C$DW$T$145	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$145, DW_AT_name("__time_t")
	.dwattr $C$DW$T$145, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$145, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$145, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$145, DW_AT_decl_line(0x89)
	.dwattr $C$DW$T$145, DW_AT_decl_column(0x19)

$C$DW$T$146	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$146, DW_AT_name("__u_register_t")
	.dwattr $C$DW$T$146, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$146, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$146, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$146, DW_AT_decl_line(0x96)
	.dwattr $C$DW$T$146, DW_AT_decl_column(0x14)

$C$DW$T$147	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$147, DW_AT_name("__uid_t")
	.dwattr $C$DW$T$147, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$147, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$147, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$147, DW_AT_decl_line(0x4d)
	.dwattr $C$DW$T$147, DW_AT_decl_column(0x14)

$C$DW$T$148	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$148, DW_AT_name("__uint_fast16_t")
	.dwattr $C$DW$T$148, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$148, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$148, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$148, DW_AT_decl_line(0x8f)
	.dwattr $C$DW$T$148, DW_AT_decl_column(0x14)

$C$DW$T$149	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$149, DW_AT_name("__uint_fast32_t")
	.dwattr $C$DW$T$149, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$149, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$149, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$149, DW_AT_decl_line(0x90)
	.dwattr $C$DW$T$149, DW_AT_decl_column(0x14)

$C$DW$T$150	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$150, DW_AT_name("__uint_fast8_t")
	.dwattr $C$DW$T$150, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$150, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$150, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$150, DW_AT_decl_line(0x8e)
	.dwattr $C$DW$T$150, DW_AT_decl_column(0x14)

$C$DW$T$151	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$151, DW_AT_name("__uint_least32_t")
	.dwattr $C$DW$T$151, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$151, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$151, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$151, DW_AT_decl_line(0x94)
	.dwattr $C$DW$T$151, DW_AT_decl_column(0x14)

$C$DW$T$152	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$152, DW_AT_name("__char32_t")
	.dwattr $C$DW$T$152, DW_AT_type(*$C$DW$T$151)
	.dwattr $C$DW$T$152, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$152, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$152, DW_AT_decl_line(0x74)
	.dwattr $C$DW$T$152, DW_AT_decl_column(0x1a)

$C$DW$T$153	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$153, DW_AT_name("__uintfptr_t")
	.dwattr $C$DW$T$153, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$153, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$153, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$153, DW_AT_decl_line(0x8b)
	.dwattr $C$DW$T$153, DW_AT_decl_column(0x14)

$C$DW$T$154	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$154, DW_AT_name("__uintptr_t")
	.dwattr $C$DW$T$154, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$154, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$154, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$154, DW_AT_decl_line(0x8d)
	.dwattr $C$DW$T$154, DW_AT_decl_column(0x14)

$C$DW$T$155	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$155, DW_AT_name("__vm_offset_t")
	.dwattr $C$DW$T$155, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$155, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$155, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$155, DW_AT_decl_line(0x97)
	.dwattr $C$DW$T$155, DW_AT_decl_column(0x14)

$C$DW$T$156	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$156, DW_AT_name("__vm_paddr_t")
	.dwattr $C$DW$T$156, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$156, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$156, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$156, DW_AT_decl_line(0x98)
	.dwattr $C$DW$T$156, DW_AT_decl_column(0x14)

$C$DW$T$157	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$157, DW_AT_name("__vm_size_t")
	.dwattr $C$DW$T$157, DW_AT_type(*$C$DW$T$138)
	.dwattr $C$DW$T$157, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$157, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$157, DW_AT_decl_line(0x99)
	.dwattr $C$DW$T$157, DW_AT_decl_column(0x14)

$C$DW$T$158	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$158, DW_AT_name("__useconds_t")
	.dwattr $C$DW$T$158, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$158, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$158, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$158, DW_AT_decl_line(0x4e)
	.dwattr $C$DW$T$158, DW_AT_decl_column(0x16)

$C$DW$T$34	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$34, DW_AT_name("size_t")
	.dwattr $C$DW$T$34, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$T$34, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$34, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/string.h")
	.dwattr $C$DW$T$34, DW_AT_decl_line(0x44)
	.dwattr $C$DW$T$34, DW_AT_decl_column(0x19)

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

$C$DW$T$160	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$160, DW_AT_name("__int64_t")
	.dwattr $C$DW$T$160, DW_AT_type(*$C$DW$T$16)
	.dwattr $C$DW$T$160, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$160, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$160, DW_AT_decl_line(0x68)
	.dwattr $C$DW$T$160, DW_AT_decl_column(0x14)

$C$DW$T$161	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$161, DW_AT_name("__blkcnt_t")
	.dwattr $C$DW$T$161, DW_AT_type(*$C$DW$T$160)
	.dwattr $C$DW$T$161, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$161, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$161, DW_AT_decl_line(0x30)
	.dwattr $C$DW$T$161, DW_AT_decl_column(0x13)

$C$DW$T$162	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$162, DW_AT_name("__id_t")
	.dwattr $C$DW$T$162, DW_AT_type(*$C$DW$T$160)
	.dwattr $C$DW$T$162, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$162, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$162, DW_AT_decl_line(0x36)
	.dwattr $C$DW$T$162, DW_AT_decl_column(0x13)

$C$DW$T$163	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$163, DW_AT_name("__int_fast64_t")
	.dwattr $C$DW$T$163, DW_AT_type(*$C$DW$T$160)
	.dwattr $C$DW$T$163, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$163, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$163, DW_AT_decl_line(0x7c)
	.dwattr $C$DW$T$163, DW_AT_decl_column(0x13)

$C$DW$T$164	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$164, DW_AT_name("__int_least64_t")
	.dwattr $C$DW$T$164, DW_AT_type(*$C$DW$T$160)
	.dwattr $C$DW$T$164, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$164, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$164, DW_AT_decl_line(0x80)
	.dwattr $C$DW$T$164, DW_AT_decl_column(0x13)

$C$DW$T$165	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$165, DW_AT_name("__intmax_t")
	.dwattr $C$DW$T$165, DW_AT_type(*$C$DW$T$160)
	.dwattr $C$DW$T$165, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$165, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$165, DW_AT_decl_line(0x77)
	.dwattr $C$DW$T$165, DW_AT_decl_column(0x13)

$C$DW$T$166	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$166, DW_AT_name("__off64_t")
	.dwattr $C$DW$T$166, DW_AT_type(*$C$DW$T$160)
	.dwattr $C$DW$T$166, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$166, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$166, DW_AT_decl_line(0x3f)
	.dwattr $C$DW$T$166, DW_AT_decl_column(0x13)

$C$DW$T$167	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$167, DW_AT_name("__rlim_t")
	.dwattr $C$DW$T$167, DW_AT_type(*$C$DW$T$160)
	.dwattr $C$DW$T$167, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$167, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$167, DW_AT_decl_line(0x41)
	.dwattr $C$DW$T$167, DW_AT_decl_column(0x13)

$C$DW$T$17	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$17, DW_AT_encoding(DW_ATE_unsigned)
	.dwattr $C$DW$T$17, DW_AT_name("unsigned long long")
	.dwattr $C$DW$T$17, DW_AT_byte_size(0x08)

$C$DW$T$168	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$168, DW_AT_name("__uint64_t")
	.dwattr $C$DW$T$168, DW_AT_type(*$C$DW$T$17)
	.dwattr $C$DW$T$168, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$168, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$168, DW_AT_decl_line(0x6d)
	.dwattr $C$DW$T$168, DW_AT_decl_column(0x1c)

$C$DW$T$169	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$169, DW_AT_name("__dev_t")
	.dwattr $C$DW$T$169, DW_AT_type(*$C$DW$T$168)
	.dwattr $C$DW$T$169, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$169, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$169, DW_AT_decl_line(0x81)
	.dwattr $C$DW$T$169, DW_AT_decl_column(0x14)

$C$DW$T$170	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$170, DW_AT_name("__fsblkcnt_t")
	.dwattr $C$DW$T$170, DW_AT_type(*$C$DW$T$168)
	.dwattr $C$DW$T$170, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$170, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$170, DW_AT_decl_line(0x33)
	.dwattr $C$DW$T$170, DW_AT_decl_column(0x14)

$C$DW$T$171	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$171, DW_AT_name("__fsfilcnt_t")
	.dwattr $C$DW$T$171, DW_AT_type(*$C$DW$T$168)
	.dwattr $C$DW$T$171, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$171, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$171, DW_AT_decl_line(0x34)
	.dwattr $C$DW$T$171, DW_AT_decl_column(0x14)

$C$DW$T$172	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$172, DW_AT_name("__ino_t")
	.dwattr $C$DW$T$172, DW_AT_type(*$C$DW$T$168)
	.dwattr $C$DW$T$172, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$172, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$172, DW_AT_decl_line(0x37)
	.dwattr $C$DW$T$172, DW_AT_decl_column(0x14)

$C$DW$T$173	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$173, DW_AT_name("__nlink_t")
	.dwattr $C$DW$T$173, DW_AT_type(*$C$DW$T$168)
	.dwattr $C$DW$T$173, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$173, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$173, DW_AT_decl_line(0x3d)
	.dwattr $C$DW$T$173, DW_AT_decl_column(0x14)

$C$DW$T$174	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$174, DW_AT_name("__uint_fast64_t")
	.dwattr $C$DW$T$174, DW_AT_type(*$C$DW$T$168)
	.dwattr $C$DW$T$174, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$174, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$174, DW_AT_decl_line(0x91)
	.dwattr $C$DW$T$174, DW_AT_decl_column(0x14)

$C$DW$T$175	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$175, DW_AT_name("__uint_least64_t")
	.dwattr $C$DW$T$175, DW_AT_type(*$C$DW$T$168)
	.dwattr $C$DW$T$175, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$175, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$175, DW_AT_decl_line(0x95)
	.dwattr $C$DW$T$175, DW_AT_decl_column(0x14)

$C$DW$T$176	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$176, DW_AT_name("__uintmax_t")
	.dwattr $C$DW$T$176, DW_AT_type(*$C$DW$T$168)
	.dwattr $C$DW$T$176, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$176, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$176, DW_AT_decl_line(0x8c)
	.dwattr $C$DW$T$176, DW_AT_decl_column(0x14)

$C$DW$T$177	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$177, DW_AT_name("__rman_res_t")
	.dwattr $C$DW$T$177, DW_AT_type(*$C$DW$T$176)
	.dwattr $C$DW$T$177, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$177, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$177, DW_AT_decl_line(0x9c)
	.dwattr $C$DW$T$177, DW_AT_decl_column(0x19)

$C$DW$T$18	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$18, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$18, DW_AT_name("float")
	.dwattr $C$DW$T$18, DW_AT_byte_size(0x04)

$C$DW$T$41	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$41, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$41, DW_AT_address_class(0x20)

$C$DW$T$179	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$179, DW_AT_type(*$C$DW$T$41)

$C$DW$T$43	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$43, DW_AT_type(*$C$DW$T$18)


$C$DW$T$181	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$181, DW_AT_type(*$C$DW$T$43)
	.dwattr $C$DW$T$181, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$181, DW_AT_byte_size(0x08)
$C$DW$123	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$123, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$181


$C$DW$T$184	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$184, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$184, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$184, DW_AT_byte_size(0x100)
$C$DW$124	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$124, DW_AT_upper_bound(0x3f)

	.dwendtag $C$DW$T$184


$C$DW$T$185	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$185, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$185, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$185, DW_AT_byte_size(0x08)
$C$DW$125	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$125, DW_AT_upper_bound(0x01)

	.dwendtag $C$DW$T$185

$C$DW$T$188	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$188, DW_AT_name("__float_t")
	.dwattr $C$DW$T$188, DW_AT_type(*$C$DW$T$18)
	.dwattr $C$DW$T$188, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$188, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$188, DW_AT_decl_line(0x75)
	.dwattr $C$DW$T$188, DW_AT_decl_column(0x10)

$C$DW$T$19	.dwtag  DW_TAG_base_type
	.dwattr $C$DW$T$19, DW_AT_encoding(DW_ATE_float)
	.dwattr $C$DW$T$19, DW_AT_name("double")
	.dwattr $C$DW$T$19, DW_AT_byte_size(0x08)

$C$DW$T$190	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$190, DW_AT_name("__double_t")
	.dwattr $C$DW$T$190, DW_AT_type(*$C$DW$T$19)
	.dwattr $C$DW$T$190, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$190, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$190, DW_AT_decl_line(0x74)
	.dwattr $C$DW$T$190, DW_AT_decl_column(0x11)

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

$C$DW$T$90	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$90, DW_AT_type(*$C$DW$T$5)

$C$DW$T$91	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$91, DW_AT_type(*$C$DW$T$90)
	.dwattr $C$DW$T$91, DW_AT_address_class(0x20)

$C$DW$T$191	.dwtag  DW_TAG_const_type
	.dwattr $C$DW$T$191, DW_AT_type(*$C$DW$T$91)


$C$DW$T$192	.dwtag  DW_TAG_array_type
	.dwattr $C$DW$T$192, DW_AT_type(*$C$DW$T$5)
	.dwattr $C$DW$T$192, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$192, DW_AT_byte_size(0x50)
$C$DW$126	.dwtag  DW_TAG_subrange_type
	.dwattr $C$DW$126, DW_AT_upper_bound(0x4f)

	.dwendtag $C$DW$T$192

$C$DW$T$193	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$193, DW_AT_type(*$C$DW$T$5)
	.dwattr $C$DW$T$193, DW_AT_address_class(0x20)

$C$DW$T$194	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$194, DW_AT_name("__va_list")
	.dwattr $C$DW$T$194, DW_AT_type(*$C$DW$T$193)
	.dwattr $C$DW$T$194, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$194, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/machine/_types.h")
	.dwattr $C$DW$T$194, DW_AT_decl_line(0xb4)
	.dwattr $C$DW$T$194, DW_AT_decl_column(0x13)

$C$DW$T$195	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$195, DW_AT_name("va_list")
	.dwattr $C$DW$T$195, DW_AT_type(*$C$DW$T$194)
	.dwattr $C$DW$T$195, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$195, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdarg.h")
	.dwattr $C$DW$T$195, DW_AT_decl_line(0x33)
	.dwattr $C$DW$T$195, DW_AT_decl_column(0x17)


$C$DW$T$27	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$27, DW_AT_name("__mq")
	.dwattr $C$DW$T$27, DW_AT_declaration
	.dwattr $C$DW$T$27, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$27, DW_AT_decl_line(0x4c)
	.dwattr $C$DW$T$27, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$T$27

$C$DW$T$196	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$196, DW_AT_type(*$C$DW$T$27)
	.dwattr $C$DW$T$196, DW_AT_address_class(0x20)

$C$DW$T$197	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$197, DW_AT_name("__mqd_t")
	.dwattr $C$DW$T$197, DW_AT_type(*$C$DW$T$196)
	.dwattr $C$DW$T$197, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$197, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$197, DW_AT_decl_line(0x4c)
	.dwattr $C$DW$T$197, DW_AT_decl_column(0x16)


$C$DW$T$32	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$32, DW_AT_name("__sFILE")
	.dwattr $C$DW$T$32, DW_AT_byte_size(0x18)
$C$DW$127	.dwtag  DW_TAG_member
	.dwattr $C$DW$127, DW_AT_type(*$C$DW$T$10)
	.dwattr $C$DW$127, DW_AT_name("fd")
	.dwattr $C$DW$127, DW_AT_TI_symbol_name("fd")
	.dwattr $C$DW$127, DW_AT_data_member_location[DW_OP_plus_uconst 0x0]
	.dwattr $C$DW$127, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$127, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$127, DW_AT_decl_line(0x5f)
	.dwattr $C$DW$127, DW_AT_decl_column(0x0b)

$C$DW$128	.dwtag  DW_TAG_member
	.dwattr $C$DW$128, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$128, DW_AT_name("buf")
	.dwattr $C$DW$128, DW_AT_TI_symbol_name("buf")
	.dwattr $C$DW$128, DW_AT_data_member_location[DW_OP_plus_uconst 0x4]
	.dwattr $C$DW$128, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$128, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$128, DW_AT_decl_line(0x60)
	.dwattr $C$DW$128, DW_AT_decl_column(0x16)

$C$DW$129	.dwtag  DW_TAG_member
	.dwattr $C$DW$129, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$129, DW_AT_name("pos")
	.dwattr $C$DW$129, DW_AT_TI_symbol_name("pos")
	.dwattr $C$DW$129, DW_AT_data_member_location[DW_OP_plus_uconst 0x8]
	.dwattr $C$DW$129, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$129, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$129, DW_AT_decl_line(0x61)
	.dwattr $C$DW$129, DW_AT_decl_column(0x16)

$C$DW$130	.dwtag  DW_TAG_member
	.dwattr $C$DW$130, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$130, DW_AT_name("bufend")
	.dwattr $C$DW$130, DW_AT_TI_symbol_name("bufend")
	.dwattr $C$DW$130, DW_AT_data_member_location[DW_OP_plus_uconst 0xc]
	.dwattr $C$DW$130, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$130, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$130, DW_AT_decl_line(0x62)
	.dwattr $C$DW$130, DW_AT_decl_column(0x16)

$C$DW$131	.dwtag  DW_TAG_member
	.dwattr $C$DW$131, DW_AT_type(*$C$DW$T$31)
	.dwattr $C$DW$131, DW_AT_name("buff_stop")
	.dwattr $C$DW$131, DW_AT_TI_symbol_name("buff_stop")
	.dwattr $C$DW$131, DW_AT_data_member_location[DW_OP_plus_uconst 0x10]
	.dwattr $C$DW$131, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$131, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$131, DW_AT_decl_line(0x63)
	.dwattr $C$DW$131, DW_AT_decl_column(0x16)

$C$DW$132	.dwtag  DW_TAG_member
	.dwattr $C$DW$132, DW_AT_type(*$C$DW$T$11)
	.dwattr $C$DW$132, DW_AT_name("flags")
	.dwattr $C$DW$132, DW_AT_TI_symbol_name("flags")
	.dwattr $C$DW$132, DW_AT_data_member_location[DW_OP_plus_uconst 0x14]
	.dwattr $C$DW$132, DW_AT_accessibility(DW_ACCESS_public)
	.dwattr $C$DW$132, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$132, DW_AT_decl_line(0x64)
	.dwattr $C$DW$132, DW_AT_decl_column(0x16)

	.dwattr $C$DW$T$32, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$T$32, DW_AT_decl_line(0x5e)
	.dwattr $C$DW$T$32, DW_AT_decl_column(0x08)
	.dwendtag $C$DW$T$32

$C$DW$T$198	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$198, DW_AT_name("FILE")
	.dwattr $C$DW$T$198, DW_AT_type(*$C$DW$T$32)
	.dwattr $C$DW$T$198, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$198, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/stdio.h")
	.dwattr $C$DW$T$198, DW_AT_decl_line(0x69)
	.dwattr $C$DW$T$198, DW_AT_decl_column(0x18)


$C$DW$T$28	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$28, DW_AT_name("__timer")
	.dwattr $C$DW$T$28, DW_AT_declaration
	.dwattr $C$DW$T$28, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$28, DW_AT_decl_line(0x4b)
	.dwattr $C$DW$T$28, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$T$28

$C$DW$T$199	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$199, DW_AT_type(*$C$DW$T$28)
	.dwattr $C$DW$T$199, DW_AT_address_class(0x20)

$C$DW$T$200	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$200, DW_AT_name("__timer_t")
	.dwattr $C$DW$T$200, DW_AT_type(*$C$DW$T$199)
	.dwattr $C$DW$T$200, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$200, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/sys/_types.h")
	.dwattr $C$DW$T$200, DW_AT_decl_line(0x4b)
	.dwattr $C$DW$T$200, DW_AT_decl_column(0x19)


$C$DW$T$29	.dwtag  DW_TAG_structure_type
	.dwattr $C$DW$T$29, DW_AT_name("_xlocale")
	.dwattr $C$DW$T$29, DW_AT_declaration
	.dwattr $C$DW$T$29, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/xlocale/_string.h")
	.dwattr $C$DW$T$29, DW_AT_decl_line(0x21)
	.dwattr $C$DW$T$29, DW_AT_decl_column(0x10)
	.dwendtag $C$DW$T$29

$C$DW$T$201	.dwtag  DW_TAG_pointer_type
	.dwattr $C$DW$T$201, DW_AT_type(*$C$DW$T$29)
	.dwattr $C$DW$T$201, DW_AT_address_class(0x20)

$C$DW$T$202	.dwtag  DW_TAG_typedef
	.dwattr $C$DW$T$202, DW_AT_name("locale_t")
	.dwattr $C$DW$T$202, DW_AT_type(*$C$DW$T$201)
	.dwattr $C$DW$T$202, DW_AT_language(DW_LANG_C)
	.dwattr $C$DW$T$202, DW_AT_decl_file("C:/ti/ccs2101/ccs/tools/compiler/ti-cgt-c6000_8.5.0.LTS/include/xlocale/_string.h")
	.dwattr $C$DW$T$202, DW_AT_decl_line(0x21)
	.dwattr $C$DW$T$202, DW_AT_decl_column(0x1a)

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

$C$DW$133	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$133, DW_AT_name("A0")
	.dwattr $C$DW$133, DW_AT_location[DW_OP_reg0]

$C$DW$134	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$134, DW_AT_name("A1")
	.dwattr $C$DW$134, DW_AT_location[DW_OP_reg1]

$C$DW$135	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$135, DW_AT_name("A2")
	.dwattr $C$DW$135, DW_AT_location[DW_OP_reg2]

$C$DW$136	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$136, DW_AT_name("A3")
	.dwattr $C$DW$136, DW_AT_location[DW_OP_reg3]

$C$DW$137	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$137, DW_AT_name("A4")
	.dwattr $C$DW$137, DW_AT_location[DW_OP_reg4]

$C$DW$138	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$138, DW_AT_name("A5")
	.dwattr $C$DW$138, DW_AT_location[DW_OP_reg5]

$C$DW$139	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$139, DW_AT_name("A6")
	.dwattr $C$DW$139, DW_AT_location[DW_OP_reg6]

$C$DW$140	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$140, DW_AT_name("A7")
	.dwattr $C$DW$140, DW_AT_location[DW_OP_reg7]

$C$DW$141	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$141, DW_AT_name("A8")
	.dwattr $C$DW$141, DW_AT_location[DW_OP_reg8]

$C$DW$142	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$142, DW_AT_name("A9")
	.dwattr $C$DW$142, DW_AT_location[DW_OP_reg9]

$C$DW$143	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$143, DW_AT_name("A10")
	.dwattr $C$DW$143, DW_AT_location[DW_OP_reg10]

$C$DW$144	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$144, DW_AT_name("A11")
	.dwattr $C$DW$144, DW_AT_location[DW_OP_reg11]

$C$DW$145	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$145, DW_AT_name("A12")
	.dwattr $C$DW$145, DW_AT_location[DW_OP_reg12]

$C$DW$146	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$146, DW_AT_name("A13")
	.dwattr $C$DW$146, DW_AT_location[DW_OP_reg13]

$C$DW$147	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$147, DW_AT_name("A14")
	.dwattr $C$DW$147, DW_AT_location[DW_OP_reg14]

$C$DW$148	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$148, DW_AT_name("A15")
	.dwattr $C$DW$148, DW_AT_location[DW_OP_reg15]

$C$DW$149	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$149, DW_AT_name("FP")
	.dwattr $C$DW$149, DW_AT_location[DW_OP_regx 0x20]

$C$DW$150	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$150, DW_AT_name("A16")
	.dwattr $C$DW$150, DW_AT_location[DW_OP_regx 0x25]

$C$DW$151	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$151, DW_AT_name("A17")
	.dwattr $C$DW$151, DW_AT_location[DW_OP_regx 0x26]

$C$DW$152	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$152, DW_AT_name("A18")
	.dwattr $C$DW$152, DW_AT_location[DW_OP_regx 0x27]

$C$DW$153	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$153, DW_AT_name("A19")
	.dwattr $C$DW$153, DW_AT_location[DW_OP_regx 0x28]

$C$DW$154	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$154, DW_AT_name("A20")
	.dwattr $C$DW$154, DW_AT_location[DW_OP_regx 0x29]

$C$DW$155	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$155, DW_AT_name("A21")
	.dwattr $C$DW$155, DW_AT_location[DW_OP_regx 0x2a]

$C$DW$156	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$156, DW_AT_name("A22")
	.dwattr $C$DW$156, DW_AT_location[DW_OP_regx 0x2b]

$C$DW$157	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$157, DW_AT_name("A23")
	.dwattr $C$DW$157, DW_AT_location[DW_OP_regx 0x2c]

$C$DW$158	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$158, DW_AT_name("A24")
	.dwattr $C$DW$158, DW_AT_location[DW_OP_regx 0x2d]

$C$DW$159	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$159, DW_AT_name("A25")
	.dwattr $C$DW$159, DW_AT_location[DW_OP_regx 0x2e]

$C$DW$160	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$160, DW_AT_name("A26")
	.dwattr $C$DW$160, DW_AT_location[DW_OP_regx 0x2f]

$C$DW$161	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$161, DW_AT_name("A27")
	.dwattr $C$DW$161, DW_AT_location[DW_OP_regx 0x30]

$C$DW$162	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$162, DW_AT_name("A28")
	.dwattr $C$DW$162, DW_AT_location[DW_OP_regx 0x31]

$C$DW$163	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$163, DW_AT_name("A29")
	.dwattr $C$DW$163, DW_AT_location[DW_OP_regx 0x32]

$C$DW$164	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$164, DW_AT_name("A30")
	.dwattr $C$DW$164, DW_AT_location[DW_OP_regx 0x33]

$C$DW$165	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$165, DW_AT_name("A31")
	.dwattr $C$DW$165, DW_AT_location[DW_OP_regx 0x34]

$C$DW$166	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$166, DW_AT_name("B0")
	.dwattr $C$DW$166, DW_AT_location[DW_OP_reg16]

$C$DW$167	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$167, DW_AT_name("B1")
	.dwattr $C$DW$167, DW_AT_location[DW_OP_reg17]

$C$DW$168	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$168, DW_AT_name("B2")
	.dwattr $C$DW$168, DW_AT_location[DW_OP_reg18]

$C$DW$169	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$169, DW_AT_name("B3")
	.dwattr $C$DW$169, DW_AT_location[DW_OP_reg19]

$C$DW$170	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$170, DW_AT_name("B4")
	.dwattr $C$DW$170, DW_AT_location[DW_OP_reg20]

$C$DW$171	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$171, DW_AT_name("B5")
	.dwattr $C$DW$171, DW_AT_location[DW_OP_reg21]

$C$DW$172	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$172, DW_AT_name("B6")
	.dwattr $C$DW$172, DW_AT_location[DW_OP_reg22]

$C$DW$173	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$173, DW_AT_name("B7")
	.dwattr $C$DW$173, DW_AT_location[DW_OP_reg23]

$C$DW$174	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$174, DW_AT_name("B8")
	.dwattr $C$DW$174, DW_AT_location[DW_OP_reg24]

$C$DW$175	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$175, DW_AT_name("B9")
	.dwattr $C$DW$175, DW_AT_location[DW_OP_reg25]

$C$DW$176	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$176, DW_AT_name("B10")
	.dwattr $C$DW$176, DW_AT_location[DW_OP_reg26]

$C$DW$177	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$177, DW_AT_name("B11")
	.dwattr $C$DW$177, DW_AT_location[DW_OP_reg27]

$C$DW$178	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$178, DW_AT_name("B12")
	.dwattr $C$DW$178, DW_AT_location[DW_OP_reg28]

$C$DW$179	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$179, DW_AT_name("B13")
	.dwattr $C$DW$179, DW_AT_location[DW_OP_reg29]

$C$DW$180	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$180, DW_AT_name("DP")
	.dwattr $C$DW$180, DW_AT_location[DW_OP_reg30]

$C$DW$181	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$181, DW_AT_name("SP")
	.dwattr $C$DW$181, DW_AT_location[DW_OP_reg31]

$C$DW$182	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$182, DW_AT_name("B16")
	.dwattr $C$DW$182, DW_AT_location[DW_OP_regx 0x35]

$C$DW$183	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$183, DW_AT_name("B17")
	.dwattr $C$DW$183, DW_AT_location[DW_OP_regx 0x36]

$C$DW$184	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$184, DW_AT_name("B18")
	.dwattr $C$DW$184, DW_AT_location[DW_OP_regx 0x37]

$C$DW$185	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$185, DW_AT_name("B19")
	.dwattr $C$DW$185, DW_AT_location[DW_OP_regx 0x38]

$C$DW$186	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$186, DW_AT_name("B20")
	.dwattr $C$DW$186, DW_AT_location[DW_OP_regx 0x39]

$C$DW$187	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$187, DW_AT_name("B21")
	.dwattr $C$DW$187, DW_AT_location[DW_OP_regx 0x3a]

$C$DW$188	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$188, DW_AT_name("B22")
	.dwattr $C$DW$188, DW_AT_location[DW_OP_regx 0x3b]

$C$DW$189	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$189, DW_AT_name("B23")
	.dwattr $C$DW$189, DW_AT_location[DW_OP_regx 0x3c]

$C$DW$190	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$190, DW_AT_name("B24")
	.dwattr $C$DW$190, DW_AT_location[DW_OP_regx 0x3d]

$C$DW$191	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$191, DW_AT_name("B25")
	.dwattr $C$DW$191, DW_AT_location[DW_OP_regx 0x3e]

$C$DW$192	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$192, DW_AT_name("B26")
	.dwattr $C$DW$192, DW_AT_location[DW_OP_regx 0x3f]

$C$DW$193	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$193, DW_AT_name("B27")
	.dwattr $C$DW$193, DW_AT_location[DW_OP_regx 0x40]

$C$DW$194	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$194, DW_AT_name("B28")
	.dwattr $C$DW$194, DW_AT_location[DW_OP_regx 0x41]

$C$DW$195	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$195, DW_AT_name("B29")
	.dwattr $C$DW$195, DW_AT_location[DW_OP_regx 0x42]

$C$DW$196	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$196, DW_AT_name("B30")
	.dwattr $C$DW$196, DW_AT_location[DW_OP_regx 0x43]

$C$DW$197	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$197, DW_AT_name("B31")
	.dwattr $C$DW$197, DW_AT_location[DW_OP_regx 0x44]

$C$DW$198	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$198, DW_AT_name("PC")
	.dwattr $C$DW$198, DW_AT_location[DW_OP_regx 0x21]

$C$DW$199	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$199, DW_AT_name("PCE1")
	.dwattr $C$DW$199, DW_AT_location[DW_OP_regx 0x21]

$C$DW$200	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$200, DW_AT_name("IRP")
	.dwattr $C$DW$200, DW_AT_location[DW_OP_regx 0x22]

$C$DW$201	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$201, DW_AT_name("IFR")
	.dwattr $C$DW$201, DW_AT_location[DW_OP_regx 0x23]

$C$DW$202	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$202, DW_AT_name("NRP")
	.dwattr $C$DW$202, DW_AT_location[DW_OP_regx 0x24]

$C$DW$203	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$203, DW_AT_name("CSR")
	.dwattr $C$DW$203, DW_AT_location[DW_OP_regx 0x46]

$C$DW$204	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$204, DW_AT_name("CSR")
	.dwattr $C$DW$204, DW_AT_location[DW_OP_regx 0x46]

$C$DW$205	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$205, DW_AT_name("SSR")
	.dwattr $C$DW$205, DW_AT_location[DW_OP_regx 0x5b]

$C$DW$206	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$206, DW_AT_name("CSR")
	.dwattr $C$DW$206, DW_AT_location[DW_OP_regx 0x46]

$C$DW$207	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$207, DW_AT_name("AMR")
	.dwattr $C$DW$207, DW_AT_location[DW_OP_regx 0x45]

$C$DW$208	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$208, DW_AT_name("ISR")
	.dwattr $C$DW$208, DW_AT_location[DW_OP_regx 0x47]

$C$DW$209	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$209, DW_AT_name("ICR")
	.dwattr $C$DW$209, DW_AT_location[DW_OP_regx 0x48]

$C$DW$210	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$210, DW_AT_name("IER")
	.dwattr $C$DW$210, DW_AT_location[DW_OP_regx 0x49]

$C$DW$211	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$211, DW_AT_name("ISTP")
	.dwattr $C$DW$211, DW_AT_location[DW_OP_regx 0x4a]

$C$DW$212	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$212, DW_AT_name("IN")
	.dwattr $C$DW$212, DW_AT_location[DW_OP_regx 0x4b]

$C$DW$213	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$213, DW_AT_name("OUT")
	.dwattr $C$DW$213, DW_AT_location[DW_OP_regx 0x4c]

$C$DW$214	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$214, DW_AT_name("ACR")
	.dwattr $C$DW$214, DW_AT_location[DW_OP_regx 0x4d]

$C$DW$215	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$215, DW_AT_name("ADR")
	.dwattr $C$DW$215, DW_AT_location[DW_OP_regx 0x4e]

$C$DW$216	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$216, DW_AT_name("FADCR")
	.dwattr $C$DW$216, DW_AT_location[DW_OP_regx 0x4f]

$C$DW$217	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$217, DW_AT_name("FAUCR")
	.dwattr $C$DW$217, DW_AT_location[DW_OP_regx 0x50]

$C$DW$218	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$218, DW_AT_name("FMCR")
	.dwattr $C$DW$218, DW_AT_location[DW_OP_regx 0x51]

$C$DW$219	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$219, DW_AT_name("GFPGFR")
	.dwattr $C$DW$219, DW_AT_location[DW_OP_regx 0x52]

$C$DW$220	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$220, DW_AT_name("DIER")
	.dwattr $C$DW$220, DW_AT_location[DW_OP_regx 0x53]

$C$DW$221	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$221, DW_AT_name("REP")
	.dwattr $C$DW$221, DW_AT_location[DW_OP_regx 0x54]

$C$DW$222	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$222, DW_AT_name("TSCL")
	.dwattr $C$DW$222, DW_AT_location[DW_OP_regx 0x55]

$C$DW$223	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$223, DW_AT_name("TSCH")
	.dwattr $C$DW$223, DW_AT_location[DW_OP_regx 0x56]

$C$DW$224	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$224, DW_AT_name("ARP")
	.dwattr $C$DW$224, DW_AT_location[DW_OP_regx 0x57]

$C$DW$225	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$225, DW_AT_name("ILC")
	.dwattr $C$DW$225, DW_AT_location[DW_OP_regx 0x58]

$C$DW$226	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$226, DW_AT_name("RILC")
	.dwattr $C$DW$226, DW_AT_location[DW_OP_regx 0x59]

$C$DW$227	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$227, DW_AT_name("DNUM")
	.dwattr $C$DW$227, DW_AT_location[DW_OP_regx 0x5a]

$C$DW$228	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$228, DW_AT_name("GPLYA")
	.dwattr $C$DW$228, DW_AT_location[DW_OP_regx 0x5c]

$C$DW$229	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$229, DW_AT_name("GPLYB")
	.dwattr $C$DW$229, DW_AT_location[DW_OP_regx 0x5d]

$C$DW$230	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$230, DW_AT_name("TSR")
	.dwattr $C$DW$230, DW_AT_location[DW_OP_regx 0x5e]

$C$DW$231	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$231, DW_AT_name("ITSR")
	.dwattr $C$DW$231, DW_AT_location[DW_OP_regx 0x5f]

$C$DW$232	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$232, DW_AT_name("NTSR")
	.dwattr $C$DW$232, DW_AT_location[DW_OP_regx 0x60]

$C$DW$233	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$233, DW_AT_name("EFR")
	.dwattr $C$DW$233, DW_AT_location[DW_OP_regx 0x61]

$C$DW$234	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$234, DW_AT_name("ECR")
	.dwattr $C$DW$234, DW_AT_location[DW_OP_regx 0x62]

$C$DW$235	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$235, DW_AT_name("IERR")
	.dwattr $C$DW$235, DW_AT_location[DW_OP_regx 0x63]

$C$DW$236	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$236, DW_AT_name("DMSG")
	.dwattr $C$DW$236, DW_AT_location[DW_OP_regx 0x64]

$C$DW$237	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$237, DW_AT_name("CMSG")
	.dwattr $C$DW$237, DW_AT_location[DW_OP_regx 0x65]

$C$DW$238	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$238, DW_AT_name("DT_DMA_ADDR")
	.dwattr $C$DW$238, DW_AT_location[DW_OP_regx 0x66]

$C$DW$239	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$239, DW_AT_name("DT_DMA_DATA")
	.dwattr $C$DW$239, DW_AT_location[DW_OP_regx 0x67]

$C$DW$240	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$240, DW_AT_name("DT_DMA_CNTL")
	.dwattr $C$DW$240, DW_AT_location[DW_OP_regx 0x68]

$C$DW$241	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$241, DW_AT_name("TCU_CNTL")
	.dwattr $C$DW$241, DW_AT_location[DW_OP_regx 0x69]

$C$DW$242	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$242, DW_AT_name("RTDX_REC_CNTL")
	.dwattr $C$DW$242, DW_AT_location[DW_OP_regx 0x6a]

$C$DW$243	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$243, DW_AT_name("RTDX_XMT_CNTL")
	.dwattr $C$DW$243, DW_AT_location[DW_OP_regx 0x6b]

$C$DW$244	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$244, DW_AT_name("RTDX_CFG")
	.dwattr $C$DW$244, DW_AT_location[DW_OP_regx 0x6c]

$C$DW$245	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$245, DW_AT_name("RTDX_RDATA")
	.dwattr $C$DW$245, DW_AT_location[DW_OP_regx 0x6d]

$C$DW$246	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$246, DW_AT_name("RTDX_WDATA")
	.dwattr $C$DW$246, DW_AT_location[DW_OP_regx 0x6e]

$C$DW$247	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$247, DW_AT_name("RTDX_RADDR")
	.dwattr $C$DW$247, DW_AT_location[DW_OP_regx 0x6f]

$C$DW$248	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$248, DW_AT_name("RTDX_WADDR")
	.dwattr $C$DW$248, DW_AT_location[DW_OP_regx 0x70]

$C$DW$249	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$249, DW_AT_name("MFREG0")
	.dwattr $C$DW$249, DW_AT_location[DW_OP_regx 0x71]

$C$DW$250	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$250, DW_AT_name("DBG_STAT")
	.dwattr $C$DW$250, DW_AT_location[DW_OP_regx 0x72]

$C$DW$251	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$251, DW_AT_name("BRK_EN")
	.dwattr $C$DW$251, DW_AT_location[DW_OP_regx 0x73]

$C$DW$252	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$252, DW_AT_name("HWBP0_CNT")
	.dwattr $C$DW$252, DW_AT_location[DW_OP_regx 0x74]

$C$DW$253	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$253, DW_AT_name("HWBP0")
	.dwattr $C$DW$253, DW_AT_location[DW_OP_regx 0x75]

$C$DW$254	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$254, DW_AT_name("HWBP1")
	.dwattr $C$DW$254, DW_AT_location[DW_OP_regx 0x76]

$C$DW$255	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$255, DW_AT_name("HWBP2")
	.dwattr $C$DW$255, DW_AT_location[DW_OP_regx 0x77]

$C$DW$256	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$256, DW_AT_name("HWBP3")
	.dwattr $C$DW$256, DW_AT_location[DW_OP_regx 0x78]

$C$DW$257	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$257, DW_AT_name("OVERLAY")
	.dwattr $C$DW$257, DW_AT_location[DW_OP_regx 0x79]

$C$DW$258	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$258, DW_AT_name("PC_PROF")
	.dwattr $C$DW$258, DW_AT_location[DW_OP_regx 0x7a]

$C$DW$259	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$259, DW_AT_name("ATSR")
	.dwattr $C$DW$259, DW_AT_location[DW_OP_regx 0x7b]

$C$DW$260	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$260, DW_AT_name("TRR")
	.dwattr $C$DW$260, DW_AT_location[DW_OP_regx 0x7c]

$C$DW$261	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$261, DW_AT_name("TCRR")
	.dwattr $C$DW$261, DW_AT_location[DW_OP_regx 0x7d]

$C$DW$262	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$262, DW_AT_name("DESR")
	.dwattr $C$DW$262, DW_AT_location[DW_OP_regx 0x7e]

$C$DW$263	.dwtag  DW_TAG_TI_assign_register
	.dwattr $C$DW$263, DW_AT_name("DETR")
	.dwattr $C$DW$263, DW_AT_location[DW_OP_regx 0x7f]

	.dwendtag $C$DW$CU

