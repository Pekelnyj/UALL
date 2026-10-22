# -*- coding: utf-8 -*-
"""Точкові QA-виправлення журналу (русизми, зламані форми, помилки змісту/відмінків)."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
TR = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
jst = tr["journalSections"]

# порядок важливий (довші форми перші)
REPL = [
    ("сквернаго", "скверного"),          # русизм -аго -> валідний родовий
    ("сквернаій", "скверній"),           # зламана форма
    ("Вогнепалій", "Піровибух"),         # вигадане слово (Pyroblast)
    ("Вогнепалад", "Піровибух"),
    ("блискавку зіпсутого світла", "блискавку зіпсутого струму"),  # lightning != світло
    ("Душить цілі гароту", "Душить цілі гаротою"),                 # відмінок
    ("Хроноразтин", "Хронорозтин"),      # одрук
    ("хащу люто Світлородних", "хащу лютих Світлородних"),         # граматика
    ("призваних", "прикликаних"),        # русизм призванный
    ("призваного", "прикликаного"),
    ("призваним", "прикликаним"),
    ("призвані", "прикликані"),
    ("призваний", "прикликаний"),
    ("каналізує", "вивільняє"),          # калька channel
    ("каналізують", "вивільняють"),
    ("Громовержень", "Громобій"),        # раритет
]

counts = {a: 0 for a, _ in REPL}
for en, ua in list(jst.items()):
    if not isinstance(ua, str):
        continue
    new = ua
    for a, b in REPL:
        if a in new:
            counts[a] += new.count(a)
            new = new.replace(a, b)
    if new != ua:
        jst[en] = new

TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print("Застосовані заміни (к-сть входжень):")
for a, _ in REPL:
    if counts[a]:
        print(f"  {a!r} -> {dict(REPL)[a]!r}: {counts[a]}")
print("Разом виправлень:", sum(counts.values()))
