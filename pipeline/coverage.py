# -*- coding: utf-8 -*-
# Статус перекладу: скільки перекладено проти наявного в джерелах, по категоріях.
# Запуск: python pipeline/coverage.py
import json, sys, csv
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
def load(p): return json.loads((DATA / p).read_text(encoding="utf-8-sig"))
def pct(a, b): return f"{(100*a//b) if b else 0}%"
def row(label, done, tot):
    print(f"  {label:16} {done:7}/{tot:<7} залишок {tot-done:7}  {pct(done,tot)}")

tr = load("translations.json")

# ---------- ПРЕДМЕТИ (назви) по доповненнях ----------
EXP_FILE = {"0":"Classic","1":"TBC","2":"Wrath","3":"Cataclysm","4":"MoP","5":"WoD",
            "6":"Legion","7":"BfA","8":"Shadowlands","9":"Dragonflight","10":"WarWithin",
            "11":"Midnight","-3":"Special"}
EXP_ORDER = ["Classic","TBC","Wrath","Cataclysm","MoP","WoD","Legion","BfA",
             "Shadowlands","Dragonflight","WarWithin","Midnight","Special","Other"]
csv.field_size_limit(10**7)
expmap = {}
with open(DATA/"wago"/"ItemSparse.enUS.latest.csv", encoding="utf-8") as fh:
    for r in csv.DictReader(fh):
        expmap[r["ID"]] = r.get("ExpansionID")

items = load("source/items.json")
names = tr.get("itemNames", {})
flavors = tr.get("itemFlavors", {})
def is_real(v): return bool(v) and not str(v).startswith("[PH]")
tot = {e:0 for e in EXP_ORDER}; done = {e:0 for e in EXP_ORDER}; ph = 0
ftot = fdone = 0
for iid, e in items.items():
    en = (e.get("name") or {}).get("en")
    if not en: continue
    b = EXP_FILE.get(expmap.get(iid), "Other")
    tot[b] += 1
    v = names.get(en)
    if is_real(v): done[b] += 1
    elif v: ph += 1
    fl = (e.get("flavor") or {}).get("en")
    if fl:
        ftot += 1
        if is_real(flavors.get(fl)): fdone += 1

print("=== ПРЕДМЕТИ — назви (по доповненнях, хронологічно) ===")
for e in EXP_ORDER:
    if tot[e]: row(e, done[e], tot[e])
T = sum(tot.values()); D = sum(done.values())
row("РАЗОМ", D, T)
if ph: print(f"  (+{ph} заглушок [PH] — формально є, реально не перекладені)")
print()
print("=== ПРЕДМЕТИ — флейвор (художній опис) ===")
row("флейвор", fdone, ftot)
print()

# ---------- КВЕСТИ ----------
quests = load("source/quests.json")
qtr = set(tr.get("quests", {}))
qtot = sum(1 for q in quests.values() if (q.get("title") or {}).get("en") or (q.get("description") or {}).get("en"))
qdone = len(qtr & set(quests))
print("=== КВЕСТИ / ЗАКЛЯТТЯ / ДОСЯГНЕННЯ / ІМЕНА / ВАЛЮТА ===")
row("квести", qdone, qtot)

# ---------- ЗАКЛЯТТЯ ----------
spells = load("source/spells.json")
sn = tr.get("spells", {}); dt = tr.get("descTemplates", {})
sn_tot = sum(1 for s in spells.values() if (s.get("name") or {}).get("en"))
sn_done = len(set(sn) & set(spells))  # sn ключ — spellID
sd_tot = sum(1 for s in spells.values() if (s.get("description") or {}).get("en"))
sd_done = sum(1 for s in spells.values() if (s.get("description") or {}).get("en") in dt)
row("закляття: назви", sn_done, sn_tot)
row("закляття: описи", sd_done, sd_tot)

# ---------- ДОСЯГНЕННЯ ----------
ach = load("source/achievements.json")
row("досягнення", len(set(tr.get("achievements", {})) & set(ach)), len(ach))

# ---------- ІМЕНА NPC ----------
creat = load("source/creatures.json")
npc = tr.get("npcNames", {})  # ключ — creatureID
row("імена NPC", len(set(npc) & set(creat)), len(creat))

# ---------- ВАЛЮТА ----------
cur = load("source/currencies.json")
ct = tr.get("currencies", {})
cur_tot = sum(1 for c in cur.values() if (c.get("name") or {}).get("en"))
cur_done = len(set(ct) & set(cur))  # ct ключ — currencyID
row("валюта", cur_done, cur_tot)

# ---------- ЕФЕКТИ ПРЕДМЕТІВ ----------
eff = load("source/item_effects.json")
eff_spells = set()
for v in eff.values():
    for sp in (v if isinstance(v, list) else [v]):
        eff_spells.add(str(sp))
# описи ефектів = опис закляття у descTemplates
spell_by_id = {sid: (s.get("description") or {}).get("en") for sid, s in spells.items()}
eff_done = sum(1 for sid in eff_spells if spell_by_id.get(sid) in dt)
row("ефекти (закл.)", eff_done, len(eff_spells))

print()
print("=== ЗІБРАНЕ В ГРІ / ІНШЕ ===")
print(f"  цілі квестів (objectives): {len(tr.get('questObjectives',{}))} перекладено")
print(f"  діалоги (gossip):          {len(tr.get('gossip',{}))} перекладено (решта збирається в грі)")
print(f"  книги (bookTexts):         {len(tr.get('bookTexts',{}))} (усе зібране наразі)")
print(f"  поради завантаження:       {len(tr.get('gameTips',{}))} перекладено — ще НЕ виводяться в грі")
print(f"  субтитри:                  0 перекладено (лише збираються)")
