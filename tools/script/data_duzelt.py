# -*- coding: utf-8 -*-
# data_duzelt.py — syserr'de gorulen sunucu data sorunlarini giderir.
#
#  1) Her surec dizinine package/ acar (ClientPackageCryptInfo uyarisi susar)
#  2) mob_proto'da FOLDER'i olup diskte olmayan canavar klasorlerini donor
#     klasorden kopyalar (petler + s_pawn + knight02 + golden_land_mine)
#  3) motlist.txt icindeki eksik .msa referanslarini ayni klasordeki uygun
#     dosyaya esler; eslenecek yoksa satiri duser (acilis "Yukleme basarisiz"
#     spam'ini bitirir — davranis ayni: hareket zaten yuklenemiyordu)
#  4) RUN satiri metinstone* klasorlerinde dusurulur (taslar hareket etmez;
#     "birikim verisi bulunamiyor" uyarisi susar)
#  5) RUN icin eslenen dosyada Accumulation.y==0 ise satir dusurulur
#
# Kullanim: python data_duzelt.py <work1_kok> [--dry]

import os, re, shutil, sys

KOK = sys.argv[1] if len(sys.argv) > 1 else r"C:\Works\work1"
DRY = "--dry" in sys.argv
SRV = os.path.join(KOK, "server")
MONSTER = os.path.join(SRV, "share", "data", "monster")
MOB_PROTO = os.path.join(SRV, "db", "mob_proto.txt")

# mob_proto FOLDER -> donor klasor (icerik tumuyle kopyalanir)
DONOR = {
    "christmas_2015_reindeer_female": "reindeer_female",
    "christmas_2015_reindeer_male": "reindeer_male",
    "christmas_2016_mammoth": "cz_elephant",
    "christmas_2017_sleddog": "ice_snow_dog",
    "christmas_2018_horse": "horse2",
    "christmas_2019_horse": "horse_event1",
    "christmas_2020_alpaca": "reindeer_young",
    "christmas_2021_wolf": "wolf",
    "christmas_2022_reindeer": "reindeer_male",
    "easter_2018_rabbit": "rabbit_pet",
    "easter_2020_cow": "12zi_cow_boss",
    "easter_2021_rabbit": "rabbit_pet",
    "easter_2022_seahorse": "rabbit_pet",
    "easter_2023_rabbit": "rabbit_pet",
    "halloween_2016_dragon": "red_dragon",
    "halloween_2017_volcano_beast": "fire_dragon",
    "halloween_2018_cerberos": "dog_god",
    "halloween_2019_bat": "phoenix1",
    "halloween_2020_crow": "phoenix1",
    "halloween_2021_ninetail": "fox_ninetail",
    "halloween_2022_bat": "phoenix1",
    "icecrystal_valley_boss": "snakevalley_boss",
    "icecrystal_valley_knight01": "snakevalley_knight",
    "icecrystal_valley_knight02": "snakevalley_knight",
    "icecrystal_valley_knight03": "snakevalley_knight",
    "icecrystal_valley_s_knight": "snakevalley_s_knight",
    "icecrystal_valley_s_pawn": "icecrystal_valley_pawn",
    "maze_gnoll_boss": "gnoll_boss",
    "maze_keingnoll_boss": "maze_keindog_boss",
    "metinstone_golden_land_mine": "metinstone_02",
    "ramadan_2017_camel": "cz_elephant",
    "ramadan_2020_sphinx": "cz_elephant",
    "reddragon_fly": "reddragon_room_fly",
    "whitedragon_cave_boss": "snakevalley_boss",
    "whitedragon_cave_knight01": "snakevalley_knight",
    "whitedragon_cave_knight02": "snakevalley_knight",
    "whitedragon_cave_knight03": "snakevalley_knight",
    "whitedragon_cave_s_knight": "snakevalley_s_knight",
    "whitedragon_fly": "reddragon_room_fly",
    "whitedragonvalley_knight01": "snakevalley_knight",
    "whitedragonvalley_knight02": "snakevalley_knight",
    "whitedragonvalley_pawn": "snakevalley_pawn",
    "whitedragonvalley_s_knight": "snakevalley_s_knight",
    "whitedragonvalley_s_pawn": "snakevalley_s_pawn",
    "yamachun": "yamachun_boss",
}

# hic msa'si olmayan statik nesneler — bos motlist acilir
EMPTY_MOTLIST = {"reddragon_room_box"}

def accum_y(path):
    try:
        with open(path, "r", errors="replace") as f:
            for line in f:
                m = re.match(r"\s*Accumulation\s+(\S+)\s+(\S+)\s+(\S+)", line, re.IGNORECASE)
                if m:
                    return float(m.group(2))
    except (OSError, ValueError):
        pass
    return None

def msas(d):
    try:
        return [f for f in os.listdir(d) if f.lower().endswith(".msa")]
    except OSError:
        return []

def no_digits(name):
    return re.sub(r"\d+$", "", os.path.splitext(name)[0])

def run_ok(path):
    a = accum_y(path)
    return a is not None and a != 0

