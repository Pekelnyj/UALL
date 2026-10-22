# -*- coding: utf-8 -*-
"""Злити хвилю квестів (out_q_*.json) у translations.quests.

Заслони ті самі, що врятували попередні хвилі [[kv-shift-substitution]]:
  • id мусить бути в завданні — інакше це чужий ключ;
  • кирилиця обов'язкова;
  • токени `{NAME}`, `{class}`, `$p(…)`, кольорові коди й числа мусять
    лишитися ті самі, що в АНГЛІЙСЬКОМУ оригіналі: гра підставляє в них
    значення, і втрата токена ламає рядок мовчки [[class-token-mechanism]].

Запуск: python _merge_quest_wave.py [--apply]
Далі: python generate_db.py
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
D = DATA_DIR / "batches" / "quests"
CYR = re.compile("[Ѐ-ӿ]")
TOKEN = re.compile(r"\{[A-Za-z_]+\}|\$[a-zA-Z]\w*|\|c[Ff][Ff0-9A-Fa-f]{6}|\|r")

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
src = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))
quests = tr.setdefault("quests", {})

asked = {}
for f in sorted(D.glob("q_[0-9]*.json")):
    for row in json.loads(f.read_text(encoding="utf-8-sig")):
        for q in row["quests"]:
            asked[q["id"]] = q

pending, rej = {}, []
for f in sorted(D.glob("out_q_*.json")):
    for qid, fields in json.loads(f.read_text(encoding="utf-8-sig")).items():
        if qid not in asked:
            rej.append((qid, "-", "id не був у завданні"))
            continue
        sv = src.get(qid) or {}
        for fld in ("title", "description"):
            new = (fields or {}).get(fld)
            if not isinstance(new, str) or not new.strip():
                continue
            if not CYR.search(new):
                rej.append((qid, fld, "без кирилиці"))
                continue
            en = sv.get(fld)
            en = en.get("en") if isinstance(en, dict) else en
            if isinstance(en, str) and sorted(TOKEN.findall(en)) != sorted(TOKEN.findall(new)):
                rej.append((qid, fld, "токени не збігаються з оригіналом"))
                continue
            pending.setdefault(qid, {})[fld] = new

print(f"у завданні: {len(asked)} | до запису: {len(pending)} завдань | "
      f"відхилено: {len(rej)}")
for qid, fld, why in rej[:12]:
    print(f"    ✖ {qid}.{fld}: {why}")
for qid, fields in list(pending.items())[:6]:
    print(f"    + {qid}: {fields.get('title', '')[:56]!r}")
left = sorted(set(asked) - set(pending))
if left:
    print(f"НЕ ПЕРЕКЛАДЕНО: {len(left)} -> {', '.join(left[:8])}")

if APPLY:
    for qid, fields in pending.items():
        quests.setdefault(qid, {}).update(fields)
    io.open(P, "w", encoding="utf-8", newline="\n").write(
        json.dumps(tr, ensure_ascii=False, indent=1))
    print(f"\nзаписано: {len(pending)}; квестів разом: {len(quests)}")
else:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
