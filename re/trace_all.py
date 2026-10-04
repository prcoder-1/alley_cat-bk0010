import pickle, sys
from pcemu import *
CODE_FORCE = 0x1E5
def boot(pc, skill=0x23):
    pc.run_ticks(40); pc.key(0x39); pc.run_ticks(10); pc.key(0x31); pc.run_ticks(10); pc.key(skill); pc.run_ticks(10); pc.key(0x39)

def force_room(pc, st):
    # 0x1E5: mov ax,st ; jmp 0x22A
    code = bytes([0xB8, st, 0x00, 0xE9]) + ((0x22A - (CODE_FORCE+6)) & 0xFFFF).to_bytes(2,'little')
    pc.mu.mem_write(pc.cs0*16+CODE_FORCE, code)

pc = PC()
tr = Tracer(pc)
boot(pc)
import random
random.seed(1)
keys=[0x4B,0x4D,0x48,0x50,0x38]
def play(pc, ticks):
    held=None
    for t in range(ticks//3):
        if random.random()<0.4:
            if held: pc.release(held)
            held=random.choice(keys); pc.press(held)
        pc.run_ticks(3)
    if held: pc.release(held)
play(pc, 600)
pc.screenshot(OUT+'/t_alley.png')
for st in (1,2,3,4,5,6,7):
    force_room(pc, st)
    pc.wb(pc.ds0, 0x551, 1)
    pc.run_ticks(60)
    play(pc, 500)
    print('state', pc.dsw(4), 'lives', pc.dsb(0x1f80))
    pc.screenshot(OUT+'/t_room%d.png'%st)
    pc.dsw(4)
pickle.dump((tr.blits, bytes(tr.dsread)), open('trace.pkl','wb'))
for k in sorted(tr.blits, key=lambda k:(k[0],abs(k[1]))):
    print(k[0], '%04X'%abs(k[1]) if k[1]>=0 else '-%04X'%-k[1], '%04X'%k[2], ' '.join('%04X'%c for c in sorted(tr.blits[k])))
