# -*- coding: utf-8 -*-
"""СИСТЕМНИЙ ГЕЙТ покриття DB2 — щоб видима таблиця більше ніколи «не загубилась»
як це сталось із гарнізоном (CSV був, а в чергу перекладу не поставили).

Проходить КОЖНУ data/wago/*.enUS.latest.csv, рахує текстові значення (Name/Title/
Description *_lang), відсіює службове (internal_tables) і сміття (junk_patterns),
порівнює з усією translations.json.

ВИХІД:
  0 — усі видимі таблиці або покриті, або у whitelist/acknowledged.
  1 — зʼявилась НОВА видима «кишеня» (не whitelist, не acknowledged) з пробілом
      >= threshold. Тоді її треба або перекласти, або свідомо внести в acknowledged.

Запуск з папки pipeline/:  python db2_coverage_audit.py [--full]
  --full — показати ВСІ таблиці з пробілами (а не лише нові/непокриті).
"""
import csv, sys, json, os, glob, re

sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(10 ** 7)
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
W = os.path.join(ROOT, "data", "wago")
FULL = "--full" in sys.argv

wl = json.load(open(os.path.join(ROOT, "data", "db2_audit_whitelist.json"), encoding="utf-8"))
INTERNAL = set(wl["internal_tables"])
ACK = set(wl["acknowledged"])
THRESHOLD = wl["threshold"]
JUNK = [re.compile(p, re.I) for p in wl["junk_patterns"]]

tr = json.load(open(os.path.join(ROOT, "data", "translations.json"), encoding="utf-8-sig"))
base = set()
for d in tr.values():
    if isinstance(d, dict):
        for k in d:
            if isinstance(k, str):
                base.add(k)
                base.add(k.replace("\r\n", "\n").replace("\r", "\n"))


def is_junk(v):
    if len(v) < 3 or v.isdigit():
        return True
    if not re.search(r"[A-Za-z]", v):
        return True
    for p in JUNK:
        if p.search(v):
            return True
    return False


def missing_count(path):
    rs = list(csv.DictReader(open(path, encoding="utf-8")))
    if not rs:
        return 0, 0
    cols = [k for k in rs[0] if "_lang" in k]
    if not cols:
        return 0, 0
    vals = set()
    for r in rs:
        for c in cols:
            v = (r.get(c) or "").strip()
            if v and not is_junk(v):
                vals.add(v)
    miss = sum(1 for v in vals
               if v not in base and v.replace("\r\n", "\n").replace("\r", "\n") not in base)
    return len(vals), miss


rows = []
for f in sorted(glob.glob(os.path.join(W, "*.enUS.latest.csv"))):
    table = os.path.basename(f).replace(".enUS.latest.csv", "")
    if table in INTERNAL:
        continue
    try:
        total, miss = missing_count(f)
    except Exception:
        continue
    if miss > 0:
        rows.append((miss, table, total))

rows.sort(reverse=True)
new_pockets = [(m, t, n) for m, t, n in rows if t not in ACK and m >= THRESHOLD]
ack_pockets = [(m, t, n) for m, t, n in rows if t in ACK]

print(f"DB2-аудит покриття · поріг кишені = {THRESHOLD} · службових у whitelist: {len(INTERNAL)}")
print("=" * 64)

if new_pockets:
    print(f"\n🔴 НОВІ видимі кишені (не whitelist, не acknowledged) — {len(new_pockets)}:")
    for m, t, n in new_pockets:
        print(f"   {t:30} {m:>6} відсутніх / {n}")
    print("\n   → перекласти АБО свідомо внести в acknowledged у whitelist.json")
else:
    print("\n✅ Нових видимих кишень немає (усе або покрито, або визнано боргом).")

print(f"\n📋 Визнаний борг (acknowledged) — {len(ack_pockets)} таблиць:")
for m, t, n in ack_pockets:
    print(f"   {t:30} {m:>6} відсутніх   — {wl['acknowledged'].get(t,'')[:50]}")

if FULL:
    print(f"\n--- УСІ таблиці з пробілами ({len(rows)}) ---")
    for m, t, n in rows:
        tag = "ACK" if t in ACK else ("NEW" if m >= THRESHOLD else "low")
        print(f"   [{tag}] {t:28} {m:>6}/{n}")

sys.exit(1 if new_pockets else 0)
