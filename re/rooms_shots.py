from pcemu import *
def boot(pc):
    pc.run_ticks(40); pc.key(0x39); pc.run_ticks(10); pc.key(0x31); pc.run_ticks(10); pc.key(0x23); pc.run_ticks(10); pc.key(0x39); pc.run_ticks(30)
def force_room(pc, st):
    code = bytes([0xB8, st, 0x00, 0xE9]) + ((0x22A - (0x1E5+6)) & 0xFFFF).to_bytes(2,'little')
    pc.mu.mem_write(pc.cs0*16+0x1E5, code)
for st in range(1,8):
    pc = PC(); boot(pc)
    force_room(pc, st)
    if st == 7: pc.wb(pc.ds0, 0x418, 1)
    pc.wb(pc.ds0, 0x551, 1)
    pc.run_ticks(25)
    print(st, 'state', pc.dsw(4))
    pc.screenshot(OUT + '/pc_room%d.png' % st)
