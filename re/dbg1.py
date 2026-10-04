from pcemu import *
pc = PC()
hits={}
base=pc.cs0*16
def h(mu,addr,size,ud):
    hits[addr-base]=hits.get(addr-base,0)+1
for a in (0x155,0x15F,0x176,0x179,0x17C,0x186,0x191,0x1A6,0x1B7,0x237B,0x2386,0x2391,0x23A7,0x23AC,0x4A0,0x1936):
    pc.mu.hook_add(UC_HOOK_CODE,h,None,base+a,base+a)
pc.run_ticks(40); pc.key(0x39); pc.run_ticks(10); pc.key(0x31); pc.run_ticks(10); pc.key(0x23); pc.run_ticks(10); pc.key(0x39)
hits.clear()
pc.run_ticks(100)
print({('%X'%k):v for k,v in sorted(hits.items())})
print('55a',pc.dsb(0x55a),'1f6c',pc.dsw(0x1f6c),'1673',pc.dsb(0x1673), 'ticks',pc.ticks)
