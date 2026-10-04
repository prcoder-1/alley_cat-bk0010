from pcemu import *
pc = PC()
hits={}
base=pc.cs0*16
def h(mu,addr,size,ud):
    hits[addr-base]=hits.get(addr-base,0)+1
pc.mu.hook_add(UC_HOOK_CODE,h,None,base+0x100,base+0x300)
pc.mu.hook_add(UC_HOOK_CODE,h,None,base+0x2D35,base+0x2D35)
pc.run_ticks(40); pc.key(0x39); pc.run_ticks(10); pc.key(0x31); pc.run_ticks(10); pc.key(0x23); pc.run_ticks(10); pc.key(0x39)
pc.run_ticks(50)
print(sorted(('%X'%k,v) for k,v in hits.items())[:80])
