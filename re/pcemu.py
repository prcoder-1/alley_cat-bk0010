#!/usr/bin/env python3
"""Инструментальный эмулятор IBM PC для CAT.EXE (unicorn, 8086 real mode).

Эмулируется только то, чем пользуется игра: BIOS int 10h/11h/1Ah, тики int 8,
клавиатура (порт 60h + IRQ1 -> обработчик игры), PIT/динамик (порты 40h-43h,
61h), статус CGA (3DAh), видеопамять B800 (CGA mode 4).

Время виртуальное: TICK_INSNS инструкций = один тик BIOS (18.2 Гц).
"""
import gzip
import struct
from unicorn import Uc, UC_ARCH_X86, UC_MODE_16, UC_HOOK_INTR, UC_HOOK_INSN, UC_HOOK_CODE, UC_HOOK_MEM_WRITE
from unicorn.x86_const import *

EXE = __file__.rsplit('/', 1)[0] + '/../CAT.EXE'
OUT = '/tmp/claude-1000/-home-prcoder---0010-develop-alley-cat-bk0010/1454101e-0a05-4497-9571-41367a1d8b00/scratchpad'
LOAD_SEG = 0x1000
PSP_SEG = LOAD_SEG - 0x10
BIOS_SEG = 0xF000

CGA_RGB = [(0, 0, 0), (0, 0, 0xAA), (0, 0xAA, 0), (0, 0xAA, 0xAA), (0xAA, 0, 0), (0xAA, 0, 0xAA),
           (0xAA, 0x55, 0), (0xAA, 0xAA, 0xAA), (0x55, 0x55, 0x55), (0x55, 0x55, 0xFF),
           (0x55, 0xFF, 0x55), (0x55, 0xFF, 0xFF), (0xFF, 0x55, 0x55), (0xFF, 0x55, 0xFF),
           (0xFF, 0xFF, 0x55), (0xFF, 0xFF, 0xFF)]


def load_font():
    d = gzip.open('/usr/lib/kbd/consolefonts/cp850-8x8.psfu.gz').read()
    hdr = struct.unpack('<8I', d[:32])
    hs, n, cs = hdr[2], hdr[4], hdr[5]
    return [d[hs + i * cs: hs + (i + 1) * cs] for i in range(min(n, 256))]


