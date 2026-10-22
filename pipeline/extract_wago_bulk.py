# -*- coding: utf-8 -*-
"""Bulk-витяг структурованого локалізованого контенту з wago (latest) у чанки на переклад.

Покриває СТАРЕ+НОВЕ одним проходом (мапа/петбатли/Базар/створення персонажа/чари/housing/…).
Джерело — data/wago/<Table>.{enUS,deDE,frFR}.latest.csv (дотягує з wago, якщо enUS бракує).
Для кожного рядка бере en (джерело) + de/fr (контекст роду/числа), фільтрує dev-сміття,
дедуплює проти всіх секцій translations.json і стейджить data/wago_bulk/<Table>.json
зі списком {id, col, en, de, fr, ua:""} — готово до хвиль перекладу.

Запуск: python pipeline/extract_wago_bulk.py
"""
import sys, os, csv, re, json, io, time
sys.stdout.reconfigure(encoding="utf-8")
import requests

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WAGO = os.path.join(ROOT, "data", "wago")
OUT = os.path.join(ROOT, "data", "wago_bulk")
os.makedirs(OUT, exist_ok=True)
tr = json.load(open(os.path.join(ROOT, "data", "translations.json"), encoding="utf-8-sig"))
H = {"User-Agent": "Mozilla/5.0"}

# Таблиця -> (текст-колонки, ярлик). Лише ті, що дали реальний вихід в інвентарі.
TABLES = {
    "AreaPOI": (["Name_lang", "Description_lang"], "мапа: точки інтересу"),
    "TaxiNodes": (["Name_lang"], "точки польоту"),
    "Vignette": (["Name_lang"], "мітки рідкісних на мапі"),
    "ChrCustomizationOption": (["Name_lang"], "створення: опції"),
    "ChrCustomizationChoice": (["Name_lang"], "створення: варіанти"),
    "ChrCustomizationCategory": (["CategoryName_lang"], "створення: категорії"),
    "BarberShopStyle": (["DisplayName_lang", "Description_lang"], "перукарня"),
    "BattlePetSpecies": (["Description_lang", "SourceText_lang"], "петбатли: види"),
    "BattlePetAbility": (["Name_lang", "Description_lang"], "петбатли: здібності"),
    "CreatureFamily": (["Name_lang"], "родини звірів"),
    "SpellItemEnchantment": (["Name_lang"], "чари на предметах"),
    "ItemNameDescription": (["Description_lang"], "суфікси предметів"),
    "TransmogSet": (["Name_lang"], "трансмог-сети"),
    "TransmogSetGroup": (["Name_lang"], "трансмог-групи"),
    "SkillLine": (["DisplayName_lang", "Description_lang"], "професії/скіли"),
    "PerksActivity": (["ActivityName_lang", "Description_lang"], "Базар: завдання"),
    "PerksActivityTag": (["TagName_lang"], "Базар: теги"),
    "Faction": (["Name_lang", "Description_lang"], "фракції"),
    "FriendshipReputation": (["Description_lang"], "дружба-репутація"),
    "HolidayNames": (["Name_lang"], "події: назви"),
    "HolidayDescriptions": (["Description_lang"], "події: описи"),
    "Difficulty": (["Name_lang"], "складності"),
    "PvpBrawl": (["Name_lang", "Description_lang"], "PvP-брол"),
    "BattlemasterList": (["Name_lang", "Description_lang"], "поля бою"),
    "GroupFinderActivity": (["FullName_lang", "ShortName_lang"], "пошук групи"),
    "UISplashScreen": (["Header_lang", "TopLeftFeatureTitle_lang", "TopLeftFeatureDesc_lang",
                        "BottomLeftFeatureTitle_lang", "BottomLeftFeatureDesc_lang",
                        "RightFeatureTitle_lang", "RightFeatureDesc_lang"], "патч-сплеші"),
    "UIEventToast": (["Title_lang", "Description_lang"], "тости подій"),
    "Languages": (["Name_lang"], "ігрові мови"),
    "Achievement_Category": (["Name_lang"], "категорії ачівок"),
    "CurrencyCategory": (["Name_lang"], "категорії валют"),
    "MapChallengeMode": (["Name_lang"], "M+ короткі назви"),
    "QuestLine": (["Name_lang", "Description_lang"], "сюжетні лінії"),
    "QuestSort": (["SortName_lang"], "сортування квестів"),
    "DyeColor": (["Name_lang"], "housing: барвники"),
    "DecorSubcategory": (["Name_lang"], "housing: підкатегорії декору"),
    "HouseRoom": (["Name_lang"], "housing: кімнати"),
    "HouseTheme": (["Name_lang"], "housing: теми"),
    "HouseDecor": (["Name_lang"], "housing: декор"),
    "ExteriorComponent": (["Name_lang"], "housing: екстер'єр"),
    "GarrAbility": (["Name_lang", "Description_lang"], "гарнізон: здібності"),
    "GarrBuilding": (["AllianceName_lang", "HordeName_lang", "Description_lang"], "гарнізон: будівлі"),
}

