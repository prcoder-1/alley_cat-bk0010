from pcemu import *
pc = PC()
pc.run_ticks(40); pc.key(0x39); pc.run_ticks(10); pc.key(0x31); pc.run_ticks(10); pc.key(0x23); pc.run_ticks(10); pc.key(0x39)
pc.run_ticks(20)
pc.press(0x4D)  # вправо
for i in range(8):
    pc.run_ticks(4)
    print(i,'ticks',pc.ticks,'catX',pc.dsw(0x579),'catY',pc.dsb(0x57b),'dir',pc.dsb(0x56e),'spd',pc.dsb(0x572),'in',pc.dsb(0x698),pc.dsb(0x699),pc.dsb(0x69a), 'kb', bytes(pc.mu.mem_read(pc.ds0*16+0x6b7,22)).hex())
pc.screenshot(OUT+'/r.png')
