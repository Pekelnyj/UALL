# -*- coding: utf-8 -*-
"""Точковий фікс 3 рядків батчу 5: прибрати дужки навколо абілок, що в EN — звичайний текст."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
TR = B / "data/translations.json"
OUTF = B / "data/_journal_out/batch_05.json"

# (унікальний фрагмент EN-ключа, [що прибрати] -> на що)
FIXES = [
    ("Heal aggressively to keep allies' Ancient Barrier",
     [("[Прадавній бар'єр]", "Прадавній бар'єр")]),
    ("Each Protector channels [Bond of the Golden Lotus]",
     [("[Відчайдушними заходами]", "Відчайдушними заходами"),
      ("[Відчайдушних заходів]", "Відчайдушних заходів")]),
    ("Dispel Sun Tenderheart's [Shadow Word: Bane]",
     [("[Відчайдушних заходів]", "Відчайдушних заходів")]),
]

tr = json.loads(TR.read_text(encoding="utf-8-sig"))
jst = tr["journalSections"]
got = json.loads(OUTF.read_text(encoding="utf-8-sig"))

done = 0
for frag, repls in FIXES:
    key = next((k for k in got if frag in k), None)
    if not key:
        print("НЕ знайдено ключ:", frag); continue
    ua = got[key]
    for a, b in repls:
        ua = ua.replace(a, b)
    got[key] = ua
    jst[key] = ua
    done += 1
    # перевірка балансу
    ok = key.count("[") == ua.count("[") and key.count("]") == ua.count("]")
    print(f"{'OK' if ok else 'ЩЕ НЕ ОК'}: {frag[:50]} -> дужки EN={key.count('[')} UA={ua.count('[')}")

OUTF.write_text(json.dumps(got, ensure_ascii=False, indent=1), encoding="utf-8")
TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Виправлено {done}/3")
