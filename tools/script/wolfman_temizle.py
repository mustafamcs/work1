#!/usr/bin/env python
# -*- coding: utf-8 -*-
# wolfman_temizle.py — wolfman/lycan kalintilarini Srcs + Pack + sql agacindan siler.
#
# C++ donusumleri:
#   #ifdef SYM a #endif              -> silinir
#   #ifdef SYM a #else b #endif      -> b korunur
#   #ifdef SYM a #elif E b ...       -> "#if E" ile baslayan zincire donusur
#   #if/#elif icinde defined(SYM)    -> (0) basilir
#   #ifndef SYM                      -> her zaman dogru oldugu icin govdesi korunur, guard kaldirilir
#
# Veri dosyalari:
#   skilltable.txt / skilldesc.txt   -> wolfman beceri satirlari (170-175, 229, 244), CLAW silah
#                                       tokenlari ve ATTACK_BLEEDING flag'leri temizlenir
#   sql/*.sql                        -> wolfman skill/mob satirlari silinir, item_attr_wolfman bloku
#                                       kaldirilir, enum/set icindeki wolfman isimleri RESERVED_*
#                                       ile degistirilir (ordinal/buy pozisyonlari korunur)
#
# Kullanim: python tools/script/wolfman_temizle.py [--dry]

import io, os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DRY = '--dry' in sys.argv

# ---------------------------------------------------------------- C++ katmani

SYMS = [
    "ENABLE_WOLFMAN_CHARACTER",
    "DISABLE_WOLFMAN_ON_CREATE",
    "USE_MOB_BLEEDING_AS_POISON",
    "USE_MOB_CLAW_AS_DAGGER",
    "USE_ITEM_BLEEDING_AS_POISON",
    "USE_ITEM_CLAW_AS_DAGGER",
    "USE_WOLFMAN_STONES",
    "USE_WOLFMAN_BOOKS",
    "USE_LYCAN_CREATE_POSITION",
]
SYM_RE = "|".join(SYMS)
RE_IFDEF   = re.compile(r'^\s*#\s*ifdef\s+(' + SYM_RE + r')\b')
RE_IFNDEF  = re.compile(r'^\s*#\s*ifndef\s+(' + SYM_RE + r')\b')
RE_IF      = re.compile(r'^\s*#\s*if\b')
RE_ELIF    = re.compile(r'^\s*#\s*elif\b')
RE_ELSE    = re.compile(r'^\s*#\s*else\b')
RE_ENDIF   = re.compile(r'^\s*#\s*endif\b')
RE_DEFINED = re.compile(r'defined\s*\(?\s*(' + SYM_RE + r')\s*\)?')
RE_EXPR    = re.compile(r'^\s*#\s*(?:if|elif)\s+(.+)$')

def scrub(line):
    """Sadece wolfman sembolu iceren if/elif satirlarina uygulanir."""
    s = RE_DEFINED.sub('(0)', line)
    s = s.replace('! (0)', '1').replace('!(0)', '1')
    m = RE_EXPR.match(s)
    if m:
        e = m.group(1).strip()
        e = re.sub(r'^1\s*&&\s*', '', e)
        e = re.sub(r'\s*&&\s*1$', '', e)
        if '||' not in e:
            e = re.sub(r'^\(0\)\s*&&.*|^0\s*&&.*', '0', e)
            e = re.sub(r'.*&&\s*\(0\)$|.*&&\s*0$', '0', e)
        e = re.sub(r'\(1\)', '1', e)
        e = re.sub(r'\(0\)', '0', e)
        s = s[:m.start(1)] + e + s[m.end(1):]
    return s

def expr_is_dead(line):
    """defined(SYM)->(0) sonrasi ifade tamamen sabit 0 mi?"""
    if not RE_DEFINED.search(line) and not re.search(r'\b(' + SYM_RE + r')\b', line):
        return False
    e = RE_EXPR.match(scrub(line))
    if not e: return False
    e = e.group(1).strip()
    if not re.fullmatch(r'[\s()0!&|]+', e):
        return False
    return eval(e.replace('!',' not ').replace('&&',' and ').replace('||',' or ') or '0') == 0

def line_has_sym(line):
    return bool(RE_DEFINED.search(line) or re.search(r'\b(' + SYM_RE + r')\b', line))

def process_cpp(path):
    lines = io.open(path, encoding='utf-8', errors='replace').read().splitlines(True)
    out, stack, changed = [], [], False
    skipping = 0
    for ln in lines:
        if RE_IFDEF.match(ln) or (RE_IF.match(ln) and expr_is_dead(ln)):
            stack.append('dead'); skipping += 1; changed = True; continue
        if RE_IFNDEF.match(ln):
            # #ifndef SYM her zaman dogru -> guard'i kaldir, govdeyi koru
            stack.append('ifndef_live'); changed = True; continue
        if RE_IF.match(ln):
            if skipping:
                stack.append('live'); skipping += 1; continue
            nl = scrub(ln) if line_has_sym(ln) else ln
            changed |= (nl != ln)
            stack.append('live'); out.append(nl); continue
        if RE_ELIF.match(ln):
            if stack and stack[-1] == 'dead':
                if expr_is_dead(ln):
                    continue
                stack[-1] = 'conv'; skipping -= 1
                head = ln[:ln.index('elif')]
                out.append(head + 'if' + scrub(ln[ln.index('elif')+4:]))
                changed = True
                continue
            if skipping: continue
            nl = scrub(ln) if line_has_sym(ln) else ln
            changed |= (nl != ln); out.append(nl); continue
        if RE_ELSE.match(ln):
            if stack and stack[-1] == 'dead':
                stack[-1] = 'elsed'; skipping -= 1; changed = True; continue
            if skipping: continue
            out.append(ln); continue
        if RE_ENDIF.match(ln):
            if stack:
                t = stack.pop()
                if t == 'dead':   skipping -= 1; continue
                if t == 'elsed':  changed = True; continue
                if t == 'ifndef_live': changed = True; continue
                if skipping:      skipping -= 1; continue
                out.append(ln); continue
            out.append(ln); continue
        if skipping:
            changed = True
            continue
        out.append(ln)
    if not changed:
        return False
    if DRY:
        return True
    io.open(path, 'w', encoding='utf-8', newline='').write(''.join(out))
    return True