def find_candidate(d, mtype, fname):
    files = msas(d)
    stem = no_digits(fname)
    # 1) ayni govde, sondaki rakamsiz (normal_attack1 -> normal_attack)
    for f in files:
        if no_digits(f) == stem and stem:
            if mtype != "RUN" or run_ok(os.path.join(d, f)):
                return f
    # 2) tip bazli yedekler
    if mtype.startswith("NORMAL_ATTACK") or mtype.startswith("SPECIAL"):
        for f in files:
            if "attack" in f.lower():
                return f
    if mtype in ("RUN", "WALK"):
        for pat in ([mtype.lower(), "run", "walk"]):
            for f in files:
                if no_digits(f).lower().startswith(pat) and run_ok(os.path.join(d, f)):
                    return f
    return None

def repair_motlist(path):
    d = os.path.dirname(path)
    is_stone = os.path.basename(d).lower().startswith("metinstone")
    out, dropped, remapped = [], 0, 0
    with open(path, "r", errors="replace") as f:
        for raw in f:
            line = raw.rstrip("\r\n")
            parts = line.split()
            if len(parts) < 3 or parts[0].startswith("#"):
                out.append(line)
                continue
            mode, mtype, fname = parts[0], parts[1], parts[2]
            rest = " ".join(parts[3:]) if len(parts) > 3 else "100"
            if is_stone and mtype == "RUN":
                dropped += 1
                continue
            fpath = os.path.join(d, fname)
            ok = os.path.isfile(fpath) and (mtype != "RUN" or run_ok(fpath))
            if ok:
                out.append(line)
                continue
            cand = find_candidate(d, mtype, fname)
            if cand:
                out.append("%s %s %s %s" % (mode, mtype, cand, rest))
                remapped += 1
            else:
                dropped += 1
    if (dropped or remapped) and not DRY:
        with open(path, "w", newline="") as f:
            f.write("\r\n".join(out) + "\r\n")
    return dropped, remapped

def mob_proto_folders():
    folders = set()
    try:
        with open(MOB_PROTO, "r", errors="replace") as f:
            header = f.readline().rstrip("\r\n").split("\t")
            try:
                fi = header.index("FOLDER")
            except ValueError:
                fi = 12
            for line in f:
                p = line.rstrip("\r\n").split("\t")
                if len(p) > fi and p[fi]:
                    folders.add(p[fi])
    except OSError as e:
        print("[HATA] mob_proto okunamadi:", e)
    return folders

def main():
    print("== 1) package/ dizinleri ==")
    for sub in ("auth", os.path.join("channel1", "core1"), "channel99"):
        p = os.path.join(SRV, sub, "package")
        if not os.path.isdir(p):
            if not DRY:
                os.makedirs(p)
            print("  olusturuldu:", p)
        else:
            print("  var:", p)

    print("== 2) eksik canavar klasorleri (donor kopyasi) ==")
    folders = mob_proto_folders()
    print("  mob_proto'da %d klasor referansi" % len(folders))
    for dname, donor in sorted(DONOR.items()):
        dst = os.path.join(MONSTER, dname)
        src = os.path.join(MONSTER, donor)
        if dname not in folders:
            print("  [atla] %s mob_proto'da yok" % dname)
            continue
        if not os.path.isdir(src):
            print("  [HATA] donor yok:", donor)
            continue
        have_msa = os.path.isdir(dst) and msas(dst)
        if not have_msa:
            if not DRY:
                os.makedirs(dst, exist_ok=True)
                for f in os.listdir(src):
                    if f.lower().endswith((".msa", ".txt")):
                        shutil.copy2(os.path.join(src, f), os.path.join(dst, f))
            print("  kopyalandi: %s <- %s" % (dname, donor))
        else:
            print("  var: %s" % dname)

    for dname in EMPTY_MOTLIST:
        dst = os.path.join(MONSTER, dname)
        if not os.path.isdir(dst):
            continue
        ml = os.path.join(dst, "motlist.txt")
        if not os.path.isfile(ml):
            if not DRY:
                with open(ml, "w", newline="") as f:
                    f.write("")
            print("  bos motlist: %s" % dname)

    print("== 3) motlist onarimi ==")
    tot_d = tot_r = 0
    for dname in sorted(os.listdir(MONSTER)):
        ml = os.path.join(MONSTER, dname, "motlist.txt")
        if not os.path.isfile(ml):
            continue
        d_, r_ = repair_motlist(ml)
        if d_ or r_:
            print("  %-40s dusurulen:%d eslenen:%d" % (dname, d_, r_))
        tot_d += d_
        tot_r += r_
    print("  toplam: %d satir dusuruldu, %d satir eslendi" % (tot_d, tot_r))

    print("== 4) kalan motlist'siz ama kullanilan klasorler ==")
    kalan = sorted(f for f in folders if f and not os.path.isfile(os.path.join(MONSTER, f, "motlist.txt")))
    for f in kalan:
        print("  [KALAN] %s" % f)
    if not kalan:
        print("  yok")

if __name__ == "__main__":
    main()
