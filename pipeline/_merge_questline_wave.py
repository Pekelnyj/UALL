# -*- coding: utf-8 -*-
"""Злити батчі гілок (out_ql_*.json {англ: укр}) у translations.questLines.

Ключ секції questLines — АНГЛІЙСЬКА НАЗВА [[sv-bucket-vs-section-key]].

ГОЛОВНИЙ ЗАСЛІН: ключ відповіді мусить бути серед ключів ЗАВДАННЯ. Саме
цього бракувало `_merge_uitt_wave.py` — він брав будь-який ключ, що йому
дали, тож коли хвиля приписала правильні тіла ключам-сусідам по абетці,
злиття записало це мовчки і в грі під «Warlock - Demonology» опинилося
тіло підказки іграшки [[kv-shift-substitution]]. Тут звірка можлива, бо
батчі-завдання ql_*.json лишаються на диску поруч із відповідями.

Решта перевірок як в інших хвиль: кирилиця обов'язкова, порожнє не беремо,
однакове значення під двома різними ключами — підозра на ту саму підміну.

Запуск: python _merge_questline_wave.py [--apply]
Далі: python generate_db.py && python _check_kv_shift.py
"""
import io
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
CYR = re.compile("[Ѐ-ӿ]")
D = DATA_DIR / "batches" / "questlines"

# Що просили перекласти
asked = {}
for f in sorted(D.glob("ql_*.json")):
    for x in json.loads(f.read_text(encoding="utf-8-sig")):
        asked[x["en"]] = x
print(f"у завданні: {len(asked)} гілок")

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
sec = tr.setdefault("questLines", {})

add = skip = alien = nocyr = 0
pending = {}
for f in sorted(D.glob("out_ql_*.json")):
    data = json.loads(f.read_text(encoding="utf-8-sig"))
    for en, ua in data.items():
        if en not in asked:
            # Ключа не було в завданні: або перекладач його вигадав, або
            # приписав тіло чужому рядку. І те, і те в базу не пускаємо.
            print(f"  ЧУЖИЙ КЛЮЧ [{f.name}]: {en[:60]!r} -> {str(ua)[:50]!r}")
            alien += 1
            continue
        if not (isinstance(ua, str) and ua.strip() and CYR.search(ua)):
            print(f"  БЕЗ КИРИЛИЦІ [{f.name}]: {en[:50]!r} -> {str(ua)[:40]!r}")
            nocyr += 1
            continue
        if sec.get(en) == ua:
            skip += 1
            continue
        pending[en] = ua

# Одне й те саме значення під різними ключами — та сама хвороба, інший бік.
rev = defaultdict(list)
for en, ua in pending.items():
    rev[ua].append(en)
dups = {ua: ks for ua, ks in rev.items() if len(ks) > 1}
for ua, ks in dups.items():
    print(f"  ОДНЕ ЗНАЧЕННЯ НА {len(ks)} КЛЮЧІВ: {ua[:44]!r} <- {[k[:28] for k in ks]}")

print(f"\nдо запису: {len(pending)} | без змін: {skip} | "
      f"чужих ключів: {alien} | без кирилиці: {nocyr} | "
      f"значень-дублікатів: {len(dups)}")

missing = sorted(set(asked) - set(pending) - {k for k in asked if sec.get(k)})
if missing:
    print(f"НЕ ПЕРЕКЛАДЕНО: {len(missing)}")
    for m in missing[:12]:
        print("   ", m[:60])

if APPLY:
    sec.update(pending)
    io.open(P, "w", encoding="utf-8", newline="\n").write(
        json.dumps(tr, ensure_ascii=False, indent=1))
    print(f"\nзаписано {len(pending)}; questLines разом: {len(sec)}")
else:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
