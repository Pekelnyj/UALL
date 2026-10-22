# -*- coding: utf-8 -*-
"""Мердж QA-фіналу журнал-хвилі (workflow #1) у translations.json.
Бере .fix.json (QA), фолбек .t.json. Категорія -> секція:
  adventure  -> journalSections
  boss_desc  -> journalSections
  subnames   -> subnames
Лише ДОДАЄ/оновлює непорожнім укр.; не чіпає наявне, не видаляє.
"""
import sys, json, glob, os, re
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
P = ROOT + "/data/translations.json"
tr = json.load(open(P, encoding="utf-8-sig"))

MAP = {"adventure": "journalSections", "boss_desc": "journalSections", "subnames": "subnames"}
def cyr(s): return bool(re.search(r"[А-Яа-яІЇЄҐ]", str(s)))

stats = {}
for cat, section in MAP.items():
    d = ROOT + f"/data/tester_new/db2clean/{cat}"
    sec = tr.setdefault(section, {})
    added = updated = skipped = 0
    # на чанк: бери .fix.json, інакше .t.json
    srcs = sorted(glob.glob(d + "/c*.json"))
    files = []
    for s in srcs:
        if os.path.exists(s + ".fix.json"): files.append(s + ".fix.json")
        elif os.path.exists(s + ".t.json"): files.append(s + ".t.json")
    for f in files:
        try:
            obj = json.load(open(f, encoding="utf-8"))
        except Exception:
            continue
        for en, ua in obj.items():
            en = en.strip()
            if not en or not isinstance(ua, str): continue
            ua = ua.strip()
            if not ua or not cyr(ua) or ua == en:
                skipped += 1; continue
            if en not in sec:
                sec[en] = ua; added += 1
            elif sec[en] != ua:
                # не перетираємо наявний переклад мовчки — лишаємо старий, рахуємо
                updated += 1
    stats[cat] = (added, updated, skipped, len(files))

json.dump(tr, open(P, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("=== МЕРДЖ журнал-хвилі ===")
for cat, (a, u, sk, nf) in stats.items():
    print(f"  {cat:10} -> {MAP[cat]:16} файлів={nf:3}  +нових={a:4}  (вже_було={u}, пропущено={sk})")
print(f"\njournalSections тепер: {len(tr.get('journalSections',{}))}")
print(f"subnames тепер: {len(tr.get('subnames',{}))}")
