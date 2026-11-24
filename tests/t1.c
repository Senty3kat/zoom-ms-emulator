/* CPU validation program: the same source is compiled with cl6x (run in the
   emulator) and with the host compiler; results[] must match exactly. */
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define N 400
unsigned results[N];
static int ri;
static void put(unsigned v) { if (ri < N) results[ri++] = v; }
static unsigned fbits(float f) { unsigned u; memcpy(&u, &f, 4); return u; }
static void putd(double d) { unsigned long long u; memcpy(&u, &d, 8); put((unsigned)u); put((unsigned)(u >> 32)); }

static volatile int vzero = 0;
static unsigned lcg = 12345;
static unsigned rnd(void) { lcg = lcg * 1103515245u + 12345u; return lcg; }

static int cmp_int(const void *a, const void *b) { int x = *(const int *)a, y = *(const int *)b; return x < y ? -1 : x > y; }
static int fib(int n) { return n < 2 ? n : fib(n - 1) + fib(n - 2); }

struct S { char c; short s; int i; long long ll; float f; };

static int sw(int x)
{
    switch (x) {
    case 0: return 11; case 1: return 22; case 2: return 33; case 3: return 44; case 5: return 55;
    case 8: return 88; case 13: return 130; case 21: return 210; default: return -1;
    }
}

short sa[256], sb[256];
int ia[512], ib[512];
float fa[256], fb[256];
unsigned char bytes[1024];

typedef int (*binop)(int, int);
static int op_add(int a, int b) { return a + b; }
static int op_sub(int a, int b) { return a - b; }
static int op_mul(int a, int b) { return a * b; }

