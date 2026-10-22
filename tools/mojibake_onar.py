# -*- coding: utf-8 -*-
# cp949 baytlarinin cp1252 sanilip UTF-8 yazilmasiyla olusan mojibake'yi duzeltir.
# Sadece non-ASCII run'lari isler; sonuc %100 Hangul ise degistirir (Turkce/Almanca korunur).
import os, re, sys

FFFD = '�'
# cp1254-farkli karakterler de run'a dahil (İıĞğŞş -> orj. baytlar D0 DD DE DF F0 FD FE)
RUN = re.compile('[\\x80-\\xffĞğİıŞş]+')
HANGUL = re.compile('[가-힣]')
import unicodedata
# noktalama/sembol kategorileri (euckr sembol ciftleri icin)
SYMBOL_CAT = {'Po', 'Pd', 'Ps', 'Pe', 'Sm', 'Sc', 'Sk', 'So', 'Zs'}

def _c2b(c):
    # karakteri orijinal bayta geri cevir: once cp1252, olmazsa cp1254
    for enc in ('cp1252', 'cp1254'):
        try:
            b = c.encode(enc)
            if len(b) == 1:
                return b[0]
        except UnicodeEncodeError:
            continue
    return None

def duzelt_run(run):
    if len(run) < 2 or len(run) % 2:
        return run
    raw = bytearray()
    for c in run:
        b = _c2b(c)
        if b is None:
            return run
        raw.append(b)
    parca = []
    hangul_var = False
    for i in range(0, len(raw), 2):
        try:
            d = raw[i:i+2].decode('cp949')
        except UnicodeDecodeError:
            return run
        if len(d) != 1:
            return run
        c = d[0]
        if HANGUL.match(c):
            hangul_var = True
        elif unicodedata.category(c) not in SYMBOL_CAT:
            return run
        parca.append(d)
    if not hangul_var:
        return run
    return ''.join(parca)

def process(path, dry):
    try:
        text = open(path, encoding='utf-8').read()
    except (OSError, UnicodeDecodeError):
        return 0
    n = [0]
    def rep(m):
        r = m.group(0)
        # tek ciftlik run'lar: kelime icindeyse Turkce olabilir (Orn. "Çö"lu -> "Çö")
        if len(r) == 2:
            onceki = text[m.start()-1] if m.start() > 0 else ' '
            sonraki = text[m.end()] if m.end() < len(text) else ' '
            if re.match(r'[A-Za-z0-9_]', onceki) or re.match(r'[A-Za-z0-9_]', sonraki):
                return r
            # gercek Turkce sozcuk olabilir ("İç", "Üç"): en az bir harf Turkce disi olmali
            TURK = set('çğıöşüÇĞİÖŞÜ')
            if r[0] in TURK and r[1] in TURK:
                return r
        yeni = duzelt_run(r)
        if yeni != r:
            n[0] += 1
        return yeni
    yeni_text = RUN.sub(rep, text)
    if n[0] and not dry:
        open(path, 'w', encoding='utf-8', newline='').write(yeni_text)
    return n[0]

SKIP_EXT = {'.eix','.epk','.exe','.dll','.lib','.obj','.pdb','.pyc','.pyd','.dds','.gr2',
            '.jpg','.jpeg','.png','.tga','.bmp','.raw','.mp3','.wav','.frm','.sub',
            '.ico','.cur','.lzo','.mcp','.mcv','.atr','.skl','.prt','.env','.msenv'}
SKIP_DIRS = {'.git','out','build','logs','log','__pycache__','_yedek'}

def main():
    args = sys.argv[1:]
    dry = '--dry' in args
    args = [a for a in args if not a.startswith('--')]
    kokler = args or ['.']
    toplam_dosya = toplam_degisen = 0
    for kok in kokler:
        for root, dirs, files in os.walk(kok):
            dirs[:] = [d for d in dirs if d not in SKIP_DIRS
                       and os.path.realpath(os.path.join(root, d)) == os.path.abspath(os.path.join(root, d))]
            for f in files:
                if os.path.splitext(f)[1].lower() in SKIP_EXT:
                    continue
                p = os.path.join(root, f)
                try:
                    n = process(p, dry)
                except Exception:
                    continue
                if n:
                    toplam_dosya += 1
                    toplam_degisen += n
                    print(n, p)
    print('dosya=%d run=%d dry=%s' % (toplam_dosya, toplam_degisen, dry))

if __name__ == '__main__':
    main()
