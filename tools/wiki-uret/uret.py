#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Wiki ureticisi. Plan 10, Uretim.

Sayfa govdesi dosyadan gelir. Dosyada olmayan alana tahmin yazilmaz.
Kaynak yoksa satir bos kalir, uydurulmaz.

1. Acik sistem listesi wiki/profiller/*.yaml. Kapi, server/profiles/*/
   profile.conf ile aynidir; iki dosya karsilastirilir, uyusmazlik
   _uretim.txt icinde uyarilir.
2. Locale okunur: proto, isim, map, regen, npc, boss, stone, drop,
   blend, cube, shop_table_ex, quest. refine_proto, shop ve skill_proto
   common tablosudur (plan 09); bu pakette ayri txt yoktur.
3. Plan 10 bolum 10 baglari kurulur. Kaynak satiri yoksa bag yazilmaz.
4. Kirik bag wiki/rapor/kirik-bag.md dosyasina duser.
5. Oyuncu cumlesi sablondan basilir. wiki/anlati/ varsa kutunun ustune
   konur. Anlati dosyasi yoksa paragraf uydurulmaz.
6. Sunucu item_proto vnum'u ile istemci item_list vnum'u ayni kimlikte
   bulusmuyorsa rapor wiki/rapor/istemci-farki.md dosyasina duser.
   Ikili proto ayristirilamaz; yalniz txt karsilastirilir.

