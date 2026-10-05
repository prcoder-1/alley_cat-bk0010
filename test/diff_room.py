#!/usr/bin/env python3
"""Дифференциальный тест комнат 1..7: CAT.EXE в pcemu против порта, собранного
для ПК (libroomN.so). Вызовы — в порядке игрового цикла оригинала (0x0260..0x0499),
после каждого прохода сравниваются все переменные с адресом [XXXX] в исходниках.

    python3 diff_room.py N [seed] [steps]
"""
import ctypes, random, sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, '..', 're'))
from pcemu import *
from varmap import varmap

# (процедура PC, функция порта) — инициализация после 0x1BF0 и проход цикла
COMMON_FILES = ['cat.c', 'dog.c', 'common.c', 'cat.h', 'dog.h', 'game.h', 'room.h', 'score.h']
ROOMS = {
    0: dict(files=['ovl_alley.c', 'alley.c', 'alley_land.c', 'alley_bg.c', 'alley.h'],
            init=[(0x2A00, 'alley_draw'), (0x5400, 'debris_draw'), ('cat_x0', None), (0x70D, 'cat_init_alley'),
                  (0x1E40, 'dog_reset'), (0x1830, 'windows_init'), (0x2210, 'canmouse_init'), (0x2330, 'mice_init'),
                  (0x58BD, 'snd_rhythm_reset'), ('lives_inv', None)],
            step=[(0x8E5, 'cat_update'), (0x1E63, 'dog_update'), ('quarter', None),
                  (0x546D, 'snd_rhythm'), (0x4A0, 'rope_update'), (0x1936, 'windows_update'), (0x184B, 'item_update'),
                  (0x2216, 'canmouse_update'), (0x237B, 'mice_update'), (0x26B3, 'lives_update')]),
    1: dict(files=['ovl_room1.c', 'room.c'],
            init=[(0x2790, 'draw'), (0x7A1, 'cat_init_room'), (0x3405, 'broom_init'), (0x1E40, 'dog_reset'), (0x58BD, 'snd_rhythm_reset')],
            step=[(0x546D, 'snd_rhythm'), (0x8E5, 'cat_update'), (0x3150, 'broom_update'), (0x1E63, 'dog_update'), (0x3850, 'bowl_update')]),
    2: dict(files=['ovl_room2.c'],
            init=[(0x2790, 'draw'), (0x35C9, 'fish_init'), (0x7A1, 'cat_init_room'), (None, 'dog_off'), (0x58BD, 'snd_rhythm_reset')],
            step=[(0x546D, 'snd_rhythm'), (0x8E5, 'cat_update'), (0x3675, 'fish_update'), (0x37E5, 'waves_update')]),
    3: dict(files=['ovl_room3.c', 'room.c'],
            init=[(0x2790, 'draw'), (0x7A1, 'cat_init_room'), (0x3405, 'broom_init'), (0x1E40, 'dog_reset'), (0x3B30, 'pots_init'), (0x3C90, 'spider_init'), (0x58BD, 'snd_rhythm_reset')],
            step=[(0x546D, 'snd_rhythm'), (0x8E5, 'cat_update'), (0x3CB1, 'spider_update'), (0x3B42, 'pots_update'), (0x3150, 'broom_update'), (0x1E63, 'dog_update')]),
    4: dict(files=['ovl_room4.c', 'room.c'],
            init=[(0x2790, 'draw'), (0x7A1, 'cat_init_room'), (0x3405, 'broom_init'), (0x1E40, 'dog_reset'), (0x4090, 'mice_init'), (0x58BD, 'snd_rhythm_reset')],
            step=[(0x546D, 'snd_rhythm'), (0x8E5, 'cat_update'), (0x3E90, 'jump_update'), (0x40C2, 'mice_update'), (0x3150, 'broom_update'), (0x1E63, 'dog_update')]),
    5: dict(files=['ovl_room5.c', 'room.c'],
            init=[(0x2790, 'draw'), (0x457A, 'cage_init'), (0x7A1, 'cat_init_room'), (0x3405, 'broom_init'), (0x1E40, 'dog_reset'), (0x58BD, 'snd_rhythm_reset')],
            step=[(0x546D, 'snd_rhythm'), (0x45AB, 'cage_update'), (0x4340, 'bird_update'), (0x8E5, 'cat_update'), (0x3150, 'broom_update'), (0x1E63, 'dog_update')]),
    6: dict(files=['ovl_room6.c', 'room.c'],
            init=[(0x2790, 'draw'), (0x7A1, 'cat_init_room'), (0x3405, 'broom_init'), (0x1E40, 'dog_reset'), (0x58BD, 'snd_rhythm_reset')],
            step=[(0x546D, 'snd_rhythm'), (0x4943, 'drink_update'), (0x47D6, 'dogs_update'), (0x8E5, 'cat_update'), ('fight', None)]),
    7: dict(files=['ovl_room7.c'],
            init=[(0x2790, 'draw'), (0x7A1, 'cat_init_room'), (0x1E40, 'dog_reset'), (0x3405, 'rand16'), (0x6100, 'arrow_init'), (0x4F59, 'rivals_init'), (0x58BD, 'snd_rhythm_reset')],
            step=[(0x546D, 'snd_rhythm'), (0x8E5, 'cat_update'), (0x6106, 'arrow_update'), (0x2F66, 'gift_pick'), (0x2E60, 'gift_drop'), (0x4C10, 'rivals_update')]),
}


