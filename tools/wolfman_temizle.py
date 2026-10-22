#!/usr/bin/env python
# -*- coding: utf-8 -*-
# wolfman_temizle.py — wolfman/lycan ile ilgili #ifdef bloklarini Srcs agacindan siler.
# Donusumler:
#   #ifdef SYM a #endif              -> silinir
#   #ifdef SYM a #else b #endif      -> b korunur
#   #ifdef SYM a #elif E b ...       -> "#if E" ile baslayan zincire donusur
#   #if/#elif icinde defined(SYM)    -> (0) basilir
# Kullanim: python tools/wolfman_temizle.py [--dry]

import io, os, re, sys

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
    e = RE_EXPR.match(scrub(line))
    if not e: return False
    e = e.group(1).strip()
    if not re.fullmatch(r'[\s()0!&|]+', e):
        return False
    return eval(e.replace('!',' not ').replace('&&',' and ').replace('||',' or ') or '0') == 0

def process(path):
    lines = io.open(path, encoding='utf-8', errors='replace').read().splitlines(True)
    out, stack, changed = [], [], False
    # stack frame: 'live' normal | 'dead' atlanan blok | 'conv' #if'e donustu | 'elsed' else govdesi canli (endif silinecek)
    skipping = 0
    for ln in lines:
        # --- blok baslangici ---
        if RE_IFDEF.match(ln) or (RE_IF.match(ln) and RE_DEFINED.search(ln) and expr_is_dead(ln)):
            stack.append('dead'); skipping += 1; changed = True; continue
        if RE_IFNDEF.match(ln):
            stack.append('live'); out.append(ln); continue
        if RE_IF.match(ln):
            if skipping:
                stack.append('live'); skipping += 1; continue
            nl = scrub(ln); changed |= (nl != ln)
            stack.append('live'); out.append(nl); continue
        # --- elif ---
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
            nl = scrub(ln); changed |= (nl != ln); out.append(nl); continue
        # --- else ---
        if RE_ELSE.match(ln):
            if stack and stack[-1] == 'dead':
                stack[-1] = 'elsed'; skipping -= 1; changed = True; continue
            if skipping: continue
            out.append(ln); continue
        # --- endif ---
        if RE_ENDIF.match(ln):
            if stack:
                t = stack.pop()
                if t == 'dead':   skipping -= 1; continue
                if t == 'elsed':  changed = True; continue      # endif'i sil
                if skipping:      skipping -= 1; continue
                out.append(ln); continue                        # live/conv
            out.append(ln); continue
        # --- govde ---
        if skipping:
            changed = True
            continue
        out.append(ln)
    if not changed:
        return False
    if '--dry' in sys.argv:
        return True
    io.open(path, 'w', encoding='utf-8', newline='').write(''.join(out))
    return True

def main():
    n = 0
    for root, ds, fs in os.walk('Srcs'):
        for fn in fs:
            if fn.endswith(('.cpp', '.h', '.hpp', '.cxx')):
                p = os.path.join(root, fn)
                try:
                    if process(p):
                        n += 1; print(('DRY ' if '--dry' in sys.argv else '') + p)
                except Exception as e:
                    print('HATA', p, e)
    print('toplam degisen:', n)

if __name__ == '__main__':
    main()
