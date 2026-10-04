import sys
d=open(__file__.rsplit('/',2)[0]+'/../AlleyCat.xex','rb').read()
mem=bytearray(65536); cov=bytearray(65536); segs=[]
i=0
while i<len(d):
    if d[i:i+2]==b'\xff\xff': i+=2
    a=d[i]|d[i+1]<<8; e=d[i+2]|d[i+3]<<8; i+=4
    n=e-a+1; mem[a:e+1]=d[i:i+n]; cov[a:e+1]=b'\1'*n; segs.append((a,e)); i+=n
if __name__=='__main__':
    print(len(segs),'segments; RUNAD=%04X INITAD=%04X'%(mem[0x2e0]|mem[0x2e1]<<8, mem[0x2e2]|mem[0x2e3]<<8))
    # слить соседние
    m=[]
    for a,e in sorted(segs):
        if m and a<=m[-1][1]+1: m[-1][1]=max(m[-1][1],e)
        else: m.append([a,e])
    print(' '.join('%04X-%04X'%(a,e) for a,e in m))
    open(__file__.rsplit('/',1)[0]+'/load.bin','wb').write(mem)
