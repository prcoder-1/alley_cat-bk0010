from pcemu import *
from collections import Counter
pc = PC()
pc.run_ticks(40); pc.key(0x39); pc.run_ticks(10); pc.key(0x31); pc.run_ticks(10); pc.key(0x23); pc.run_ticks(10); pc.key(0x39)
pc.run_ticks(20)
c=Counter()
for i in range(3000):
    pc.run(37)
    c[pc.r(UC_X86_REG_IP)]+=1
print(sorted(c.items(), key=lambda x:-x[1])[:30])
