# -*- coding: utf-8 -*-
"""Консистентність шкіл шкоди в журналі: Shadow -> «темної магії», Nature -> «від сил природи».
Нормалізуємо меншість-варіанти до канону. Анкер на «шкод*», щоб не чіпати небойові «Тінню/Природою»."""
import json
import sys
import re
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
TR = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
jst = tr["journalSections"]

# (regex, заміна) — \1 зберігає відмінкову форму «шкод-»
RULES = [
    # Shadow: «Тінню» / «від сил темряви» -> «темної магії»
    (re.compile(r"шкод(и|у|а|ою) Тінню"), r"шкод\1 темної магії"),
    (re.compile(r"шкод(и|у|а|ою) від сил темряви"), r"шкод\1 темної магії"),
    (re.compile(r"шкод(и|у|а|ою) тінню"), r"шкод\1 темної магії"),
    # Nature: «Природою» -> «від сил природи»
    (re.compile(r"шкод(и|у|а|ою) Природою"), r"шкод\1 від сил природи"),
    (re.compile(r"шкод(и|у|а|ою) природою"), r"шкод\1 від сил природи"),
]

counts = [0] * len(RULES)
for en, ua in list(jst.items()):
    if not isinstance(ua, str):
        continue
    new = ua
    for i, (rx, rep) in enumerate(RULES):
        new2, n = rx.subn(rep, new)
        if n:
            counts[i] += n
            new = new2
    if new != ua:
        jst[en] = new

TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
labels = ["Тінню->темної магії", "від сил темряви->темної магії", "тінню(мала)->темної магії",
          "Природою->від сил природи", "природою(мала)->від сил природи"]
print("Нормалізовано:")
for l, c in zip(labels, counts):
    if c:
        print(f"  {l}: {c}")
print("Разом:", sum(counts))

# контроль: що лишилось
text = " ".join(v for v in jst.values() if isinstance(v, str))
print("\nКонтроль після нормалізації:")
for name, pat in [("Shadow: темної магії", r"темної магії"),
                  ("Shadow: Тінню(зал.)", r"шкод\w+ Тінню"),
                  ("Shadow: від сил темряви(зал.)", r"від сил темряви"),
                  ("Nature: від сил природи", r"від сил природи"),
                  ("Nature: Природою(зал.)", r"шкод\w+ Природою")]:
    print(f"  {len(re.findall(pat, text)):>4}  {name}")
