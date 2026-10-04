#!/usr/bin/env python3
"""Шрифт для text.c из ПЗУ монитора БК-0010: знаки 040..0137 с адреса 0112276
(10 байт на знак, нужны первые 8 строк). Ядру он нужен своим: на БК-0011М
(и в режиме Std10 СМК на ней) ПЗУ монитора БК-0010 по этому адресу нет.

    mkfont.py monit10.rom > font.s
"""
import sys

rom = open(sys.argv[1], 'rb').read()
print('/ Шрифт ПЗУ монитора БК-0010, знаки 040..0137 по 8 байт (re/mkfont.py)')
print('\t.globl _font\n\t.text\n_font:')
for k in range(64):
    off = 0o12276 + 10 * k
    print('\t.byte ' + ', '.join('0%o' % b if b else '0' for b in rom[off:off + 8]))
print('\t.even')
