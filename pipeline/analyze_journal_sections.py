# -*- coding: utf-8 -*-
"""Аналіз api_journal_sections.json: що всередині 1.5 млн символів секцій."""
import sys, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

d = json.loads((DATA_DIR / "source" / "api_journal_sections.json").read_text(encoding="utf-8-sig"))
items = [(t, len(v.get("enc", []))) for t, v in d.items()]
total_chars = sum(len(t) for t, _ in items)
print(f"Рядків: {len(items)} | символів: {total_chars:,}\n")

# 1) Розподіл за довжиною
buckets = [(0, 20, "дуже короткі (титули/мітки)"), (20, 60, "короткі"),
           (60, 200, "середні"), (200, 600, "довгі (механіки)"), (600, 10**9, "дуже довгі")]
print("=== За довжиною ===")
for lo, hi, label in buckets:
    sel = [t for t, _ in items if lo <= len(t) < hi]
    ch = sum(len(t) for t in sel)
    print(f"  {label:32} {len(sel):6} рядків | {ch:>10,} символів ({100*ch//total_chars}%)")

# 2) Повторюваність (рядок у скількох енкаунтерах)
shared = [(t, n) for t, n in items if n >= 3]
shared_chars = sum(len(t) for t, _ in shared)
print(f"\n=== Спільні (у 3+ боса) ===")
print(f"  {len(shared)} рядків, {shared_chars:,} символів — перекласти РАЗ, діють усюди")
uniq = [t for t, n in items if n == 1]
print(f"  Унікальних (рівно 1 бос): {len(uniq)} | {sum(len(t) for t in uniq):,} символів")

print(f"\n=== ТОП-25 найповторюваніших (титули/спільні мітки) ===")
for t, n in sorted(items, key=lambda x: -x[1])[:25]:
    print(f"  x{n:4} | {t[:70]!r}")

# 3) Скільки коротких титулів (часто це назви здібностей/мітки складності)
titles = [t for t, _ in items if len(t) < 40 and "\n" not in t]
print(f"\nКоротких (<40, без \\n, ймовірно титули/здібності): {len(titles)}")
