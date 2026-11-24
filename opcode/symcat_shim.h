#ifndef SYMCAT_SHIM_H
#define SYMCAT_SHIM_H
#define CONCAT2(a,b) a##b
#define CONCAT3(a,b,c) a##b##c
#define CONCAT4(a,b,c,d) a##b##c##d
#define CONCAT5(a,b,c,d,e) a##b##c##d##e
#define CONCAT6(a,b,c,d,e,f) a##b##c##d##e##f
#define XSTRING(s) #s
#define STRINGX(s) XSTRING(s)
#endif