int main(void)
{
    int i, j;
    /* integer arithmetic and division */
    for (i = 0; i < 20; i++) {
        int a = (int)rnd(), b = (int)(rnd() >> (i % 31)) | 1;
        unsigned ua = rnd(), ub = (rnd() >> (i % 30)) | 1;
        put((unsigned)(a / b)); put((unsigned)(a % b)); put(ua / ub); put(ua % ub);
        put((unsigned)(a >> (i % 32))); put(ua >> (i % 32)); put((unsigned)a << (i % 32));
    }
    /* 64-bit */
    for (i = 0; i < 10; i++) {
        long long x = ((long long)rnd() << 32) | rnd(), y = ((long long)(rnd() >> 3) << 20) | rnd() | 1;
        unsigned long long ux = (unsigned long long)x, uy = (unsigned long long)y;
        long long r1 = x * y, r2 = x / y, r3 = x % y;
        put((unsigned)r1); put((unsigned)(r1 >> 32));
        put((unsigned)r2); put((unsigned)(r2 >> 32));
        put((unsigned)r3); put((unsigned)(ux / uy)); put((unsigned)((ux >> (i * 5)) ^ (x << (i * 3))));
    }
    /* float / double basic ops (exactly rounded) */
    for (i = 0; i < 10; i++) {
        float fx = (float)(int)rnd() / 65536.0f, fy = (float)(int)(rnd() >> 8) / 1024.0f + 0.5f;
        double dx = (double)(int)rnd() * 1.25, dy = (double)(rnd() >> 4) / 3.0 + 1.0;
        put(fbits(fx + fy)); put(fbits(fx - fy)); put(fbits(fx * fy));
        putd(dx + dy); putd(dx * dy); putd(dx - dy);
        put((unsigned)(int)(fx * 3.0f)); put((unsigned)(int)dx); put(fbits((float)dx)); putd((double)fx);
        put((unsigned)(fx < fy)); put((unsigned)(dx > dy));
    }
    /* SPLOOP candidates */
    for (i = 0; i < 256; i++) { sa[i] = (short)rnd(); sb[i] = (short)(rnd() >> 3); fa[i] = (float)(i * 3 - 100) * 0.25f; fb[i] = (float)(i & 15) + 0.5f; }
    for (i = 0; i < 512; i++) { ia[i] = (int)rnd() >> 4; }
    {
        int acc = 0; long long acc64 = 0; float facc = 0;
        for (i = 0; i < 256; i++) acc += sa[i] * sb[i];
        put((unsigned)acc);
        for (i = 0; i < 512; i++) acc64 += (long long)ia[i] * (i + 1);
        put((unsigned)acc64); put((unsigned)(acc64 >> 32));
        for (i = 0; i < 256; i++) facc += fa[i] * fb[i];
        put(fbits(facc));
        for (i = 0; i < 512; i++) ib[i] = ia[i] * 3 + (ia[(i + 1) & 511] >> 2);
        acc = 0; for (i = 0; i < 512; i++) acc ^= ib[i] + i;
        put((unsigned)acc);
        for (j = 0; j < 7; j++) { int n = j * 37 + 1; acc = 0; for (i = 0; i < n; i++) acc += ia[i] & 0xFF; put((unsigned)acc); }
    }
    /* memcpy / memset / strings */
    for (i = 0; i < 1024; i++) bytes[i] = (unsigned char)rnd();
    memcpy(bytes + 3, bytes + 500, 301);
    memset(bytes + 700, 0x5A, 77);
    memmove(bytes + 10, bytes + 13, 200);
    { unsigned h = 0; for (i = 0; i < 1024; i++) h = h * 31 + bytes[i]; put(h); }
    {
        char buf[200];
        int n = sprintf(buf, "x=%d u=%u h=%08x s=%s c=%c ld=%lld", -12345, 4000000000u, 0xBEEF, "abc", 'Q', -9876543210LL);
        unsigned h = (unsigned)n; for (i = 0; buf[i]; i++) h = h * 33 + (unsigned char)buf[i]; put(h);
        n = sprintf(buf, "%.3f %e %g %10.4f", 3.14159265, -0.000123456, 12345.678, -2.5);
        h = (unsigned)n; for (i = 0; buf[i]; i++) h = h * 33 + (unsigned char)buf[i]; put(h);
        put((unsigned)strlen("hello world")); put((unsigned)strcmp("abc", "abd")); put((unsigned)atoi("-31337"));
        put((unsigned)strtol("7fffABC", 0, 16));
    }
    /* sort, recursion, switch, function pointers, structs */
    { int arr[100]; for (i = 0; i < 100; i++) arr[i] = (int)(rnd() % 1000) - 500;
      qsort(arr, 100, sizeof(int), cmp_int);
      unsigned h = 0; for (i = 0; i < 100; i++) h = h * 7 + (unsigned)arr[i]; put(h); }
    put((unsigned)fib(20));
    { int s = 0; for (i = 0; i < 25; i++) s = s * 3 + sw(i); put((unsigned)s); }
    { binop ops[3] = { op_add, op_sub, op_mul }; int v = 1; for (i = 0; i < 30; i++) v = ops[i % 3](v, i + 1); put((unsigned)v); }
    { struct S s1 = { -5, -300, 70000, -123456789012LL, 1.5f }, s2; s2 = s1; s2.i += s1.c; put((unsigned)s2.i); put((unsigned)s2.ll); put(fbits(s2.f)); put((unsigned)(int)s2.s); }
    /* math library */
    { float x = 0.7f; double y = 1.3;
      put(fbits(sqrtf(2.0f))); putd(sqrt(2.0)); put((unsigned)(int)(sinf(x) * 1e6f)); put((unsigned)(int)(cos(y) * 1e9));
      put((unsigned)(int)(expf(x) * 1e6f)); put((unsigned)(int)(log(y) * 1e9)); put((unsigned)(int)(atan2f(x, 0.3f) * 1e6f));
      put((unsigned)(int)(powf(x, 2.5f) * 1e6f)); put(fbits(1.0f / 3.0f)); putd(1.0 / 7.0); put(fbits(fabsf(-x))); put(fbits(floorf(-2.5f)));
    }
    put(0xC0FFEEu + (unsigned)vzero);
#ifdef HOST
    for (i = 0; i < N; i++) printf("%d %08x\n", i, results[i]);
#endif
    return 0;
}
