# Заставка и меню (0x5CB0..0x5FE5, музыка 0x53B0)
from mkdata import DS, bk_byte

# строчные шрифта ПЗУ CGA IBM PC — им набрана строка Copyright (p, o, r сверены с d_title5)
CGA = {
    'c': (0x00, 0x00, 0x78, 0xCC, 0xC0, 0xCC, 0x78, 0x00),
    'd': (0x1C, 0x0C, 0x0C, 0x7C, 0xCC, 0xCC, 0x76, 0x00),
    'e': (0x00, 0x00, 0x78, 0xCC, 0xFC, 0xC0, 0x78, 0x00),
    'o': (0x00, 0x00, 0x78, 0xCC, 0xCC, 0xCC, 0x78, 0x00),
    'p': (0x00, 0x00, 0xDC, 0x66, 0x66, 0x7C, 0x60, 0xF0),
    'r': (0x00, 0x00, 0xDC, 0x76, 0x66, 0x60, 0xF0, 0x00),
}


def signature(text='prcoder'):
    """Подпись порта 11 x 80 точек как «© Copyright» (d_title5): знак © отражён
    в копилефт, пробел, текст в строках 2..9; фон — цвет 2, буквы — цвет 0."""
    w = 16 + 8 + 8 * len(text)
    px = [[2] * w for _ in range(11)]
    for r in range(11):
        for x in range(4, 16):
            b = DS[0x6760 + r * 24 + x // 4]
            px[r][19 - x] = (b >> (6 - 2 * (x % 4))) & 3
    for k, ch in enumerate(text):
        for r, g in enumerate(CGA[ch]):
            for i in range(8):
                if g & (0x80 >> i):
                    px[2 + r][24 + 8 * k + i] = 0
    cga = bytes(px[r][x] << 6 | px[r][x + 1] << 4 | px[r][x + 2] << 2 | px[r][x + 3]
                for r in range(11) for x in range(0, w, 4))
    return bytes(bk_byte(b) for b in cga)


ITEMS = [
    ('d_title1', 'gfx', 0x6152, 29 * 22, 'надпись ALLEY: 29 x 11 слов'),
    ('d_title2', 'gfx', 0x63D0, 22 * 28, 'надпись CAT: 22 x 14 слов'),
    ('d_title3', 'gfx', 0x6638, 12 * 6, '12 x 3 слова'),
    ('d_title4', 'gfx', 0x6680, 8 * 28, '8 x 14 слов'),
    ('d_title5', 'gfx', 0x6760, 11 * 24, '11 x 12 слов'),
    ('d_title6', 'gfx', 0x6868, 8 * 8, '8 x 4 слова'),
    ('d_title_blink', 'gfx', 0x68A8, 2 * 240, 'мигающая часть: 2 кадра 12 x 10 слов'),
    ('d_title_pr', 'raw', 0, signature(), 'подпись порта (не из CAT.EXE): 11 x 10 слов'),
    ('t_title_notes', 'b', 0x538C, 845 + 1, 'мелодия: байт — смещение в таблице делителей, 0x66 — конец'),
    ('t_title_div', 'w', 0x5324, 0x34, 'делители PIT по смещению/2'),
    ('t_title_len', 'w', 0x56DA, 1, 'длительность мелодии, тиков'),
]
