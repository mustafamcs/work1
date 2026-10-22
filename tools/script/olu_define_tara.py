#!/usr/bin/env python
# -*- coding: utf-8 -*-
# olu_define_tara.py — Controls.h icindeki TUM define'leri (aktif + kapali)
# tarar ve her birinin repo icinde (Controls.h disinda) kullanilip
# kullanilmadigini raporlar. Boylece "olu/eski bayrak"lar bulunur.
#
# Kullanim:
#   python olu_define_tara.py            # tam rapor
#   python olu_define_tara.py --dead     # sadece olu bayraklari listele
#
# Not: "Pack/Python Ayarlari" bolumundeki define'ler app.X olarak python'a
# aktarilir; kullanim sayiminda PythonApplicationModule.cpp ve .py dosyalari
# da taranir — bu yuzden onlar "olu" sayilmaz.

import io, os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
HDR = os.path.join(ROOT, 'Srcs', 'Controls.h')
LOGDIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'log')
LOGFILE = os.path.join(LOGDIR, 'olu_define_tara.txt')

RE_DEF = re.compile(r'^\s*#\s*define\s+(\S+)')           # aktif
RE_CDEF = re.compile(r'^\s*//+\s*#\s*define\s+(\S+)')    # kapali (// #define / //#define)
RE_SECTION = re.compile(r'^\s*//\s*###\s*(.+?)\s*###')
RE_ENUM_START = re.compile(r'^\s*enum\s+\w+\s*\{')
RE_ENUM_MEMBER = re.compile(r'([A-Z_][A-Z0-9_]*)\s*=')

# tarama disi dizinler ve ikili dosya uzantilari
SKIP_DIRS = {'.git', '__pycache__', 'log', '.vs', 'Debug', 'Release', 'x64'}
SKIP_EXT = {
    '.eix', '.epk', '.dll', '.exe', '.lib', '.obj', '.pdb', '.ilk', '.exp',
    '.png', '.jpg', '.jpeg', '.bmp', '.tga', '.dds', '.ico', '.cur',
    '.gr2', '.mde', '.mse', '.msm', '.msenv', '.prt', '.atr', '.sub', '.mss',
    '.wav', '.mp3', '.ogg', '.ttf', '.fnt', '.pyc', '.pyo', '.zip', '.rar',
    '.7z', '.dat', '.idx', '.raw', '.spt', '.msa', '.tbi', '.mdatr', '.mdatr2',
    '.grn', '.amd', '.smd', '.skl', '.dds2',
}
MAX_FILE_MB = 8

def parse_controls():
    """Controls.h -> [(ad, durum, bolum)] ; durum: 'AKTIF' | 'KAPALI'"""
    out, section = [], ''
    lines = io.open(HDR, encoding='utf-8').read().splitlines()
    in_enum = False
    for ln in lines:
        sm = RE_SECTION.match(ln)
        if sm:
            section = sm.group(1).strip()
            continue
        if RE_ENUM_START.match(ln):
            in_enum = True
        if in_enum:
            mm = RE_ENUM_MEMBER.search(ln)
            if mm:
                out.append((mm.group(1), 'ENUM', section or 'enum'))
            if '}' in ln:
                in_enum = False
            continue
        m = RE_DEF.match(ln)
        if m:
            name = m.group(1)
            if name.startswith('__INC_'):  # include guard sayilmaz
                continue
            out.append((name, 'AKTIF', section or '-'))
            continue
        m = RE_CDEF.match(ln)
        if m:
            out.append((m.group(1), 'KAPALI', section or '-'))
    return out

def collect_files():
    for base, dirs, files in os.walk(ROOT):
        dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
        for fn in files:
            fp = os.path.join(base, fn)
            if os.path.abspath(fp) == os.path.abspath(HDR):
                continue
            if fn.startswith('Controls.h'):  # yedekler (Controls.h.on vb.) sayilmaz
                continue
            if os.path.splitext(fn)[1].lower() in SKIP_EXT:
                continue
            try:
                if os.path.getsize(fp) > MAX_FILE_MB * 1024 * 1024:
                    continue
            except OSError:
                continue
            yield fp

def main():
    defs = parse_controls()
    names = [d[0] for d in defs]
    uniq = set(names)
    # uzun isim once — ayni anda tek regex ile ara
    pat = re.compile(r'(?<![A-Za-z0-9_])(' +
                     '|'.join(re.escape(n) for n in sorted(uniq, key=len, reverse=True)) +
                     r')(?![A-Za-z0-9_])')

    hits = {n: {'count': 0, 'files': []} for n in uniq}
    scanned = 0
    for fp in collect_files():
        try:
            data = io.open(fp, 'r', encoding='utf-8', errors='ignore').read()
        except (IOError, OSError):
            continue
        scanned += 1
        found = set()
        for mm in pat.finditer(data):
            n = mm.group(1)
            hits[n]['count'] += 1
            found.add(n)
        rel = os.path.relpath(fp, ROOT)
        for n in found:
            if len(hits[n]['files']) < 6:
                hits[n]['files'].append(rel)

    dead, only_hdr, alive = [], [], []
    for name, durum, section in defs:
        h = hits[name]
        if h['count'] == 0:
            dead.append((name, durum, section))
        elif all(f.endswith('Controls.h') for f in h['files']) and h['count'] <= len(h['files']):
            # sadece Controls.h icinde (ornegin baska define'in ifndef'i)
            only_hdr.append((name, durum, section, h['files']))
        else:
            alive.append((name, durum, section, h['count'], h['files']))

    out = []
    def w(s=''):
        out.append(s)
        print(s)

    w('Taranan dosya: %d   Define sayisi: %d' % (scanned, len(defs)))
    w('')
    w('=' * 70)
    w('OLU BAYRAKLAR (Controls.h disinda hic gecmiyor): %d' % len(dead))
    w('=' * 70)
    for name, durum, section in dead:
        w('  [%-6s] %-50s (%s)' % (durum, name, section))
    w('')
    w('=' * 70)
    w('SADECE Controls.h ICINDE REFERANSLI: %d' % len(only_hdr))
    w('=' * 70)
    for name, durum, section, files in only_hdr:
        w('  [%-6s] %-50s (%s)' % (durum, name, section))
    w('')
    w('=' * 70)
    w('KULLANILAN DEFINE\'LER: %d' % len(alive))
    w('=' * 70)
    for name, durum, section, cnt, files in alive:
        w('  [%-6s] %-50s %4d eslesme  (%s)' % (durum, name, cnt, section))
        if '--dead' not in sys.argv:
            for f in files:
                w('        -> %s' % f)

    if not os.path.isdir(LOGDIR):
        os.makedirs(LOGDIR)
    io.open(LOGFILE, 'w', encoding='utf-8', newline='').write('\n'.join(out) + '\n')
    print('')
    print('Rapor: %s' % LOGFILE)

if __name__ == '__main__':
    main()
