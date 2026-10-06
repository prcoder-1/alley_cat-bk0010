#!/usr/bin/env python3
"""Шрифт для text.c и загрузчика (знаки 040..0137 по 8 байт, младший бит —
левая точка). Какой шрифт попадёт в ядро, выбирает FONT в Makefile.

    mkfont.py pc [шрифт.psfu.gz] > font_pc.s    8x8 BIOS IBM PC (как текст оригинала;
                                                тот же шрифт рисует BIOS в re/pcemu.py)
    mkfont.py zx 48.rom > font_zx.s             шрифт ПЗУ ZX Spectrum 48K (с 0x3D00); ПЗУ в
                                                репозиторий не входит (есть в эмуляторе FUSE)
"""
import gzip
import struct
import sys


def rev(b):
    return int('{:08b}'.format(b)[::-1], 2)


def pc(path):
    d = gzip.open(path).read()
    hdr = struct.unpack('<8I', d[:32])
    hs, cs = hdr[2], hdr[5]
    assert cs == 8
    # в PSF старший бит — левая точка
    return [[rev(b) for b in d[hs + k * cs: hs + (k + 1) * cs]] for k in range(0o40, 0o140)]


def zx(path):
    d = open(path, 'rb').read()
    assert len(d) == 16384
    # знаки 32..127 по 8 байт с 0x3D00, старший бит — левая точка
    return [[rev(b) for b in d[0x3D00 + (k - 32) * 8: 0x3D00 + (k - 31) * 8]] for k in range(0o40, 0o140)]


kind = sys.argv[1]
if kind == 'pc':
    font = pc(sys.argv[2] if len(sys.argv) > 2 else '/usr/lib/kbd/consolefonts/cp850-8x8.psfu.gz')
    title = 'Шрифт 8x8 BIOS IBM PC'
else:
    font = zx(sys.argv[2])
    title = 'Шрифт ПЗУ ZX Spectrum 48K'
print('/ %s, знаки 040..0137 по 8 байт, младший бит — левая точка (re/mkfont.py %s)' % (title, kind))
print('\t.globl _font\n\t.text\n_font:')
for g in font:
    print('\t.byte ' + ', '.join('0%o' % b if b else '0' for b in g))
print('\t.even')
