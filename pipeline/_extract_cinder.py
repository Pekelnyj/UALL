# -*- coding: utf-8 -*-
"""Витягти ВСІ записи з EN «Cinder» для уніфікації -> попелястий / транслітерація прізвищ."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))

out = []
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for key, val in d.items():
        # пласкі: ключ=EN
        if isinstance(val, str) and "Cinder" in str(key):
            out.append({"section": sec, "key": str(key), "ua": val})
        # вкладені (quests): значення-словник з полями, ключ=ID -> треба EN з джерела; пропустимо (рідко)
        elif isinstance(val, dict):
            for f, fv in val.items():
                if isinstance(fv, str) and "Cinder" in fv and "Cinder" not in str(key):
                    pass  # текст усередині — обробимо стем-свопом окремо

# дедуп за (section,key)
seen = set()
uniq = []
for r in out:
    k = (r["section"], r["key"])
    if k not in seen:
        seen.add(k); uniq.append(r)

(B / "data/_cinder_all.json").write_text(json.dumps(uniq, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"EN-Cinder записів (пласкі ключі): {len(uniq)}")
from collections import Counter
secs = Counter(r["section"] for r in uniq)
print("по секціях:", dict(secs))
# скільки ще НЕ попеляст
bad = [r for r in uniq if "попеляст" not in r["ua"].lower()]
print(f"ще не «попеляст»: {len(bad)}")
for r in bad[:12]:
    print(f"  [{r['section']}] {r['key'][:35]:<37} -> {r['ua'][:40]}")
