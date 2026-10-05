#!/usr/bin/env python3
"""Дифференциальный тест: кот (0x08E5) и пёс (0x1E63) во дворе, PC против порта."""
import ctypes, random, sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, '..', 're'))
from pcemu import *

lib = ctypes.CDLL(os.path.join(HERE, 'libcat.so'))
def v8(n): return ctypes.c_uint8.in_dll(lib, n)
def v16(n): return ctypes.c_uint16.in_dll(lib, n)

def pos_of(off):
    row = (off >> 13) & 1; l = off & 0x1FFF
    return ((row + 2 * (l // 80)) << 8) | (l % 80)

# переменные: (имя в порту, DS-смещение, размер, преобразование)
VARS = [('cat_x',0x579,2),('cat_y',0x57B,1),('cat_ry',0x57C,1),('cat_dir',0x56E,1),('cat_vdir',0x571,1),
        ('cat_vy',0x576,1),('cat_acc',0x577,1),('cat_dec',0x578,1),('cat_speed',0x572,2),('cat_stun',0x55B,1),
        ('cat_fence',0x550,1),('cat_onrope',0x55C,1),('cat_frame',0x56B,1),('cat_spr',0x55D,2),('cat_size',0x561,2),
        ('cat_enter',0x558,1),('cat_enter_dly',0x559,1),('cat_hit',0x55A,1),('cat_noerase',0x583,1),
        ('cat_jspr',0x569,2),('cat_jsize',0x567,2),('cat_sub',0x684,2),
        ('dog_active',0x1CBF,1),('dog_fight',0x1CB8,1),('dog_x',0x1CC6,2),('g_lives',0x1F80,1),
        ('rand_state',0x2AE5,2)]

def run(seed, steps, level=1, inputs_seed=0):
    pc = PC(); pc.run_ticks(3); pc.force_retrace = True; pc.auto_tick = 50
    for o,v in ((0x2ae5,seed),(8,level),(0x6df8,1)): pc.ww(pc.ds0,o,v)
    pc.wb(pc.ds0,0x1f80,3)
    call_proc(pc, 0x2A00)
    pc.ww(pc.ds0,0x579,0)
    call_proc(pc, 0x1E40)
    call_proc(pc, 0x70D)
    # порт
    lib.rand_seed(seed); v16('g_level').value=level; v16('g_skill').value=1; v8('g_lives').value=3
    v16('g_state').value=0
    lib.alley_draw()
    # крючки двора
    hooks = ctypes.c_void_p.in_dll(lib,'hooks')
    land = ctypes.cast(lib.alley_land, ctypes.c_void_p).value
    ctypes.memmove(ctypes.addressof(hooks)+8, ctypes.byref(ctypes.c_void_p(land)), 8)
    v16('cat_x').value=0
    lib.dog_reset(); lib.cat_init_alley()
    rnd = random.Random(inputs_seed)
    dx = dy = 0
    t = 100
    for step in range(steps):
        if rnd.random() < 0.15: dx = rnd.choice([0,1,0xFF,1,0xFF])
        if rnd.random() < 0.15: dy = rnd.choice([0,0,0xFF,1])
        t += 1
        for k in range(2):     # обновление на смене тика и второе внутри тика
            pc.ticks = t; pc.mu.mem_write(0x46C, t.to_bytes(4,'little'))
            pc.wb(pc.ds0,0x698,dx); pc.wb(pc.ds0,0x699,dy)
            ctypes.c_uint16.in_dll(lib,'host_ticks').value = t
            v8('in_dx').value=dx; v8('in_dy').value=dy
            if k == 1:
                pc.ww(pc.ds0,0x684,1); v16('cat_sub').value=1
            call_proc(pc, 0x8E5); lib.cat_update()
            dx = pc.dsb(0x698); dy = pc.dsb(0x699)
        call_proc(pc, 0x1E63); lib.dog_update()
        if pc.dsw(0x2AE5) != v16('rand_state').value and os.environ.get('RESYNC', '1') == '1':
            print('  шаг %d: ГСЧ синхронизирован (звук, зависящий от времени)' % step)
            v16('rand_state').value = pc.dsw(0x2AE5)
        for name,off,sz in VARS:
            a = pc.dsw(off) if sz==2 else pc.dsb(off)
            b = (v16 if sz==2 else v8)(name).value
            if a != b:
                print('seed %04X шаг %d: %s PC=%X порт=%X'%(seed,step,name,a,b))
                return False
        if os.environ.get('EVERY'):
            px = pc.pixels(); vr = (ctypes.c_uint8*16384).in_dll(lib,'vram')
            for y in range(170,200):
                for x in range(320):
                    if x % 5 == 4: continue
                    bx = x - x//5
                    b = (vr[(y+28)*64 + bx//4] >> (2*(bx%4))) & 3
                    if b != [0, 2, 1, 3][px[y][x]]:
                        print('шаг', step, 'пиксель', bx, y, 'PC', px[y][x], 'порт', b, 'кот', pc.dsw(0x579), pc.dsb(0x57B), 'пёс', pc.dsb(0x1CBF), pc.dsb(0x1CB8), pc.dsw(0x1CC6)); return False
        if pos_of(pc.dsw(0x55F)) != v16('cat_pos').value:
            print('шаг %d: cat_pos PC=%04X порт=%04X'%(step,pos_of(pc.dsw(0x55F)),v16('cat_pos').value)); return False
    # экран
    pcs = scale45(pc.pixels())
    vr = (ctypes.c_uint8*16384).in_dll(lib,'vram')
    bad = 0
    for y in range(200):
        for x in range(256):
            b = vr[(y+28)*64 + x//4]; b = (b >> (2*(x%4))) & 3
            if b != [0, 2, 1, 3][pcs[y][x]]:
                if 112 <= y < 176 and x % 32 == 31 and b == 1: continue   # щели забора (fence_gaps)
                bad += 1
                if bad <= 5: print('  пиксель', x, y, 'PC', pcs[y][x], 'порт', b)
    print('seed %04X: %d шагов совпали, отличий на экране: %d' % (seed, steps, bad))
    return bad == 0

if len(sys.argv) > 1:
    sys.exit(0 if run(int(sys.argv[1], 16), int(sys.argv[2]) if len(sys.argv) > 2 else 300, inputs_seed=int(sys.argv[1], 16)) else 1)
import subprocess
ok = all([subprocess.call([sys.executable, __file__, '%X' % s, '400']) == 0 for s in (0x1234, 0x7777, 0xBEEF, 0x0F0F, 0xA5A5, 0x5A5A)])
print('ИТОГ:', 'OK' if ok else 'РАСХОЖДЕНИЕ')
