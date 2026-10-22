#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
work1 - U+FFFD ile bozulmus string literal'larini work1-kaynak referanslarindan geri yukler.

Bozulma zinciri (dogrulanmis): cp949 baytlari -> utf-8 decode(errors='replace') -> utf-8.
Simulasyon: aday.encode('cp949').decode('utf-8','replace') == bozuk literal.
Ayriyeten komsu literal baglamiyla (prev/next bozulmamis capalar) ayristirilir.

Kullanim:
    python fffd_onar.py <dosya|dizin>... [--dry] [--rapor yol]
"""

import os
import re
import sys

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

KOK = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
KAYNAK = r'C:\Works\work1-kaynak'

FFFD = '�'
LIT_RE = re.compile(r'"((?:\\.|[^"\\])*)"')
LIT_RE_SQ = re.compile(r"'((?:\\.|[^'\\])*)'")
WORDS = re.compile(r'\S+')

SKIP_DIRS = {'.git', 'out', '_yedek', '.pre_qc', '__pycache__', 'build',
             'logs', 'log', '.vs', 'shop', 'mark', 'upload', 'node_modules',
             'wiki'}

# latin-corba mojibake karakterleri: aday bunlari iceriyorsa supheli
MOJI = set('¹º¼½¾¿ÀÁÂÃÄÅÆÈÉÊËÌÍÎÏÐÒÓÔÕ×ØÙÚÛÝÞßðøýþ°±µ¶·¸¡¢£¤¥¦§¨©ª«¬­®¯´'
           '³²âîûÂÎÛüöÜÖçÇşŞğĞıİäëïñãõÿ')


def looks_mojibake(s):
    return sum(1 for c in s if c in MOJI) >= 2


def corrupt_forms(s):
    out = set()
    for enc in ('cp949', 'cp1254', 'cp1252'):
        try:
            out.add(s.encode(enc).decode('utf-8', errors='replace'))
        except Exception:
            pass
    return out


def decode(path):
    raw = open(path, 'rb').read()
    if raw.startswith(b'\xef\xbb\xbf'):
        raw = raw[3:]
    for enc in ('utf-8', 'cp949', 'cp1254'):
        try:
            return raw.decode(enc)
        except UnicodeDecodeError:
            continue
    return None


_NAME_INDEX = None


def name_index():
    global _NAME_INDEX
    if _NAME_INDEX is None:
        _NAME_INDEX = {}
        for root, dirs, files in os.walk(KAYNAK):
            dirs[:] = [d for d in dirs if d not in {'.git', 'node_modules'}]
            for fn in files:
                _NAME_INDEX.setdefault(fn, []).append(os.path.join(root, fn))
    return _NAME_INDEX


def find_refs(basename, rel_hint):
    hits = []
    for p in name_index().get(basename, []):
        score = 2 if p.replace('\\', '/').endswith(rel_hint.replace('\\', '/')) else 0
        hits.append((score, p))
    return [p for _, p in sorted(hits, key=lambda x: -x[0])]


class Pool:
    def __init__(self):
        self.by_corrupt = {}

    def add(self, lit):
        for cf in corrupt_forms(lit):
            self.by_corrupt.setdefault(cf, set()).add(lit)

    def get(self, lit):
        return self.by_corrupt.get(lit, set())


def load_global_pool():
    """locale_string.txt gibi tum dosyalardan ortak aday havuzu (bir kere)."""
    pool = Pool()
    for p in name_index().get('locale_string.txt', []):
        try:
            t = decode(p)
        except OSError:
            continue
        if t is None or FFFD in t:
            continue
        for lit in LIT_RE.findall(t):
            pool.add(lit)
    return pool


GPOOL = None


def neighbor_score(w_lits, i, r_lits, j, span=4):
    """i bozuk literal cevresindeki bozulmamis capalarin r_lits j cevresinde gorunme sayisi."""
    score = 0
    for k in range(max(0, i - span), i):
        if w_lits[k] and FFFD not in w_lits[k] and w_lits[k] in r_lits[max(0, j - span):j]:
            score += 1
    for k in range(i + 1, min(len(w_lits), i + span + 1)):
        if w_lits[k] and FFFD not in w_lits[k] and w_lits[k] in r_lits[j + 1:j + span + 1]:
            score += 1
    return score


def process_file(path, dry, rapor):
    global GPOOL
    try:
        text = decode(path)
    except OSError:
        return
    if text is None or FFFD not in text:
        return

    basename = os.path.basename(path)
    rel = os.path.relpath(path, KOK)

    refs = []
    for rp in find_refs(basename, rel):
        try:
            rt = decode(rp)
        except OSError:
            continue
        if rt is not None and FFFD not in rt:
            refs.append((rp, rt, LIT_RE.findall(rt)))

    own_pool = Pool()
    for _, rt, r_lits in refs:
        for lit in r_lits:
            own_pool.add(lit)
        if basename.endswith('.py'):
            for lit in LIT_RE_SQ.findall(rt):
                own_pool.add(lit)

    if GPOOL is None:
        GPOOL = load_global_pool()

    w_lits = LIT_RE.findall(text)

    # her ref dosyasinin work1 dosyasina benzerlik skoru (bozulmamis eslesmeler)
    clean_w = [l for l in w_lits if FFFD not in l]
    ref_rank = [sum(1 for l in clean_w if l in set(r_lits)) for _, _, r_lits in refs]

    # konumsal eslesme: ayni literal sayisina sahip temiz ref -> birebir indeks;
    # aday ayrica bozulma simulasyonunu da saglamali
    pos_map = {}
    for _, _, r_lits in refs:
        if len(r_lits) == len(w_lits):
            for i, (wl, rl) in enumerate(zip(w_lits, r_lits)):
                if FFFD in wl and wl in corrupt_forms(rl):
                    pos_map.setdefault(i, set()).add(rl)

    fixed = ambiguous = unresolved = 0
    samples = []
    idx = [-1]

    def pick(lit, i):
        """en iyi aday: konumsal > simulasyon-esit + mojibake-olmayan + komsu skoru."""
        if i >= 0 and pos_map.get(i):
            pc = pos_map[i]
            clean = {c for c in pc if not looks_mojibake(c)}
            if clean:
                pc = clean
            if len(pc) == 1:
                return next(iter(pc)), 'fixed'
        cands = own_pool.get(lit) | GPOOL.get(lit)
        if pos_map.get(i):
            cands |= pos_map[i]
        if not cands:
            return None, 'unresolved'
        clean = {c for c in cands if not looks_mojibake(c)}
        if clean:
            cands = clean
        if len(cands) == 1:
            return next(iter(cands)), 'fixed'
        # komsu baglami ile skorla (ayni-adli ref dosyalari uzerinden)
        best, best_s = [], -1
        for _, _, r_lits in refs:
            for j, rlit in enumerate(r_lits):
                if rlit in cands:
                    s = neighbor_score(w_lits, i, r_lits, j)
                    if s > best_s:
                        best, best_s = [rlit], s
                    elif s == best_s:
                        best.append(rlit)
        best = list(dict.fromkeys(best))
        if len(best) == 1 and best_s > 0:
            return best[0], 'fixed'
        # son care: en benzer ref dosyasinda gecen adayi sec
        order = sorted(range(len(refs)), key=lambda ri: -ref_rank[ri])
        for ri in order:
            rset = set(refs[ri][2])
            hit = [c for c in cands if c in rset]
            if len(hit) == 1:
                return hit[0], 'fixed'
        return None, 'ambiguous'

    def repl(m):
        nonlocal fixed, ambiguous, unresolved
        idx[0] += 1
        lit = m.group(1)
        if FFFD not in lit:
            return m.group(0)
        new, st = pick(lit, idx[0])
        if st == 'fixed':
            fixed += 1
            if len(samples) < 12:
                samples.append((lit[:50], new[:50]))
            return '"' + new.replace('"', '\\"') + '"'
        if st == 'ambiguous':
            ambiguous += 1
            if len(samples) < 12:
                samples.append((lit[:45], '?'))
        else:
            unresolved += 1
        return m.group(0)

    def sq_repl(m):
        nonlocal fixed, ambiguous, unresolved
        lit = m.group(1)
        if FFFD not in lit:
            return m.group(0)
        new, st = pick(lit, -1)
        if st == 'fixed':
            fixed += 1
            return "'" + new.replace("'", "\\'") + "'"
        if st == 'ambiguous':
            ambiguous += 1
        else:
            unresolved += 1
        return m.group(0)

    # ayni bozuk literal baska yerde cozulduyse ayni cevir: once tumunu tara
    seen = {}
    for m in LIT_RE.finditer(text):
        lit = m.group(1)
        if FFFD in lit and lit not in seen:
            new, st = pick(lit, -1)
            if st == 'fixed':
                seen[lit] = new

    def repl2(m):
        nonlocal fixed, ambiguous, unresolved
        idx[0] += 1
        lit = m.group(1)
        if FFFD not in lit:
            return m.group(0)
        new, st = pick(lit, idx[0])
        if st != 'fixed' and lit in seen:
            new, st = seen[lit], 'fixed'
        if st == 'fixed':
            fixed += 1
            if len(samples) < 12:
                samples.append((lit[:50], new[:50]))
            return '"' + new.replace('"', '\\"') + '"'
        if st == 'ambiguous':
            ambiguous += 1
            if len(samples) < 12:
                samples.append((lit[:45], '?'))
        else:
            unresolved += 1
        return m.group(0)

    new_text = LIT_RE.sub(repl2, text)
    if basename.endswith('.py'):
        new_text = LIT_RE_SQ.sub(sq_repl, new_text)
    if not dry and new_text != text:
        with open(path, 'w', encoding='utf-8', newline='') as f:
            f.write(new_text)

    rapor.append(f'{os.path.relpath(path, KOK)}\tfixed={fixed} ambig={ambiguous} unresolved={unresolved}')
    for a, b in samples:
        rapor.append(f'    {a!r}  =>  {b!r}')
    return fixed, ambiguous, unresolved


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    dry = '--dry' in sys.argv
    rapor_path = None
    if '--rapor' in sys.argv:
        rapor_path = sys.argv[sys.argv.index('--rapor') + 1]

    targets = []
    for a in args:
        if os.path.isdir(a):
            for root, dirs, files in os.walk(a):
                dirs[:] = [d for d in dirs if d not in SKIP_DIRS
                           and os.path.realpath(os.path.join(root, d)) == os.path.abspath(os.path.join(root, d))]
                targets += [os.path.join(root, fn) for fn in files]
        else:
            targets.append(a)

    rapor = []
    tf = ta = tu = nf = 0
    for p in targets:
        r = process_file(p, dry, rapor)
        if r:
            nf += 1
            tf += r[0]; ta += r[1]; tu += r[2]

    print(f'dosya={nf} duzeltildi={tf} belirsiz={ta} bulunamadi={tu} (dry={dry})')
    out = '\n'.join(rapor)
    if rapor_path:
        with open(rapor_path, 'w', encoding='utf-8') as f:
            f.write(out)
        print('rapor:', rapor_path)
    else:
        print(out[:8000])
    return 0


if __name__ == '__main__':
    sys.exit(main())
