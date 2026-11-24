#include <c6x.h>
unsigned r[16];
void f(void)
{
    r[0] = _sadd(0x7fff0000, 0x12345678);
    r[1] = _smpy32(0x87654321, 0x12345678);
    r[2] = _dotprsu2(0x12345678, 0x9abcdef0);
    r[3] = _shfl(0x12345678);
    r[4] = _gmpy4(0x12345678, 0x9abcdef0);
    r[5] = _norm(0x00012345);
    r[6] = _cmpyr(0x12345678, 0x9abcdef0);
    r[7] = _spacku4(0x12345678, 0x9abcdef0);
    r[8] = _subc(0x12345678, 0x9abc);
    r[9] = _lmbd(1, 0x00012345);
    r[10] = _rpack2(0x12345678, 0x9abcdef0);
    r[11] = _sshvl(0x12345678, 5);
    r[12] = _avg2(0x12345678, 0x9abcdef0);
    r[13] = _xormpy(0x12345678, 0x123);
    r[14] = _ftoi(_rcpsp(3.0f));
    r[15] = _ftoi(_rsqrsp(3.0f));
}
