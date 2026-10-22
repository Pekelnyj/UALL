# -*- coding: utf-8 -*-
"""Черга книг: відсів сторінок з іменами гравців + розкладка по агентах.

extract_capture_books.py збирає сторінки з усіх зборів і міняє ІМ'Я ВЛАСНОГО
персонажа на {NAME}. Але в книгах-листівках гра підставляє й ЧУЖІ імена
(«Dearest <нік>,» у валентинці), а такий ключ мертвий для всіх, крім одного
гравця, і сам є витоком [[guild-names-never-translate]]. Тут:

  • сторінки з НАДІЙНИМ ніком (ручний список + meta.playerName зборів) —
    виключаємо; якщо для сторінки є двійник із {NAME}, вона й так покрита;
  • сторінки, де сам текст — лише ім'я або службовий відбиток, — виключаємо;
  • решту складаємо по PARTS однакових за обсягом частин (слова, не сторінки:
    у книгах сторінки різної довжини).

Вихід: data/book_batches/bctx_NN.json — [{"book","page","en"}], відсортовано
за книгою й сторінкою, щоб агент бачив зв'язний текст.
Злиття: _merge_books_wave.py -> translations.json["bookTexts"].

Запуск: python _prep_books_wave.py [--parts 12]
"""
import glob
import json
import re
import sys
from collections import Counter, defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import strong_nicks

PARTS = int(sys.argv[sys.argv.index("--parts") + 1]) if "--parts" in sys.argv else 12
B = DATA_DIR / "book_batches"
pages = {}
for f in sorted(glob.glob(str(B / "batch_*.json"))):
    for en, meta in json.loads(open(f, encoding="utf-8").read()).items():
        pages[en] = meta

nicks = strong_nicks(min_len=4)
NICK = re.compile(r"(?:(?<=\|c[0-9A-Fa-f]{8})|\b)("
                  + "|".join(re.escape(n) for n in sorted(nicks, key=len, reverse=True)) + r")\b")
JUNK = re.compile(r"^\s*$|^[\W\d]+$")

keep, drop = [], Counter()
dropped_examples = []
for en, meta in pages.items():
    m = NICK.search(en)
    if m:
        drop["ім'я гравця в тексті"] += 1
        if len(dropped_examples) < 10:
            dropped_examples.append((meta["_book"], m.group(1), en[:70]))
        continue
    if JUNK.match(en) or len(en.split()) < 2:
        drop["порожня/службова сторінка"] += 1
        continue
    keep.append({"book": meta["_book"], "page": meta["_page"], "en": en})

keep.sort(key=lambda x: (x["book"], x["page"]))
print(f"сторінок у черзі: {len(pages)} | лишилось: {len(keep)} | відсіяно: {dict(drop)}")
for b, n, t in dropped_examples:
    print(f"   [{b}] нік «{n}»: {t}…")

words = sum(len(x["en"].split()) for x in keep)
print(f"слів: {words} | книг: {len({x['book'] for x in keep})}")

for f in B.glob("bctx_*.json"):
    f.unlink()
# розкладка ПО КНИГАХ: одна книга — один агент, щоб стиль і імена не розійшлись
by_book = defaultdict(list)
for x in keep:
    by_book[x["book"]].append(x)
order = sorted(by_book.values(), key=lambda v: -sum(len(p["en"].split()) for p in v))
parts = [[] for _ in range(PARTS)]
sizes = [0] * PARTS
for book_pages in order:                      # найбільші книги першими, у найлегшу частину
    i = sizes.index(min(sizes))
    parts[i] += book_pages
    sizes[i] += sum(len(p["en"].split()) for p in book_pages)
for i, part in enumerate(parts):
    if not part:
        continue
    part.sort(key=lambda x: (x["book"], x["page"]))
    p = B / f"bctx_{i:02d}.json"
    p.write_text(json.dumps(part, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"  {p.name}: сторінок {len(part)}, слів {sizes[i]}, книг "
          f"{len({x['book'] for x in part})}, {p.stat().st_size // 1024} КБ")