class PC:
    def __init__(self, tick_insns=20000, machine_id=0xFF):
        self.tick_insns = tick_insns
        self.icount = 0
        self.mu = mu = Uc(UC_ARCH_X86, UC_MODE_16)
        mu.mem_map(0, 0x110000)
        self.font = load_font()
        exe = open(EXE, 'rb').read()
        (sig, cblp, cp, crlc, cparhdr, minalloc, maxalloc, ss, sp, csum, ip, cs, lfarlc) = struct.unpack('<13H', exe[:26])
        hdr = cparhdr * 16
        size = cp * 512 - (512 - cblp if cblp else 0)
        img = bytearray(exe[hdr:size])
        for i in range(crlc):
            off, seg = struct.unpack('<HH', exe[lfarlc + 4 * i: lfarlc + 4 * i + 4])
            a = seg * 16 + off
            v = struct.unpack('<H', img[a:a + 2])[0]
            img[a:a + 2] = struct.pack('<H', (v + LOAD_SEG) & 0xFFFF)
        mu.mem_write(LOAD_SEG * 16, bytes(img))
        self.cs0 = LOAD_SEG + cs
        self.ds0 = LOAD_SEG + 0x10
        # PSP: int 20h
        mu.mem_write(PSP_SEG * 16, b'\xCD\x20')
        # IVT -> заглушки IRET в F000:1000+n
        for n in range(256):
            mu.mem_write(n * 4, struct.pack('<HH', 0x1000 + n, BIOS_SEG))
            mu.mem_write(BIOS_SEG * 16 + 0x1000 + n, b'\xCF')
        mu.mem_write(BIOS_SEG * 16 + 0xFFFE, bytes([machine_id]))
        # BDA: оборудование = CGA 80x25, 1 дисковод
        mu.mem_write(0x410, struct.pack('<H', 0x0021 | 0x20))
        self.ticks = 0
        mu.reg_write(UC_X86_REG_CS, self.cs0)
        mu.reg_write(UC_X86_REG_IP, ip)
        mu.reg_write(UC_X86_REG_SS, LOAD_SEG + ss)
        mu.reg_write(UC_X86_REG_SP, sp)
        mu.reg_write(UC_X86_REG_DS, PSP_SEG)
        mu.reg_write(UC_X86_REG_ES, PSP_SEG)
        self.port60 = 0
        self.sub = 0
        self.slice_n = 1
        self.cyc = None
        self.force_retrace = None
        self.port61 = 0
        self.pit_ctrl = 0
        self.pit_latch = None
        self.pit2_div = 0
        self.pit2_lohi = 0
        self.pal_reg = 0      # порт 3D9
        self.bios_pal = (0, 1)  # (фон, палитра) через int 10h AH=0Bh
        self.key_queue = []   # скан-коды для IRQ1
        self.sound_log = []   # (icount, событие, значение)
        self.cursor = (0, 0)
        self.halted = False
        self.watch = None
        self.code_hooks = {}
        mu.hook_add(UC_HOOK_INTR, self._intr)
        mu.hook_add(UC_HOOK_INSN, self._in, None, 1, 0, UC_X86_INS_IN)
        mu.hook_add(UC_HOOK_INSN, self._out, None, 1, 0, UC_X86_INS_OUT)

    # --- регистры/память ---
    def r(self, reg):
        return self.mu.reg_read(reg)

    def w(self, reg, v):
        self.mu.reg_write(reg, v)

    def rb(self, seg, off):
        return self.mu.mem_read(seg * 16 + off, 1)[0]

    def rw(self, seg, off):
        return struct.unpack('<H', self.mu.mem_read(seg * 16 + off, 2))[0]

    def wb(self, seg, off, v):
        self.mu.mem_write(seg * 16 + off, bytes([v & 0xFF]))

    def ww(self, seg, off, v):
        self.mu.mem_write(seg * 16 + off, struct.pack('<H', v & 0xFFFF))

    def dsb(self, off):
        return self.rb(self.ds0, off)

    def dsw(self, off):
        return self.rw(self.ds0, off)

    def push(self, v):
        sp = (self.r(UC_X86_REG_SP) - 2) & 0xFFFF
        self.w(UC_X86_REG_SP, sp)
        self.ww(self.r(UC_X86_REG_SS), sp, v)

    def raise_int(self, n):
        """Войти в обработчик прерывания n, как это делает процессор."""
        fl = self.r(UC_X86_REG_FLAGS)
        self.push(fl)
        self.push(self.r(UC_X86_REG_CS))
        self.push(self.r(UC_X86_REG_IP))
        self.w(UC_X86_REG_FLAGS, fl & ~0x0300)  # IF=0, TF=0
        off, seg = struct.unpack('<HH', self.mu.mem_read(n * 4, 4))
        self.w(UC_X86_REG_CS, seg)
        self.w(UC_X86_REG_IP, off)

    # --- BIOS ---
    def _intr(self, mu, intno, ud):
        if intno != 0xFF:
            pass
        n = intno
        # unicorn: IP уже после INT
        off, seg = struct.unpack('<HH', mu.mem_read(n * 4, 4))
        if seg != BIOS_SEG:
            self.raise_int(n)
            return
        ah = (self.r(UC_X86_REG_AX) >> 8) & 0xFF
        al = self.r(UC_X86_REG_AX) & 0xFF
        if n == 0x10:
            self._int10(ah, al)
        elif n == 0x11:
            self.w(UC_X86_REG_AX, self.rw(0x40, 0x10))
        elif n == 0x1A:
            if ah == 0:
                if getattr(self, 'auto_tick', 0):
                    self._at = getattr(self, '_at', 0) + 1
                    if self._at >= self.auto_tick:
                        self._at = 0
                        self.ticks += 1
                t = self.ticks
                self.w(UC_X86_REG_CX, (t >> 16) & 0xFFFF)
                self.w(UC_X86_REG_DX, t & 0xFFFF)
                self.w(UC_X86_REG_AX, self.r(UC_X86_REG_AX) & 0xFF00)
        elif n == 0x09:
            pass  # BIOS-обработчик клавиатуры: ничего
        elif n == 0x16:
            self.w(UC_X86_REG_AX, 0)
        elif n == 0x20 or (n == 0x21 and ah == 0x4C):
            self.halted = True
            mu.emu_stop()
        else:
            print('int %02X ah=%02X @%04X:%04X' % (n, ah, self.r(UC_X86_REG_CS), self.r(UC_X86_REG_IP)))

    def _int10(self, ah, al):
        if ah == 0x00:
            self.mu.mem_write(0xB8000, b'\0' * 0x4000)
            self.mode = al
        elif ah == 0x0B:
            bx = self.r(UC_X86_REG_BX)
            bh, bl = bx >> 8, bx & 0xFF
            bg, pal = self.bios_pal
            if bh == 0:
                bg = bl & 0x1F
                self.pal_reg = (self.pal_reg & 0x20) | (bl & 0x1F)
            else:
                pal = bl & 1
                self.pal_reg = (self.pal_reg & 0x1F) | (0x20 if pal else 0)
            self.bios_pal = (bg, pal)
        elif ah == 0x02:
            dx = self.r(UC_X86_REG_DX)
            self.cursor = (dx & 0xFF, dx >> 8)
        elif ah == 0x0E:
            col, row = self.cursor
            bl = self.r(UC_X86_REG_BX) & 0xFF
            if al == 13:
                col = 0
            elif al == 10:
                row += 1
            elif al == 8:
                col = max(0, col - 1)
            else:
                self.draw_char(col, row, al, bl & 3)
                col += 1
                if col >= 40:
                    col = 0
                    row += 1
            self.cursor = (col, row)
        elif ah == 0x0F:
            self.w(UC_X86_REG_AX, (40 << 8) | 4)
            self.w(UC_X86_REG_BX, self.r(UC_X86_REG_BX) & 0xFF)
        elif ah == 0x10:
            pass  # PCjr
        else:
            print('int10 ah=%02X' % ah)

    def draw_char(self, col, row, ch, color):
        glyph = self.font[ch]
        for y in range(8):
            line = row * 8 + y
            base = 0xB8000 + (line & 1) * 0x2000 + (line >> 1) * 80 + col * 2
            bits = glyph[y]
            word = 0
            for x in range(8):
                if bits & (0x80 >> x):
                    word |= color << (14 - 2 * x)
            self.mu.mem_write(base, bytes([word >> 8, word & 0xFF]))

    # --- порты ---
    def _in(self, mu, port, size, ud):
        if port == 0x60:
            return self.port60
        if port == 0x61:
            return self.port61
        if port == 0x3DA:
            if self.force_retrace is not None:
                return 0x09 if self.force_retrace else 0
            self.sub = min(self.sub + 25, self.slice_n - 1)
            t = self.icount + self.sub
            frame = self.tick_insns * 18.2065 / 60
            ph = (t % int(frame)) / frame
            if self.cyc is not None:
                ph = (self.cyc.cycles % 79545) / 79545
            return 0x09 if ph > 0.92 else (0x01 if (self.icount // 50) & 1 else 0)
        if port == 0x40:
            # счётчик канала 0 убывает 65536 за тик
            if self.pit_latch is None:
                self.sub = min(self.sub + 25, self.slice_n - 1)
                t = self.icount + self.sub
                if self.cyc is not None:
                    v = (65535 - (self.cyc.cycles // 4)) & 0xFFFF
                else:
                    v = (65535 - int((t % self.tick_insns) * 65536 / self.tick_insns)) & 0xFFFF
                self.pit_latch = [v & 0xFF, v >> 8]
            b = self.pit_latch.pop(0)
            if not self.pit_latch:
                self.pit_latch = None
            return b
        if port == 0x201:
            return 0xFF
        return 0xFF

    def _out(self, mu, port, size, value, ud):
        if port == 0x43:
            self.pit_ctrl = value
            if (value & 0xC0) == 0x00 and (value & 0x30) == 0:
                self.pit_latch = None
            if (value & 0xC0) == 0x80:
                self.pit2_lohi = 0
            self.sound_log.append((self.icount, 'ctrl', value))
        elif port == 0x42:
            if self.pit2_lohi == 0:
                self.pit2_div = (self.pit2_div & 0xFF00) | value
                self.pit2_lohi = 1
            else:
                self.pit2_div = (self.pit2_div & 0xFF) | (value << 8)
                self.pit2_lohi = 0
                self.sound_log.append((self.icount, 'div', self.pit2_div))
        elif port == 0x61:
            if (value & 3) != (self.port61 & 3):
                self.sound_log.append((self.icount, 'spk', value & 3))
            self.port61 = value
        elif port == 0x3D9:
            self.pal_reg = value
        elif port == 0x20:
            pass

    # --- выполнение ---
    def run(self, insns, slice_=2000):
        if self.tick_insns >= 10**9:
            n = insns
            cs, ip = self.r(UC_X86_REG_CS), self.r(UC_X86_REG_IP)
            self.sub = 0; self.slice_n = 10**6
            self.mu.emu_start(cs * 16 + ip, 0x200000, count=n)
            self.icount += n
            return
        end = self.icount + insns
        while self.icount < end and not self.halted:
            n = min(slice_, end - self.icount)
            # граница тика
            to_tick = self.tick_insns - (self.icount % self.tick_insns)
            n = min(n, to_tick)
            cs, ip = self.r(UC_X86_REG_CS), self.r(UC_X86_REG_IP)
            self.sub = 0
            self.slice_n = n
            try:
                self.mu.emu_start(cs * 16 + ip, 0x200000, count=n)
            except Exception as e:
                print('EXC', e, '%04X:%04X' % (self.r(UC_X86_REG_CS), self.r(UC_X86_REG_IP)))
                raise
            self.icount += n
            if self.icount % self.tick_insns == 0:
                self.ticks += 1
                self.mu.mem_write(0x46C, struct.pack('<I', self.ticks))
            fl = self.r(UC_X86_REG_FLAGS)
            if self.key_queue and (fl & 0x200):
                sc = self.key_queue.pop(0)
                self.port60 = sc
                self.raise_int(9)

    def run_ticks(self, t):
        self.run(int(t * self.tick_insns))

    def key(self, sc, hold_ticks=2):
        """Нажать и отпустить клавишу (скан-код)."""
        self.key_queue.append(sc)
        self.run_ticks(hold_ticks)
        self.key_queue.append(sc | 0x80)
        self.run_ticks(1)

    def press(self, sc):
        self.key_queue.append(sc)

    def release(self, sc):
        self.key_queue.append(sc | 0x80)

    # --- видео ---
    def vram(self):
        return bytes(self.mu.mem_read(0xB8000, 0x4000))

    def pixels(self):
        v = self.vram()
        out = []
        for y in range(200):
            base = (y & 1) * 0x2000 + (y >> 1) * 80
            row = []
            for b in v[base:base + 80]:
                row += [(b >> 6) & 3, (b >> 4) & 3, (b >> 2) & 3, b & 3]
            out.append(row)
        return out

    def palette(self):
        r = self.pal_reg
        bg = r & 0x0F
        intense = 8 if r & 0x10 else 0
        if r & 0x20:
            cols = [3, 5, 7]
        else:
            cols = [2, 4, 6]
        return [CGA_RGB[bg]] + [CGA_RGB[c + intense] for c in cols]

    def screenshot(self, path, scale=2):
        from PIL import Image
        pal = self.palette()
        px = self.pixels()
        im = Image.new('RGB', (320, 200))
        im.putdata([pal[c] for row in px for c in row])
        im = im.resize((320 * scale, 200 * scale * 6 // 5), Image.NEAREST)
        im.save(path)


if __name__ == '__main__':
    import sys
    pc = PC()
    pc.run_ticks(float(sys.argv[1]) if len(sys.argv) > 1 else 40)
    print('ticks', pc.ticks, 'at %04X:%04X' % (pc.r(UC_X86_REG_CS), pc.r(UC_X86_REG_IP)), 'pal %02X' % pc.pal_reg)
    pc.screenshot(OUT + '/shot.png')


class Tracer:
    """Перехват блиттеров и карта чтений DS."""
    BLITS = {0x2CCC: 'KEY', 0x2D35: 'AND', 0x2D9D: 'COPY', 0x2D70: 'LIN', 0x2B24: 'LIST', 0x3339: 'OR', 0x4FDF: 'OR3'}

    def __init__(self, pc, reads=True):
        from unicorn import UC_HOOK_MEM_READ
        self.pc = pc
        self.blits = {}
        self.dsread = bytearray(0x7200)
        base = pc.cs0 * 16
        for a, kind in self.BLITS.items():
            pc.mu.hook_add(UC_HOOK_CODE, self._blit, (a, kind), base + a, base + a)
        if reads:
            ds = pc.ds0 * 16
            pc.mu.hook_add(UC_HOOK_MEM_READ, self._rd, None, ds, ds + 0x7200)

    def _blit(self, mu, addr, size, ud):
        a, kind = ud
        pc = self.pc
        si, cx, di = pc.r(UC_X86_REG_SI), pc.r(UC_X86_REG_CX), pc.r(UC_X86_REG_DI)
        ds = pc.r(UC_X86_REG_DS)
        if kind == 'LIST':
            key = (kind, pc.r(UC_X86_REG_BX), 0)
        else:
            key = (kind, si if ds == pc.ds0 else -si, cx)
        # вызывающий
        sp = pc.r(UC_X86_REG_SP)
        caller = pc.rw(pc.r(UC_X86_REG_SS), sp) - 3
        self.blits.setdefault(key, set()).add(caller)

    def _rd(self, mu, access, addr, size, value, ud):
        o = addr - self.pc.ds0 * 16
        for k in range(size):
            if 0 <= o + k < len(self.dsread):
                self.dsread[o + k] = 1


class CycleModel:
    """Приближённые такты 8088 4,77 МГц: шина 4 такта/байт (команда + данные),
    база по типу команды, +4 такта на байт CGA (ожидание), int 1Ah BIOS = 300."""
    BASE = {'mul': 70, 'imul': 80, 'div': 80, 'idiv': 100, 'loop': 13, 'call': 19, 'ret': 16,
            'int': 51, 'iret': 24, 'jmp': 11, 'rep': 9}

    def __init__(self, pc):
        from capstone import Cs, CS_ARCH_X86, CS_MODE_16
        from unicorn import UC_HOOK_MEM_READ, UC_HOOK_MEM_WRITE
        self.pc = pc
        self.md = Cs(CS_ARCH_X86, CS_MODE_16)
        self.cache = {}
        self.cycles = 0
        pc.cyc = self
        pc.mu.hook_add(UC_HOOK_CODE, self._code, None, 0, 0xFFFFF)
        pc.mu.hook_add(UC_HOOK_MEM_READ | UC_HOOK_MEM_WRITE, self._mem, None, 0, 0xFFFFF)

    def _code(self, mu, addr, size, ud):
        c = self.cache.get(addr)
        if c is None:
            code = bytes(mu.mem_read(addr, size))
            c = 4 * size + 2
            for i in self.md.disasm(code, 0):
                m = i.mnemonic
                if m.startswith('j') and m != 'jmp':
                    c += 4
                elif m in ('shl', 'shr', 'sar', 'rcr', 'rcl', 'rol', 'ror') and 'cl' in i.op_str:
                    c += 8 + 4 * 4
                c += self.BASE.get(m, 0)
                if m == 'int' and i.op_str == '0x1a':
                    c += 300
            self.cache[addr] = c
        self.cycles += c

    def _mem(self, mu, access, addr, size, value, ud):
        self.cycles += 4 * size
        if 0xB8000 <= addr < 0xBC000:
            self.cycles += 4 * size


def call_proc(pc, ip, regs=None, max_insns=50_000_000):
    """Вызвать процедуру CAT.EXE (near call) и вернуться: адрес возврата — заглушка HLT."""
    ret = 0xFFF0
    pc._at = 0
    pc.mu.mem_write(pc.cs0 * 16 + ret, b'\xF4')
    pc.w(UC_X86_REG_DS, pc.ds0)
    pc.w(UC_X86_REG_ES, 0xB800)
    pc.w(UC_X86_REG_CS, pc.cs0)
    for r, v in (regs or {}).items():
        pc.w(r, v)
    pc.push(ret)
    pc.w(UC_X86_REG_IP, ip)
    pc.mu.emu_start(pc.cs0 * 16 + ip, pc.cs0 * 16 + ret, count=max_insns)
    assert pc.r(UC_X86_REG_IP) == ret, 'не вернулась: %04X' % pc.r(UC_X86_REG_IP)


def scale45(px):
    """Картинка CGA 320x200 -> БК 256x200: выбросить каждый пятый пиксель."""
    return [[row[x] for x in range(320) if x % 5 != 4] for row in px]


def bk_png_values(path):
    """Снимок экрана эмулятора БК (512x256) -> значения пикселей 256x256."""
    from PIL import Image
    im = Image.open(path).convert('RGB')
    cmap = {(0, 0, 0): 0, (0, 0, 255): 1, (0, 255, 0): 2, (255, 0, 0): 3}
    out = []
    for y in range(256):
        out.append([cmap.get(im.getpixel((2 * x, y)), 9) for x in range(256)])
    return out
