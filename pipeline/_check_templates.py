# -*- coding: utf-8 -*-
"""ГЕЙТ шаблонних секцій (system, emotes): чи не зламана підстановка %s.

ChatHooks підставляє захоплене строго ПО ПОРЯДКУ, звичайним gsub по «%s».
Звідси дві тихі поломки, які око не бачить, а гравець бачить одразу:

  1) РІЗНА КІЛЬКІСТЬ %s в оригіналі й перекладі. Якщо в UA їх менше —
     ім'я або число просто зникає з рядка; якщо більше — у тексті лишається
     буквальне «%s».
  2) ПОЗИЦІЙНИЙ специфікатор «%1$s». Спокуса написати його велика (порядок
     слів українською інший), але матчер його не розуміє: у чат поїде
     «%2$s тепер вважають тебе». Порядок треба тримати перестановкою слів,
     а не нумерацією.

Падає (exit 1) — щоб не поїхало в реліз.
"""
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

SECTIONS = ["system", "emotes"]
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))

POS = re.compile(r"%\d+\$s")
bad = []
for sec in SECTIONS:
    d = tr.get(sec) or {}
    for en, ua in d.items():
        if not isinstance(en, str) or not isinstance(ua, str):
            continue
        if POS.search(ua):
            bad.append((sec, en, ua, "позиційний %N$s — матчер його не знає"))
        elif en.count("%s") != ua.count("%s"):
            bad.append((sec, en, ua,
                        f"%s: в оригіналі {en.count('%s')}, у перекладі "
                        f"{ua.count('%s')}"))

for sec, en, ua, why in bad[:30]:
    print(f"  [{sec}] {en[:70]!r}\n        -> {ua[:70]!r}\n        {why}")
if bad:
    print(f"\n❌ ГЕЙТ ШАБЛОНІВ: знайдено {len(bad)}")
    sys.exit(1)
n = sum(len(tr.get(s) or {}) for s in SECTIONS)
print(f"✅ ГЕЙТ ШАБЛОНІВ: {n} шаблонів, підстановка %s ціла.")
