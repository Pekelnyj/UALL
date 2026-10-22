# -*- coding: utf-8 -*-
"""ГЕЙТ ПЕРЕД ЗЛИТТЯМ: нове ім'я суперечить уже наявному для ТОГО САМОГО EN.

ЧОМУ ЦЕ ВАЖЛИВО. `NpcNames.lua` ключується АНГЛІЙСЬКОЮ назвою, а база —
creatureID. Різні ID з однаковим EN — звичайна річ у датамайні:
    257145  Spitesting Hatchling  = «Злоколюче маля»     (було)
    257149  Spitesting Hatchling  = «Маля злобожала»     (хвиля 18.10)
Генератор зводить їх в ОДИН ключ, тож одна назва перезаписує іншу, і плашка
стає непередбачуваною. Для гравця це той самий різнобій, який ми й виганяємо.

Саме так і сталося: пакет доказів не показав агентові наявного «Злоколюч-»,
бо індекс прецедентів був побудований лише на creatures.json і не бачив ID з
api_creatures_full [[plates-need-en-from-captures]].

Гейт зіставляє out_*.json із наявним шаром EN→UA і показує розбіжності. Де
наявна форма краща — беремо її (--align перепише вихід хвилі); де краща нова —
треба свіпнути СТАРІ ID, і це вже рішення власника.

Запуск: python _check_wave_name_clash.py <тека з out_*.json> [--align]
"""
import glob
import json
import re
import sys
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

ALIGN = "--align" in sys.argv
dirs = [a for a in sys.argv[1:] if not a.startswith("--")]
if not dirs:
    sys.exit("вкажи теку з out_*.json")

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
npc = tr.get("npcNames") or {}

# ПОВНИЙ індекс ID -> EN: усі джерела істот, інакше гейт сам себе обдурить
en_of = {}
for name in ("api_creatures_full.json", "captured_creatures.json",
             "_midnight_creatures.json", "creatures.json"):
    p = DATA_DIR / "source" / name
    if not p.exists():
        continue
    try:
        d = json.loads(p.read_text(encoding="utf-8-sig"))
    except ValueError:
        continue
    for cid, v in (d.items() if isinstance(d, dict) else ()):
        nm = v.get("name") if isinstance(v, dict) else None
        en = nm.get("en") if isinstance(nm, dict) else None
        if en:
            en_of[str(cid)] = en

# наявні EN -> які UA вже стоять (із рахунком, щоб бачити домінанту)
have = {}
for cid, ua in npc.items():
    en = en_of.get(str(cid))
    if en and isinstance(ua, str) and ua:
        have.setdefault(en, Counter())[ua] += 1

clash, fixed = [], 0
for d in dirs:
    for f in sorted(glob.glob(str(Path(d) / "out_*.json"))):
        try:
            out = json.loads(open(f, encoding="utf-8-sig").read())
        except ValueError as e:
            print(f"!! {Path(f).name}: {e}")
            continue
        if isinstance(out, list):
            out = {str(x.get("id")): x.get("ua") for x in out if isinstance(x, dict)}
        changed = False
        for cid, ua in list(out.items()):
            en = en_of.get(str(cid))
            if not en or not isinstance(ua, str):
                continue
            old = have.get(en)
            if not old or ua in old:
                continue
            dom, n = old.most_common(1)[0]
            clash.append((Path(f).name, cid, en, ua, dom, n))
            if ALIGN:
                out[cid] = dom
                changed = True
                fixed += 1
        if changed:
            Path(f).write_text(json.dumps(out, ensure_ascii=False, indent=1),
                               encoding="utf-8")

print(f"розбіжностей із наявним шаром: {len(clash)}")
for fn, cid, en, ua, dom, n in clash:
    print(f"  [{fn}] {cid}  {en}")
    print(f"       хвиля: {ua!r}")
    print(f"       в базі: {dom!r}  (вже під {n} ID)")
if ALIGN:
    print(f"\nзведено до наявної форми: {fixed}")
else:
    print("\nЧЕРНЕТКА — виходи не змінено; --align зведе до наявної форми")
sys.exit(1 if clash else 0)
