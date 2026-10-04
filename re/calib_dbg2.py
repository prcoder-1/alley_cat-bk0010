from pcemu import *
pc = PC(tick_insns=10**9)
cm = CycleModel(pc)
hits={}
base=pc.cs0*16
def h(mu,a,s,u): hits[a-base]=hits.get(a-base,0)+1
pc.mu.hook_add(UC_HOOK_CODE,h,None,base+0x100,base+0x1B0)
for i in range(30):
    pc.run(200000)
print(pc.ticks, cm.cycles, sorted(hits.items())[:20])
