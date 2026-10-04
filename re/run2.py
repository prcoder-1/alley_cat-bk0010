from pcemu import *
import pickle
pc = PC()
pc.run_ticks(40); pc.key(0x39); pc.run_ticks(10); pc.key(0x31); pc.run_ticks(10); pc.key(0x23); pc.run_ticks(10); pc.key(0x39)
for i in range(8):
    pc.run_ticks(15)
    pc.screenshot(OUT+'/y%d.png'%i)
    print(i, 'ticks',pc.ticks,'state',pc.dsw(4),'catX',pc.dsw(0x579),'catY',pc.dsb(0x57b),pc.dsb(0x57c))
