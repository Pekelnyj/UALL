# -*- coding: utf-8 -*-
"""Викинути з ВИХОДІВ ХВИЛІ рядки з іменами живих гравців — перед злиттям.

Преп відсіює ніки на вході, але два шляхи лишаються:
  1) нік, якого ще немає в списку (його додають уже після того, як побачать);
  2) агент приймає нік за ім'я персонажа й перекладає його — 14.10 один агент
     переклав «the goddess, <нік>» як «богиня Фірдіоніс», хоча в тому ж
     зборі лежить «You have earned the title 'Crusader <нік>'».

Тому перевіряємо ВИХІД, а не лише вхід: і англійський ключ, і український
переклад (нік у перекладі буває транслітерованим, тож звіряємо й за першими
літерами) [[guild-names-never-translate]].

Запуск: python _drop_nicks_from_wave.py <тека з out_*.json> [--apply]
"""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import strong_nicks

APPLY = "--apply" in sys.argv
dirs = [a for a in sys.argv[1:] if not a.startswith("--")]
if not dirs:
    sys.exit("вкажи теку з out_*.json")

# ЛИШЕ надійні ніки (ручний BASE + власники зборів). Повний зібраний список
# шукати всередині назв не можна: 14.10 він зняв законний предмет «Duskmantle
# Spiteglass», бо хтось узяв собі таке слово за нік [[guild-names-never-translate]].
nicks = {n for n in strong_nicks(min_len=4, drop_ambiguous=False)}
LAT = re.compile(r"\b(" + "|".join(re.escape(n) for n in sorted(nicks, key=len, reverse=True))
                 + r")\b") if nicks else None

# транслітерація ніка: беремо перші 4 латинські літери і прикидаємо кириличні
TRANS = str.maketrans({"a": "а", "b": "б", "c": "к", "d": "д", "e": "е", "f": "ф",
                       "g": "ґ", "h": "г", "i": "і", "j": "дж", "k": "к", "l": "л",
                       "m": "м", "n": "н", "o": "о", "p": "п", "q": "к", "r": "р",
                       "s": "с", "t": "т", "u": "у", "v": "в", "w": "в", "x": "кс",
                       "y": "и", "z": "з"})
cyr_stems = {n.lower().translate(TRANS)[:4] for n in nicks if len(n) >= 5}

total = dropped = 0
for d in dirs:
    for f in sorted(Path(d).glob("out_*.json")):
        data = json.loads(f.read_text(encoding="utf-8-sig"))
        keep, gone = {}, []
        for k, v in data.items():
            ua = v if isinstance(v, str) else (v.get("name") if isinstance(v, dict) else "")
            total += 1
            hit = LAT.search(k) if LAT else None
            if not hit and isinstance(ua, str):
                low = ua.lower()
                for st in cyr_stems:
                    if st and st in low and LAT and LAT.search(k):
                        hit = True
                        break
            if hit:
                gone.append((k, ua))
                continue
            keep[k] = v
        if gone:
            dropped += len(gone)
            print(f"{f.name}: викинуто {len(gone)}")
            for k, ua in gone[:5]:
                print(f"   EN: {k[:70]}\n   UA: {str(ua)[:70]}")
            if APPLY:
                f.write_text(json.dumps(keep, ensure_ascii=False, indent=1),
                             encoding="utf-8")

print(f"\nперевірено рядків: {total} | з ніками: {dropped}")
if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
