#!/usr/bin/env python3
"""Длительность прохода главного цикла PC по сценам (модель тактов 8088).

Шаги прохода — те же процедуры CAT.EXE, что в test/diff_room.py; время BIOS
идёт по тактам. Накладные расходы цикла сверх шагов (опрос клавиатуры и т.п.)
берутся из калибровки двора (re/calib.py: ~85 проходов за тик) и добавляются
к каждому проходу. Выход — такты на проход, отсчёты таймера БК на проход
(PASS_CNT в hw.c; 1 отсчёт = 128/3 МГц = 203,6 такта 4,77 МГц) и число
обновлений кота за тик.

    calib_rooms.py [комната ...]
"""
import os
import sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, '..', 'test'))
from pcemu import *
from diff_room import ROOMS

TICK = 262144                 # тактов 4,77 МГц на тик BIOS
CYC_PER_BK = 4772727 / (3000000 / 128)
ALLEY_PASS = TICK / 85        # двор: ~85 проходов за тик (re/calib.py)


def setup(room, seed=0x1234, level=3):
    pc = PC(tick_insns=10**9)
    cm = CycleModel(pc)
    for o, v in ((0x2AE5, seed), (8, level), (0x6DF8, 1), (4, room), (6, 0)):
        pc.ww(pc.ds0, o, v)
    pc.wb(pc.ds0, 0x1F80, 3)
    fill = 0x55 if room in (2, 7) else 0xAA
    pc.mu.mem_write(0xB8000, bytes([fill]) * 0x4000)
    for proc, fn in ROOMS[room]['init']:
        if proc == 'cat_x0':
            pc.ww(pc.ds0, 0x579, 0)
        elif proc == 'lives_inv':
            pc.wb(pc.ds0, 0x1F81, 0xFF)
        elif proc is not None:
            call_proc(pc, proc)
        if fn == 'dog_off':
            pc.wb(pc.ds0, 0x1CBF, 0)
            pc.wb(pc.ds0, 0x1CB8, 0)
    return pc, cm


def measure(room, passes=1500, ovh=0):
    pc, cm = setup(room)
    steps = [p for p, _ in ROOMS[room]['step'] if isinstance(p, int)]
    base = pc.cs0 * 16
    upd = [0]
    pc.mu.hook_add(UC_HOOK_CODE, lambda mu, a, s, u: upd.__setitem__(0, upd[0] + 1), None, base + 0x926, base + 0x926)
    t0 = 100
    c0 = cm.cycles
    moves = [(1, 1), (1, 0), (0xFF, 1), (0xFF, 0xFF), (1, 0xFF), (0, 1)]
    for n in range(passes):
        dx, dy = moves[(n // 150) % len(moves)]
        pc.wb(pc.ds0, 0x698, dx)
        pc.wb(pc.ds0, 0x699, dy)
        for p in steps:
            t = t0 + (cm.cycles - c0) // TICK
            pc.ticks = t
            pc.mu.mem_write(0x46C, t.to_bytes(4, 'little'))
            call_proc(pc, p)
        cm.cycles += ovh
    cyc = (cm.cycles - c0) / passes
    ticks = (cm.cycles - c0) / TICK
    return cyc, upd[0] / ticks


if __name__ == '__main__':
    steps_alley, _ = measure(0, 600)
    ovh = max(0, int(ALLEY_PASS - steps_alley))
    print('двор: шаги %.0f тактов, накладные %d (до %.0f на проход)' % (steps_alley, ovh, ALLEY_PASS))
    rooms = [int(a) for a in sys.argv[1:]] or list(range(8))
    for r in rooms:
        cyc, ups = measure(r, ovh=ovh)
        print('сцена %d: %.0f тактов на проход = %.1f отсчёта БК, %.1f прохода за тик, кот %.2f обн./тик'
              % (r, cyc, cyc / CYC_PER_BK, TICK / cyc, ups))
