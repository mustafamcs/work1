#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
work1 - tum metin dosyalarini UTF-8'e donusturur.

Tespit: cp949 (Korece) / cp1254 (Turkce) / cp1252 (Latin) arasindan
icerik skoru ile secer; hicbir karakter bozulmadan UTF-8 yazar.

Kullanim:
    python utf8_donustur.py <kok_dizin> [--dry-run] [--rapor <dosya>]
"""

import os
import sys

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

BIN_EXT = {
    '.eix', '.epk', '.exe', '.dll', '.pdb', '.idb', '.ipch', '.tlog', '.ilk',
    '.bsc', '.map', '.obj', '.o', '.a', '.lib', '.so', '.pyc', '.pyo', '.pyd',
    '.dds', '.tga', '.jpg', '.jpeg', '.png', '.bmp', '.ico', '.cur', '.gr2',
    '.msa', '.mse', '.msk', '.msm', '.msv', '.mde', '.mdatr', '.sub', '.atr',
    '.ogg', '.wav', '.mp3', '.fnt', '.ttf', '.zip', '.7z', '.rar', '.gz',
    '.bin', '.dat', '.db', '.frm', '.ibd', '.msi', '.iso', '.raw', '.res',
    '.nls', '.idx', '.pack', '.ttc', '.otf', '.woff', '.swf', '.avi', '.wmv',
    '.flv', '.mid', '.bik', '.pfx', '.cer', '.key', '.pem', '.crt', '.der',
    '.tlb', '.ocx', '.sys', '.fon', '.pth', '.opendb', '.sdf', '.pch', '.ncb',
    '.aps', '.sbr', '.exp', '.lastbuildstate', '.recipe', '.manifest',
}

SKIP_DIRS = {
    '.git', 'out', 'node_modules', '_yedek', '.pre_qc', '__pycache__',
    'build', 'logs', 'log', '.vs', 'shop', 'mark', 'upload',
}

SKIP_FILES = {
    'syserr', 'syserr.txt', 'syslog', 'syslog.txt', 'stdout', 'stdout.txt',
    'pts.txt', 'usage.txt', 'vnum', 'mark', 'pid', 'lock_recalc.flag',
    'lock_recalc.sql', 'packet_info.txt', 'p2p_packet_info.txt',
    'metin2.cfg', 'loca.cfg', 'mouse.cfg', 'channel.inf', 'chat_filter.bin',
    'command.txt',
}

TR_CHARS = set('ğışöçĞİŞÖÇâîûÂÎÛ')
HANGUL_RANGES = ((0xAC00, 0xD7A3), (0x1100, 0x11FF), (0x3130, 0x318F))
LATIN_ACC = set('áéíóúàèìòùäëïöüñâêîôûãõçÿÁÉÍÓÚÀÈÌÒÙÄËÏÖÜÑÂÊÎÔÛÃÕÇ')

def is_hangul(ch):
    cp = ord(ch)
    return any(lo <= cp <= hi for lo, hi in HANGUL_RANGES)

def detect(raw):
    """(codec, skor_detayi) dondurur; utf8 ise None."""
    if raw.startswith(b'\xef\xbb\xbf'):
        return 'utf-8-sig', {}
    try:
        raw.decode('utf-8')
        return None, {}
    except UnicodeDecodeError:
        pass

    scores = {}
    for enc in ('cp949', 'cp1254', 'cp1252'):
        try:
            t = raw.decode(enc)
        except Exception:
            scores[enc] = -10**9
            continue
        hangul = sum(1 for c in t if is_hangul(c))
        tr = sum(1 for c in t if c in TR_CHARS)
        lat = sum(1 for c in t if c in LATIN_ACC)
        ctrl = sum(1 for c in t if ord(c) < 0x20 and c not in '\t\n\r')
        c1 = sum(1 for c in t if 0x80 <= ord(c) <= 0x9F)
        # cp949 bozuntusu tek baytlik kodlarda sembol corbasi uretir
        sym = sum(1 for c in t if c in '³²¹º¼½¾¿ÀÁÂÃÄÅÆÈÉÊËÌÍÎÏÐÒÓÔÕ×ØÙÚÛÝÞßàèìðòøùýþ°±µ¶·¸¡¢£¤¥¦§¨©ª«¬­®¯°²´¸')
        if enc == 'cp949':
            scores[enc] = hangul * 5 - ctrl * 5
        else:
            scores[enc] = tr * 3 + lat - ctrl * 5 - c1 * 4 - sym * 2
    best = max(scores, key=scores.get)
    return best, scores

def convert_file(path, dry=False):
    raw = open(path, 'rb').read()
    enc, scores = detect(raw)
    if enc is None:
        return 'utf8', scores
    if enc == 'utf-8-sig':
        return 'bom', scores
    text = raw.decode(enc)
    if not dry:
        with open(path, 'wb') as f:
            f.write(text.encode('utf-8'))
    return enc, scores

def walk(root):
    for dirpath, dirs, files in os.walk(root):
        # junction/symlink dizinleri atla (server/*/locale -> share/locale)
        dirs[:] = [d for d in dirs
                   if d not in SKIP_DIRS
                   and os.path.realpath(os.path.join(dirpath, d)) == os.path.abspath(os.path.join(dirpath, d))]
        for fn in files:
            if fn.lower() in SKIP_FILES:
                continue
            if os.path.splitext(fn)[1].lower() in BIN_EXT:
                continue
            yield os.path.join(dirpath, fn)

def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    root = sys.argv[1]
    dry = '--dry-run' in sys.argv
    rapor = None
    if '--rapor' in sys.argv:
        rapor = sys.argv[sys.argv.index('--rapor') + 1]

    n_ok = n_conv = n_bom = n_err = 0
    lines = []
    for path in walk(root):
        try:
            raw = open(path, 'rb').read(4096)
        except OSError:
            continue
        if b'\x00' in raw:
            continue
        try:
            sonuc, scores = convert_file(path, dry)
        except Exception as e:
            n_err += 1
            lines.append(f'HATA\t{path}\t{e}')
            continue
        if sonuc == 'utf8':
            n_ok += 1
        elif sonuc == 'bom':
            n_bom += 1
        else:
            n_conv += 1
            lines.append(f'{sonuc.upper()}\t{path}\t{scores}')

    print(f'utf8:{n_ok}  donusturulen:{n_conv}  bom:{n_bom}  hata:{n_err}  (dry={dry})')
    if rapor:
        with open(rapor, 'w', encoding='utf-8') as f:
            f.write('\n'.join(lines))
        print('rapor:', rapor)
    return 0

if __name__ == '__main__':
    sys.exit(main())
