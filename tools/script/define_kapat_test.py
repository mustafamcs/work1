#!/usr/bin/env python
# -*- coding: utf-8 -*-
# define_kapat_test.py — Controls.h icindeki TUM aktif #define'leri gecici
# olarak kapatir veya geri yukler. ifndef/if/else/elif/endif yapisinin
# dogru kurgulandigini derleme ile test etmek icin kullanilir.
#
# Kullanim:
#   python define_kapat_test.py --off      # hepsini kapat (yedek: Controls.h.on)
#   python define_kapat_test.py --restore  # geri yukle
#
# Include guard (__INC_*_H__) kapatilmaz — o ozellik flag'i degildir.

import io, os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
HDR = os.path.join(ROOT, 'Srcs', 'Controls.h')
BAK = HDR + '.on'

RE_DEF = re.compile(r'^(\s*)#\s*define\s+(\S+)')

def main():
    if '--restore' in sys.argv:
        if not os.path.exists(BAK):
            print('Yedek yok:', BAK); sys.exit(1)
        io.open(HDR, 'wb').write(io.open(BAK, 'rb').read())
        os.remove(BAK)
        print('Geri yuklendi:', HDR)
        return

    if '--off' not in sys.argv:
        print('Kullanim: --off | --restore'); sys.exit(1)

    if os.path.exists(BAK):
        print('Yedek zaten var, once --restore:', BAK); sys.exit(1)

    lines = io.open(HDR, encoding='utf-8').read().splitlines(True)
    out, n = [], 0
    for ln in lines:
        m = RE_DEF.match(ln)
        if m and not m.group(2).startswith('__INC_'):
            indent, name = m.group(1), m.group(2)
            # ic ice yapida girintili define'lar da kapatilir
            out.append('%s// %s' % (indent, ln.lstrip()))
            n += 1
        else:
            out.append(ln)

    io.open(BAK, 'wb').write(io.open(HDR, 'rb').read())
    io.open(HDR, 'w', encoding='utf-8', newline='').write(''.join(out))
    print('%d define kapatildi -> %s' % (n, HDR))
    print('Geri yuklemek icin: --restore')

if __name__ == '__main__':
    main()
