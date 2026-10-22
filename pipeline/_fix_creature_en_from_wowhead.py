# -*- coding: utf-8 -*-
"""Виправити в creatures.json англійські назви, які насправді НІМЕЦЬКІ.

ЧОМУ ЦЕ ВАЖЛИВО. generate_db.id_to_en бере назву істоти СПЕРШУ з
creatures.json, і з неї будує ключ плашки в NpcNames.lua. Збирач плашок
записував назву такою, яку показувала гра, тож тестер із німецьким клієнтом
заніс у датамайн «Feldmarschall Rohamus» замість «Field Marshal Rohamus».
Наслідок: переклад за ID правильний, а плашка отримує німецький ключ і в
англійського гравця не спрацьовує НІКОЛИ — робота зроблена, у грі не видно.

Фільтр мови (capfilter.is_foreign) ловить німецьку з умляутами й службовими
словами, але не «Wachoffizier Cragtar» чи «Bruder Daniels». Тому доказ тут
інший — англійська назва ТОГО САМОГО ID з wowhead, яку агенти хвилі 13.09
дотягнули у свої кеші.

Кеші: *wowhead*.json у теці скретчпада (передається аргументом).
Змінюємо лише ГОЛІ записи (name.en без de/fr) — справжні записи датамайну
мають локалізації, їх не чіпаємо.

Запуск: python _fix_creature_en_from_wowhead.py <тека_з_кешами> [--apply]
Далі:   python generate_db.py
"""
import io
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
args = [a for a in sys.argv[1:] if not a.startswith("--")]
if not args:
    sys.exit("вкажи теку з кешами wowhead")
CACHE_DIR = Path(args[0])
P = DATA_DIR / "source" / "creatures.json"
cr = json.loads(P.read_text(encoding="utf-8-sig"))

wh = {}
for f in CACHE_DIR.glob("*wowhead*.json"):
    try:
        d = json.loads(f.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        continue
    if isinstance(d, dict):
        for cid, v in d.items():
            if isinstance(v, dict):
                e = v.get("en") or v.get("name_en") or v.get("name")
                if isinstance(e, str) and e.strip():
                    wh[str(cid)] = e.strip()
print(f"англійських назв у кешах: {len(wh)}")

fix = []
for cid, v in cr.items():
    nm = v.get("name") if isinstance(v, dict) else None
    if not isinstance(nm, dict):
        continue
    en = nm.get("en")
    if not en or [k for k in nm if nm.get(k)] != ["en"]:
        continue                          # не голий запис — справжній датамайн
    w = wh.get(str(cid))
    if not w or w == en:
        continue
    # регістр і дефіси — не підміна мови, лишаємо як є
    if w.lower().replace("-", " ") == en.lower().replace("-", " "):
        continue
    fix.append((cid, en, w))

print(f"голих записів із назвою, що не збігається з wowhead: {len(fix)}")
for cid, en, w in fix[:20]:
    print(f"   {cid}: {en!r} -> {w!r}")
if len(fix) > 20:
    print(f"   … ще {len(fix) - 20}")

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
for cid, _en, w in fix:
    cr[cid]["name"]["en"] = w
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(cr, ensure_ascii=False, indent=2))
print(f"\nвиправлено {len(fix)}; creatures.json записано")
