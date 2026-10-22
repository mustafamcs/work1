# -*- coding: utf-8 -*-
# locale/turkey/*.json icindeki yapisal tablolari common.game_data_row
# icin SQL INSERT cumlelerine cevirir.
#
# Kullanim:
#   python tools/game_data_sql_import.py > game_data_row_data.sql
#   mariadb -u... -p... common < game_data_row_data.sql
#
# Dil dosyasi (locale_string) ve zaten SQL'de olan skill_power harictir.

import glob
import io
import json
import os
import sys

LOCALE_DIR = os.path.join(os.path.dirname(__file__), "..", "server", "share", "locale", "turkey")

# SQL'e alinmayacaklar
EXCLUDE = {
    "locale_string",   # dil dosyasi -> dosyada kalir
    "skill_power",     # zaten `locale` SQL tablosundan okunuyor
}

COLS = ",c".join("")  # placeholder


def hexlit(value):
    b = str(value).encode("utf-8")
    return "0x" + b.hex().upper() if b else "''"


def main():
    sys.stdout.write("SET NAMES utf8mb4;\n")
    total_srcs = 0

    for path in sorted(glob.glob(os.path.join(LOCALE_DIR, "*.json"))):
        src = os.path.splitext(os.path.basename(path))[0]
        if src in EXCLUDE:
            continue

        with io.open(path, encoding="utf-8") as f:
            data = json.load(f)
        rows = data["rows"] if isinstance(data, dict) else data

        # src'i kayda ekle + onceki veriyi temizle (idempotent import)
        sys.stdout.write("REPLACE INTO `game_data_src` (`src`) VALUES ('%s');\n" % src)
        sys.stdout.write("DELETE FROM `game_data_row` WHERE `src` = '%s';\n" % src)

        seq = 0
        batch = []
        for row in rows:
            cells = [str(c) for c in (row if isinstance(row, list) else [row])]
            if not cells:
                continue
            k = cells[0]
            rest = cells[1:]
            if len(rest) > 24:
                sys.stderr.write("UYARI: %s satir %d 24'den fazla hucre (%d)\n"
                                 % (src, seq, len(rest) + 1))
            rest = rest[:24]
            cols = ["`src`", "`seq`", "`k`"] + ["`c%d`" % i for i in range(1, len(rest) + 1)]
            vals = ["'%s'" % src, str(seq), hexlit(k)] + [hexlit(c) for c in rest]
            batch.append("INSERT INTO `game_data_row` (%s) VALUES (%s);\n"
                         % (",".join(cols), ",".join(vals)))
            seq += 1
            if len(batch) >= 500:
                sys.stdout.write("".join(batch))
                batch = []
        if batch:
            sys.stdout.write("".join(batch))

        sys.stderr.write("%-20s %d satir\n" % (src, seq))
        total_srcs += 1

    sys.stderr.write("TOPLAM %d tablo\n" % total_srcs)


if __name__ == "__main__":
    main()
