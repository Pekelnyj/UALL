# -*- coding: utf-8 -*-
"""Злиття хвилі КНИГ у translations.json -> секція bookTexts.

Вхід: data/book_batches/out_b*.json {англ. сторінка: український переклад}.
Ключ мусить бути з черги (bctx_*.json) байт у байт — хук BookHooks шукає
точний збіг тексту сторінки.

Відхиляє сторінку (лишає як була) і пише причину, якщо:
  • ключа немає в черзі або він уже є в базі з іншим перекладом;
  • у перекладі немає кирилиці або лишилась латиниця довша за 3 літери
    (крім того, що є і в оригіналі: назви на кшталт «Bon-Bomb»);
  • розійшлись розмітка/плейсхолдери: {NAME}, |c…|r, |T…|t, $-коди, переноси;
  • переклад коротший за третину або довший за подвоєний оригінал (ознака
    обрізаної чи склеєної сторінки).

Запуск: python _merge_books_wave.py [--apply]
Далі:   python generate_db.py
"""
import glob
import io
import json
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
B = DATA_DIR / "book_batches"
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
book = tr.setdefault("bookTexts", {})

queue = {}
for f in sorted(glob.glob(str(B / "bctx_*.json"))):
    for it in json.loads(open(f, encoding="utf-8").read()):
        queue[it["en"]] = it

CYR = re.compile(r"[А-Яа-яІіЇїЄєҐґ]")
LAT = re.compile(r"[A-Za-z]{4,}")
CODES = (r"\{NAME\}", r"\|c[0-9A-Fa-f]{8}", r"\|r", r"\|T[^|]*\|t", r"\$[a-zA-Z]", r"\n")

ok, rej = 0, Counter()
examples = []
for f in sorted(glob.glob(str(B / "out_b*.json"))):
    try:
        d = json.loads(open(f, encoding="utf-8-sig").read())
    except ValueError as e:
        print(f"ПОМИЛКА JSON {f}: {e}")
        continue
    for en, ua in d.items():
        it = queue.get(en)
        if not it:
            rej["ключа немає в черзі"] += 1
            continue
        if not isinstance(ua, str) or not CYR.search(ua):
            rej["без кирилиці"] += 1
            continue
        stray = [w for w in set(LAT.findall(ua)) if w not in en]
        if stray:
            rej["латиниця не з оригіналу"] += 1
            examples.append((it["book"], it["page"], "латиниця: " + ", ".join(stray[:4])))
            continue
        bad = next((c for c in CODES
                    if len(re.findall(c, en)) != len(re.findall(c, ua))), None)
        if bad:
            rej["розійшлась розмітка"] += 1
            examples.append((it["book"], it["page"], f"код {bad}"))
            continue
        if not (len(en) / 3 <= len(ua) <= len(en) * 2):
            rej["довжина не збігається"] += 1
            examples.append((it["book"], it["page"], f"{len(en)} -> {len(ua)} символів"))
            continue
        if en in book and book[en] != ua:
            rej["уже в базі з іншим перекладом"] += 1
            continue
        ok += 1
        if APPLY:
            book[en] = ua

print(f"прийнято сторінок: {ok} | відхилено: {dict(rej)} | у черзі: {len(queue)} | "
      f"у базі bookTexts: {len(book)}")
for b, p, why in examples[:20]:
    print(f"   [{b}] с.{p}: {why}")
if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(json.dumps(tr, ensure_ascii=False, indent=1))
print("translations.json записано")
