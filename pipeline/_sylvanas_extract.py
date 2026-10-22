# -*- coding: utf-8 -*-
"""Витягти всі записи з формами Sylvanas (крім Sylvanaar) для контекстної уніфікації."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))

# форма Sylvanas, але НЕ Sylvanaar (Сільванаар/Сильванаар)
SYL = re.compile(r"[СC][іиІИ]льван(?!аар|аара|аару|аарі)\w*")
# виключаємо також 'Сильванських' (прикметник від Sylvanaar?) — лишимо агенту
hits = []
for section, d in tr.items():
    if not isinstance(d, dict):
        continue
    for key, v in d.items():
        if isinstance(v, str) and SYL.search(v):
            forms = set(SYL.findall(v))
            # пропустити, якщо ЄДИНА форма — уже канон 'Сильвана' без потреби (але можуть бути інші слова поряд)
            hits.append({"section": section, "key": key, "ua": v, "forms": sorted(forms)})

(B / "data/_sylvanas.json").write_text(json.dumps(hits, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Записів із формами Sylvanas: {len(hits)}")
from collections import Counter
allf = Counter(f for h in hits for f in h["forms"])
print("Форми, що трапляються:")
for f, n in allf.most_common(30):
    print(f"  {n:>4}  {f}")
