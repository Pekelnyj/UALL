# -*- coding: utf-8 -*-
"""Виправити порушення _canon_names_gate.py (16 на 17.09) — за англійським якорем.

Правка лише там, де ключ запису містить англійську назву з canon.json, а
значення — заборонену форму. Корінь міняється, закінчення лишається:
«Оґрімара» -> «Оґриммара», «Сонцехвата» -> «Санрівера». Зіадан — жіноче ім'я
на приголосний, за каноном НЕ відмінюється: «Зіадану» -> «Зіадан».

broadcast — через _update_broadcast_values.py [[never-regex-edit-broadcast-lua]].

Запуск: python _fix_canon_gate_0917.py [--apply]
Далі:   python _update_broadcast_values.py data/tester_new/canon0917_broadcast.json
        python _sync_broadcast_master.py && python generate_db.py
"""
import io
import json
import re
import subprocess
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
qs = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))

RULES = {
    "Orgrimmar": [(r"О[ґг]рімар", "Оґриммар")],
    "Gallywix": [(r"Ґалівікс|Геллівікс|Ґеллівікс", "Ґаллівікс")],
    "Grimtotem": [(r"Грімтотем", "Ґрімтотем")],
    "Sunreaver": [(r"Сонцехват", "Санрівер")],
    "Ziadan": [(r"Зіадан(?:а|у|ом)(?![А-Яа-яІіЇїЄєҐґ])", "Зіадан")],
}


def anchor(sec, k, field):
    if sec == "quests":
        q = qs.get(str(k)) or {}
        parts = []
        for f in (field,) if field else q:
            v = q.get(f)
            if isinstance(v, dict) and v.get("en"):
                parts.append(v["en"])
        return " ".join(parts)
    return k if isinstance(k, str) else ""


def fix(s, a):
    for en, rules in RULES.items():
        if en in a:
            for rx, rep in rules:
                s = re.sub(rx, rep, s)
    return s


changes, bc = [], {}
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k, v in d.items():
        if isinstance(v, str):
            new = fix(v, anchor(sec, k, None))
            if new != v:
                changes.append((sec, k, v, new))
                if sec == "broadcast":
                    bc[k] = new
                elif APPLY:
                    d[k] = new
        elif isinstance(v, dict):
            for f, s in v.items():
                if isinstance(s, str):
                    new = fix(s, anchor(sec, k, f))
                    if new != s:
                        changes.append((sec, f"{k}/{f}", s, new))
                        if APPLY:
                            v[f] = new

print(f"змінено: {len(changes)} (broadcast: {len(bc)})")
for sec, k, old, new in changes:
    i = next((j for j, (x, y) in enumerate(zip(old, new)) if x != y), 0)
    print(f"[{sec}] {str(k)[:50]}\n   - …{old[max(0, i - 25):i + 40]}\n   + …{new[max(0, i - 25):i + 40]}")
if not APPLY:
    print("\nЧЕРНЕТКА — додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(json.dumps(tr, ensure_ascii=False, indent=1))
(DATA_DIR / "tester_new" / "canon0917_broadcast.json").write_text(
    json.dumps(bc, ensure_ascii=False, indent=1), encoding="utf-8")
print("translations.json записано; broadcast окремим JSON")
