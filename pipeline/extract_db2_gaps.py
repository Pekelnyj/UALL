# -*- coding: utf-8 -*-
"""Витяг цінних локалізованих таблиць DB2 (wago.tools) + аналіз ДІРОК (що НЕ перекладено).

Закриває діру Jun26: AdventureJournal (Рекомендоване), ScenarioStep (делви/сценарії),
Creature.Title (підзаголовки), JournalEncounter/Section (боси/абілки), AreaTable (зони).
Зберігає EN→"" чанки в data/tester_new/db2gaps/<cat>/ для хвиль перекладу.

Запуск: python pipeline/extract_db2_gaps.py
"""
import sys, csv, io, json, re, os, math
sys.stdout.reconfigure(encoding="utf-8")
import requests
from concurrent.futures import ThreadPoolExecutor

ROOT = r"g:/Claude Code/WoWUkraine"
OUT = ROOT + "/data/tester_new/db2gaps"
tr = json.load(open(ROOT + "/data/translations.json", encoding="utf-8-sig"))


def fetch(tbl):
    r = requests.get(f"https://wago.tools/db2/{tbl}/csv?locale=enUS", timeout=300)
    r.raise_for_status()
    return list(csv.DictReader(io.StringIO(r.text)))


def canon(s):
    s = re.sub(r"\|c%x+|\|c[0-9A-Fa-f]+|\|r|\|H.-\|h|\|T.-\|t", "", s)
    s = s.replace("$bullet;", "").replace("|n", " ")
    s = re.sub(r"[\r\n]+", " ", s)
    s = re.sub(r"\s+", " ", s)
    return s.strip()


# ── множини «вже відомого EN» ─────────────────────────────────────────
def keys_of(*sections):
    ks = set()
    for sec in sections:
        d = tr.get(sec, {})
        if isinstance(d, dict):
            for k in d.keys():
                ks.add(k); ks.add(canon(k))
    return ks


journal_known = keys_of("journalSections", "instanceDesc", "journal", "journal_instances")
sub_known = keys_of("subnames")
# імена NPC: manual EN-ключі + creatures.json EN
man = json.load(open(ROOT + "/data/source/manual_npc_names.json", encoding="utf-8-sig"))
npc_known = set(man.keys())
for src in ("creatures.json", "api_creatures_full.json", "captured_creatures.json"):
    p = ROOT + "/data/source/" + src
    if os.path.exists(p):
        try:
            d = json.load(open(p, encoding="utf-8-sig"))
            for v in (d.values() if isinstance(d, dict) else d):
                en = v.get("name") if isinstance(v, dict) else v
                en = (en.get("en") if isinstance(en, dict) else en)
                if isinstance(en, str):
                    npc_known.add(en)
        except Exception:
            pass

CAT = {}  # cat -> set of EN gap strings


def add_gap(cat, en, known):
    en = (en or "").strip()
    if not en or len(en) < 3 or not re.search(r"[A-Za-z]{3,}", en):
        return
    if en in known or canon(en) in known:
        return
    CAT.setdefault(cat, set()).add(en)


def do(tbl, fn):
    try:
        rows = fetch(tbl)
        fn(rows)
        print(f"  {tbl}: {len(rows)} рядків опрацьовано")
    except Exception as e:
        print(f"  {tbl}: ПОМИЛКА {str(e)[:60]}")


def h_adv(rows):
    for r in rows:
        for c in ("Name_lang", "Description_lang", "ButtonText_lang", "RewardDescription_lang"):
            add_gap("adventure", r.get(c), journal_known)

def h_scen(rows):
    for r in rows:
        add_gap("scenario", r.get("Title_lang"), journal_known)
        add_gap("scenario", r.get("Description_lang"), journal_known)

def h_scenname(rows):
    for r in rows:
        add_gap("scenario_names", r.get("Name_lang"), journal_known)

def h_jenc(rows):
    for r in rows:
        add_gap("boss_desc", r.get("Description_lang"), journal_known)

def h_jsec(rows):
    for r in rows:
        add_gap("boss_ability", r.get("Title_lang"), journal_known)
        add_gap("boss_ability", r.get("BodyText_lang"), journal_known)

def h_area(rows):
    for r in rows:
        add_gap("area", r.get("AreaName_lang"), journal_known)

def h_crtitle(rows):
    for r in rows:
        add_gap("subnames", r.get("Title_lang"), sub_known)


print("Витягую DB2-таблиці...")
do("AdventureJournal", h_adv)
do("ScenarioStep", h_scen)
do("Scenario", h_scenname)
do("JournalEncounter", h_jenc)
do("JournalEncounterSection", h_jsec)
do("AreaTable", h_area)
do("Creature", h_crtitle)

print("\n=== ДІРКИ (EN, ще не перекладено) ===")
for cat in sorted(CAT):
    items = sorted(CAT[cat])
    d = f"{OUT}/{cat}"
    os.makedirs(d, exist_ok=True)
    for f in os.listdir(d):
        if f.endswith(".json"):
            os.remove(d + "/" + f)
    N = max(1, math.ceil(len(items) / 13))
    sz = math.ceil(len(items) / N)
    for i in range(N):
        part = items[i*sz:(i+1)*sz]
        if part:
            json.dump({k: "" for k in part}, open(f"{d}/c{i+1:02d}.json", "w", encoding="utf-8"),
                      ensure_ascii=False, indent=1)
    print(f"  {cat:14} {len(items):5} рядків -> {N} чанків")
