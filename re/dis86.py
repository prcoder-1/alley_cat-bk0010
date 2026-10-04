#!/usr/bin/env python3
"""Рекурсивный дизассемблер кода CAT.EXE (CS:0000 = файл 0x7430).

    python3 dis86.py            -> cat.lst (полный листинг), procs.txt (процедуры и вызовы)
"""
import re
import sys
from collections import defaultdict
from capstone import Cs, CS_ARCH_X86, CS_MODE_16

HERE = __file__.rsplit('/', 1)[0]
CODE = open(HERE + '/cat_code.bin', 'rb').read()
md = Cs(CS_ARCH_X86, CS_MODE_16)

# таблицы переходов jmp [cs:bx+T]: адрес таблицы -> число элементов
JUMP_TABLES = {}


def decode(ip):
    for ins in md.disasm(CODE[ip:ip + 16], ip):
        return ins
    return None


insns = {}
procs = set([0])
labels = set()
calls = defaultdict(set)
work = [0]
seen_entry = set()


def scan_tables():
    # найти jmp [cs:bx+imm] и взять таблицу до первого невалидного адреса
    pass


while work:
    ip = work.pop()
    while ip < len(CODE) and ip not in insns:
        ins = decode(ip)
        if ins is None:
            break
        insns[ip] = ins
        m, op = ins.mnemonic, ins.op_str
        nxt = ip + ins.size
        if m in ('call',) and re.fullmatch(r'0x[0-9a-f]+', op):
            t = int(op, 16)
            procs.add(t)
            calls[ip].add(t)
            work.append(t)
        elif m.startswith('j') or m in ('loop', 'loope', 'loopne', 'jcxz'):
            if re.fullmatch(r'0x[0-9a-f]+', op):
                t = int(op, 16)
                labels.add(t)
                work.append(t)
            else:
                mt = re.search(r'cs:\[bx \+ (0x[0-9a-f]+)\]', op)
                if mt:
                    tb = int(mt.group(1), 16)
                    JUMP_TABLES[ip] = tb
                    # элементы таблицы: слова-адреса, пока похожи на код
                    k = 0
                    while k < (8 if tb == 0x250 else 32):
                        a = CODE[tb + 2 * k] | (CODE[tb + 2 * k + 1] << 8)
                        if a >= len(CODE) or a < 0x10 or (tb <= a < tb + 2 * k + 2):
                            break
                        labels.add(a)
                        work.append(a)
                        insns.setdefault(tb + 2 * k, None)
                        k += 1
                    JUMP_TABLES[ip] = (tb, k)
            if m == 'jmp':
                break
        if m in ('ret', 'retf', 'iret'):
            break
        ip = nxt

# процедуры, на которые ставятся векторы прерываний (mov ax, imm до записи в IVT)
EXTRA = [0x14B3, 0x14FB]
for e in EXTRA:
    if e not in insns:
        procs.add(e)
        work = [e]
        while work:
            ip = work.pop()
            while ip < len(CODE) and ip not in insns:
                ins = decode(ip)
                if ins is None:
                    break
                insns[ip] = ins
                m, op = ins.mnemonic, ins.op_str
                if m == 'call' and re.fullmatch(r'0x[0-9a-f]+', op):
                    procs.add(int(op, 16)); work.append(int(op, 16))
                elif (m.startswith('j') or m.startswith('loop')) and re.fullmatch(r'0x[0-9a-f]+', op):
                    labels.add(int(op, 16)); work.append(int(op, 16))
                    if m == 'jmp':
                        break
                if m in ('ret', 'retf', 'iret'):
                    break
                ip += ins.size

DSREF = re.compile(r'(?<!cs:)\[(?:bx \+ |si \+ |di \+ |bp \+ )?(0x[0-9a-f]+)\]')


def main():
    out = []
    ip = 0
    covered = 0
    while ip < len(CODE):
        ins = insns.get(ip, 'x')
        if ins is None:  # элемент таблицы переходов
            a = CODE[ip] | (CODE[ip + 1] << 8)
            out.append('%04X  dw 0x%04X' % (ip, a))
            ip += 2
            continue
        if ins == 'x':
            # данные/недостижимый код: дамп по 16 байт до следующей инструкции
            j = ip + 1
            while j < len(CODE) and j not in insns:
                j += 1
            for k in range(ip, j, 16):
                chunk = CODE[k:min(k + 16, j)]
                out.append('%04X  db %s' % (k, ' '.join('%02X' % b for b in chunk)))
            ip = j
            continue
        if ip in procs:
            out.append('')
            out.append(';' + '=' * 70)
            out.append('proc_%04X:' % ip)
        elif ip in labels:
            out.append('L%04X:' % ip)
        out.append('%04X  %-14s %s %s' % (ip, ins.bytes.hex(), ins.mnemonic, ins.op_str))
        covered += ins.size
        ip += ins.size
    open(HERE + '/cat.lst', 'w').write('\n'.join(out) + '\n')
    # процедуры: границы и вызовы
    ps = sorted(procs)
    with open(HERE + '/procs.txt', 'w') as f:
        for i, p in enumerate(ps):
            end = ps[i + 1] if i + 1 < len(ps) else len(CODE)
            cl = sorted({t for a, ts in calls.items() if p <= a < end for t in ts})
            callers = sorted({a for a, ts in calls.items() if p in ts})
            f.write('%04X  len=%5d  calls: %s\n' % (p, end - p, ' '.join('%04X' % c for c in cl)))
    print('procs', len(procs), 'covered', covered, 'of', len(CODE), 'jump tables', {('%04X' % k): v for k, v in JUMP_TABLES.items()})


main()