JUNK = re.compile(r"\btest\b|\bdummy\b|\bunused\b|\bdeprecated\b|placeholder|\bWIP\b|"
                  r"Now with extra|\bTBD\b|\bphgo/|\[PH\]|\[DNT\]|<DNT>|\bNYI\b|DO NOT USE|"
                  r"^PLAYER,|rt_hook|_hook\d|Bro!|^\W*$|^[A-Z0-9_]+$|^\d+$|"
                  r"^z[A-Z]|QA |^OLD |^old_|XXX|Template|^\W*\d+\W*$", re.I)

def cyr(s): return bool(re.search(r"[А-Яа-яІіЇїЄєҐґ]", s))
def canon(s):
    s = re.sub(r"\|c[0-9A-Fa-f]{6,8}|\|c\w+:|\|r|\|H.-?\|h|\|T.-?\|t|\|A.-?\|a|\|n", " ", s)
    s = re.sub(r"\$bullet;|\$[a-z]+;?", " ", s)
    return re.sub(r"\s+", " ", s).strip()

def useful(v):
    v = (v or "").strip()
    if len(v) < 2 or cyr(v) or not re.search(r"[A-Za-z]", v) or JUNK.search(v):
        return None
    return v

# глобальна множина відомого EN (усі секції)
KNOWN = set()
for sec, d in tr.items():
    if isinstance(d, dict):
        for k in d: KNOWN.add(k); KNOWN.add(canon(k))

def load_locale(tbl, loc):
    p = os.path.join(WAGO, f"{tbl}.{loc}.latest.csv")
    if not os.path.exists(p):
        if loc == "enUS":  # дотягнути лише джерело
            try:
                r = requests.get(f"https://wago.tools/db2/{tbl}/csv?locale=enUS", timeout=300, headers=H)
                if r.status_code == 200:
                    open(p, "w", encoding="utf-8").write(r.text)
                else:
                    return None
            except Exception:
                return None
        else:
            return {}
    out = {}
    for row in csv.DictReader(open(p, encoding="utf-8", errors="replace")):
        rid = (row.get("ID") or "").strip()
        if rid: out[rid] = row
    return out

total = 0
report = []
for tbl, (cols, label) in TABLES.items():
    en = load_locale(tbl, "enUS")
    if not en:
        report.append((tbl, label, "нема даних", 0)); continue
    de = load_locale(tbl, "deDE") or {}
    fr = load_locale(tbl, "frFR") or {}
    have = [c for c in cols if next(iter(en.values())).get(c) is not None]
    if not have:
        report.append((tbl, label, "колонок нема", 0)); continue
    seen, items = set(), []
    for rid, row in en.items():
        for c in have:
            v = useful(row.get(c))
            if not v or v in seen: continue
            seen.add(v)
            if v in KNOWN or canon(v) in KNOWN: continue
            items.append({"id": rid, "col": c, "en": v,
                          "de": (de.get(rid, {}).get(c) or "").strip(),
                          "fr": (fr.get(rid, {}).get(c) or "").strip(),
                          "ua": ""})
    if items:
        json.dump({"table": tbl, "label": label, "items": items},
                  open(os.path.join(OUT, f"{tbl}.json"), "w", encoding="utf-8"),
                  ensure_ascii=False, indent=1)
    total += len(items)
    report.append((tbl, label, f"{len(items)} нових", len(items)))

report.sort(key=lambda x: -x[3])
print(f"{'ТАБЛИЦЯ':26}{'категорія':30} результат")
print("-" * 78)
for tbl, label, res, _ in report:
    print(f"{tbl:26}{label:30} {res}")
print("-" * 78)
print(f"РАЗОМ стейджнуто на переклад: {total} рядків -> {OUT}")
