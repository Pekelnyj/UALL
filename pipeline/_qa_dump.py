# -*- coding: utf-8 -*-
"""Вивантажити нові переклади (ручні рецепти + GameObjects) для незалежного QA."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
BASE = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((BASE / "data/translations.json").read_text(encoding="utf-8-sig"))
go = json.loads((BASE / "data/source/gameobjects.json").read_text(encoding="utf-8-sig"))

# Реконструюємо словник M ручних рецептів зі скрипта
src = (BASE / "pipeline/_add_recipes_manual.py").read_text(encoding="utf-8")
mtext = src[src.index("M = {") + len("M = "): src.index("}\n\ntr =") + 1]
M = eval(mtext)
with open(BASE / "pipeline/_qa_recipes.txt", "w", encoding="utf-8") as f:
    for en, ua in sorted(M.items()):
        f.write(f"{en}  |  {ua}\n")

got = tr.get("gameObjects", {})
de_by_en = {}
for v in go.values():
    nm = v.get("name", {})
    en, de = nm.get("en", ""), nm.get("de", "")
    if en and en not in de_by_en:
        de_by_en[en] = de
with open(BASE / "pipeline/_qa_gameobjects.txt", "w", encoding="utf-8") as f:
    for en, ua in sorted(got.items()):
        f.write(f"{en}  |  {ua}   (de: {de_by_en.get(en, '?')})\n")

print(f"recipes на QA: {len(M)} -> pipeline/_qa_recipes.txt")
print(f"gameObjects на QA: {len(got)} -> pipeline/_qa_gameobjects.txt")
