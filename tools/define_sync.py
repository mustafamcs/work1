# -*- coding: utf-8 -*-
# Locale_inc.h + CommonDefines.h -> constinfo.py flag senkronu.
# Tek dogruluk kaynagi iki header'dir; bu dosya elle duzenlenmez.
#
# Kural:
#   #define X          -> X = True
#   #define X <deger>  -> X = <deger>
#   // #define X       -> X = False
# Aktif tanim, yorumlu tanimdan baskindir (iki header birlesik).

import io
import re
import sys
import os

ROOT = os.path.normpath(os.path.join(os.path.dirname(__file__), ".."))
HEADERS = [
    os.path.join(ROOT, "Srcs", "Client", "UserInterface", "Locale_inc.h"),
    os.path.join(ROOT, "Srcs", "Server", "common", "CommonDefines.h"),
]
TARGET = os.path.join(ROOT, "Srcs", "Pack", "root", "constinfo.py")

BEGIN = u"# >>> DEFINE_SYNC_BEGIN >>>"
END = u"# <<< DEFINE_SYNC_END <<<"

DEF_RE = re.compile(r'^\s*#\s*define\s+([A-Za-z_][A-Za-z0-9_]*)\s*(.*?)\s*(?://.*)?$')
CDEF_RE = re.compile(r'^\s*//+\s*#\s*define\s+([A-Za-z_][A-Za-z0-9_]*)\b')


def parse_header(path):
    vals = {}
    for ln in io.open(path, encoding="utf-8", errors="replace"):
        m = DEF_RE.match(ln)
        if m and not ln.strip().startswith("//"):
            name, val = m.group(1), m.group(2).strip()
            vals[name] = val if val else "True"
            continue
        m = CDEF_RE.match(ln)
        if m and m.group(1) not in vals:
            vals[m.group(1)] = "False"
    return vals


def main():
    vals = {}
    for h in HEADERS:
        for k, v in parse_header(h).items():
            if vals.get(k) in (None, "False") or v != "False":
                vals[k] = v
        # aktif her zaman yorumluyu ezer
    for h in HEADERS:
        for ln in io.open(h, encoding="utf-8", errors="replace"):
            m = DEF_RE.match(ln)
            if m and not ln.strip().startswith("//"):
                vals[m.group(1)] = m.group(2).strip() or "True"

    lines = io.open(TARGET, encoding="utf-8").read().splitlines()
    try:
        b = next(i for i, l in enumerate(lines) if BEGIN in l)
        e = next(i for i, l in enumerate(lines) if END in l)
    except StopIteration:
        sys.stderr.write("HATA: constinfo.py'de DEFINE_SYNC isaretleri yok\n")
        return 1

    # constinfo icinde def/property olan isimleri ezme (DEBUG_MODE gibi)
    src_all = io.open(TARGET, encoding="utf-8").read()
    for fn in re.findall(r'^\s*def\s+([A-Za-z_][A-Za-z0-9_]*)', src_all, re.M):
        vals.pop(fn, None)

    gen = [u"# (tools/define_sync.py uretti - elle degistirme)"]
    for name in sorted(vals):
        gen.append(u"%s = %s" % (name, vals[name]))

    lines[b + 1:e] = gen
    io.open(TARGET, "w", encoding="utf-8", newline="").write(
        u"\n".join(lines) + u"\n")
    sys.stderr.write("constinfo.py: %d flag senkronlandi\n" % len(gen))
    return 0


if __name__ == "__main__":
    sys.exit(main())