# ---------------------------------------------------------------- veri dosyalari

WOLFMAN_SKILL_IDS = set(str(i) for i in range(170, 176)) | {'183', '229', '244', '306'}

def write_preserve_eol(path, text, eol):
    """Verilen satir sonu sekliyle yazar (autocrlf -> CRLF)."""
    with io.open(path, 'w', encoding='utf-8', newline='') as f:
        f.write(text.replace('\r\n', '\n').replace('\n', eol))

def detect_eol(path):
    raw = io.open(path, 'rb').read()
    return '\r\n' if b'\r\n' in raw else '\n'

def clean_skillfile(path):
    """Ilk sutun vnum olan tablo satirlarindan wolfman becerilerini ve
    CLAW/ATTACK_BLEEDING tokenlarini temizler."""
    eol = detect_eol(path)
    lines = io.open(path, encoding='utf-8', errors='replace').read().splitlines(True)
    out, changed = [], False
    for ln in lines:
        first = ln.split('\t', 1)[0].strip().lstrip('﻿')
        if first in WOLFMAN_SKILL_IDS:
            changed = True
            continue
        nl = ln.replace('|CLAW', '').replace(',ATTACK_BLEEDING', '')
        if nl != ln: changed = True
        out.append(nl)
    if changed and not DRY:
        write_preserve_eol(path, ''.join(out), eol)
    return changed

ENUM_RENAMES = [
    ("'BLEEDING_REDUCE'",      "'RESERVED_92'"),
    ("'BLEEDING_PCT'",         "'RESERVED_93'"),
    ("'ATT_BONUS_TO_WOLFMAN'", "'RESERVED_94'"),
    ("'RESIST_WOLFMAN'",       "'RESERVED_95'"),
    ("'RESIST_CLAW'",          "'RESERVED_96'"),
    ("'ATTBONUS_CLAW'",        "'RESERVED_114'"),
    ("'ATTACK_BLEEDING'",      "'RESERVED_28'"),
    ("'RED_POSSESSION'",       "'RESERVED_44'"),
    ("'BLUE_POSSESSION'",      "'RESERVED_45'"),
    ("'BLEEDING'",             "'RESERVED_43'"),
]

def clean_sql(path):
    eol = detect_eol(path)
    lines = io.open(path, encoding='utf-8', errors='replace').read().splitlines(True)
    out, changed, i = [], False, 0
    in_wolfman_create = False
    while i < len(lines):
        ln = lines[i]
        low = ln.lower()
        if in_wolfman_create:
            changed = True; i += 1
            if 'engine' in low or ln.rstrip().endswith(';'):
                in_wolfman_create = False
            continue
        # item_attr_wolfman tablo bloku: yorum basligi + DROP + CREATE + INSERT'ler
        if 'item_attr_wolfman' in low:
            changed = True
            if 'create table' in low:
                in_wolfman_create = True
            i += 1
            continue
        # wolfman mob satiri (vnum 4505 'Lycan' / secret_wolfman)
        if 'insert into `mob_proto`' in low and ('0x4c7963616e' in low or 'secret_wolfman' in low):
            changed = True; i += 1; continue
        # wolfman skill satirlari (170-175)
        m = re.search(r'insert into `?skill_proto`?\s+values\s*\((\d+)', low)
        if m and m.group(1) in {'170','171','172','173','174','175','183','306'}:
            changed = True; i += 1; continue
        nl = ln
        for a, b in ENUM_RENAMES:
            if a in nl:
                nl = nl.replace(a, b)
        nl = nl.replace(',ATTACK_BLEEDING', '')
        if nl != ln: changed = True
        out.append(nl)
        i += 1
    if changed and not DRY:
        write_preserve_eol(path, ''.join(out), eol)
    return changed

def main():
    cpp_changed, data_changed = 0, 0
    for root, ds, fs in os.walk(os.path.join(ROOT, 'Srcs')):
        for fn in fs:
            if fn.endswith(('.cpp', '.h', '.hpp', '.cxx')):
                p = os.path.join(root, fn)
                try:
                    if process_cpp(p):
                        cpp_changed += 1; print(('DRY ' if DRY else '') + p)
                except Exception as e:
                    print('HATA', p, e)

    for rel in (
        'Srcs/Pack/locale/locale/tr/skilldesc.txt',
        'Srcs/Pack/locale/locale/tr/skilltable.txt',
        'Srcs/Pack/root/skilltable.txt',
    ):
        p = os.path.join(ROOT, rel)
        if os.path.exists(p) and clean_skillfile(p):
            data_changed += 1; print(('DRY ' if DRY else '') + rel)

    for root, ds, fs in os.walk(os.path.join(ROOT, 'sql')):
        for fn in fs:
            if fn.endswith('.sql'):
                p = os.path.join(root, fn)
                try:
                    if clean_sql(p):
                        data_changed += 1
                        print(('DRY ' if DRY else '') + os.path.relpath(p, ROOT))
                except Exception as e:
                    print('HATA', p, e)

    print('cpp degisen: %d, veri degisen: %d' % (cpp_changed, data_changed))

if __name__ == '__main__':
    main()
