    .global start
    .global results
    .global C$$EXIT
    .sect ".text"
start:
    MVK .S1 0x40,A4
    MVKH .S1 0xC0100000,A4
    MVK .S1 77,A5
    STW .D1T1 A5,*A4
    NOP 5
    LDW .D1T1 *A4,A1
    MV .L1 A1,A10
    MV .L1 A1,A11
    MV .L1 A1,A12
    MV .L1 A1,A13
    MV .L1 A1,A14
    MVK .S1 3,A6
    MVK .S1 5,A7
    NOP 1
    MPY .M1 A6,A7,A2
    MV .L1 A2,A20
    MV .L1 A2,A21
    LDW .D1T1 *A4,A0
    MVK .S1 0,A0
    [A0] B .S1 tgt
    NOP 5
    MVK .S1 1,A30
tgt:
    MVK .S1 2,A31
; BNOP with false predicate still inserts NOPs: A0=0
    MVK .S1 0,A0
    MVK .S1 0,A16
    [A0] BNOP .S1 tgt2,3
    MVK .S1 1,A16
tgt2:
; results
    MVKL .S2 results,B4
    MVKH .S2 results,B4
    NOP 2
    STW .D2T1 A10,*B4[0]
    STW .D2T1 A11,*B4[1]
    STW .D2T1 A12,*B4[2]
    STW .D2T1 A13,*B4[3]
    STW .D2T1 A14,*B4[4]
    STW .D2T1 A20,*B4[5]
    STW .D2T1 A21,*B4[6]
    STW .D2T1 A30,*B4[7]
    STW .D2T1 A31,*B4[8]
    STW .D2T1 A16,*B4[9]
C$$EXIT:
    B .S1 C$$EXIT
    NOP 5
    .bss results,64,4
