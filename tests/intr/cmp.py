import sys
F=[l.split()[1] for l in open('F.txt')]; R=[l.split()[1] for l in open('R.txt')]
N=[l.rstrip() for l in open('names.txt')]
bad={}
for i,(a,b) in enumerate(zip(F,R)):
    if a!=b:
        nm=N[i].split('#')[0]; bad.setdefault(nm,[]).append((N[i],a,b))
print('mismatching intrinsics:',len(bad),'of',len(set(n.split('#')[0] for n in N)))
for k,v in bad.items():
    print(k,len(v))
    for x in v[:4]: print('   ',x)
