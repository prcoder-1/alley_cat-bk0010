#!/usr/bin/env python3
"""Шрифт для text.c и загрузчика: 8x8 BIOS IBM PC (как текст оригинала; тот же
шрифт рисует BIOS в re/pcemu.py), знаки 040..0137. В PSF старший бит — левая
точка, у БК — младший: биты разворачиваются.

    mkfont.py [шрифт.psfu.gz] > font.s
"""
import gzip
import struct
import sys

path = sys.argv[1] if len(sys.argv) > 1 else '/usr/lib/kbd/consolefonts/cp850-8x8.psfu.gz'
d = gzip.open(path).read()
hs, cs = struct.unpack('<8I', d[:32])[2], struct.unpack('<8I', d[:32])[5]
assert cs == 8


def rev(b):
    return int('{:08b}'.format(b)[::-1], 2)


print('/ Шрифт 8x8 BIOS IBM PC, знаки 040..0137 по 8 байт, младший бит — левая точка (re/mkfont.py)')
print('\t.globl _font\n\t.text\n_font:')
for k in range(0o40, 0o140):
    g = d[hs + k * cs: hs + (k + 1) * cs]
    print('\t.byte ' + ', '.join('0%o' % rev(b) if b else '0' for b in g))
print('\t.even')
