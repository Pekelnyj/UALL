# -*- coding: utf-8 -*-
"""Пакети доказів для імен істот (неймплейти) — із ЦІЛЯМИ КВЕСТІВ у комплекті.

НАВІЩО. Імена перекладалися окремо від квестів, і шари розійшлися: на плашці
«Маля дикогрива», а в цілі «Нагодовано пташеня Лютогрива» — гравець читає одне,
а в світі шукає інше й не знаходить [[base-contradicts-itself-across-layers]].
Тому пакет дає перекладачеві ВСІ місця, де ця істота вже згадана:

  obj_lines   — цілі квестів, що містять англійське ім'я, разом з українським
                (якщо там уже є форма — ім'я мусить збігтися з нею або, якщо
                форма погана, агент каже про це в звіті, і ми правимо ОБА шари);
  word_cases  — як ті самі англійські слова вже перекладено в інших іменах
                (із підрахунком), щоб не народжувати 12-й корінь для Swarmer;
  subname     — титул під іменем («‹Кравець›»): дає роль і рід;
  de / fr     — рід і число, яких англійська не показує.

Запуск: python _prep_plate_context.py --take 600 [--skip 0] [--parts 12]
Вихід:  data/batches/creatures/pl_NN.json
"""
import json
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

ARG = sys.argv[1:]


def opt(name, default):
    return int(ARG[ARG.index(name) + 1]) if name in ARG else default


TAKE, SKIP, PARTS = opt("--take", 600), opt("--skip", 0), opt("--parts", 12)
B = DATA_DIR / "batches" / "creatures"
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))

# --- черга з батчів ---------------------------------------------------------
queue = []
for f in sorted(B.glob("batch_*.json")):
    queue += json.loads(f.read_text(encoding="utf-8"))
items = queue[SKIP:SKIP + TAKE]
if not items:
    sys.exit("черга порожня")

# --- ID -> EN, EN -> UA (канон плашки) --------------------------------------
# ДЖЕРЕЛО ID->EN МУСИТЬ БУТИ ПОВНИМ. Перша версія брала лише creatures.json і
# давала 36 092 пари EN->UA замість 42 458 — 15% прецедентів не доїжджали до
# агентів, і вони бачили МЕНШІСТЬ як домінанту (18.10: «Shadowpine» показався
# як 5 проти 18, «Riverbeast» як 1 проти 38). Беремо той самий набір джерел,
# що й generate_db з _obj_npc_consistency [[plates-need-en-from-captures]].
en_of, npc = {}, tr.get("npcNames") or {}
for name in ("api_creatures_full.json", "captured_creatures.json",
             "_midnight_creatures.json"):
    p = DATA_DIR / "source" / name
    if not p.exists():
        continue
    try:
        extra = json.loads(p.read_text(encoding="utf-8-sig"))
    except ValueError:
        continue
    for cid, v in (extra.items() if isinstance(extra, dict) else ()):
        nm = v.get("name") if isinstance(v, dict) else None
        en = nm.get("en") if isinstance(nm, dict) else (v if isinstance(v, str) else None)
        if en:
            en_of[str(cid)] = en
for cid, v in cr.items():        # creatures.json останнім: він головніший
    nm = v.get("name") if isinstance(v, dict) else None
    en = nm.get("en") if isinstance(nm, dict) else None
    if en:
        en_of[str(cid)] = en
pairs = [(en_of[c], ua) for c, ua in npc.items()
         if c in en_of and isinstance(ua, str) and ua]

# --- слово EN -> як уже перекладали (із рахунком) ---------------------------
WORD = re.compile(r"[A-Za-z']{4,}")
by_word = defaultdict(list)
for en, ua in pairs:
    for w in WORD.findall(en):
        by_word[w.lower()].append((en, ua))

# --- цілі квестів: EN-ключ -> UA --------------------------------------------
obj = {k: v for k, v in (tr.get("questObjectives") or {}).items()
       if isinstance(k, str) and isinstance(v, str) and v}
# індекс за словами, щоб не бігати 25 тис. цілей на кожне ім'я
obj_by_word = defaultdict(list)
for k in obj:
    for w in set(WORD.findall(k)):
        obj_by_word[w.lower()].append(k)

# --- підназви зі зборів (титул під іменем) ----------------------------------
sub = tr.get("subnames") or {}

glossary = ""
gp = DATA_DIR.parent / "pipeline" / "glossary.md"
if gp.exists():
    glossary = gp.read_text(encoding="utf-8", errors="replace")
gl_lines = [ln for ln in glossary.splitlines() if ln.startswith("|")]

out = []
for it in items:
    en = it.get("en") or ""
    words = [w.lower() for w in WORD.findall(en)]
    rec = {"id": it.get("id"), "en": en,
           "de": it.get("de"), "fr": it.get("fr")}

    # цілі, що містять це ім'я цілком
    lines = []
    cand = set()
    for w in words:
        cand.update(obj_by_word.get(w, ()))
    for k in sorted(cand):
        if en in k:
            lines.append({"obj_en": k, "obj_ua": obj[k]})
    if lines:
        rec["obj_lines"] = lines[:4]

    # як ці слова вже передано в інших іменах
    cases = {}
    for w in dict.fromkeys(words):
        ex = by_word.get(w, ())
        if not ex:
            continue
        cnt = Counter()
        for _en, ua in ex:
            cnt[ua] += 1
        cases[w] = {"скільки_імен": len(ex),
                    "приклади": [f"{e} = {u}" for e, u in ex[:4]]}
    if cases:
        rec["word_cases"] = cases

    if en in sub:
        rec["subname"] = sub[en]
    g = [ln for ln in gl_lines
         if any(w in ln.lower() for w in words if len(w) >= 5)]
    if g:
        rec["glossary"] = g[:6]
    out.append(rec)

size = (len(out) + PARTS - 1) // PARTS
for i in range(PARTS):
    part = out[i * size:(i + 1) * size]
    if not part:
        break
    p = B / f"pl_{i:02d}.json"
    p.write_text(json.dumps(part, ensure_ascii=False, indent=1), encoding="utf-8")
    withobj = sum(1 for r in part if "obj_lines" in r)
    print(f"{p.name}: {len(part)} імен | з цілями квестів: {withobj}")
print(f"\nусього в пакетах: {len(out)} із черги {len(queue)}")