PERM = [0, 2, 1, 3]    # цвета БК: синий и зелёный поменяны (re/mkdata.py)


def bk_byte(b):
    return PERM[(b >> 6) & 3] | (PERM[(b >> 4) & 3] << 2) | (PERM[(b >> 2) & 3] << 4) | (PERM[b & 3] << 6)


BKFMT = {'wash_buf'}   # графика в порядке бит БК


def pos_of(off):
    row = (off >> 13) & 1; l = off & 0x1FFF
    return ((row + 2 * (l // 80)) << 8) | (l % 80)


def run(room, seed, steps, level=3, verbose=True):
    cfg = ROOMS[room]
    lib = ctypes.CDLL(os.path.join(HERE, 'libroom%d.so' % room))
    def v8(n): return ctypes.c_uint8.in_dll(lib, n)
    def v16(n): return ctypes.c_uint16.in_dll(lib, n)
    vars_ = []
    IGNORE = {'zp_n', 'zp_w', 'spi_n', 'fence_prev'}   # счётчики звука, зависящие от скорости циклов ожидания
    RAWPOS = {'dog_kill_pos'}            # хранят смещение CGA, как на PC
    for name, addr, size, n, f in varmap(cfg['files'] + COMMON_FILES + ['snd.c']):
        if name in IGNORE:
            continue
        try:
            ctypes.c_uint8.in_dll(lib, name)
            vars_.append((name, addr, size, n, f))
        except ValueError:
            pass
    pc = PC(); pc.run_ticks(3); pc.force_retrace = True; pc.auto_tick = 50
    for o, v in ((0x2AE5, seed), (8, level), (0x6DF8, 1), (4, room), (6, 0)):
        pc.ww(pc.ds0, o, v)
    pc.wb(pc.ds0, 0x1F80, 3)
    lib.rand_seed(seed); v16('g_level').value = level; v16('g_skill').value = 1
    v8('g_lives').value = 3; v16('g_state').value = room; v16('g_prev_state').value = 0
    v8('g_sound').value = 0xFF
    lib.ovl_entry()
    # исходное состояние порта = состояние PC (переменные, которые комната не задаёт)
    for name, addr, size, n, f in vars_:
        arr = (ctypes.c_uint16 if size == 2 else ctypes.c_uint8) * n
        mine = arr.in_dll(lib, name)
        for i in range(n):
            a = pc.dsw(addr + 2 * i) if size == 2 else pc.dsb(addr + i)
            mine[i] = pos_of(a) if ('pos' in name and size == 2 and name not in RAWPOS) else (bk_byte(a) if name in BKFMT else a)
    v16('g_state').value = room; v16('g_level').value = level
    # экран после шторки 0x1BF0: залит 0xAA (у аквариума и Фелиции — 0x55)
    fill = 0x55 if room in (2, 7) else 0xAA
    pc.mu.mem_write(0xB8000, bytes([fill]) * 0x4000)
    ctypes.memset((ctypes.c_uint8 * 16384).in_dll(lib, 'vram'), bk_byte(fill), 16384)
    t = 100
    pc.ticks = t; pc.mu.mem_write(0x46C, t.to_bytes(4, 'little')); v16('host_ticks').value = t
    for proc, fn in cfg['init']:
        if proc == 'cat_x0':
            pc.ww(pc.ds0, 0x579, 0); v16('cat_x').value = 0; continue
        if proc == 'lives_inv':
            pc.wb(pc.ds0, 0x1F81, 0xFF); lib.lives_invalidate(); continue
        if proc is not None:
            call_proc(pc, proc)
        if fn == 'dog_off':
            pc.wb(pc.ds0, 0x1CBF, 0); pc.wb(pc.ds0, 0x1CB8, 0)
            v8('dog_active').value = 0; v8('dog_fight').value = 0
        elif fn == 'arrow_init':
            v8('ar_on').value = 0
        else:
            getattr(lib, fn)()

    def compare(stage):
        for name, addr, size, n, f in vars_:
            arr = (ctypes.c_uint16 if size == 2 else ctypes.c_uint8) * n
            mine = arr.in_dll(lib, name)
            for i in range(n):
                a = pc.dsw(addr + 2 * i) if size == 2 else pc.dsb(addr + i)
                b = mine[i]
                if 'pos' in name and size == 2 and name not in RAWPOS:
                    a = pos_of(a)
                if name in BKFMT:
                    a = bk_byte(a)
                if a != b:
                    return '%s: %s%s PC=%X порт=%X  (%s, [%04X])' % (
                        stage, name, '[%d]' % i if n > 1 else '', a, b, f, addr)
        return None

    err = compare('инициализация')
    if err:
        print('комната %d seed %04X %s' % (room, seed, err)); return False
    rnd = random.Random(seed)
    dx = dy = 0; btn = 0x10; resync = 0
    for step in range(steps):
        if step % 2 == 0:
            t += 1
        if rnd.random() < 0.15: dx = rnd.choice([0, 1, 0xFF, 1, 0xFF])
        if rnd.random() < 0.15: dy = rnd.choice([0, 0, 0xFF, 1])
        if rnd.random() < 0.10: btn = rnd.choice([0, 0x10, 0x10])
        rt = rnd.random() < 0.6
        pc.force_retrace = rt; ctypes.c_uint8.in_dll(lib, 'host_retrace').value = 1 if rt else 0
        pc.ticks = t; pc.mu.mem_write(0x46C, t.to_bytes(4, 'little')); v16('host_ticks').value = t
        pc.wb(pc.ds0, 0x698, dx); pc.wb(pc.ds0, 0x699, dy); pc.wb(pc.ds0, 0x69A, btn)
        v8('in_dx').value = dx; v8('in_dy').value = dy; v8('in_btn').value = btn
        for proc, fn in cfg['step']:
            if proc == 'quarter':    # 0x017F: блок двора — каждый 4-й проход, в драке — каждый
                if pc.dsb(0x1CB8) == 0:
                    q = (pc.dsb(0x40F) + 1) & 0xFF
                    pc.wb(pc.ds0, 0x40F, q)
                    if q & 3:
                        break
                v16('g_passes4').value = 1
                continue
            if proc == 'fight':      # 0x02D7: пёс дерётся — пёс, иначе метла
                if pc.dsb(0x1CB8):
                    call_proc(pc, 0x1E63)
                else:
                    call_proc(pc, 0x3150)
                if v8('dog_fight').value:
                    lib.dog_update()
                else:
                    lib.broom_update()
                continue
            r0 = pc.dsw(0x2AE5), v16('rand_state').value
            call_proc(pc, proc)
            getattr(lib, fn)()
            if os.environ.get('RNGTRACE') and int(os.environ['RNGTRACE']) == step:
                print('  %04X: ГСЧ до %04X/%04X после %04X/%04X, тик PC %X порт %X' % (proc, r0[0], r0[1], pc.dsw(0x2AE5), v16('rand_state').value, pc.ticks, v16('host_ticks').value))
            if pc.dsw(0x2AE5) != v16('rand_state').value:
                resync += 1
                if verbose:
                    print('  проход %d после %04X: ГСЧ синхронизирован' % (step, proc))
                v16('rand_state').value = pc.dsw(0x2AE5)
        dx = pc.dsb(0x698); dy = pc.dsb(0x699)
        if os.environ.get('SHOW'):
            want = os.environ['SHOW'].split(',')
            line = []
            for name, addr, size, n, f in vars_:
                for w_ in want:
                    nm, _, idx = w_.partition(':')
                    if nm != name:
                        continue
                    i = int(idx or 0)
                    a = pc.dsw(addr + 2 * i) if size == 2 else pc.dsb(addr + i)
                    arr = ((ctypes.c_uint16 if size == 2 else ctypes.c_uint8) * n).in_dll(lib, name)
                    line.append('%s=%X/%X' % (w_, a, arr[i]))
            print('  проход %d: %s' % (step, ' '.join(line)))
        err = compare('проход %d' % step)
        if err:
            print('комната %d seed %04X %s' % (room, seed, err)); return False
        ex = (pc.dsb(0x551), pc.dsb(0x552), pc.dsb(0x553))
        if any(ex):
            if verbose:
                print('  проход %d: выход из комнаты (exit/failed/won = %s)' % (step, ex))
            break
    pcs = scale45(pc.pixels())
    vr = (ctypes.c_uint8 * 16384).in_dll(lib, 'vram')
    bad = 0
    known = 0
    tint = room == 2 and v8('cat_tint').value
    cx = pc.dsw(0x579) * 4 // 5; cy = pc.dsb(0x57B)
    for y in range(200):
        for x in range(256):
            b = (vr[(y + 28) * 64 + x // 4] >> (2 * (x % 4))) & 3
            if b != PERM[pcs[y][x]]:
                # известные отступления: сдвиг верёвок при сжатии 4/5; щели забора, потерянные
                # при сжатии (fence_gaps); подкрашенный кот вместо палитры
                if room == 0 and any(r <= y < r + 16 for r in (8, 40, 72)) or \
                   room == 0 and 112 <= y < 176 and x % 32 == 31 and b == 1 or \
                   tint and pcs[y][x] == 0 and cx <= x < cx + 24 and cy <= y < cy + 16:
                    known += 1
                    continue
                bad += 1
                if bad <= 5 and verbose:
                    print('  пиксель', x, y, 'PC', pcs[y][x], 'порт', b)
    if os.environ.get('PNG'):
        from PIL import Image
        pal = [(0, 0, 0), (0, 0, 255), (0, 255, 0), (255, 0, 0)]
        im = Image.new('RGB', (256, 404), (255, 255, 255))
        for y in range(200):
            for x in range(256):
                im.putpixel((x, y), pal[PERM[pcs[y][x]]])
                im.putpixel((x, y + 204), pal[(vr[(y + 28) * 64 + x // 4] >> (2 * (x % 4))) & 3])
        im.resize((512, 808), Image.NEAREST).save(os.environ['PNG'])
    print('комната %d seed %04X: %d проходов, %d переменных совпали, ГСЧ подправлен %d раз, отличий на экране %d (известных %d)'
          % (room, seed, step + 1, len(vars_), resync, bad, known))
    return bad == 0


if __name__ == '__main__' and sys.argv[1] == 'all':
    import subprocess
    bad = []
    for room in range(0, 8):
        for level in (0, 3, 7):
            for seed in ('1234', '7777', 'BEEF', '0F0F'):
                r = subprocess.run([sys.executable, __file__, str(room), seed, '600', str(level)],
                                   capture_output=True, text=True)
                last = [l for l in r.stdout.splitlines() if l.startswith('комната')]
                print('ур.%d %s' % (level, last[-1] if last else r.stdout[-300:] + r.stderr[-300:]), flush=True)
                if r.returncode:
                    bad.append((room, level, seed))
    print('ИТОГ:', 'OK' if not bad else 'расхождения: %s' % bad)
    sys.exit(1 if bad else 0)

if __name__ == '__main__':
    room = int(sys.argv[1])
    seed = int(sys.argv[2], 16) if len(sys.argv) > 2 else 0x1234
    steps = int(sys.argv[3]) if len(sys.argv) > 3 else 400
    level = int(sys.argv[4]) if len(sys.argv) > 4 else 3
    sys.exit(0 if run(room, seed, steps, level) else 1)