Kod sayfasi UTF-8. Okunamazsa cp949 denenir. NAME(K) Korece kalir,
oyuncu adi item_names.txt / mob_names.txt uzerinden gelir. Ad
okunamazsa kayit "ad okunamadi" diye isaretlenir.
Lycan, Yohara, eldiven, won ve ametist sayfasi uretilmez.
uretilen/ elle duzenlenmez.
"""

from pathlib import Path
import datetime
import re
import sys

ROOT = Path(__file__).resolve().parents[2]

PROFILLER = ("99", "105", "120")

DB = ROOT / "server" / "db"
LOCALE = ROOT / "server" / "share" / "locale" / "turkey"
MAP_DIR = LOCALE / "map"
QUEST_DIR = LOCALE / "quest"
WIKI = ROOT / "wiki"
URETILEN = WIKI / "uretilen"
RAPOR = WIKI / "rapor"
CLIENT_ITEM_LIST = ROOT / "Srcs" / "Pack" / "locale" / "locale" / "tr" / "item_list.txt"
CLIENT_PACK_ITEM_LIST = ROOT / "client" / "pack" / "locale" / "locale" / "tr" / "item_list.txt"
CLIENT_LOCALE_GAME = ROOT / "Srcs" / "Pack" / "locale" / "locale" / "tr" / "locale_game.txt"

# plan 10 bolum 15; uretilen/{profil}/ altindaki tur dizinleri
TURLER = (
    "esya",
    "yaratik",
    "harita",
    "zindan",
    "gorev",
    "biyolog",
    "meslek",
    "beceri",
    "set",
)

# ----------------------------------------------------------------------
# yardimcilar
# ----------------------------------------------------------------------


def oku(yol):
    """UTF-8, olmazsa cp949. (metin, kodlama) dondurur."""
    bayt = yol.read_bytes()
    try:
        return bayt.decode("utf-8"), "utf-8"
    except UnicodeDecodeError:
        return bayt.decode("cp949", errors="replace"), "cp949"


def conf_oku(yol):
    out = {}
    metin, _ = oku(yol)
    for satir in metin.splitlines():
        satir = satir.strip()
        if not satir or satir.startswith("#") or "=" not in satir:
            continue
        anahtar, deger = satir.split("=", 1)
        out[anahtar.strip()] = deger.strip()
    return out


def yaml_oku(yol):
    """Bu depodaki profil yaml'inin kapsadigi kucuk kume: duz anahtar,
    liste anahtari ve '|' blok metni."""
    out = {}
    metin, _ = oku(yol)
    anahtar = None
    blok = None
    for satir in metin.splitlines():
        if blok is not None:
            if satir.startswith("  ") or satir.strip() == "":
                blok.append(satir)
                continue
            out[anahtar] = "\n".join(blok).strip("\n")
            blok = None
            anahtar = None
        if not satir.strip() or satir.lstrip().startswith("#"):
            continue
        if satir.startswith("  - "):
            if anahtar is not None:
                out.setdefault(anahtar, [])
                if isinstance(out[anahtar], list):
                    out[anahtar].append(satir.strip()[2:].strip())
            continue
        if ":" in satir and not satir.startswith(" "):
            anahtar, _, deger = satir.partition(":")
            anahtar = anahtar.strip()
            deger = deger.strip()
            if deger == "|":
                blok = []
            elif deger == "":
                out[anahtar] = []
            else:
                out[anahtar] = deger
                anahtar = None
    if blok is not None and anahtar is not None:
        out[anahtar] = "\n".join(blok).strip("\n")
    return out


def tablo_oku(yol):
    """Sekme ayrimli, ilk satir baslik. Sozluk listesi dondurur."""
    metin, enc = oku(yol)
    satirlar = metin.splitlines()
    if not satirlar:
        return [], enc
    baslik = satirlar[0].split("\t")
    kayitlar = []
    for satir in satirlar[1:]:
        if not satir.strip():
            continue
        alan = satir.split("\t")
        kayitlar.append({baslik[i]: alan[i] for i in range(min(len(baslik), len(alan)))})
    return kayitlar, enc


def isim_oku(yol):
    out = {}
    metin, _ = oku(yol)
    for satir in metin.splitlines()[1:]:
        alan = satir.rstrip("\n").split("\t")
        if len(alan) >= 2 and alan[0].strip().isdigit():
            out[int(alan[0].strip())] = alan[1].strip()
    return out


def yaz(yol, metin):
    yol.parent.mkdir(parents=True, exist_ok=True)
    yol.write_text(metin, encoding="utf-8")


# ----------------------------------------------------------------------
# sozlukler
# ----------------------------------------------------------------------

FEATURE_TR = {
    "core": "cekirdek",
    "belt": "kemer",
    "costume": "kostum",
    "energy": "enerji",
    "seal_pet": "muhurlu pet",
    "maps_90": "90 sahalari",
    "spider3": "orumcek 3",
    "catacomb": "seytan katakombu",
    "nemere": "Nemere",
    "razador": "Razador",
    "dragon_soul": "simya",
    "sash": "omuz kusagi",
    "aura": "aura",
    "talisman": "tilsim",
    "level_pet": "levelli pet",
    "attr67": "6/7 efsun",
    "gaya": "gaya",
    "transmutation": "yansitma",
    "autohunt": "otomatik av",
    "buffi": "yardimci saman",
    "enchanted_forest": "Buyulu Orman",
    "ochao": "Ochao",
    "meley": "Meley",
    "hydra": "Hidra",
    "zodiac": "Zodyak",
    "jotun": "Jotun",
}

# esya turu -> gerektirdigi feature (kapaliysa sayfada "kilitli" rozeti)
def esya_feature(tur, alt):
    if tur == "ITEM_BELT":
        return "belt"
    if tur == "ITEM_COSTUME":
        return "sash" if alt == "COSTUME_ACCE" else "costume"
    if tur in ("ITEM_DS", "ITEM_EXTRACT"):
        return "dragon_soul"
    if alt.startswith("MATERIAL_DS_"):
        return "dragon_soul"
    if alt in ("USE_ADD_ATTRIBUTE2", "USE_CHANGE_ATTRIBUTE2"):
        return "attr67"
    if alt == "USE_PUT_INTO_BELT_SOCKET":
        return "belt"
    if tur == "ITEM_PET":
        return "seal_pet"
    if tur == "ITEM_SOULITEM_PASSIVE":
        return "aura"
    if tur == "ITEM_ARMOR" and alt == "ARMOR_PENDANT":
        return "talisman"
    return None


TUR_TR = {
    "ITEM_WEAPON": "silah",
    "ITEM_ARMOR": "zirh kusagi",
    "ITEM_BELT": "kemer",
    "ITEM_BLEND": "ciy",
    "ITEM_CAMPFIRE": "kamp atesi",
    "ITEM_CONTAINER": "kutu",
    "ITEM_COSTUME": "kostum",
    "ITEM_DS": "ejderha tasi",
    "ITEM_ELK": "yang ceki",
    "ITEM_EXTRACT": "ejderha tasi cikarma",
    "ITEM_FISH": "balik",
    "ITEM_GACHA": "sans kutusu",
    "ITEM_GIFTBOX": "sandik",
    "ITEM_LOTTERY": "sans bileti",
    "ITEM_MATERIAL": "malzeme",
    "ITEM_MEDIUM": "oyun ici para birimi",
    "ITEM_METIN": "ruh tasi",
    "ITEM_NONE": "atanmamis",
    "ITEM_PET": "pet esyasi",
    "ITEM_PICK": "kazma",
    "ITEM_POLYMORPH": "donusum kuresi",
    "ITEM_QUEST": "gorev esyasi",
    "ITEM_RESOURCE": "kaynak",
    "ITEM_RING": "yuzuk",
    "ITEM_ROD": "olta",
    "ITEM_SKILLBOOK": "beceri kitabi",
    "ITEM_SKILLFORGET": "unutma kitabi",
    "ITEM_SOULITEM_PASSIVE": "pasif ruh esyasi",
    "ITEM_SPECIAL": "ozel",
    "ITEM_TREASURE_BOX": "anahtarli sandik",
    "ITEM_TREASURE_KEY": "sandik anahtari",
    "ITEM_UNIQUE": "ozel takilabilir",
    "ITEM_USE": "kullanilabilir",
}

ALT_TR = {
    "WEAPON_SWORD": "kilic",
    "WEAPON_TWO_HANDED": "cift el kilic",
    "WEAPON_DAGGER": "hancer",
    "WEAPON_BOW": "yay",
    "WEAPON_BELL": "can",
    "WEAPON_FAN": "yelpaze",
    "WEAPON_ARROW": "ok",
    "ARMOR_BODY": "zirh",
    "ARMOR_HEAD": "kask",
    "ARMOR_SHIELD": "kalkan",
    "ARMOR_WRIST": "bilezik",
    "ARMOR_FOOTS": "ayakkabi",
    "ARMOR_NECK": "kolye",
    "ARMOR_EAR": "kupe",
    "ARMOR_PENDANT": "tilsim",
    "COSTUME_BODY": "kostum",
    "COSTUME_HAIR": "sac",
    "COSTUME_WEAPON": "silah gorunumu",
    "COSTUME_ACCE": "omuz kusagi",
    "COSTUME_MOUNT": "binek gorunumu",
    "USE_POTION": "iksir",
    "USE_POTION_NODELAY": "iksir",
    "USE_POTION_CONTINUE": "iksir",
    "USE_TALISMAN": "isin parscmensi",
    "USE_TUNING": "basim parscmensi",
    "USE_BAIT": "yem",
    "USE_ADD_ATTRIBUTE": "efsun ekleme",
    "USE_CHANGE_ATTRIBUTE": "efsun degistirme",
    "USE_ADD_ATTRIBUTE2": "6/7 efsun ekleme",
    "USE_CHANGE_ATTRIBUTE2": "6/7 efsun degistirme",
    "USE_CLEAN_SOCKET": "tasi sokme",
    "USE_DETACHMENT": "tasi sokme",
    "USE_PUT_INTO_ACCESSORY_SOCKET": "cevher",
    "USE_ADD_ACCESSORY_SOCKET": "cevher yuvasi",
    "USE_ABILITY_UP": "statu etkisi",
    "USE_AFFECT": "sureli etki",
    "METIN_NORMAL": "ruh tasi",
    "FISH_ALIVE": "canli balik",
    "FISH_DEAD": "olu balik",
    "MATERIAL_LEATHER": "malzeme",
}

APPLY_TR = {
    "APPLY_ATT_SPEED": "saldiri hizi",
    "APPLY_MOV_SPEED": "hareket hizi",
    "APPLY_MAX_HP": "maks. can",
    "APPLY_MAX_SP": "maks. SP",
    "APPLY_HP_REGEN": "can yenileme",
    "APPLY_SP_REGEN": "SP yenileme",
    "APPLY_DEF_GRADE_BONUS": "savunma",
    "APPLY_ATT_GRADE_BONUS": "saldiri",
    "APPLY_CRITICAL_PCT": "kritik vurus",
    "APPLY_PENETRATE_PCT": "delici vurus",
    "APPLY_ATTBONUS_HUMAN": "insanlara karsi guc",
    "APPLY_STEAL_HP": "can emme",
    "APPLY_STEAL_SP": "SP emme",
    "APPLY_POISON_PCT": "zehirleme",
    "APPLY_STUN_PCT": "sersemletme",
    "APPLY_SLOW_PCT": "yavaslatma",
    "APPLY_BLOCK": "blok",
    "APPLY_DODGE": "kacinma",
    "APPLY_RESIST_SWORD": "kilic direnci",
    "APPLY_RESIST_BOW": "yay direnci",
    "APPLY_RESIST_MAGIC": "buyu direnci",
    "APPLY_EXP_DOUBLE_BONUS": "tecrube bonusu",
    "APPLY_GOLD_DOUBLE_BONUS": "yang bonusu",
    "APPLY_ITEM_DROP_BONUS": "dusus bonusu",
    "APPLY_STR": "guc (STR)",
    "APPLY_DEX": "ceviklik (DEX)",
    "APPLY_INT": "zeka (INT)",
    "APPLY_CON": "dayaniklilik (CON)",
    "APPLY_SKILL_DAMAGE_BONUS": "beceri hasari",
    "APPLY_NORMAL_HIT_DAMAGE_BONUS": "ortalama hasar",
    "APPLY_CAST_SPEED": "beceri hizi",
    "APPLY_RESIST_FIRE": "ates direnci",
    "APPLY_RESIST_ICE": "buz direnci",
    "APPLY_RESIST_ELEC": "simsek direnci",
    "APPLY_RESIST_WIND": "ruzgar direnci",
    "APPLY_RESIST_DARK": "karanlik direnci",
    "APPLY_RESIST_HUMAN": "insan direnci",
    "APPLY_NONE": "",
}

MESLEK_ANTI = (
    ("savasci", "ANTI_MUSA"),
    ("ninja", "ANTI_ASSASSIN"),
    ("sura", "ANTI_SURA"),
    ("saman", "ANTI_MUDANG"),
)

MESLEKLER = {
    0: ("Savasci", "Bedensel", "Zihinsel", "kilic, cift el kilic"),
    1: ("Ninja", "Yakin", "Uzak", "hancer, yay"),
    2: ("Sura", "Buyulu silah", "Kara buyu", "kilic"),
    3: ("Saman", "Ejderha yardimi", "Iyilestirme", "can, yelpaze"),
}

RANK_TR = {
    "PAWN": "sira disi / siradan",
    "S_PAWN": "guclu surum",
    "KNIGHT": "grup lideri",
    "S_KNIGHT": "metinlerin sik kullandigi rutbe",
    "BOSS": "boss",
    "KING": "dunya boss'u",
}

MOB_TUR_TR = {
    "MONSTER": "yaratik",
    "STONE": "metin tasi",
    "NPC": "NPC",
    "WARP": "isin kapisi",
    "GOTO": "isin kapisi",
    "DOOR": "kapi",
    "BUILDING": "lonca binasi",
    "HORSE": "binek",
    "PC": "donusum hedefi",
    "POLYMORPH_PC": "donusum hedefi",
}

IMPARATORLUK = {
    "a": "Shinsoo",
    "b": "Chunjo",
    "c": "Jinno",
}

ETKINLIK_INDEX = {81, 112, 113, 114, 181, 182, 183}
LONCA_INDEX = {4, 24, 44, 250, 6, 26, 46}

# zindan katalogu: kod -> (ad, index listesi, feature kapi, gorev dosyasi)
ZINDANLAR = (
    ("maymun", "Maymun Zindani", (107, 108, 109), "core", None),
    ("kule", "Seytan Kulesi", (66,), "core", "dungeons/deviltower_zone.quest"),
    ("orumcek1", "Orumcek Zindani 1", (104,), "core", None),
    ("orumcek2", "Orumcek Zindani 2", (71,), "core", "systems/warps/spider_dungeon_2floor.quest"),
    ("orumcek3", "Orumcek Zindani 3", (217,), "spider3", None),
    ("surgun", "Surgun Magarasi", (72, 73, 208), "core", None),
    ("katakomb", "Seytan Katakombu", (216,), "catacomb", "dungeons/devilcatacomb_zone.quest"),
    ("razador", "Kizil Ejderha Kalesi", (351, 364), "razador", "dungeons/flame_dungeon.quest"),
    ("nemere", "Nemere Gozlemevi", (352, 367), "nemere", None),
    ("ochao", "Ochao Tapinagi", (210,), "ochao", None),
    ("meley", "Meley'in Ini", (212,), "meley", None),
    ("hidra", "Gemi Savunmasi", (355, 356), "hydra", None),
    ("zodyak", "Zodyak Tapinagi", (358,), "zodiac", None),
)

# gorev dosya adi -> feature kapi (kapaliysa sayfa kilitli rozetli)
def gorev_feature(ad):
    if ad.startswith("dragon_soul"):
        return "dragon_soul"
    if ad.startswith("energy_system"):
        return "energy"
    if ad.startswith("sash"):
        return "sash"
    if ad.startswith("devilcatacomb"):
        return "catacomb"
    if ad.startswith("flame_dungeon"):
        return "razador"
    if ad.startswith("pet_system"):
        return "level_pet"
    return None


def gorev_tur(ad):
    for onek, tur in (
        ("main_quest_flame_lv", "alev hatti ana gorev"),
        ("main_quest_lv", "ana gorev"),
        ("new_quest_lv", "yan gorev"),
        ("subquest_", "yan gorev"),
        ("collect_quest_lv", "biyolog"),
        ("collect_herb_lv", "bitki gorevi"),
        ("horse_", "at"),
        ("pony_", "at"),
        ("ride", "at"),
        ("guild_", "lonca"),
        ("marriage_", "evlilik"),
        ("couple_", "evlilik"),
        ("deviltower_", "zindan"),
        ("devilcatacomb_", "zindan"),
        ("spider_dungeon_", "zindan"),
        ("dragon_lair", "zindan"),
        ("flame_dungeon", "zindan"),
        ("christmas_", "etkinlik"),
        ("event_", "etkinlik"),
        ("oxevent", "etkinlik"),
        ("forked_road", "etkinlik"),
        ("skill_group", "beceri"),
        ("skill_reset", "beceri"),
        ("cube", "kup"),
        ("mining", "maden"),
        ("fisher", "balikci"),
        ("blacksmith", "demirci"),
        ("give_basic_weapon", "baslangic"),
        ("map_warp", "isin"),
        ("neutral_warp", "isin"),
        ("goto_empire_castle", "isin"),
        ("ring_warp", "isin"),
        ("check_trans_ticket", "isin"),
    ):
        if ad.startswith(onek):
            return tur
    return "sistem"


# ----------------------------------------------------------------------
# kaynak okuma
# ----------------------------------------------------------------------


def kaynaklari_oku():
    k = {}

    kayitlar, enc = tablo_oku(DB / "item_proto.txt")
    items = {}
    aralik = 0
    for r in kayitlar:
        v = r.get("ITEM_VNUM~RANGE", "").strip()
        if "~" in v:
            # aralik satiri: sayfa taban vnum'a acilir, aralik ham olarak
            # sunucu tablosunda durur
            a, _, b = v.partition("~")
            if a.isdigit() and b.isdigit():
                items.setdefault(int(a), r)
                aralik += 1
        elif v.isdigit():
            items[int(v)] = r
    k["items"] = items
    k["item_aralik"] = aralik
    k["item_enc"] = enc

    k["item_names"] = isim_oku(DB / "item_names.txt")

    kayitlar, _ = tablo_oku(DB / "mob_proto.txt")
    mobs = {}
    for r in kayitlar:
        v = r.get("VNUM", "").strip()
        if v.isdigit():
            mobs[int(v)] = r
    k["mobs"] = mobs
    k["mob_names"] = isim_oku(DB / "mob_names.txt")

    # map/index
    index = {}
    metin, _ = oku(MAP_DIR / "index")
    for satir in metin.splitlines():
        alan = satir.split()
        if len(alan) >= 2 and alan[0].isdigit():
            index[int(alan[0])] = alan[1]
    k["map_index"] = index

    # harita klasor icerigi
    harita = {}
    for idx, klasor in index.items():
        klasor_yol = MAP_DIR / klasor
        if not klasor_yol.is_dir():
            harita[idx] = {"klasor": klasor, "klasor_yok": True}
            continue
        bilgi = {"klasor": klasor, "klasor_yok": False}
        setting = klasor_yol / "Setting.txt"
        if setting.is_file():
            metin, _ = oku(setting)
            m = re.search(r"MapSize\s+(\d+)\s+(\d+)", metin)
            if m:
                bilgi["mapsize"] = (int(m.group(1)), int(m.group(2)))
            m = re.search(r"BasePosition\s+(\d+)\s+(\d+)", metin)
            if m:
                bilgi["base"] = (int(m.group(1)), int(m.group(2)))
        town = klasor_yol / "Town.txt"
        if town.is_file():
            metin, _ = oku(town)
            koord = re.findall(r"(\d+)\s+(\d+)", metin)
            bilgi["town"] = [(int(x), int(y)) for x, y in koord]
        for dosya in ("regen", "npc", "boss", "stone"):
            yol = klasor_yol / (dosya + ".txt")
            satirlar = []
            if yol.is_file():
                metin, _ = oku(yol)
                for satir in metin.splitlines():
                    satir = satir.strip()
                    if not satir or satir.startswith("//"):
                        continue
                    alan = satir.split("\t")
                    if len(alan) < 2:
                        alan = satir.split()
                    if len(alan) >= 2 and alan[0] in ("r", "m", "g", "gd"):
                        vnum = alan[-1].strip()
                        if vnum.isdigit():
                            satirlar.append((alan[0], int(vnum), alan))
            bilgi[dosya] = satirlar
        harita[idx] = bilgi
    k["harita"] = harita

    # group.txt: regen 'g' satirlarinin grup cozumu
    grup_vnum = {}
    yol = LOCALE / "group.txt"
    if yol.is_file():
        metin, _ = oku(yol)
        g_ad = None
        g_vnum = None
        uyeler = []
        for satir in metin.splitlines():
            s = satir.strip()
            m = re.match(r"Group\s+(\S+)", s)
            if m:
                g_ad = m.group(1)
                g_vnum = None
                uyeler = []
                continue
            m = re.match(r"Vnum\s+(\d+)", s)
            if m and g_ad:
                g_vnum = int(m.group(1))
                grup_vnum[g_vnum] = {"ad": g_ad, "uyeler": uyeler}
                continue
            m = re.match(r"\d+\s+\S+\s+(\d+)", s)
            if m and g_vnum is not None:
                uyeler.append(int(m.group(1)))
            m = re.match(r"Leader\s+\S+\s+(\d+)", s)
            if m and g_ad:
                grup_vnum.setdefault(g_vnum or -1, {"ad": g_ad, "uyeler": uyeler})
                if g_vnum is not None:
                    grup_vnum[g_vnum]["leader"] = int(m.group(1))
    k["grup_vnum"] = grup_vnum

    # dusus dosyalari: bos dosya "dusus grubu bos" notu
    dusus = {"bos": [], "vnumlar": set(), "satir": {}}
    for ad in ("mob_drop_item.txt", "common_drop_item.txt", "etc_drop_item.txt",
               "drop_item_group.txt", "special_item_group.txt"):
        yol = LOCALE / ad
        if not yol.is_file() or yol.stat().st_size == 0:
            dusus["bos"].append(ad)
            continue
        metin, _ = oku(yol)
        vnumlar = set()
        for satir in metin.splitlines():
            for tok in re.findall(r"\d+", satir):
                v = int(tok)
                if v in items:
                    vnumlar.add(v)
        dusus["vnumlar"] |= vnumlar
        dusus["satir"][ad] = vnumlar
    k["dusus"] = dusus

    # cube.txt ve blend.txt: vnum uye listesi (bag icin)
    for ad in ("cube.txt", "blend.txt", "fishing.txt", "dragon_soul_table.txt"):
        yol = LOCALE / ad
        if not yol.is_file() or yol.stat().st_size == 0:
            continue
        metin, _ = oku(yol)
        k[ad] = {int(t) for t in re.findall(r"\d+", metin) if int(t) in items}

    # shop_table_ex.txt: Group ShopNPC npc->grup adi; Group <ad> icindeki
    # "sira vnum adet fiyat" satirlari o npc'ye baglanir.
    shop_npc = {}
    yol = LOCALE / "shop_table_ex.txt"
    if yol.is_file():
        metin, _ = oku(yol)
        npc_grup = {}
        grup_esya = {}
        blok_ad = None
        for satir in metin.splitlines():
            s = satir.strip()
            m = re.match(r"Group\s+(\S+)", s)
            if m:
                blok_ad = m.group(1)
                continue
            if blok_ad == "ShopNPC":
                m = re.match(r"\d+\s+(\d+)\s+(\S+)", s)
                if m:
                    npc_grup.setdefault(int(m.group(1)), []).append(m.group(2))
            else:
                m = re.match(r"\d+\s+(\d+)\s+\d+\s+\d+", s)
                if m and blok_ad:
                    grup_esya.setdefault(blok_ad, set()).add(int(m.group(1)))
        for npc_v, gruplar in npc_grup.items():
            for g in gruplar:
                shop_npc.setdefault(npc_v, set()).update(grup_esya.get(g, set()))
    k["shop_npc"] = shop_npc

    # quest_list: etkin (isaretlenmemis) gorev dosyalari
    etkin = []
    metin, _ = oku(QUEST_DIR / "quest_list")
    for satir in metin.splitlines():
        s = satir.strip()
        if not s or s.startswith("#"):
            continue
        etkin.append(s)
    k["quest_etkin"] = etkin

    quests = []
    for rel in etkin:
        yol = QUEST_DIR / rel
        if not yol.is_file():
            quests.append({"dosya": rel, "yok": True})
            continue
        metin, _ = oku(yol)
        ad = Path(rel).stem
        q = {"dosya": rel, "ad": ad, "yok": False}
        # seviye sarti: dosyadaki ilk seviye kiyaslamasi giris kapisidir;
        # '--' ile basan yorum satirlari sayilmaz
        q["level_min"] = None
        temiz = "\n".join(s for s in metin.splitlines()
                          if not s.lstrip().startswith("--"))
        for m in re.finditer(
                r"pc\.(?:level|get_level\(\))\s*(>=|<)\s*(\d+)", temiz):
            q["level_min"] = int(m.group(2))
            break
        q["states"] = re.findall(r"state\s+(\w+)\s+begin", metin)
        q["when"] = sorted(set(
            re.findall(r"when\s+(?:\w+\.)?(\w+)", metin)))
        q["count_item"] = sorted(set(int(x) for x in re.findall(
            r"pc\.count_item\(\s*[\"']?(\d+)", metin)))
        q["give_item"] = sorted(set(int(x) for x in re.findall(
            r"pc\.give_item2?\(\s*[\"']?(\d+)", metin)))
        q["remove_item"] = sorted(set(int(x) for x in re.findall(
            r"pc\.remove_item\(\s*[\"']?(\d+)", metin)))
        q["say_item"] = sorted(set(int(x) for x in re.findall(
            r"say_item_vnum\(\s*(\d+)", metin)))
        q["use_item"] = sorted(set(int(x) for x in re.findall(
            r"when\s+(\d+)\.use", metin)))
        q["kill"] = sorted(set(int(x) for x in re.findall(
            r"when\s+(\d+)\.kill", metin)))
        q["chat"] = sorted(set(int(x) for x in re.findall(
            r"when\s+(\d+)\.chat", metin)))
        q["find_npc"] = sorted(set(int(x) for x in re.findall(
            r"find_npc_by_vnum\(\s*(\d+)", metin)))
        q["warp_index"] = []
        for m in re.finditer(r"pc\.warp\(([^)]*)\)", metin):
            parcalar = [p.strip() for p in m.group(1).split(",")]
            if len(parcalar) >= 3 and parcalar[2].isdigit():
                q["warp_index"].append(int(parcalar[2]))
        quests.append(q)
    k["quests"] = quests

    # istemci item_list vnumlari
    def item_list_vnum(yol):
        out = set()
        if not yol.is_file():
            return None
        metin, _ = oku(yol)
        for satir in metin.splitlines():
            alan = satir.split("\t")
            if alan and alan[0].strip().isdigit():
                out.add(int(alan[0].strip()))
        return out

    k["item_list_srcs"] = item_list_vnum(CLIENT_ITEM_LIST)
    k["item_list_pack"] = item_list_vnum(CLIENT_PACK_ITEM_LIST)

    # istemci locale_game MAP_ adlari
    map_ad = {}
    if CLIENT_LOCALE_GAME.is_file():
        metin, _ = oku(CLIENT_LOCALE_GAME)
        for satir in metin.splitlines():
            alan = satir.rstrip("\n").split("\t")
            if len(alan) >= 2 and alan[0].startswith("MAP_"):
                map_ad[alan[0][4:]] = alan[1].strip()
    k["map_ad"] = map_ad

    # profiller: yaml + profile.conf
    profiller = {}
    uyari = []
    for p in PROFILLER:
        yaml_yol = WIKI / "profiller" / (p + ".yaml")
        conf_yol = ROOT / "server" / "profiles" / p / "profile.conf"
        y = yaml_oku(yaml_yol)
        c = conf_oku(conf_yol)
        y_map = [int(x) for x in y.get("map_allow", []) if str(x).strip().isdigit()]
        c_map = [int(x) for x in c.get("map_allow", "").split() if x.isdigit()]
        y_feat = sorted(str(x) for x in y.get("features", []))
        c_feat = sorted(x for x in c.get("features", "").split(",") if x)
        if y_map != c_map:
            uyari.append("%s: yaml map_allow != conf map_allow" % p)
        if y_feat != c_feat:
            uyari.append("%s: yaml features != conf features" % p)
        if str(y.get("level_cap")) != c.get("level_cap"):
            uyari.append("%s: yaml level_cap != conf level_cap" % p)
        if str(y.get("attr_slots")) != c.get("attr_slots"):
            uyari.append("%s: yaml attr_slots != conf attr_slots" % p)
        profiller[p] = {
            "level_cap": int(c.get("level_cap") or y.get("level_cap") or 0),
            "attr_slots": int(c.get("attr_slots") or y.get("attr_slots") or 0),
            "features": set(c_feat),
            "map_allow": set(c_map),
            "ozet": y.get("ozet", ""),
        }
    k["profiller"] = profiller
    k["profil_uyari"] = uyari

    return k


def map_adi(k, idx):
    klasor = k["map_index"].get(idx, "")
    if not klasor:
        return ""
    for onek in ("metin2_map_", "Metin2_map_", "metin2_", "map_", "metin2_guild_", "gm_"):
        if klasor.startswith(onek):
            ad = k["map_ad"].get(klasor[len(onek):].upper())
            if ad:
                return ad
    ad = k["map_ad"].get(klasor.upper())
    if ad:
        return ad
    return klasor


def harita_moblari(k, idx):
    """Haritadaki mob vnum kumesini regen/npc/boss/stone'dan cozer.
    'g' satirlari group.txt Vnum uzerinden uyelere acilir."""
    bilgi = k["harita"].get(idx)
    if not bilgi or bilgi.get("klasor_yok"):
        return {}, {}, {}, {}
    regen, npc, boss, stone = set(), set(), set(), set()
    for tur, hedef in (("regen", regen), ("npc", npc), ("boss", boss), ("stone", stone)):
        for tip, vnum, _alan in bilgi.get(tur, []):
            if tip in ("r", "m"):
                hedef.add(vnum)
            elif tip in ("g", "gd"):
                grup = k["grup_vnum"].get(vnum)
                if grup and grup["uyeler"]:
                    hedef.update(grup["uyeler"])
                elif grup and grup.get("leader"):
                    hedef.add(grup["leader"])
                else:
                    hedef.add(vnum)
    return regen, npc, boss, stone


def mob_haritalari(k):
    """mob vnum -> dogdugu harita indexleri."""
    out = {}
    for idx in k["map_index"]:
        regen, npc, boss, stone = harita_moblari(k, idx)
        for v in regen | npc | boss | stone:
            out.setdefault(v, set()).add(idx)
    return out


def anlati(tur, kimlik):
    yol = WIKI / "anlati" / tur / (str(kimlik) + ".md")
    if yol.is_file():
        metin, _ = oku(yol)
        if metin.strip():
            return metin.strip()
    return None


def antiflag_coz(flag):
    tokenlar = {t.strip() for t in flag.split("|")} if flag else set()
    giyemez = {ad for ad, tok in MESLEK_ANTI if tok in tokenlar}
    giyer = [ad for ad, tok in MESLEK_ANTI if ad not in giyemez]
    cinsiyet = ""
    if "ANTI_MALE" in tokenlar:
        cinsiyet = "yalniz kadin"
    elif "ANTI_FEMALE" in tokenlar:
        cinsiyet = "yalniz erkek"
    ticaret = []
    if "ANTI_DROP" in tokenlar:
        ticaret.append("yere atilamaz")
    if "ANTI_SELL" in tokenlar:
        ticaret.append("NPC'ye satilamaz")
    if "ANTI_GIVE" in tokenlar:
        ticaret.append("takaslanamaz")
    if "ANTI_MYSHOP" in tokenlar:
        ticaret.append("pazara konamaz")
    return giyer, cinsiyet, ticaret


def sayi(s):
    try:
        return int(s)
    except (TypeError, ValueError):
        return 0


# ----------------------------------------------------------------------
# sayfa sablonlari
# ----------------------------------------------------------------------


def sayfa_baslik(ad, kimlik, profil, tur):
    return "# %s\n\nProfil: `%s` | Tur: `%s` | Kimlik: `%s`\n\n" % (
        ad, profil, tur, kimlik)


def esya_sayfasi(k, profil, feat, vnum, r):
    ad = k["item_names"].get(vnum) or "ad okunamadi"
    tur = r.get("ITEM_TYPE", "")
    alt = r.get("SUB_TYPE", "")
    satirlar = [sayfa_baslik(ad, vnum, profil, "esya")]

    gereken = esya_feature(tur, alt)
    if gereken and gereken not in feat:
        satirlar.append("> **Kilitli:** bu esya turu (%s) %s profilinde kapali.\n\n"
                        % (FEATURE_TR.get(gereken, gereken), profil))

    an = anlati("esya", vnum)
    if an:
        satirlar.append(an + "\n\n")

    # oyuncu kutusu
    giyer, cinsiyet, ticaret = antiflag_coz(r.get("ANTI_FLAG", ""))
    seviye = ""
    for i in ("0", "1"):
        if r.get("LIMIT_TYPE" + i) == "LEVEL" and sayi(r.get("LIMIT_VALUE" + i)):
            seviye = r["LIMIT_VALUE" + i]
    oyuncu = ["## Oyuncu\n\n"]
    cumle = []
    if seviye:
        cumle.append("%s. seviye" % seviye)
    if giyer and len(giyer) < 4:
        cumle.append(", ".join(giyer))
    if tur == "ITEM_WEAPON" and alt in ALT_TR:
        cumle.append(ALT_TR[alt])
    elif tur in TUR_TR:
        cumle.append(TUR_TR[tur])
    if cumle:
        oyuncu.append("- Tur: %s\n" % ", ".join(cumle))
    oyuncu.append("- Ad: %s\n" % ad)
    oyuncu.append("- Tur/alt tur: `%s` / `%s`\n" % (tur, alt))
    if seviye:
        oyuncu.append("- Seviye siniri: %s\n" % seviye)
    if cinsiyet:
        oyuncu.append("- Cinsiyet: %s\n" % cinsiyet)
    if giyer:
        oyuncu.append("- Giyebilen meslekler: %s\n" % ", ".join(giyer))
    if ticaret:
        oyuncu.append("- Ticaret: %s\n" % ", ".join(ticaret))
    socket = sayi(r.get("SOCKET"))
    if socket:
        oyuncu.append("- Tas yuvasi: %d\n" % min(socket, 3))
    if sayi(r.get("SIZE")):
        oyuncu.append("- Envanter boyu: %s\n" % r["SIZE"])
    if sayi(r.get("GOLD")):
        oyuncu.append("- NPC alis fiyati: %s yang\n" % r["GOLD"])
    if sayi(r.get("SHOP_BUY_PRICE")):
        oyuncu.append("- NPC satis fiyati: %s yang\n" % r["SHOP_BUY_PRICE"])

    # sabit bonuslar
    bonus = []
    for i in ("0", "1", "2"):
        at = r.get("ADDON_TYPE" + i, "")
        av = r.get("ADDON_VALUE" + i, "0")
        if at and at != "APPLY_NONE":
            bonus.append("%s %s (`%s`)" % (APPLY_TR.get(at, at), av, at))
    if bonus:
        oyuncu.append("- Sabit bonuslar: %s\n" % "; ".join(bonus))

    # ture gore value cumlesi
    if tur == "ITEM_WEAPON":
        v = [sayi(r.get("VALUE" + str(i))) for i in range(6)]
        oyuncu.append("- Saldiri degeri: %d-%d (fiziksel), %d-%d (sihirli)\n"
                      % (v[3] + v[5], v[4] + v[5], v[1] + v[5], v[2] + v[5]))
    elif tur == "ITEM_ARMOR" and alt in ("ARMOR_BODY", "ARMOR_HEAD", "ARMOR_SHIELD",
                                         "ARMOR_FOOTS", "ARMOR_WRIST"):
        oyuncu.append("- Savunma: %d\n"
                      % (sayi(r.get("VALUE1")) + sayi(r.get("VALUE5")) * 2))

    # arti zinciri
    rafine = sayi(r.get("REFINE"))
    if rafine:
        hedef = k["item_names"].get(rafine) or "ad okunamadi"
        oyuncu.append("- Arti zinciri: +basim -> [%s](../esya/%d.md)\n"
                      % (hedef, rafine))

    # dusus
    if vnum in k["dusus"]["vnumlar"]:
        oyuncu.append("- Nereden duser: ortak dusus tablosunda kayitli\n")
    else:
        oyuncu.append("- Nereden duser: dusus dosyalarinda kayit yok"
                      " (mob_drop_item.txt bos)\n")

    # kup / shop
    if vnum in k.get("cube.txt", set()):
        oyuncu.append("- Kup: cube.txt icerisinde tarif satiri var\n")
    satan = [n for n, vs in k["shop_npc"].items() if vnum in vs]
    if satan:
        adlar = ", ".join(k["mob_names"].get(n, str(n)) for n in sorted(satan))
        oyuncu.append("- Satan NPC: %s\n" % adlar)

    satirlar.append("".join(oyuncu) + "\n")

    # sunucu tablosu: proto satirinin tamami
    sunucu = ["## Sunucu\n\n| Alan | Deger |\n| --- | --- |\n"]
    for anahtar, deger in r.items():
        sunucu.append("| `%s` | `%s` |\n" % (anahtar, deger))
    if "MIN_PROFILE" not in r:
        sunucu.append("| `min_profile` | proto'da yok; varsayilan 99 |\n")
    satirlar.append("".join(sunucu) + "\n")

    # gelistirici
    gel = ["<details><summary>Gelistirici</summary>\n\n"]
    gel.append("- Proto satiri: `server/db/item_proto.txt`\n")
    gel.append("- Ad kaynagi: `server/db/item_names.txt`\n")
    if k["item_list_srcs"] is not None:
        gel.append("- Istemci item_list (Srcs/tr): %s\n"
                   % ("vnum kayitli" if vnum in k["item_list_srcs"] else "vnum yok"))
    gel.append("- Ikili istemci proto ayristirilmadi.\n")
    gel.append("</details>\n")
    satirlar.append("".join(gel))
    return "".join(satirlar)


def yaratik_sayfasi(k, profil, feat, vnum, r, dogma):
    ad = k["mob_names"].get(vnum) or "ad okunamadi"
    tur = r.get("TYPE", "")
    satirlar = [sayfa_baslik(ad, vnum, profil, "yaratik")]

    an = anlati("esya", vnum)  # anlati dizinleri: esya/rehber/zindan
    if an:
        satirlar.append(an + "\n\n")

    oyuncu = ["## Oyuncu\n\n"]
    oyuncu.append("- Ad: %s\n" % ad)
    oyuncu.append("- Tur: %s\n" % MOB_TUR_TR.get(tur, tur or "?"))
    rutbe = r.get("RANK", "")
    if rutbe:
        oyuncu.append("- Rutbe: %s\n" % RANK_TR.get(rutbe, rutbe))
    if sayi(r.get("LEVEL")):
        oyuncu.append("- Seviye: %s\n" % r["LEVEL"])
    if r.get("RACE_FLAG") and r["RACE_FLAG"] != "0":
        oyuncu.append("- Irk bayraklari: `%s`\n" % r["RACE_FLAG"])
    if r.get("BATTLE_TYPE"):
        oyuncu.append("- Saldiri turu: `%s`\n" % r["BATTLE_TYPE"])
    if sayi(r.get("MAX_HP")):
        oyuncu.append("- Can: %s\n" % r["MAX_HP"])
    if sayi(r.get("DAMAGE_MIN")) or sayi(r.get("DAMAGE_MAX")):
        oyuncu.append("- Hasar: %s-%s\n" % (r.get("DAMAGE_MIN", "0"),
                                            r.get("DAMAGE_MAX", "0")))
    if sayi(r.get("DEF")):
        oyuncu.append("- Savunma: %s\n" % r["DEF"])
    if sayi(r.get("EXP")):
        oyuncu.append("- Tecrube: %s\n" % r["EXP"])
    if sayi(r.get("GOLD_MIN")) or sayi(r.get("GOLD_MAX")):
        oyuncu.append("- Yang: %s-%s\n" % (r.get("GOLD_MIN", "0"), r.get("GOLD_MAX", "0")))

    # direncler (sifirdan buyuk)
    direnc = []
    for anahtar, deger in r.items():
        if anahtar.startswith("RESIST_") and sayi(deger) > 0:
            direnc.append("`%s` %s" % (anahtar, deger))
    if direnc:
        oyuncu.append("- Direncler: %s\n" % ", ".join(direnc))

    # nerede dogar
    haritalar = sorted(dogma.get(vnum, set()))
    if haritalar:
        parca = []
        for idx in haritalar:
            adh = map_adi(k, idx)
            kapali = "" if idx in k["profiller"][profil]["map_allow"] else " (bu profilde kapali)"
            parca.append("%s`%d`" % ((adh + " " if adh else ""), idx) + kapali)
        oyuncu.append("- Nerede dogar: %s\n" % ", ".join(parca))
    else:
        oyuncu.append("- Nerede dogar: regen kaydi yok\n")

    if "mob_drop_item.txt" in k["dusus"]["bos"]:
        oyuncu.append("- Dusenler: mob_drop_item.txt bos; yaraticina ozel dusus kaydi yok\n")

    raf = sayi(r.get("RESURRECTION_VNUM"))
    if raf:
        oyuncu.append("- Olunce dogan ikinci asama: `%d`\n" % raf)
    pol = sayi(r.get("POLYMORPH_ITEM"))
    if pol:
        polad = k["item_names"].get(pol) or "ad okunamadi"
        oyuncu.append("- Donusum kuresi: [%s](../esya/%d.md)\n" % (polad, pol))
    satirlar.append("".join(oyuncu) + "\n")

    sunucu = ["## Sunucu\n\n| Alan | Deger |\n| --- | --- |\n"]
    for anahtar, deger in r.items():
        sunucu.append("| `%s` | `%s` |\n" % (anahtar, deger))
    satirlar.append("".join(sunucu) + "\n")

    gel = ["<details><summary>Gelistirici</summary>\n\n"]
    gel.append("- Proto satiri: `server/db/mob_proto.txt`\n")
    gel.append("- Ad kaynagi: `server/db/mob_names.txt`\n")
    gel.append("- Regen kaynagi: `map/<klasor>/{regen,npc,boss,stone}.txt`,"
               " grup satirlari `group.txt`\n")
    gel.append("</details>\n")
    satirlar.append("".join(gel))
    return "".join(satirlar)


def harita_sayfasi(k, profil, feat, idx):
    bilgi = k["harita"][idx]
    ad = map_adi(k, idx)
    satirlar = [sayfa_baslik(ad or bilgi["klasor"], idx, profil, "harita")]

    if bilgi.get("klasor_yok"):
        satirlar.append("> **Kirik:** index %d icin map klasoru yok: `%s`\n\n"
                        % (idx, bilgi["klasor"]))
        return "".join(satirlar)

    an = anlati("esya", idx)
    if an:
        satirlar.append(an + "\n\n")

    oyuncu = ["## Oyuncu\n\n"]
    oyuncu.append("- Gorunen ad: %s\n" % (ad or "ad okunamadi"))
    if idx in ETKINLIK_INDEX:
        oyuncu.append("- Sinif: etkinlik haritasi; yaratik avlama yeri degil\n")
    elif idx in LONCA_INDEX:
        oyuncu.append("- Sinif: lonca arazisi\n")

    regen, npc, boss, stone = harita_moblari(k, idx)

    # seviye bandi: dogan yaratiklarin mob_proto.level'i
    seviyeler = [sayi(k["mobs"][v].get("LEVEL")) for v in regen | boss
                 if v in k["mobs"] and sayi(k["mobs"][v].get("LEVEL"))]
    if seviyeler:
        oyuncu.append("- Seviye bandi: %d-%d (regen/boss yaratiklarindan)\n"
                      % (min(seviyeler), max(seviyeler)))

    if bilgi.get("town"):
        oyuncu.append("- Kasaba koordinati: %s\n"
                      % ", ".join("(%d,%d)" % t for t in bilgi["town"][:4]))

    def mob_satirlari(vnumlar):
        parca = []
        for v in sorted(vnumlar):
            mad = k["mob_names"].get(v) or str(v)
            parca.append("[%s](../yaratik/%d.md)" % (mad, v))
        return ", ".join(parca)

    if regen:
        oyuncu.append("- Dogan yaratiklar (%d tur): %s\n"
                      % (len(regen), mob_satirlari(regen)))
    if boss:
        oyuncu.append("- Boss (%d tur): %s\n" % (len(boss), mob_satirlari(boss)))
    if stone:
        oyuncu.append("- Metin taslari (%d tur): %s\n"
                      % (len(stone), mob_satirlari(stone)))
    if npc:
        oyuncu.append("- NPC (%d tur): %s\n" % (len(npc), mob_satirlari(npc)))
    satirlar.append("".join(oyuncu) + "\n")

    sunucu = ["## Sunucu\n\n| Alan | Deger |\n| --- | --- |\n"]
    sunucu.append("| `index` | `%d` |\n" % idx)
    sunucu.append("| `klasor` | `%s` |\n" % bilgi["klasor"])
    if bilgi.get("base"):
        sunucu.append("| `BasePosition` | `%d %d` |\n" % bilgi["base"])
    if bilgi.get("mapsize"):
        sunucu.append("| `MapSize` | `%d %d` |\n" % bilgi["mapsize"])
    for tur in ("regen", "npc", "boss", "stone"):
        sunucu.append("| `%s.txt satir` | `%d` |\n" % (tur, len(bilgi.get(tur, []))))
    sunucu.append("| `server_attr` | ikili dosya, okunmadi |\n")
    satirlar.append("".join(sunucu) + "\n")

    gel = ["<details><summary>Gelistirici</summary>\n\n"]
    gel.append("- Index: `server/share/locale/turkey/map/index`\n")
    gel.append("- Klasor: `map/%s/{Setting,Town,regen,npc,boss,stone}.txt`\n"
               % bilgi["klasor"])
    gel.append("- Ad: istemci `locale_game.txt` `MAP_*` satiri\n")
    gel.append("</details>\n")
    satirlar.append("".join(gel))
    return "".join(satirlar)


def zindan_sayfasi(k, profil, feat, kod, ad, indexler, kapi, gorev_dosya):
    satirlar = [sayfa_baslik(ad, kod, profil, "zindan")]

    an = anlati("zindan", kod)
    if an:
        satirlar.append(an + "\n\n")

    oyuncu = ["## Oyuncu\n\n"]
    oyuncu.append("- Ad: %s\n" % ad)
    acik_idx = [i for i in indexler if i in k["map_index"]]
    kapali_idx = [i for i in indexler if i not in k["profiller"][profil]["map_allow"]]
    oyuncu.append("- Index: %s\n" % ", ".join("`%d`" % i for i in indexler))

    seviye = None
    if gorev_dosya:
        for q in k["quests"]:
            if q.get("dosya") == gorev_dosya and q.get("level_min"):
                seviye = q["level_min"]
    if seviye:
        oyuncu.append("- Giris seviyesi: %d (gorev dosyasindan)\n" % seviye)
    else:
        oyuncu.append("- Giris seviyesi: gorev/dosya kaydinda yok\n")

    toplam_regen, toplam_boss, toplam_stone = 0, 0, 0
    moblar = set()
    for i in indexler:
        if i not in k["harita"] or k["harita"][i].get("klasor_yok"):
            continue
        regen, npc, boss, stone = harita_moblari(k, i)
        toplam_regen += len(k["harita"][i].get("regen", []))
        toplam_boss += len(k["harita"][i].get("boss", []))
        toplam_stone += len(k["harita"][i].get("stone", []))
        moblar |= regen | boss | stone
    if moblar:
        isimli = []
        for v in sorted(moblar):
            mad = k["mob_names"].get(v)
            if mad:
                isimli.append("[%s](../yaratik/%d.md)" % (mad, v))
        if isimli:
            oyuncu.append("- Yaratik ve boss turleri (%d): %s\n"
                          % (len(isimli), ", ".join(isimli)))
    satirlar.append("".join(oyuncu) + "\n")

    sunucu = ["## Sunucu\n\n| Alan | Deger |\n| --- | --- |\n"]
    sunucu.append("| `kod` | `%s` |\n" % kod)
    for i in indexler:
        klasor = k["map_index"].get(i, "index'te yok")
        sunucu.append("| `index %d` | `%s` |\n" % (i, klasor))
    if gorev_dosya:
        varmi = any(q.get("dosya") == gorev_dosya and not q.get("yok")
                    for q in k["quests"])
        sunucu.append("| `gorev dosyasi` | `%s` (%s) |\n"
                      % (gorev_dosya, "etkin" if varmi else "quest_list'te yok"))
    sunucu.append("| `regen/boss/stone satir` | `%d / %d / %d` |\n"
                  % (toplam_regen, toplam_boss, toplam_stone))
    sunucu.append("| `kapi` | feature `%s` |\n" % kapi)
    satirlar.append("".join(sunucu) + "\n")

    gel = ["<details><summary>Gelistirici</summary>\n\n"]
    gel.append("- Katalog: `tools/wiki-uret/uret.py` ZINDANLAR tablosu\n")
    gel.append("- Harita dosyalari: `map/<klasor>/`\n")
    if gorev_dosya:
        gel.append("- Gorev: `quest/%s`\n" % gorev_dosya)
    gel.append("</details>\n")
    satirlar.append("".join(gel))
    return "".join(satirlar)


def gorev_sayfasi(k, profil, feat, q):
    ad = q["ad"]
    satirlar = [sayfa_baslik(ad, ad, profil, "gorev")]

    gereken = gorev_feature(ad)
    if gereken and gereken not in feat:
        satirlar.append("> **Kilitli:** bu sistemin gorevi (%s) %s profilinde kapali.\n\n"
                        % (FEATURE_TR.get(gereken, gereken), profil))

    an = anlati("rehber", ad)
    if an:
        satirlar.append(an + "\n\n")

    oyuncu = ["## Oyuncu\n\n"]
    oyuncu.append("- Gorev: `%s`\n" % ad)
    oyuncu.append("- Tur: %s\n" % gorev_tur(ad))
    if q.get("level_min"):
        oyuncu.append("- Seviye sarti: %d\n" % q["level_min"])
    if q.get("find_npc") or q.get("chat"):
        npcs = sorted(set(q.get("find_npc", [])) | set(q.get("chat", [])))
        adlar = ", ".join(k["mob_names"].get(n, "`%d`" % n) for n in npcs)
        oyuncu.append("- NPC: %s\n" % adlar)
    if q.get("kill"):
        adlar = ", ".join(k["mob_names"].get(v, "`%d`" % v) for v in q["kill"])
        oyuncu.append("- Kesilecek yaratik: %s\n" % adlar)
    istenen = sorted(set(q["count_item"]) | set(q["say_item"]))
    if istenen:
        adlar = ", ".join(k["item_names"].get(v, "`%d`" % v) for v in istenen)
        oyuncu.append("- Istenen esya: %s\n" % adlar)
    satirlar.append("".join(oyuncu) + "\n")

    sunucu = ["## Sunucu\n\n| Alan | Deger |\n| --- | --- |\n"]
    sunucu.append("| `dosya` | `%s` |\n" % q["dosya"])
    sunucu.append("| `state` | %s |\n"
                  % ", ".join("`%s`" % s for s in q.get("states", [])))
    if q.get("when"):
        sunucu.append("| `olaylar` | %s |\n"
                      % ", ".join("`%s`" % s for s in q["when"]))
    for alan, etiket in (("count_item", "count_item"), ("give_item", "give_item"),
                         ("remove_item", "remove_item"), ("kill", "kill"),
                         ("chat", "chat"), ("warp_index", "warp index")):
        if q.get(alan):
            sunucu.append("| `%s` | %s |\n"
                          % (etiket, ", ".join("`%d`" % v for v in q[alan])))
    satirlar.append("".join(sunucu) + "\n")

    gel = ["<details><summary>Gelistirici</summary>\n\n"]
    gel.append("- Kaynak: `server/share/locale/turkey/quest/%s`\n" % q["dosya"])
    gel.append("- quest_list: etkin\n")
    gel.append("</details>\n")
    satirlar.append("".join(gel))
    return "".join(satirlar)


def biyolog_sayfasi(k, profil, feat):
    satirlar = [sayfa_baslik("Biyolog", "biyolog", profil, "biyolog")]

    an = anlati("rehber", "biyolog")
    if an:
        satirlar.append(an + "\n\n")

    satirlar.append("## Oyuncu\n\n")
    satirlar.append("Biyolog kademe tablosu. Satirlar `collect_quest_lv*` "
                    "gorev dosyalarindan okunur.\n\n")
    satirlar.append("| Seviye | NPC | Arastirma esyasi | Dusuren | Teslim araligi | Dosya |\n")
    satirlar.append("| --- | --- | --- | --- | --- | --- |\n")

    satirlar_sunucu = []
    for q in k["quests"]:
        if not q["ad"].startswith("collect_quest_lv"):
            continue
        m = re.search(r"lv(\d+)", q["ad"])
        lv = int(m.group(1)) if m else 0
        # 95+ satirlar yalniz 120 adresinde; dosya duruyorsa digerlerinde
        # "kapali" satiri basilir (plan 10 bolum 5.18)
        if lv >= 95 and profil != "120":
            satirlar_sunucu.append(
                "| `%s` | gorev dosyasi duruyor, bu profilde kapali |\n" % q["ad"])
            continue
        npc = (q["find_npc"] or q["chat"] or [None])[0]
        npc_ad = k["mob_names"].get(npc, "`%s`" % npc) if npc else "?"
        esya_v = (q["count_item"] or q["say_item"] or [None])[0]
        esya_ad = k["item_names"].get(esya_v, "`%s`" % esya_v) if esya_v else "?"
        dus = ", ".join(k["mob_names"].get(v, "`%d`" % v) for v in q["kill"]) or "?"
        dosya = q["dosya"]
        # teslim araligi: quest icerisinde duration saniye
        metin_yol = QUEST_DIR / q["dosya"]
        aralik = "?"
        if metin_yol.is_file():
            metin, _ = oku(metin_yol)
            m2 = re.search(r"duration\"\s*,\s*get_time\(\)\s*\+\s*(\d+)\s*\*\s*(\d+)\s*\*\s*(\d+)", metin)
            if m2:
                sn = int(m2.group(1)) * int(m2.group(2)) * int(m2.group(3))
                aralik = "%d saat" % round(sn / 3600)
        satirlar.append("| %d | %s | %s | %s | %s | `%s` |\n"
                        % (q["level_min"] or lv, npc_ad, esya_ad, dus, aralik, dosya))

    satirlar.append("\n")
    if satirlar_sunucu:
        satirlar.append("## Sunucu\n\n| Satir | Not |\n| --- | --- |\n")
        satirlar.append("".join(satirlar_sunucu) + "\n")

    gel = ["<details><summary>Gelistirici</summary>\n\n"]
    gel.append("- Kaynak: `quest/biology/collect_quest_lv*.quest`\n")
    gel.append("- 25. seviye bitki gorevi (`collect_herb_lv*`) bu tabloya yazilmaz.\n")
    gel.append("</details>\n")
    satirlar.append("".join(gel))
    return "".join(satirlar)


def meslek_sayfasi(k, profil, feat, job):
    ad, dal1, dal2, silah = MESLEKLER[job]
    satirlar = [sayfa_baslik(ad, job, profil, "meslek")]

    an = anlati("rehber", "meslek_%d" % job)
    if an:
        satirlar.append(an + "\n\n")

    anti = MESLEK_ANTI[job][1]
    oyuncu = ["## Oyuncu\n\n"]
    oyuncu.append("- Meslek: %s (`job` %d)\n" % (ad, job))
    oyuncu.append("- Dallar: %s (`/dal/%d/1`), %s (`/dal/%d/2`)\n"
                  % (dal1, job, dal2, job))
    oyuncu.append("- Silah alt turu: %s\n" % silah)
    oyuncu.append("- Dal secimi 5. seviyede bir kez yapilir.\n")

    # antiflag bu meslegi yasaklamayan kusak vnumlari
    for tur, alt, etiket in (
            ("ITEM_WEAPON", None, "Silahlar"),
            ("ITEM_ARMOR", "ARMOR_BODY", "Zirhlar"),
            ("ITEM_ARMOR", "ARMOR_HEAD", "Kasklar")):
        uygun = []
        for v, r in k["items"].items():
            if r.get("ITEM_TYPE") != tur:
                continue
            if alt and r.get("SUB_TYPE") != alt:
                continue
            if anti in r.get("ANTI_FLAG", ""):
                continue
            uygun.append(v)
        oyuncu.append("- %s: %d vnum\n" % (etiket, len(uygun)))
        if uygun:
            liste = " ".join(
                "[%s](../esya/%d.md)" % (k["item_names"].get(v, str(v)), v)
                for v in sorted(uygun)[:60])
            ek = " ... (+%d)" % (len(uygun) - 60) if len(uygun) > 60 else ""
            oyuncu.append("  %s%s\n" % (liste, ek))
    satirlar.append("".join(oyuncu) + "\n")

    sunucu = ["## Sunucu\n\n| Alan | Deger |\n| --- | --- |\n"]
    sunucu.append("| `job` | `%d` |\n" % job)
    sunucu.append("| `antiflag` | `%s` |\n" % anti)
    sunucu.append("| `skill_group` | `1`, `2` |\n")
    satirlar.append("".join(sunucu) + "\n")

    gel = ["<details><summary>Gelistirici</summary>\n\n"]
    gel.append("- Sabit dortludur (plan 10, 5.16). Besinci meslek uretilmez.\n")
    gel.append("- Liste: `item_proto.txt` antiflag sorgusu.\n")
    gel.append("</details>\n")
    satirlar.append("".join(gel))
    return "".join(satirlar)


# ----------------------------------------------------------------------
# raporlar
# ----------------------------------------------------------------------


def kirik_bag(k, dogma):
    bulgu = []

    # 1. regen/npc/boss/stone vnum kontrolu (profil map_allow birlesimi)
    birlesim = set()
    for p in PROFILLER:
        birlesim |= k["profiller"][p]["map_allow"]
    for idx in sorted(birlesim):
        if idx not in k["harita"]:
            continue
        bilgi = k["harita"][idx]
        if bilgi.get("klasor_yok"):
            continue
        for dosya in ("regen", "npc", "boss", "stone"):
            for tip, vnum, _a in bilgi.get(dosya, []):
                if tip in ("r", "m"):
                    if vnum not in k["mobs"]:
                        bulgu.append(("regen",
                                      "map %d `%s` %s.txt: vnum %d mob_proto'da yok"
                                      % (idx, bilgi["klasor"], dosya, vnum)))
                else:
                    if vnum not in k["grup_vnum"] and vnum not in k["mobs"]:
                        bulgu.append(("regen",
                                      "map %d `%s` %s.txt: grup vnum %d group.txt "
                                      "Vnum satirinda ve mob_proto'da yok"
                                      % (idx, bilgi["klasor"], dosya, vnum)))

    # 2. gorev esya kontrolu
    for q in k["quests"]:
        if q.get("yok"):
            bulgu.append(("gorev", "quest_list satiri dosyasi yok: `%s`" % q["dosya"]))
            continue
        for v in q["count_item"]:
            if v not in k["items"]:
                bulgu.append(("gorev",
                              "gorev `%s` esya %d istiyor, item_proto'da yok"
                              % (q["ad"], v)))
            elif v not in k["dusus"]["vnumlar"]:
                bulgu.append(("gorev",
                              "gorev `%s` esya %d istiyor, taranan dusus "
                              "dosyalarinda yok" % (q["ad"], v)))

    # 3. index'te olup klasoru olmayan haritalar
    for idx, bilgi in sorted(k["harita"].items()):
        if bilgi.get("klasor_yok"):
            bulgu.append(("harita",
                          "map/index %d icin klasor yok: `%s`"
                          % (idx, bilgi["klasor"])))

    # 4. map_allow'da olup index'te olmayanlar
    for p in PROFILLER:
        for idx in sorted(k["profiller"][p]["map_allow"]):
            if idx not in k["map_index"]:
                bulgu.append(("harita",
                              "profil %s map_allow %d map/index'te yok" % (p, idx)))

    # 5. quest warp index kontrolu
    for q in k["quests"]:
        if q.get("yok"):
            continue
        for idx in q["warp_index"]:
            if idx not in k["map_index"]:
                bulgu.append(("gorev",
                              "gorev `%s` pc.warp index %d istiyor, map/index'te yok"
                              % (q["ad"], idx)))

    satir = ["# Kirik bag\n\n"]
    satir.append("Uretim: %s\n\n" % datetime.datetime.now().isoformat(timespec="seconds"))
    if k["dusus"]["bos"]:
        satir.append("> Dusus grubu bos dosya: %s. Gorev-esya kontrolu bu "
                     "yuzden eksiktir.\n\n" % ", ".join("`%s`" % a for a in k["dusus"]["bos"]))
    if not bulgu:
        satir.append("Kirik bag bulunamadi.\n")
    else:
        for grup in ("regen", "gorev", "harita"):
            alt = [b for g, b in bulgu if g == grup]
            if not alt:
                continue
            satir.append("## %s (%d)\n\n" % (grup, len(alt)))
            for b in sorted(set(alt)):
                satir.append("- %s\n" % b)
            satir.append("\n")
    yaz(RAPOR / "kirik-bag.md", "".join(satir))
    return bulgu


def istemci_farki(k):
    satir = ["# Istemci farki\n\n"]
    satir.append("Uretim: %s\n\n" % datetime.datetime.now().isoformat(timespec="seconds"))
    satir.append("Ikili istemci proto (`client/pack` icindeki eix/epk) "
                 "ayristirilamadi. Karsilastirma sunucu `item_proto.txt` vnum "
                 "kumesi ile istemci `item_list.txt` vnum kumesi arasindadir.\n\n")

    proto = set(k["items"])
    for etiket, kaynak, vnumlar in (
            ("Srcs/Pack tr item_list.txt", CLIENT_ITEM_LIST, k["item_list_srcs"]),
            ("client/pack tr item_list.txt", CLIENT_PACK_ITEM_LIST, k["item_list_pack"])):
        satir.append("## %s\n\n" % etiket)
        if vnumlar is None:
            satir.append("Kaynak yok: `%s`\n\n" % kaynak)
            continue
        satir.append("- Kaynak: `%s` (%d vnum)\n\n" % (kaynak, len(vnumlar)))
        fark1 = sorted(vnumlar - proto)
        fark2 = sorted(proto - vnumlar)
        satir.append("Istemcide var, sunucu proto'sunda yok (%d):\n\n" % len(fark1))
        if fark1:
            satir.append("`" + "`, `".join(str(v) for v in fark1[:200]) + "`")
            if len(fark1) > 200:
                satir.append(" ... (+%d)" % (len(fark1) - 200))
            satir.append("\n\n")
        satir.append("Sunucu proto'sunda var, istemcide yok (%d):\n\n" % len(fark2))
        if fark2:
            satir.append("`" + "`, `".join(str(v) for v in fark2[:200]) + "`")
            if len(fark2) > 200:
                satir.append(" ... (+%d)" % (len(fark2) - 200))
            satir.append("\n\n")
    yaz(RAPOR / "istemci-farki.md", "".join(satir))


# ----------------------------------------------------------------------
# ana uretim
# ----------------------------------------------------------------------


def main():
    eksik = []
    for yol in (DB / "item_proto.txt", DB / "item_names.txt",
                DB / "mob_proto.txt", DB / "mob_names.txt",
                MAP_DIR / "index", QUEST_DIR / "quest_list"):
        if not yol.is_file():
            eksik.append(yol)
    if eksik:
        sys.stdout.write("kaynak yok, uretim durdu\n")
        for yol in eksik:
            sys.stdout.write(str(yol) + "\n")
        return 1

    k = kaynaklari_oku()
    dogma = mob_haritalari(k)

    # uretilen/ ureticinindir: onceki cikti silinir, bayat sayfa kalmaz
    import shutil
    for profil in PROFILLER:
        profil_dizin = URETILEN / profil
        if profil_dizin.is_dir():
            shutil.rmtree(profil_dizin)
    for t in TURLER:
        bos = URETILEN / t
        if bos.is_dir() and not any(bos.iterdir()):
            bos.rmdir()

    sayfa_sayisi = {}
    for profil in PROFILLER:
        feat = k["profiller"][profil]["features"]
        sayfa_sayisi[profil] = {t: 0 for t in TURLER}
        profil_dizin = URETILEN / profil
        for t in TURLER:
            (profil_dizin / t).mkdir(parents=True, exist_ok=True)

        # esya: eldiven (ARMOR_GLOVE) sayfasi uretilmez (plan 10)
        for vnum, r in k["items"].items():
            if r.get("ITEM_TYPE") == "ITEM_ARMOR" and r.get("SUB_TYPE") == "ARMOR_GLOVE":
                continue
            yaz(profil_dizin / "esya" / ("%d.md" % vnum),
                esya_sayfasi(k, profil, feat, vnum, r))
            sayfa_sayisi[profil]["esya"] += 1

        for vnum, r in k["mobs"].items():
            yaz(profil_dizin / "yaratik" / ("%d.md" % vnum),
                yaratik_sayfasi(k, profil, feat, vnum, r, dogma))
            sayfa_sayisi[profil]["yaratik"] += 1

        for idx in sorted(k["profiller"][profil]["map_allow"]):
            if idx not in k["harita"]:
                continue
            yaz(profil_dizin / "harita" / ("%d.md" % idx),
                harita_sayfasi(k, profil, feat, idx))
            sayfa_sayisi[profil]["harita"] += 1

        for kod, ad, indexler, kapi, gorev_dosya in ZINDANLAR:
            if kapi != "core" and kapi not in feat:
                continue
            if not any(i in k["profiller"][profil]["map_allow"] and i in k["map_index"]
                       for i in indexler):
                continue
            yaz(profil_dizin / "zindan" / ("%s.md" % kod),
                zindan_sayfasi(k, profil, feat, kod, ad, indexler, kapi, gorev_dosya))
            sayfa_sayisi[profil]["zindan"] += 1

        for q in k["quests"]:
            if q.get("yok"):
                continue
            yaz(profil_dizin / "gorev" / ("%s.md" % q["ad"]),
                gorev_sayfasi(k, profil, feat, q))
            sayfa_sayisi[profil]["gorev"] += 1

        yaz(profil_dizin / "biyolog" / "biyolog.md",
            biyolog_sayfasi(k, profil, feat))
        sayfa_sayisi[profil]["biyolog"] = 1

        for job in range(4):
            yaz(profil_dizin / "meslek" / ("%d.md" % job),
                meslek_sayfasi(k, profil, feat, job))
            sayfa_sayisi[profil]["meslek"] += 1

        # beceri ve set: veri yoksa dizin bos kalir, uydurma yapilmaz.
        # skill_proto ve set tablosu bu pakette common tablosudur (plan 09);
        # okunabilir txt kaynak yoktur.

        # profil indeksi
        idx_satir = ["# Profil %s wiki indeksi\n\n" % profil]
        p = k["profiller"][profil]
        idx_satir.append("- Seviye tavani: %d\n" % p["level_cap"])
        idx_satir.append("- Efsun yuvasi: %d\n" % p["attr_slots"])
        idx_satir.append("- Acik sistemler: %s\n" % ", ".join(
            FEATURE_TR.get(f, f) for f in sorted(p["features"])))
        kapali = sorted(set(FEATURE_TR) - p["features"] - {"core"})
        if kapali:
            idx_satir.append("- Kapali sistemler: %s\n" % ", ".join(
                FEATURE_TR[f] for f in kapali))
        idx_satir.append("\n## Bolumler\n\n")
        for t in TURLER:
            n = sayfa_sayisi[profil][t]
            if n:
                idx_satir.append("- `%s/` — %d sayfa\n" % (t, n))
            else:
                idx_satir.append("- `%s/` — veri yok, sayfa uretilmedi\n" % t)
        idx_satir.append("\n## Haritalar\n\n")
        for i in sorted(p["map_allow"] & set(k["map_index"])):
            idx_satir.append("- [%s](harita/%d.md) (`%d`)\n"
                             % (map_adi(k, i) or k["map_index"][i], i, i))
        yaz(profil_dizin / "index.md", "".join(idx_satir))

    bulgu = kirik_bag(k, dogma)
    istemci_farki(k)

    # _uretim.txt
    satir = []
    satir.append("uretim zamani: %s\n" % datetime.datetime.now().isoformat(timespec="seconds"))
    satir.append("kaynak:\n")
    satir.append("  item_proto: %d vnum + %d aralik satiri (%s)\n"
                 % (len(k["items"]), k["item_aralik"], k["item_enc"]))
    satir.append("  item_names: %d satir\n" % len(k["item_names"]))
    satir.append("  mob_proto: %d satir\n" % len(k["mobs"]))
    satir.append("  mob_names: %d satir\n" % len(k["mob_names"]))
    satir.append("  map/index: %d satir\n" % len(k["map_index"]))
    satir.append("  group.txt Vnum: %d grup\n" % len(k["grup_vnum"]))
    satir.append("  quest etkin: %d dosya\n" % len([q for q in k["quests"] if not q.get("yok")]))
    satir.append("  dusus vnum kumesi: %d (bos dosya: %s)\n"
                 % (len(k["dusus"]["vnumlar"]), ", ".join(k["dusus"]["bos"]) or "yok"))
    if k["item_list_srcs"] is not None:
        satir.append("  istemci item_list (Srcs/tr): %d vnum\n" % len(k["item_list_srcs"]))
    satir.append("sayfa:\n")
    for profil in PROFILLER:
        toplam = sum(sayfa_sayisi[profil].values())
        satir.append("  profil %s: %d sayfa\n" % (profil, toplam))
        for t in TURLER:
            satir.append("    %s: %d\n" % (t, sayfa_sayisi[profil][t]))
    satir.append("kirik bag bulgu: %d\n" % len(bulgu))
    if k["profil_uyari"]:
        satir.append("uyari:\n")
        for u in k["profil_uyari"]:
            satir.append("  %s\n" % u)
    yaz(URETILEN / "_uretim.txt", "".join(satir))

    sys.stdout.write("uretim bitti\n")
    for profil in PROFILLER:
        sys.stdout.write("profil %s: %s\n"
                         % (profil, ", ".join("%s=%d" % (t, sayfa_sayisi[profil][t])
                                              for t in TURLER)))
    sys.stdout.write("kirik bag bulgu: %d\n" % len(bulgu))
    for u in k["profil_uyari"]:
        sys.stdout.write("uyari: %s\n" % u)
    return 0


if __name__ == "__main__":
    sys.exit(main())
