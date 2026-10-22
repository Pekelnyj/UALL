# -*- coding: utf-8 -*-
"""Екстракт objLines-типів із DB2 (НЕ Wowhead): критерії ачівок + сценарії.

Джерело — data/wago/*.enUS.latest.csv:
  • CriteriaTree.Description — критерії ачівок (те, що видно в трекері/тултіпі).
    Лишаємо ЛИШЕ дієслівні критерії ("Defeat X", "Win Y") + мітки статистики.
    Відсіюємо: імена босів/NPC (їх резолвить npcNames за ID), раси/рівні/числа,
    дублі описів ачівок (є за ID), усе вже наявне в базі як ключ.
  • Scenario.Name + ScenarioStep.Description — дірки сценаріїв.

Вихід: data/source/criteria.json = {EN: ""}  (порожнє UA — на переклад).
Наступний крок: prep у порції → переклад (Opus) → merge у секцію 'criteria'.

Запуск з папки pipeline/:  python extract_criteria.py
"""
import csv, json, re, sys, os
sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(10 ** 7)
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
W = os.path.join(ROOT, "data", "wago")
OUT = os.path.join(ROOT, "data", "source", "criteria.json")

tr = json.load(open(os.path.join(ROOT, "data", "translations.json"), encoding="utf-8-sig"))
base = set()
for d in tr.values():
    if isinstance(d, dict):
        for k in d:
            if isinstance(k, str):
                base.add(k.strip())

# EN-тексти ачівок, чий ID ми вже переклали → фактично покрито
ach_ua_ids = set(tr.get("achievements", {}).keys())
ach_covered = set()
with open(os.path.join(W, "Achievement.enUS.latest.csv"), encoding="utf-8") as f:
    r = csv.DictReader(f)
    idc = next((c for c in r.fieldnames if c.lower() in ("id", "_id")), r.fieldnames[0])
    cols = [c for c in r.fieldnames if c.lower().startswith("title") or "description" in c.lower()]
    for row in r:
        if (row.get(idc) or "").strip() in ach_ua_ids:
            for c in cols:
                v = (row.get(c) or "").strip()
                if v:
                    ach_covered.add(v)

RACE_CLASS = {"Dwarf", "Human", "Gnome", "Night Elf", "Draenei", "Worgen", "Orc",
 "Troll", "Tauren", "Undead", "Blood Elf", "Goblin", "Pandaren", "Warrior", "Paladin",
 "Hunter", "Rogue", "Priest", "Shaman", "Mage", "Warlock", "Monk", "Druid",
 "Demon Hunter", "Death Knight", "Evoker", "Nightborne", "Highmountain Tauren",
 "Void Elf", "Lightforged Draenei", "Dark Iron Dwarf", "Kul Tiran", "Zandalari Troll",
 "Vulpera", "Mag'har Orc", "Mechagnome", "Earthen"}
reNum = re.compile(r"^[\d,\.\:%\s\-\+/x]+$", re.I)
reLevel = re.compile(r"^Reach(ed)? level \d+", re.I)
reJunk = re.compile(r"^\[?(DNT|PH|TEST|UNUSED|Test|Impl|Placeholder)", re.I)
# внутрішні/дев-критерії, яких гравець не бачить (лічильники, приховані копії тощо)
reInternal = re.compile(r"hidden copy|char specific|Credit Creature|% Credit|"
    r"\bCredit\b|\bDNT\b|\bcopy\)|- Saddle|Combatant \(|placeholder|deprecated|"
    r"^Earn Conquest While|\bproxy\b|\bdummy\b|\btracker\b|\binternal\b", re.I)
reVerb = re.compile(r"^(Complete|Defeat|Kill|Collect|Use|Win|Reach|Slay|Destroy|"
    r"Obtain|Loot|Discover|Learn|Craft|Gather|Catch|Free|Rescue|Escort|Deliver|"
    r"Speak|Find|Enter|Explore|Earn|Participate|Equip|Acquire|Complete|Defeated|"
    r"Killed|Reached|Recruit|Upgrade|Build|Purchase|Buy|Sell|Cook|Fish|Mine|Skin|"
    r"Herbalize|Disenchant|Turn in|Return|Bring|Rescue|Save|Protect|Survive|Reduce|"
    r"Increase|Raise|Repair|Activate|Interact|Talk|Travel|Fly|Ride|Swim|Jump|Solve|"
    r"Unlock|Open|Close|Light|Extinguish|Plant|Harvest|Feed|Tame|Capture)\b", re.I)
reStat = re.compile(r"(owned|ever owned|Number of|Total |Most |Largest |Highest |"
    r"completed|earned|Amount of|deaths|kills|Duels|honorable|lost|won|Fastest|"
    r"Longest|Deepest|Damage done|Healing done)", re.I)

def looks_meat(v):
    """True якщо дієслівний критерій або мітка статистики (а не імʼя/дрібне)."""
    if v in RACE_CLASS or reNum.match(v) or reJunk.match(v) or reLevel.match(v):
        return None
    if reInternal.search(v):
        return None
    if len(v) < 5:
        return None
    if reVerb.match(v):
        return "criterion"
    if reStat.search(v) and " " in v:
        return "stat"
    return None

out = {}
stats = {"criterion": 0, "stat": 0, "scenario": 0, "scenariostep": 0}
seen = set()

# --- CriteriaTree ---
with open(os.path.join(W, "CriteriaTree.enUS.latest.csv"), encoding="utf-8") as f:
    r = csv.DictReader(f)
    dcol = next(c for c in r.fieldnames if "description" in c.lower())
    for row in r:
        v = (row.get(dcol) or "").strip()
        if not v or v in seen:
            continue
        seen.add(v)
        if v in base or v in ach_covered:
            continue
        kind = looks_meat(v)
        if kind:
            out[v] = ""
            stats[kind] += 1

# --- Scenario + ScenarioStep дірки ---
for tbl, col, tag in [("Scenario", "Name", "scenario"),
                      ("ScenarioStep", "Description", "scenariostep")]:
    p = os.path.join(W, f"{tbl}.enUS.latest.csv")
    if not os.path.exists(p):
        continue
    with open(p, encoding="utf-8") as f:
        r = csv.DictReader(f)
        c = next((x for x in r.fieldnames if col.lower() in x.lower()), None)
        if not c:
            continue
        for row in r:
            v = (row.get(c) or "").strip()
            if not v or v in seen or v in base or reJunk.match(v) or len(v) < 3:
                continue
            seen.add(v)
            out[v] = ""
            stats[tag] += 1

os.makedirs(os.path.dirname(OUT), exist_ok=True)
json.dump({k: out[k] for k in sorted(out)}, open(OUT, "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)

print("=== EXTRACT CRITERIA (DB2, без Wowhead) ===")
for k, v in stats.items():
    print(f"  {k:14} {v}")
print(f"  РАЗОМ на переклад: {len(out)}")
print(f"  → {OUT}")
