# -*- coding: utf-8 -*-
"""Комплексна карта ДІРОК по цінних локалізованих DB2-таблицях (live-білд).
Рахує, скільки рядків НЕ покрито нашою базою. EN-keyed таблиці звіряє з усіма ключами
translations.json; achievements — по ID. Друкує зведення hook-ready vs hook-needed.

Запуск: python pipeline/db2_gap_map.py [build]
"""
import sys, csv, io, json, re
sys.stdout.reconfigure(encoding="utf-8")
import requests
from concurrent.futures import ThreadPoolExecutor

ROOT = r"g:/Claude Code/WoWUkraine"
BUILD = sys.argv[1] if len(sys.argv) > 1 else "12.1.0.68301"
tr = json.load(open(ROOT + "/data/translations.json", encoding="utf-8-sig"))
ALL = set()
for v in tr.values():
    if isinstance(v, dict):
        ALL |= set(v.keys())

def cyr(s):
    return bool(re.search(r"[А-Яа-яІЇЄҐ]", str(s)))

# (таблиця, [колонки], секція, hook_ready)
TABLES = [
    # HOOK-READY
    ("Achievement", ["Title_lang", "Description_lang", "Reward_lang"], "achievements", True),
    ("CharTitles", ["Name_lang"], "titles", True),
    ("QuestObjective", ["Description_lang"], "questObjectives", True),
    ("DungeonEncounter", ["Name_lang"], "journal", True),
    ("AdventureJournal", ["Name_lang", "Description_lang", "ButtonText_lang", "RewardDescription_lang"], "journalSections", True),
    ("ScenarioStep", ["Title_lang", "Description_lang"], "questObjectives", True),
    ("Scenario", ["Name_lang"], "journalSections", True),
    ("JournalEncounter", ["Description_lang"], "journalSections", True),
    ("JournalEncounterSection", ["Title_lang", "BodyText_lang"], "journalSections", True),
    ("AreaTable", ["AreaName_lang"], "zones", True),
    # HOOK-NEEDED (дані Є, UI-хук треба)
    ("TransmogSet", ["Name_lang"], "transmogSets", False),
    ("DyeColor", ["Name_lang"], "housing", False),
    ("DecorCategory", ["Name_lang"], "housing", False),
    ("ExteriorComponent", ["Name_lang"], "housing", False),
    ("BarberShopStyle", ["DisplayName_lang"], "barber", False),
    ("EmotesTextData", ["Text_lang"], "emotes", False),
    ("AdventureMapPOI", ["Title_lang", "Description_lang"], "mapPOI", False),
    ("FriendshipReputation", ["Description_lang"], "reputation", False),
    ("BattlemasterList", ["Name_lang", "Description_lang"], "queues", False),
    ("GarrAbility", ["Name_lang", "Description_lang"], "garrison", False),
]

def check(spec):
    tbl, cols, section, ready = spec
    try:
        r = requests.get(f"https://wago.tools/db2/{tbl}/csv?locale=enUS&build={BUILD}", timeout=180)
        if r.status_code != 200:
            return (tbl, section, ready, f"HTTP{r.status_code}", 0, 0)
        rows = list(csv.DictReader(io.StringIO(r.text)))
        if tbl == "Achievement":  # ID-keyed
            ach = tr.get("achievements", {})
            miss = 0
            for row in rows:
                t = (row.get("Title_lang") or "").strip()
                if not t or not re.search(r"[A-Za-z]{3,}", t):
                    continue
                e = ach.get(row.get("ID", ""))
                if not e or (isinstance(e, dict) and not cyr(e.get("title", ""))):
                    miss += 1
            return (tbl, section, ready, f"{len(rows)}", miss, miss)
        vals = set()
        for row in rows:
            for c in cols:
                v = (row.get(c) or "").strip()
                if v and re.search(r"[A-Za-z]{3,}", v):
                    vals.add(v)
        miss = sum(1 for v in vals if v not in ALL)
        return (tbl, section, ready, f"{len(rows)}", len(vals), miss)
    except Exception as e:
        return (tbl, section, ready, "ERR:" + str(e)[:20], 0, 0)

print(f"=== GAP-MAP @ build {BUILD} ===\n")
print(f"{'таблиця':24}{'секція':14}{'hook':5}{'рядків':>8}{'унік':>7}{'ДІРА':>8}")
results = []
with ThreadPoolExecutor(max_workers=6) as ex:
    for res in ex.map(check, TABLES):
        results.append(res)
ready_gap = need_gap = 0
for tbl, sec, ready, st, u, m in sorted(results, key=lambda x: (not x[2], -x[5])):
    flag = "✅" if ready else "🔧"
    print(f"{tbl:24}{sec:14}{flag:5}{st:>8}{u:>7}{m:>8}")
    if ready: ready_gap += m
    else: need_gap += m
print(f"\nHOOK-READY діра (перекладати зараз): {ready_gap}")
print(f"HOOK-NEEDED діра (дані є, хук треба):  {need_gap}")
print(f"РАЗОМ: {ready_gap + need_gap}")
