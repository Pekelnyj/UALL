# -*- coding: utf-8 -*-
"""Базові канон-фікси з QA Midnight (наскрізні, безпечні)."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
P = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(P.read_text(encoding="utf-8-sig"))

REPL = [
    # Twilight's Blade → Клинок Сутінків (інверсія «Сутінковий Клинок» хибна)
    ("Сутінкового Клинка", "Клинка Сутінків"),
    ("Сутінковим Клинком", "Клинком Сутінків"),
    ("Сутінковому Клинку", "Клинку Сутінків"),
    ("Сутінкових Клинків", "Клинків Сутінків"),
    ("Сутінкові Клинки", "Клинки Сутінків"),
    ("Сутінковий Клинок", "Клинок Сутінків"),
    # gnarldin → корчедіни (ґнарлдіни — хибна транслітерація)
    ("Ґнарлдін", "Корчедін"), ("ґнарлдін", "корчедін"),
    ("Гнарлдін", "Корчедін"), ("гнарлдін", "корчедін"),
    # Burning Legion → Палаючий Легіон (Полум'яний хибно)
    ("Полум'яного Легіону", "Палаючого Легіону"),
    ("Полум'яним Легіоном", "Палаючим Легіоном"),
    ("Полум'яному Легіону", "Палаючому Легіону"),
    ("Полум'яний Легіон", "Палаючий Легіон"),
    # зламані слова
    ("Бровароство", "Броварство"), ("бровароство", "броварство"),
    ("Жаргобатіг", "Жаробатіг"), ("жаргобатіг", "жаробатіг"),
    ("Вівтарнативна історія", "Історія вівтарів"),
    ("Вівтарнативн", "Історія вівтар"),
]

cnt = {}
def fix(s):
    for a, b in REPL:
        if a in s:
            cnt[a] = cnt.get(a, 0) + s.count(a)
            s = s.replace(a, b)
    return s

def walk(v):
    if isinstance(v, str):
        return fix(v)
    if isinstance(v, dict):
        return {k: walk(x) for k, x in v.items()}
    if isinstance(v, list):
        return [walk(x) for x in v]
    return v

tr = walk(tr)
P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print("замін:", sum(cnt.values()))
for k, v in sorted(cnt.items(), key=lambda x: -x[1]):
    print(f"  {k}: {v}")
blob = json.dumps(tr, ensure_ascii=False)
print("лишок 'Сутінковий Клинок':", blob.count("Сутінковий Клинок"), "| 'ґнарлдін':", blob.lower().count("ґнарлдін"))
