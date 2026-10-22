# -*- coding: utf-8 -*-
"""ГЕЙТ: у тому, що бачить гравець, немає російських даних.

Принцип проєкту: жодного байта російських даних — ні як джерела, ні як контексту
([[no-russian-calques]]). Гейт перевіряє те, що їде в архів (усі теки addon/) і майстер
data/translations.json, і падає (код 1), якщо знаходить:
  * літери, яких немає в українській абетці (ы, э, ъ, ё і великі): так «Тіньовиры»
    й «Хаотичні Виры» дожили до бази (знайдено 07.10.2026);
  * код російської локалі (ruRU, ru_RU) у шляху чи в тексті.
Робочі скрипти pipeline/ навмисно не перевіряються: шукачі русизмів містять ці літери
як зразки. Перенесено з проєкту Forever (tools/ru_guard.py).

Запуск: python pipeline/_ru_guard.py
"""
import os
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import ADDON_ROOT, DATA_DIR

RU_LETTERS = re.compile("[ыэъёЫЭЪЁ]")
RU_LOCALE = re.compile(r"ru[-_]?RU")  # саме код локалі, без ignorecase: не ловити «Kuruuru»


def targets():
    yield DATA_DIR / "translations.json"
    for dirpath, dirnames, filenames in os.walk(ADDON_ROOT):
        dirnames[:] = [d for d in dirnames if d not in {".git", "__pycache__"}]
        for name in filenames:
            yield Path(dirpath) / name


def main():
    problems = []
    for path in targets():
        rel = path.relative_to(ADDON_ROOT.parent)
        if RU_LOCALE.search(str(rel)):
            problems.append((rel, "код російської локалі у шляху", ""))
            continue
        try:
            raw = path.read_bytes()
        except OSError:
            continue
        if b"\0" in raw[:4096]:
            continue                                   # бінарні (шрифти, текстури)
        text = raw.decode("utf-8", errors="replace")
        m = RU_LETTERS.search(text) or RU_LOCALE.search(text)
        if m:
            n = len(RU_LETTERS.findall(text)) + len(RU_LOCALE.findall(text))
            ctx = text[max(0, m.start() - 40): m.end() + 30].replace("\n", " ")
            problems.append((rel, f"знахідок: {n}", ctx))
    for rel, why, ctx in problems:
        print(f"РОСІЙСЬКІ ДАНІ: {rel} — {why}" + (f"\n    …{ctx}…" if ctx else ""))
    if problems:
        sys.exit(1)
    print("OK: російських даних в аддоні й майстрі немає")


if __name__ == "__main__":
    main()
