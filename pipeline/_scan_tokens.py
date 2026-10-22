# -*- coding: utf-8 -*-
"""Скан форм проблемних токенів по ВСІХ таблицях translations.json."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from collections import Counter

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))

GROUPS = {
    "Kargath surname": [r"Лезокулак", r"Блейдфіст", r"Клинкокулак", r"Лезокулака", r"Блейдфіста"],
    "Kargath first": [r"Карґат", r"Каргат"],
    "Ahn'kahar": [r"Ан'кагар", r"Ан'кахар"],
    "Windfury Totem": [r"Тотем Лютого Вітру", r"Тотем Шаленства Вітру",
                       r"Лютого [Вв]ітру", r"Шаленства [Вв]ітру"],
}


def allvals():
    for tname, tbl in tr.items():
        if not isinstance(tbl, dict):
            continue
        for k, v in tbl.items():
            if isinstance(v, str):
                yield tname, v
            elif isinstance(v, dict):
                for vv in v.values():
                    if isinstance(vv, str):
                        yield tname, vv


cnt = {g: Counter() for g in GROUPS}
bytbl = {g: Counter() for g in GROUPS}
for g, pats in GROUPS.items():
    for pat in pats:
        rx = re.compile(pat)
        for tname, v in allvals():
            for _ in rx.finditer(v):
                cnt[g][pat] += 1
                bytbl[g][tname] += 1

for g in GROUPS:
    print(f"=== {g} ===")
    for pat, c in cnt[g].most_common():
        print(f"  {pat}: {c}")
    print(f"  (по таблицях: {dict(bytbl[g])})")
