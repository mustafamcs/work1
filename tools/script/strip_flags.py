# -*- coding: utf-8 -*-
# Olu flag define'larin #if bloklarini temizler (kapali kabul edilir):
#   #ifdef X / #if defined(X) / #if <expr>  -> true-dal silinir, #else dali korunur
#   #ifndef X / #if !defined(X)             -> true-dal korunur, #else dali silinir
# Ifade sadece hedef makrolar + defined/!/&&/||/() iceriyorsa islenir.
import sys, re, io

DEAD = set(sys.argv[2:])
IDENT = re.compile(r'[A-Za-z_][A-Za-z0-9_]*')

def try_eval(expr):
    # yorum eki temizle
    expr = expr.split('//')[0]
    # defined(X) -> D(X)
    e = re.sub(r'\bdefined\s*\(\s*([A-Za-z_][A-Za-z0-9_]*)\s*\)', r' D(\1) ', expr)
    ids = [i for i in IDENT.findall(e) if i not in ('D', 'and', 'or', 'not')]
    dead = [i for i in ids if i in DEAD]
    free = [i for i in set(ids) if i not in DEAD]
    for i in dead:
        e = re.sub(r'\b' + re.escape(i) + r'\b', '0', e)
    if not dead:
        return None
    e = e.replace('&&', ' and ').replace('||', ' or ')
    e = re.sub(r'!\s*', ' not ', e)
    e = e.replace('/', '//')
    # serbest makrolari {0,1} kombinasyonlariyla dene; sonuc sabitse kabul et
    import itertools
    results = set()
    combos = itertools.product((0, 1), repeat=len(free)) if len(free) <= 4 else [(0,)*len(free)]
    for combo in combos:
        ee = e
        for name, val in zip(free, combo):
            ee = re.sub(r'\bD\(\s*' + re.escape(name) + r'\s*\)', str(val), ee)
            ee = re.sub(r'\b' + re.escape(name) + r'\b', str(val), ee)
        ee = re.sub(r'D\(\s*0\s*\)', '0', ee)
        try:
            results.add(bool(eval(ee)))
        except Exception:
            return None
    if len(results) == 1:
        return results.pop()
    return None

def process(path):
    with io.open(path, 'r', encoding='latin-1') as f:
        lines = f.read().splitlines(keepends=True)
    out = []
    i = 0
    changed = False
    n = len(lines)

    def read_block(start):
        # start: index of #if* line; returns list of segments [(cond, lines)] and end index of #endif
        depth = 0
        segs = []
        cur = []
        j = start
        conds = []
        while j < n:
            l = lines[j]
            s = l.strip()
            m = re.match(r'#\s*(if|ifdef|ifndef|elif|else|endif)\b(.*)', s)
            boundary = False
            if m:
                kw, rest = m.group(1), m.group(2)
                if kw in ('if', 'ifdef', 'ifndef'):
                    if depth == 0:
                        conds.append((kw, rest.strip()))
                        boundary = True
                    depth += 1
                elif kw == 'elif':
                    if depth == 1:
                        segs.append(cur); cur = []
                        conds.append(('elif', rest.strip()))
                        boundary = True
                elif kw == 'else':
                    if depth == 1:
                        segs.append(cur); cur = []
                        conds.append(('else', ''))
                        boundary = True
                elif kw == 'endif':
                    depth -= 1
                    if depth == 0:
                        segs.append(cur)
                        return conds, segs, j
            if depth > 0 and not boundary:
                cur.append(l)
            j += 1
        return None, None, None

    while i < n:
        s = lines[i].strip()
        m = re.match(r'#\s*(if|ifdef|ifndef)\b(.*)', s)
        if m:
            conds, segs, endi = read_block(i)
            if conds:
                kw, expr = conds[0]
                expr = expr.split('//')[0].strip()
                if kw == 'ifdef':
                    val = try_eval('defined(%s)' % expr)
                elif kw == 'ifndef':
                    v = try_eval('defined(%s)' % expr)
                    val = None if v is None else (not v)
                else:
                    val = try_eval(expr)
                if val is not None:
                    # tum dallar bilinmeyen cond'dan sonra else'e kadar secilemez;
                    # sadece ilk dalin sonucu kesin.
                    if val:
                        out.extend(segs[0])
                    else:
                        # ilk false dal: elif'leri de eval etmeyi dene
                        taken = False
                        for k in range(1, len(conds)):
                            ck, ce = conds[k]
                            if ck == 'elif':
                                cv = try_eval(ce)
                                if cv:
                                    out.extend(segs[k]); taken = True; break
                                elif cv is False:
                                    continue
                                else:
                                    break  # bilinmeyen -> blok oldugu gibi kalmali
                            elif ck == 'else':
                                out.extend(segs[k]); taken = True; break
                        if not taken and conds[-1][0] != 'else':
                            pass  # hicbir dal yok -> hic sey yazma
                        elif not taken and conds[-1][0] == 'else':
                            out.extend(segs[-1])
                    changed = True
                    i = endi + 1
                    continue
        out.append(lines[i])
        i += 1

    if changed:
        with io.open(path, 'w', encoding='latin-1', newline='') as f:
            f.write(''.join(out))
        print('temizlendi:', path)
    return changed

if __name__ == '__main__':
    for p in sys.argv[1].split(';'):
        if p:
            process(p)
