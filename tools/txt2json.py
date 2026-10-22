# -*- coding: utf-8 -*-
"""
txt -> json donusturucu (work1)

Ust duzey JSON: dizi-icinde-dizi (satir/hucre). Tum hucreler string.
Turkce karakterler UTF-8 duz yazilir (ensure_ascii=False).

Modlar:
  tab       - cCsvFile semantigi (TAB ayirici, "..." kapsayici, # yorum, cok-satirli alan)
  ws        - CMemoryTextFileLoader::SplitLine semantigi (bosluk, "..." token, #/#--#)
  wsregen   - ws + '//' token'indan sonrasi yorum (regen/npc/boss/stone/dungeon)
  pair      - locale_string.txt: "anahtar";"deger";  (\n -> gercek satir sonu)
  kv        - conf.txt: ANAHTAR = DEGER  (tirnak soyulur)
  firstrest - ilk token + satirin geri kalani (questnpc.txt)

Kullanim:
    python txt2json.py <dosya.txt|dizin> [--mod=auto|tab|ws|wsregen|pair|kv|firstrest] [--dry]
"""
import io, os, re, sys, json

def oku(yol):
    raw = io.open(yol, 'rb').read()
    for enc in ('utf-8-sig', 'utf-8', 'cp1254'):
        try:
            return raw.decode(enc)
        except UnicodeDecodeError:
            continue
    return raw.decode('latin1')

# --- tab: cCsvFile portu ---
def tab_parse(satirlar):
    rows, state, token, row = [], 0, '', None
    for raw in satirlar:
        line = raw.strip(' \t\r')
        if line == '' or (state == 0 and line[0] == '#'):
            continue
        text = line + '  '
        i, n = 0, len(text)
        while i < n:
            ch = text[i]
            if state == 1:
                if ch == '"':
                    if i + 1 < n and text[i + 1] == '"':
                        token += '"'
                        i += 1
                    else:
                        state = 0
                else:
                    token += ch
            else:
                if row is None:
                    row = []
                if ch == '\t':
                    row.append(token)
                    token = ''
                elif ch == '"':
                    state = 1
                else:
                    token += ch
            i += 1
        if state == 0:
            row.append(token[:-2])
            rows.append(row)
            token = ''
            row = None
        else:
            token = token[:-2] + '\r\n'
    return rows

# --- rawtab: ham fgets semantigi (tum bos alanlar korunur, quote yok) ---
def rawtab_parse(satirlar):
    rows = []
    for raw in satirlar:
        line = raw.rstrip('\r\n')
        if line == '' or line[0] == '#':
            continue
        rows.append(line.split('\t'))
    return rows

# --- ws: SplitLine portu ---
def ws_parse_line(line):
    toks = []
    n = len(line)
    pos = 0
    first = True
    while True:
        b = pos
        while b < n and line[b] in ' \t':
            b += 1
        if b >= n:
            return toks
        if first and line[b] == '#' and line[b:b + 4] != '#--#':
            return None  # yorum satiri
        if line[b] == '"':
            e = line.find('"', b + 1)
            if e < 0:
                return None
            toks.append(line[b + 1:e])
            pos = e + 1
        else:
            e = b
            while e < n and line[e] not in ' \t':
                e += 1
            toks.append(line[b:e])
            pos = e
        first = False
        nb = pos
        while nb < n and line[nb] in ' \t':
            nb += 1
        if nb >= n:
            return toks
        pos = nb

def ws_parse(satirlar, regen=False):
    rows = []
    for raw in satirlar:
        line = raw.rstrip('\r\n')
        toks = ws_parse_line(line)
        if not toks:
            continue
        if regen:
            kes = None
            for k, t in enumerate(toks):
                if t.startswith('//'):
                    kes = k
                    break
            if kes is not None:
                toks = toks[:kes]
            if not toks:
                continue
        rows.append(toks)
    return rows

# --- pair: locale_string ("k";"v"; akis, ciftler satirlar arasi olabilir) ---
def pair_parse(satirlar):
    metin = '\n'.join(satirlar)
    cells = []
    i, n = 0, len(metin)
    while i < n:
        if metin[i] == '"':
            i += 1
            cell = ''
            while i < n:
                ch = metin[i]
                if ch == '\\' and i + 1 < n and metin[i + 1] == 'n':
                    cell += '\n'
                    i += 2
                    continue
                if ch == '"':
                    i += 1
                    break
                cell += ch
                i += 1
            cells.append(cell)
        else:
            i += 1
    rows = []
    for k in range(0, len(cells) - 1, 2):
        rows.append([cells[k], cells[k + 1]])
    return rows

# --- kv: ANAHTAR = DEGER ---
def kv_parse(satirlar):
    rows = []
    for raw in satirlar:
        line = raw.strip(' \t\r')
        if not line or line.startswith('#') or line.startswith('//'):
            continue
        m = re.match(r'^([^=\s]+)\s*=\s*(.*)$', line)
        if not m:
            continue
        key, val = m.group(1), m.group(2).strip(' \t')
        if len(val) >= 2 and val[0] == '"' and val[-1] == '"':
            val = val[1:-1]
        rows.append([key, val])
    return rows

# --- firstrest ---
def firstrest_parse(satirlar):
    rows = []
    for raw in satirlar:
        line = raw.strip(' \t\r')
        if not line or line.startswith('#') or line.startswith('//'):
            continue
        parts = line.split(None, 1)
        rows.append(parts)
    return rows

