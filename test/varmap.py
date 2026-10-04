"""Карта переменных порта на сегмент данных CAT.EXE: из объявлений вида
`uint16_t name;  /* [XXXX] ... */` (несколько имён — столько же адресов)."""
import re, os

HERE = os.path.dirname(os.path.abspath(__file__))
DECL = re.compile(r'^(?:static\s+|extern\s+)?(uint8_t|uint16_t|int8_t|int16_t)\s+([^;=]+?)\s*(?:=[^;]*)?;\s*/\*\s*(.*?)\*/')
ADDR = re.compile(r'\[([0-9A-Fa-f]{4})\]')
ITEM = re.compile(r'^\s*([A-Za-z_]\w*)\s*(?:\[\s*(\d+)\s*\])?\s*$')


def varmap(files):
    out = []
    for f in files:
        for line in open(os.path.join(HERE, '..', f), encoding='utf-8'):
            m = DECL.match(line)
            if not m:
                continue
            typ, names, comment = m.groups()
            addrs = ADDR.findall(comment)
            items = [n.strip() for n in names.split(',')]
            if not addrs or len(addrs) != len(items):
                continue
            size = 2 if '16' in typ else 1
            for it, a in zip(items, addrs):
                mi = ITEM.match(it)
                if not mi:
                    continue
                name, n = mi.group(1), int(mi.group(2) or 1)
                if name.endswith('_save') or 'save' in name:
                    continue        # фон под спрайтом — формат БК
                out.append((name, int(a, 16), size, n, f))
    return out
