unsigned results[8];
volatile int vi = 123456;
volatile double vd = 2.5;
int main(void)
{
    double x = (double)vi;
    double y = x * 1.25;
    double z = y + vd;
    unsigned long long u;
    __builtin_memcpy(&u, &x, 8); results[0] = (unsigned)u; results[1] = (unsigned)(u >> 32);
    __builtin_memcpy(&u, &y, 8); results[2] = (unsigned)u; results[3] = (unsigned)(u >> 32);
    __builtin_memcpy(&u, &z, 8); results[4] = (unsigned)u; results[5] = (unsigned)(u >> 32);
    return 0;
}
