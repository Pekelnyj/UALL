# -*- coding: utf-8 -*-
"""Ключі із запеченим іменем гравця, які видно за власним значенням.

Ознака самоочевидна й не потребує списку ніків: якщо ЗНАЧЕННЯ містить {name}
(бо перекладач токенізував звертання), а КЛЮЧ — ні, то в ключі на місці токена
стоїть чиєсь ім'я. Хук нормалізує ім'я ВЛАСНОГО персонажа перед пошуком, тож
такий ключ мертвий для всіх, крім одного гравця, і щоразу вертається в чергу
збору як «новий рядок».

Знаходимо слово-кандидата, зіставляючи ключ із його ж перекладеним двійником,
у якого токен уже стоїть. Це дзеркало до перевірки «ключ із токеном, значення
без токена».

Запуск: python _fix_untokenized_keys.py [--apply]
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
SECTIONS = {"gossip": "{name}", "broadcast": "{NAME}"}
WORD = re.compile(r"\b[A-ZÀ-Þ][A-Za-zÀ-ÿ']{2,}\b")

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
total = 0

for sec, tok in SECTIONS.items():
    d = tr.get(sec)
    if not isinstance(d, dict):
        continue
    # шаблони, у яких токен уже стоїть у ключі
    tpl = {re.sub(r"\s+", " ", k).strip() for k in d
           if isinstance(k, str) and tok in k}
    hits = {}
    for k, v in d.items():
        if not (isinstance(k, str) and isinstance(v, str)):
            continue
        if tok in k or tok not in v:
            continue
        for m in WORD.finditer(k):
            cand = k[:m.start()] + tok + k[m.end():]
            if re.sub(r"\s+", " ", cand).strip() in tpl:
                hits[k] = (cand, m.group(0))
                break
    for k, (nk, w) in hits.items():
        print(f"  [{sec}] «{w}» -> {tok}: {k[:58]!r}")
    total += len(hits)
    if APPLY:
        for k, (nk, _) in hits.items():
            v = d.pop(k)
            d.setdefault(nk, v)

print(f"\nключів із запеченим іменем: {total}")
if not APPLY:
    print("(звіт; щоб застосувати — --apply)")
    sys.exit(1 if total else 0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("translations.json оновлено")
