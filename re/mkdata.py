#!/usr/bin/env python3
"""Генерация C-данных порта из сегмента данных CAT.EXE.

Графика (CGA, старший пиксель слева) переводится в порядок бит БК
(пиксель 0 в битах 0-1), геометрия не меняется. Значения цветов — как в
оригинале (палитра БК-0010 фиксирована: 1 синий, 2 зелёный, 3 красный).

Описание объектов — в re/data_*.py (список (имя, вид, адрес, размер)).
    python3 mkdata.py alley   ->  ../data_alley.c / .h
"""
import importlib
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
DS = open(os.path.join(HERE, 'cat_data.bin'), 'rb').read()

# перестановка цветов CGA -> БК (по значению пикселя): синий и зелёный
# поменяны местами, как в прежнем порте (небо синее, забор зелёный)
PERM = [0, 2, 1, 3]


def bk_byte(b):
    out = 0
    for i in range(4):
        px = (b >> (6 - 2 * i)) & 3
        out |= PERM[px] << (2 * i)
    return out


def w(a):
    return DS[a] | DS[a + 1] << 8


def c_bytes(name, data, static=False, comment=''):
    lines = ['%sconst uint8_t %s[%d] =%s' % ('static ' if static else '', name, len(data),
                                            (' /* %s */' % comment) if comment else ''), '{']
    for i in range(0, len(data), 16):
        lines.append('    ' + ', '.join('0x%02x' % b for b in data[i:i + 16]) + ',')
    lines.append('};')
    return '\n'.join(lines)


def c_words(name, data, comment=''):
    lines = ['const uint16_t %s[%d] =%s' % (name, len(data), (' /* %s */' % comment) if comment else ''), '{']
    for i in range(0, len(data), 8):
        lines.append('    ' + ', '.join('0x%04x' % v for v in data[i:i + 8]) + ',')
    lines.append('};')
    return '\n'.join(lines)


def gfx(addr, n):
    return bytes(bk_byte(b) for b in DS[addr:addr + n])


def build(mod):
    spec = importlib.import_module('data_' + mod)
    c = ['/* Сгенерировано re/mkdata.py из CAT.EXE — не править вручную */',
         '#include <stdint.h>', '#include "data_%s.h"' % mod, '']
    h = ['/* Сгенерировано re/mkdata.py */', '#pragma once', '#include <stdint.h>', '']
    for item in spec.ITEMS + getattr(spec, 'ITEMS_BG', []):
        name, kind, addr, size = item[:4]
        note = item[4] if len(item) > 4 else 'DS:%04X' % addr
        if kind == 'gfx':
            data = gfx(addr, size)
            c.append(c_bytes(name, data, comment=note))
            h.append('extern const uint8_t %s[%d];' % (name, len(data)))
        elif kind == 'b':
            data = DS[addr:addr + size]
            c.append(c_bytes(name, data, comment=note))
            h.append('extern const uint8_t %s[%d];' % (name, len(data)))
        elif kind == 'w':
            data = [w(addr + 2 * i) for i in range(size)]
            c.append(c_words(name, data, comment=note))
            h.append('extern const uint16_t %s[%d];' % (name, len(data)))
        elif kind == 'list':     # список блоков 0x2B24: CX, пары (src, dst), 0xFFFF
            n = 1
            while w(addr + 2 * n) != 0xFFFF:
                n += 2
            data = [w(addr + 2 * i) for i in range(n + 1)]
            c.append(c_words(name, data, comment=note))
            h.append('extern const uint16_t %s[%d];' % (name, len(data)))
        elif kind == 'region':   # графика с вкраплениями списков 0x2B24 (их байты — как есть)
            raw = set()
            for a0, a1 in (item[7] if len(item) > 7 else []):
                raw.update(range(a0, a1))
            for la in item[5]:
                n = 1
                while w(la + 2 * n) != 0xFFFF:
                    n += 2
                raw.update(range(la, la + 2 * (n + 1)))
            data = bytes(DS[a] if a in raw else bk_byte(DS[a]) for a in range(addr, addr + size))
            c.append('__attribute__((aligned(2)))')
            c.append(c_bytes(name, data, comment=note))
            h.append('extern const uint8_t %s[%d];' % (name, len(data)))
            h.append('#define %s 0x%04X' % (item[6], addr))
        elif kind == 'raw':      # готовые байты (например, перепакованные таблицы)
            c.append(c_bytes(name, size, comment=note))
            h.append('extern const uint8_t %s[%d];' % (name, len(size)))
        c.append('')
    root = os.path.dirname(HERE)
    open(os.path.join(root, 'data_%s.c' % mod), 'w').write('\n'.join(c) + '\n')
    open(os.path.join(root, 'data_%s.h' % mod), 'w').write('\n'.join(h) + '\n')


if __name__ == '__main__':
    sys.path.insert(0, HERE)
    for m in sys.argv[1:]:
        build(m)
