import re, sys
from collections import defaultdict
from capstone import Cs, CS_ARCH_MOS65XX, CS_MODE_MOS65XX_6502
RT=open('rt.bin','rb').read()
md=Cs(CS_ARCH_MOS65XX, CS_MODE_MOS65XX_6502)
LO,HI=0x1B00,0xA000
insns={}; procs=set(); labels=set(); calls=defaultdict(set)
entries=[0x28A5]+[RT[a+1]|RT[a+2]<<8 for a in range(0x9300,0x93A2,3)]
# адреса, загружаемые парами LDA #lo/LDX #hi или LDY/LDX перед SETVBV и в VDSLST — добавим найденные вручную
entries+= [int(x,16) for x in sys.argv[1:]]
work=list(entries); procs.update(entries)
def dec(a):
    for i in md.disasm(RT[a:a+3],a): return i
while work:
    a=work.pop()
    while LO<=a<HI and a not in insns:
        i=dec(a)
        if i is None: break
        insns[a]=i
        m,op=i.mnemonic,i.op_str
        t=None
        mm=re.fullmatch(r'0x([0-9a-f]+)',op)
        if mm: t=int(mm.group(1),16)
        if m=='jsr' and t is not None:
            procs.add(t); calls[a].add(t); work.append(t)
        elif m in ('bcc','bcs','beq','bne','bmi','bpl','bvc','bvs') and t is not None:
            labels.add(t); work.append(t)
        elif m=='jmp':
            if t is not None:
                labels.add(t); work.append(t)
            break
        if m in ('rts','rti','brk'): break
        a+=i.size
out=[]; a=LO
while a<HI:
    i=insns.get(a)
    if i is None:
        j=a
        while j<HI and j not in insns: j+=1
        for k in range(a,j,16): out.append('%04X  .byte %s'%(k,' '.join('%02X'%b for b in RT[k:min(k+16,j)])))
        a=j; continue
    if a in procs: out+=['',';'+'='*60,'proc_%04X:'%a]
    elif a in labels: out.append('L%04X:'%a)
    out.append('%04X  %s %s'%(a,i.mnemonic,i.op_str)); a+=i.size
open('a.lst','w').write('\n'.join(out)+'\n')
print('procs',len(procs),'code bytes',sum(i.size for i in insns.values()))
