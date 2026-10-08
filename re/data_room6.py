# Псарня: спящие собаки и миски (state 6)
ITEMS = [
    ('d_eyes',      'gfx', 0x4100, 12, 'глаза собаки: 3 стадии, 2 стороны'),
    ('d_drink',     'gfx', 0x410C, 0x41FC - 0x410C, 'кот пьёт 24x10: влево/вправо, 2 кадра'),
    ('d_bowls',     'gfx', 0x41FC, 0x429C - 0x41FC, 'миска 16x8: налито 0..4'),
    ('d_sleepdog',  'gfx', 0x429C, 0x43A0 - 0x429C, 'спящая собака 40x13, 2 стороны'),
    ('t_dog_pos',   'w', 0x4411, 12, ''),
    ('t_kdog_spr',  'w', 0x4429, 12, ''),
    ('t_dog_x',     'w', 0x43E1, 12, ''),
    ('t_dog_y',     'w', 0x43F9, 12, ''),
    ('t_dogs_n',    'b', 0x4471, 8, 'собак по уровню'),
    ('t_bowl_fill', 'b', 0x4479, 8, 'глотков в миске по уровню'),
    ('t_bowl_x',    'w', 0x4481, 12, ''),
    ('t_bowl_y',    'b', 0x4499, 12, ''),
    ('t_drink_spr', 'w', 0x44A5, 12, 'кот пьёт: сторона по миске'),
    ('t_wake_t',    'w', 0x44DC, 8, 'период пробуждения по уровню'),
    ('t_wake_d',    'w', 0x44EC, 8, 'дистанция пробуждения по уровню'),
]

# Пакет с молоком из Atari-версии (AlleyCat.xex, комната 3, 0x246E): игроки PMG 2
# (тело, кадры $25B8) и 3 (узор и струя, $25F8), 8x16 точек Atari -> 16x16 CGA.
# Тело — зелёный (2), узор — красный (3), как молоко в мисках порта.
_RT = open(__file__.rsplit('/', 1)[0] + '/atari/rt.bin', 'rb').read()
_BAG = [(0x00, 0x00), (0x10, 0x10), (0x20, 0x20), (0x30, 0x30), (0x30, 0x40), (0x20, 0x50)]


def _bag():
    out = bytearray()
    for o2, o3 in _BAG:
        for r in range(16):
            p2, p3 = _RT[0x25B8 + o2 + r], _RT[0x25F8 + o3 + r]
            for k in range(4):
                b = 0
                for i in range(4):      # точка CGA i байта k = точка Atari 2k + i//2
                    bit = 0x80 >> (2 * k + i // 2)
                    c = 2 if p2 & bit else (3 if p3 & bit else 0)
                    b |= c << (2 * i)
                out.append(b)
    return bytes(out)


# кадр по состоянию налива 0..7 ($25A5 / $25AD)
_FR = bytes(_BAG.index((_RT[0x25A5 + s], _RT[0x25AD + s])) for s in range(8))

ITEMS += [
    ('d_bag', 'raw', 0, _bag(), 'пакет 16x16, 6 кадров (Atari $25B8/$25F8)'),
    ('t_bag_frame', 'raw', 0, _FR, 'кадр пакета по состоянию налива (Atari $25A5/$25AD)'),
]
