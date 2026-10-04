import re
lines=open('c.lst').read().split('\n')
BL={'0x2d35':'AND','0x2ccc':'KEY','0x2d9d':'COPY','0x2d70':'LIN','0x2b24':'LIST','0x2dca':'SAVE','0x337':'OR'}
for i,l in enumerate(lines):
    m=re.match(r'^([0-9A-F]{4})  call (0x[0-9a-f]+)',l)
    if not m or m.group(2) not in BL: continue
    si=cx=bx=None
    for j in range(i-1,max(0,i-14),-1):
        t=lines[j]
        if t.startswith('proc_') : break
        mm=re.search(r'mov si, (0x[0-9a-f]+|word ptr \[[^]]+\])',t)
        if mm and si is None: si=mm.group(1)
        mm=re.search(r'mov cx, (0x[0-9a-f]+|word ptr \[[^]]+\])',t)
        if mm and cx is None: cx=mm.group(1)
        mm=re.search(r'mov bx, (0x[0-9a-f]+)',t)
        if mm and bx is None: bx=mm.group(1)
    print(m.group(1), BL[m.group(2)], 'si=',si,'cx=',cx, 'bx=',bx if BL[m.group(2)]=='LIST' else '')
