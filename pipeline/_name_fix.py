# -*- coding: utf-8 -*-
"""Уніфікація власних назв до домінантної форми (и/і). Колізій-безпечні підрядки."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
TR = B / "data/translations.json"
tr = json.loads(TR.read_text(encoding="utf-8-sig"))

# (хибний підрядок -> канон). Тільки розпізнавані власні назви, капіталізовані.
REPL = [
    ("Кирин", "Кірін"), ("Кірин", "Кірін"), ("Кирін", "Кірін"),          # Kirin Tor
    ("Вирм", "Вірм"),                                                       # Wyrm
    ("Сильвермун", "Сільвермун"),                                          # Silvermoon
    ("Андерситі", "Андерсіті"),                                            # Undercity
    ("Анима", "Аніма"),                                                    # Anima
    ("Триумвірат", "Тріумвірат"),                                          # Triumvirate
    ("Архимаг", "Архімаг"),                                                # Archmage
    ("Нордрассил", "Нордрассіл"),                                          # Nordrassil
    ("Малиґос", "Малігос"), ("Малигос", "Малігос"), ("Маліґос", "Малігос"),  # Malygos
    ("Тиранда", "Тіранда"), ("Тиранди", "Тіранди"), ("Тиранді", "Тіранді"),
    ("Тиранду", "Тіранду"), ("Тирандою", "Тірандою"), ("Тирандо", "Тірандо"),  # Tyrande
    ("Ониксі", "Оніксі"),                                                  # Onyxia
    ("Назмир", "Назмір"),                                                  # Nazmir
    ("Стігійськ", "Стигійськ"),                                            # Stygian (т->и)
    ("Умбрік", "Умбрик"),                                                  # Umbric (р->и)
    ("Джинью", "Джінью"),                                                  # Jinyu
    ("Ринн", "Рінн"),                                                      # Wrynn
]

cnt = {a: 0 for a, _ in REPL}
def fix(s):
    for a, b in REPL:
        if a in s:
            cnt[a] += s.count(a)
            s = s.replace(a, b)
    return s


def walk(v):
    if isinstance(v, str): return fix(v)
    if isinstance(v, dict): return {k: walk(x) for k, x in v.items()}
    if isinstance(v, list): return [walk(x) for x in v]
    return v


tr2 = walk(tr)
TR.write_text(json.dumps(tr2, ensure_ascii=False, indent=1), encoding="utf-8")
total = sum(cnt.values())
print(f"Уніфіковано власних назв: {total} замін")
for a, _ in REPL:
    if cnt[a]:
        print(f"  {a} -> {dict(REPL)[a]}: {cnt[a]}")
