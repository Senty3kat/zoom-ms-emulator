/* SPLOOP stress: short trip counts, float MACs, nested and while loops.
   Built with cl6x -O3 (emulator) and the host compiler; results[] must match. */
#include <string.h>
#include <stdio.h>

#define N 2000
unsigned results[N];
static int ri;
static void put(unsigned v) { if (ri < N) results[ri++] = v; }
static unsigned fb(float f) { unsigned u; memcpy(&u, &f, 4); return u; }

float xa[64], xb[64], xc[64];
int ia[64], ib[64];
short sa[64];
volatile int vn[32];

#pragma FUNC_CANNOT_INLINE(fmac)
static float fmac(const float *a, const float *b, int n)
{
    float s = 0;
    int i;
    for (i = 0; i < n; i++) s += a[i] * b[i];
    return s;
}

#pragma FUNC_CANNOT_INLINE(fscale)
static void fscale(float *restrict d, const float *restrict a, float g, int n)
{
    int i;
    for (i = 0; i < n; i++) d[i] = a[i] * g + 0.25f;
}

#pragma FUNC_CANNOT_INLINE(fbiquad)
static void fbiquad(float *restrict y, const float *restrict x, int n, float *st)
{
    float b0 = 0.2f, b1 = 0.4f, b2 = 0.2f, a1 = -0.5f, a2 = 0.1f;
    float z1 = st[0], z2 = st[1];
    int i;
    for (i = 0; i < n; i++) {
        float o = b0 * x[i] + z1;
        z1 = b1 * x[i] - a1 * o + z2;
        z2 = b2 * x[i] - a2 * o;
        y[i] = o;
    }
    st[0] = z1; st[1] = z2;
}

#pragma FUNC_CANNOT_INLINE(isum)
static int isum(const int *a, int n)
{
    int s = 0, i;
    for (i = 0; i < n; i++) s += a[i] * (i + 3);
    return s;
}

#pragma FUNC_CANNOT_INLINE(icopy)
static void icopy(int *restrict d, const int *restrict s, int n)
{
    int i;
    for (i = 0; i < n; i++) d[i] = s[i] ^ (i << 4);
}

#pragma FUNC_CANNOT_INLINE(ssat)
static void ssat(short *restrict d, const int *restrict s, int n)
{
    int i;
    for (i = 0; i < n; i++) { int v = s[i] >> 3; d[i] = (short)(v > 32767 ? 32767 : v < -32768 ? -32768 : v); }
}

#pragma FUNC_CANNOT_INLINE(slen)
static int slen(const char *p)
{
    const char *q = p;
    while (*q) q++;
    return (int)(q - p);
}

#pragma FUNC_CANNOT_INLINE(find)
static int find(const int *a, int n, int key)
{
    int i = 0;
    do { if (a[i] == key) return i; i++; } while (i < n);
    return -1;
}

#pragma FUNC_CANNOT_INLINE(nested)
static int nested(int r, int c)
{
    int i, j, s = 0;
    for (i = 0; i < r; i++)
        for (j = 0; j < c; j++)
            s += ia[(i * c + j) & 63] * (j + 1) - i;
    return s;
}

int main(void)
{
    int i, n;
    unsigned lcg = 1;
    for (i = 0; i < 64; i++) {
        lcg = lcg * 1664525u + 1013904223u;
        xa[i] = (float)(int)(lcg >> 20) / 512.0f - 1.0f;
        xb[i] = (float)(i % 7) * 0.125f - 0.3f;
        ia[i] = (int)(lcg >> 8) - 0x400000;
        ib[i] = 0;
    }
    for (n = 0; n <= 40; n++) {
        float st[2] = { 0.01f, -0.02f };
        put(fb(fmac(xa, xb, n)));
        fscale(xc, xa, 0.75f, n);
        { unsigned h = 0; for (i = 0; i < 64; i++) h = h * 31 + fb(xc[i]); put(h); }
        memset(xc, 0, sizeof xc);
        fbiquad(xc, xa, n, st);
        { unsigned h = 0; for (i = 0; i < 64; i++) h = h * 31 + fb(xc[i]); put(h); put(fb(st[0])); put(fb(st[1])); }
        memset(xc, 0, sizeof xc);
        put((unsigned)isum(ia, n));
        icopy(ib, ia, n);
        { unsigned h = 0; for (i = 0; i < 64; i++) h = h * 31 + (unsigned)ib[i]; put(h); }
        memset(ib, 0, sizeof ib);
        ssat(sa, ia, n);
        { unsigned h = 0; for (i = 0; i < 64; i++) h = h * 31 + (unsigned short)sa[i]; put(h); }
        memset(sa, 0, sizeof sa);
        put((unsigned)find(ia, n ? n : 1, ia[n / 2]));
        put((unsigned)nested(n % 7 + 1, n % 5 + 1));
    }
    {
        char s[80];
        for (n = 0; n < 70; n += 3) { memset(s, 'a', n); s[n] = 0; put((unsigned)slen(s)); }
    }
    put(0x600DF00Du);
#ifdef HOST
    for (i = 0; i < N; i++) printf("%d %08x\n", i, results[i]);
#endif
    return 0;
}
