# Сверка фона двора: PC (0x2A00 при seed=0x1234, level=1, skill=1) против снимка БК
import sys
from pcemu import *
pc = PC()
pc.run_ticks(5)
pc.ww(pc.ds0, 0x2ae5, 0x1234); pc.ww(pc.ds0, 8, 1); pc.ww(pc.ds0, 0x6df8, 1)
call_proc(pc, 0x2A00)
pcs = scale45(pc.pixels())
bk = bk_png_values(sys.argv[1])
diff = 0; first = None
for y in range(200):
    for x in range(256):
        if pcs[y][x] != bk[y + 28][x]:
            diff += 1
            if first is None: first = (x, y)
print('различающихся пикселей:', diff, 'из', 256 * 200, 'первый:', first)
from PIL import Image
pal = [(0,0,0),(0,0,255),(0,255,0),(255,0,0),(255,255,255)]
im = Image.new('RGB', (256, 200*2+4))
for y in range(200):
    for x in range(256):
        im.putpixel((x, y), pal[pcs[y][x]])
        v = bk[y+28][x]; im.putpixel((x, y + 204), pal[v if v < 4 else 4])
im.resize((512, 808), Image.NEAREST).save(OUT + '/cmp.png')
