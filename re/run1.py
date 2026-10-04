from pcemu import *
pc = PC()
pc.run_ticks(40)
pc.key(0x39)   # пробел
pc.run_ticks(20); pc.screenshot(OUT+'/s1.png')
pc.key(0x31)   # N (джойстик нет)
pc.run_ticks(20); pc.screenshot(OUT+'/s2.png')
pc.key(0x23)   # H? 
pc.run_ticks(20); pc.screenshot(OUT+'/s3.png')
pc.key(0x39)
pc.run_ticks(60); pc.screenshot(OUT+'/s4.png')
print('state', pc.dsw(4), 'lives', pc.dsb(0x1f80))
