# -*- coding: utf-8 -*-
"""ГЕЙТ КОНСИСТЕНТНОСТІ ВЛАСНИХ НАЗВ: ловить одне ім'я в кількох формах (и/і-розбіжності
в коренях транслітерацій — той самий клас, що «Сільванас vs Сильвана»)."""
import json
import re
import sys
from collections import defaultdict, Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))

# розділ для скану (за аргументом, інакше — весь корпус)
section = sys.argv[1] if len(sys.argv) > 1 else None
data = {section: tr[section]} if section and section in tr else tr

WORD = re.compile(r"[А-ЯІЇЄҐ][а-яіїєґ'А-ЯІЇЄҐ]{3,}")  # капіталізоване слово (власна назва)
# часті НЕ-власні слова на початку речення (відсіюємо шум)
STOP = set("Коли Якщо Після Перед Тепер Тоді Нехай Тільки Тобі Тебе Твій Твоя Ваш Вони Вона Воно "
           "Гравець Завдання Опис Увага Можеш Знайди Убий Поговори Принеси Збери Поверни Допоможи "
           "Цей Ця Це Той Така Таке Усі Весь Будь Може Треба Один Два Три Священна Велика Темна".split())


def words_of(v):
    if isinstance(v, str):
        for w in WORD.findall(v):
            yield w
    elif isinstance(v, dict):
        for x in v.values():
            yield from words_of(x)
    elif isinstance(v, list):
        for x in v:
            yield from words_of(x)


freq = Counter()
for v in data.values():
    for w in words_of(v):
        if w not in STOP:
            freq[w] += 1

# нормалізація: і/ї->и, є->е, ґ->г, ь-> '' -> ключ; групуємо surface-форми
def norm(w):
    s = w.lower().replace("і", "и").replace("ї", "и").replace("є", "е").replace("ґ", "г").replace("ь", "")
    return s

groups = defaultdict(Counter)
for w, n in freq.items():
    groups[norm(w)][w] += n

# флаг: и/і-розбіжність у КОРЕНІ (не в останній літері-відмінку)
def stem_diff_internal(forms):
    """True, якщо між формами є и<->і різниця НЕ в останній позиції (=справжня, не відмінок)."""
    fl = [f.lower() for f in forms]
    for a in fl:
        for b in fl:
            if a == b:
                continue
            if len(a) != len(b):
                continue  # різна довжина — порівнюємо лише рівні (відмінок міняє довжину рідко тут)
            for i, (ca, cb) in enumerate(zip(a, b)):
                if {ca, cb} <= {"и", "і", "ї"} and ca != cb and i < len(a) - 2:
                    return True
    return False


flagged = []
for key, forms in groups.items():
    if len(forms) < 2:
        continue
    if stem_diff_internal(list(forms)):
        flagged.append((sum(forms.values()), key, dict(forms)))

flagged.sort(reverse=True)
scope = section or "ВЕСЬ КОРПУС"
print(f"=== ГЕЙТ ІМЕН [{scope}]: підозри и/і-розбіжності ===")
print(f"капіталізованих унікальних: {len(freq)} | флаговано груп: {len(flagged)}\n")
for tot, key, forms in flagged[:40]:
    fs = ", ".join(f"{w}×{n}" for w, n in sorted(forms.items(), key=lambda x: -x[1]))
    print(f"[{tot:>4}] {fs}")
