# -*- coding: utf-8 -*-
"""Скан ОПИСОВИХ дрейф-форм епітетів (мали б транслітеруватися за політикою).
Показує форму + к-сть + таблиці + приклад, щоб агент потім контекстно судив
(особа→транслітерувати, клан/раса/буквальне→лишити)."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from collections import Counter

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))

# описова_форма : канон-транслітерація (для довідки)
DRIFT = {
    "Пеклокрик": "Геллскрім (Hellscream)",
    "Кровокопит": "Бладгуф (Bloodhoof)",
    "Кривавокопит": "Бладгуф (Bloodhoof)",
    "Вітрогін": "Віндраннер (Windrunner)",
    "Вітробіг": "Віндраннер (Windrunner)",
    "Лютошторм": "Стормрейдж (Stormrage)",
    "Бурегнів": "Стормрейдж (Stormrage)",
    "Тіньоспів": "Шедовсонг (Shadowsong)",
    "Бронзоборід": "Бронзбірд (Bronzebeard)",
    "Шепіт Вітру": "Віспервінд (Whisperwind)",
    "Смертокрил": "Дезвінг (Deathwing)",
    "Громовий Молот": "Тандерфордж?",
    "Молот Долі": "Думгаммер (Doomhammer)",
    "Чорнорук": "Блекгенд (Blackhand)",
    "Чорнодих": "Блеквбрет? (Blackbreath)",
}

vals = []
for tname, tbl in tr.items():
    if not isinstance(tbl, dict):
        continue
    for k, v in tbl.items():
        if isinstance(v, str):
            vals.append((tname, v))
        elif isinstance(v, dict):
            for vv in v.values():
                if isinstance(vv, str):
                    vals.append((tname, vv))

for form, canon in DRIFT.items():
    rx = re.compile(form)
    bytbl = Counter()
    ex = None
    total = 0
    for tname, v in vals:
        if rx.search(v):
            bytbl[tname] += 1
            total += 1
            if ex is None:
                ex = v[:75]
    if total:
        print(f"{form} (канон {canon}): {total} | {dict(bytbl)}")
        print(f"    напр.: {ex!r}")
