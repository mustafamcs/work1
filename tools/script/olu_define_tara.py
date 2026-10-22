#!/usr/bin/env python
# -*- coding: utf-8 -*-
# olu_define_tara.py — Controls.h icindeki TUM define'leri (aktif + kapali)
# tarar ve her birinin repo icinde (Controls.h disinda) NASIL kullanildigini
# baglamina gore siniflandirir:
#   KOD   : #if/#ifdef/#ifndef/#elif/defined() iceren gercek kosul satirlari
#   APP   : PyModule_AddIntConstant / app.X export blogu
#   PY    : .py dosyasinda app.X / dogrudan isim kullanimi (yorum haric)
#   YORUM : // veya # ile baslayan yorum satirlari, docstring, txt/md/bat
#   DIGER : yukaridakilere girmeyen duz metin eslesmeleri
#
# Boylece "kod dahil silinebilir" adaylari bulunur:
#   - hic dis referansi olmayanlar (OLU)
#   - sadece yorum/doc'ta gecenler (yorumlu iz)
#   - sadece app export + py okunanlar (py-pack bayragi; C++ kodu yok)
#
# Kullanim:
#   python olu_define_tara.py            # tam rapor (detaylar log'a)
#   python olu_define_tara.py --dead     # sadece silinebilir adaylari listele
#
# Rapor her zaman tools/script/log/olu_define_tara.txt dosyasina yazilir.

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

RE_CPP_IF = re.compile(r'^\s*#\s*(if|ifdef|ifndef|elif)\b|defined\s*\(')
RE_CPP_COMMENT = re.compile(r'^\s*(//|/\*|\*)')
RE_PY_COMMENT = re.compile(r'^\s*#')
RE_APP_EXPORT = re.compile(r'PyModule_AddIntConstant')

def parse_controls():
    """Controls.h -> [(ad, durum, bolum)] ; durum: 'AKTIF' | 'KAPALI' | 'ENUM'"""
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

def classify_line(ext, line, name):
    """Tek satirdaki eslesmenin baglam sinifi."""
    if ext in ('.cpp', '.c', '.h', '.hpp', '.cc', '.cxx'):
        if RE_APP_EXPORT.search(line):
            return 'APP'
        if RE_CPP_IF.search(line):
            return 'KOD'
        if RE_CPP_COMMENT.match(line):
            return 'YORUM'
        return 'KOD'   # cpp ici duz kullanim
    if ext == '.py':
        if RE_PY_COMMENT.match(line):
            return 'YORUM'
        return 'PY'
    # bat/txt/md/lua/vcxproj vb. -> belge niteliginde
    return 'YORUM'

def main():
    defs = parse_controls()
    names = [d[0] for d in defs]
    uniq = set(names)
    pat = re.compile(r'(?<![A-Za-z0-9_])(' +
                     '|'.join(re.escape(n) for n in sorted(uniq, key=len, reverse=True)) +
                     r')(?![A-Za-z0-9_])')

    # ad -> {baglam -> adet, 'files' -> [ilk dosyalar]}
    hits = {n: {'KOD': 0, 'APP': 0, 'PY': 0, 'YORUM': 0, 'files': []} for n in uniq}
    scanned = 0
    for fp in collect_files():
        try:
            lines = io.open(fp, 'r', encoding='utf-8', errors='ignore').read().splitlines()
        except (IOError, OSError):
            continue
        scanned += 1
        ext = os.path.splitext(fp)[1].lower()
        try:
            rel = os.path.relpath(fp, ROOT)
        except ValueError:  # aygit/junction yollari (\\.\nul vb.) atla
            continue
        file_hits = set()
        for ln in lines:
            for mm in pat.finditer(ln):
                n = mm.group(1)
                ctx = classify_line(ext, ln, n)
                hits[n][ctx] += 1
                file_hits.add(n)
        for n in file_hits:
            if len(hits[n]['files']) < 8:
                hits[n]['files'].append(rel)

    def total(h):
        return h['KOD'] + h['APP'] + h['PY'] + h['YORUM']

    dead, comment_only, py_only, alive = [], [], [], []
    for name, durum, section in defs:
        h = hits[name]
        if total(h) == 0:
            dead.append((name, durum, section))
        elif h['KOD'] == 0 and h['APP'] == 0 and h['PY'] == 0:
            comment_only.append((name, durum, section, h['files']))
        elif h['KOD'] == 0:
            py_only.append((name, durum, section, h['APP'], h['PY'], h['files']))
        else:
            alive.append((name, durum, section, h))

    out = []
    def w(s=''):
        out.append(s)
        print(s)

    w('Taranan dosya: %d   Define sayisi: %d' % (scanned, len(defs)))
    w('')
    w('=' * 74)
    w('OLU BAYRAKLAR (Controls.h disinda hic gecmiyor): %d' % len(dead))
    w('=' * 74)
    for name, durum, section in dead:
        w('  [%-6s] %-50s (%s)' % (durum, name, section))
    w('')
    w('=' * 74)
    w('SADECE YORUM/BELGEDE GECENLER (kodda yok): %d' % len(comment_only))
    w('=' * 74)
    for name, durum, section, files in comment_only:
        w('  [%-6s] %-50s (%s)' % (durum, name, section))
        for f in files:
            w('        -> %s' % f)
    w('')
    w('=' * 74)
    w('C++ KODU OLMAYANLAR (sadece app.X export / py kullanimi): %d' % len(py_only))
    w('=' * 74)
    for name, durum, section, app_n, py_n, files in py_only:
        w('  [%-6s] %-50s app=%d py=%d (%s)' % (durum, name, app_n, py_n, section))
        for f in files:
            w('        -> %s' % f)
    w('')
    w('=' * 74)
    w('GERCEK KODDA KULLANILANLAR: %d' % len(alive))
    w('=' * 74)
    for name, durum, section, h in alive:
        w('  [%-6s] %-46s kod=%-4d app=%-3d py=%-4d yorum=%-4d (%s)'
          % (durum, name, h['KOD'], h['APP'], h['PY'], h['YORUM'], section))
        if '--dead' not in sys.argv:
            for f in h['files']:
                w('        -> %s' % f)

    if not os.path.isdir(LOGDIR):
        os.makedirs(LOGDIR)
    io.open(LOGFILE, 'w', encoding='utf-8', newline='').write('\n'.join(out) + '\n')
    print('')
    print('Rapor: %s' % LOGFILE)

if __name__ == '__main__':
    main()
