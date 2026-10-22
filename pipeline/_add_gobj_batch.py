# -*- coding: utf-8 -*-
"""Додати батч перекладів GameObjects у translations.json (секція gameObjects, ключ=EN-назва)."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
TR = Path("g:/Claude Code/WoWUkraine/data/translations.json")

# Батч 7 — чисті generic-обʼєкти з хвоста (без місць/вивісок/ITK/лор-фракцій).
BATCH = {
    "Chest": "Скриня",
    "Bag": "Сумка",
    "Keg": "Барило",
    "Keg Stand": "Підставка для барила",
    "Oil Drum": "Бочка з мастилом",
    "Tool Bucket": "Відро з інструментами",
    "Fish Skeleton": "Скелет риби",
    "Sacred Scroll": "Священний сувій",
    "Satyr Brazier": "Жаровня сатирів",
    "Mushroom Circle": "Грибне коло",
    "Mushroom Container": "Ємність для грибів",
    "Tailoring Table": "Кравецький стіл",
    "Night Elf Moon Crystal": "Місячний кристал нічних ельфів",
    "Resort Map": "Карта курорту",
    "Horde Supplies": "Припаси Орди",
    "Fine Food and Refreshments": "Вишукані наїдки й напої",
    "Statue of Denathrius": "Статуя Денатріуса",
}

tr = json.loads(TR.read_text(encoding="utf-8-sig"))
sec = tr.setdefault("gameObjects", {})
added = sum(1 for k in BATCH if k not in sec)
sec.update(BATCH)
TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"gameObjects: всього {len(sec)} | додано нових {added}")