# --- istemci: satir-koruyucu (tab / line) ---
def istemci_parse(satirlar):
    """TAB iceriyorsa 'tab' (hucre hucre), degilse 'line' (satir verbatim).
    Yorum ve bos olmayan tum satirlar korunur; geri-cevirim ayni metni uretir."""
    tabvar = any('\t' in l for l in satirlar if l.strip(' \t\r'))
    rows = []
    for raw in satirlar:
        line = raw.rstrip('\r\n') if not tabvar else raw.rstrip('\r')
        if not tabvar:
            line = raw.rstrip('\r\n')
            if line == '':
                continue
            rows.append([line])
        else:
            line = raw.rstrip('\r')
            if line == '':
                continue
            rows.append(line.split('\t'))
    return ('tab' if tabvar else 'line'), rows

# --- dosya adi -> mod ---
MOD_TABLO = {
    'locale_string.txt': 'pair',
    'conf.txt': 'kv',
    'questnpc.txt': 'firstrest',
    'questcategory.txt': 'firstrest',
    'regen.txt': 'wsregen',
    'npc.txt': 'wsregen',
    'boss.txt': 'wsregen',
    'stone.txt': 'wsregen',
    'dungeon.txt': 'wsregen',
    'item_proto.txt': 'tab',
    'mob_proto.txt': 'tab',
    'item_names.txt': 'tab',
    'mob_names.txt': 'tab',
    'common_drop_item.txt': 'rawtab',
    'etc_drop_item.txt': 'rawtab',
    'fishing.txt': 'rawtab',
    'skill_power.txt': 'tab',
    'group.txt': 'ws',
    'group_group.txt': 'ws',
    'shop_table_ex.txt': 'ws',
    'drop_item_group.txt': 'ws',
    'mob_drop_item.txt': 'ws',
    'special_item_group.txt': 'ws',
    'dragon_soul_table.txt': 'ws',
    'blend.txt': 'ws',
    'cube.txt': 'ws',
    'castle_data.txt': 'ws',
    'motlist.txt': 'ws',
    'forkedmapindex.txt': 'ws',
    'setting.txt': 'ws',
    'town.txt': 'ws',
    'ori_to_new_table.txt': 'ws',
    'charset.txt': 'ws',
}

HARIC = {
    'syserr.txt', 'syslog.txt', 'usage.txt', 'version.txt', 'pts.txt',
    'special_item_group_vnum.txt', 'packet_info.txt', 'p2p_packet_info.txt',
    'profile.txt', 'udp_packet_info.txt',
}

def mod_sec(yol, satirlar, secim='auto'):
    if secim != 'auto':
        return secim
    base = os.path.basename(yol).lower()
    if base in MOD_TABLO:
        return MOD_TABLO[base]
    for l in satirlar:
        t = l.strip()
        if t and not t.startswith('#'):
            return 'tab' if '\t' in t else 'ws'
    return 'ws'

def dosya_donustur(yol, secim='auto', dry=False, istemci=False):
    metin = oku(yol)
    if '\x00' in metin:
        raise Exception('ikili icerik, atlaniyor')
    satirlar = metin.split('\n')
    if istemci:
        mod, rows = istemci_parse(satirlar)
    else:
        mod = mod_sec(yol, satirlar, secim)
        rows = None

    if rows is not None:
        pass
    elif mod == 'tab':
        rows = tab_parse(satirlar)
    elif mod == 'rawtab':
        rows = rawtab_parse(satirlar)
    elif mod == 'ws':
        rows = ws_parse(satirlar)
    elif mod == 'wsregen':
        rows = ws_parse(satirlar, regen=True)
    elif mod == 'pair':
        rows = pair_parse(satirlar)
    elif mod == 'kv':
        rows = kv_parse(satirlar)
    elif mod == 'firstrest':
        rows = firstrest_parse(satirlar)
    else:
        rows = ws_parse(satirlar)

    hedef = yol[:-4] + '.json' if yol.lower().endswith('.txt') else yol + '.json'
    if dry:
        return hedef, len(rows), mod
    cikti = {'format': mod, 'rows': rows} if istemci else rows
    with io.open(hedef, 'w', encoding='utf-8', newline='\n') as f:
        json.dump(cikti, f, ensure_ascii=False, indent=1)
        f.write('\n')
    return hedef, len(rows), mod

def ana():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    hedef = sys.argv[1]
    secim = 'auto'
    dry = '--dry' in sys.argv
    istemci = '--ist' in sys.argv
    for a in sys.argv[2:]:
        if a.startswith('--mod='):
            secim = a.split('=', 1)[1].lower()

    dosyalar = []
    if os.path.isdir(hedef):
        for dp, dn, fn in os.walk(hedef):
            for f in fn:
                if f.lower().endswith('.txt') and f.lower() not in HARIC:
                    dosyalar.append(os.path.join(dp, f))
    else:
        dosyalar.append(hedef)

    toplam, hata = 0, 0
    for p in sorted(dosyalar):
        try:
            h, n, m = dosya_donustur(p, secim, dry, istemci)
            print('%-72s %-9s %d satir' % (h, m, n))
            toplam += 1
        except Exception as e:
            print('HATA %s: %s' % (p, e))
            hata += 1
    print('toplam %d dosya, %d hata' % (toplam, hata))
    return 0

if __name__ == '__main__':
    sys.exit(ana())
