# -*- coding: utf-8 -*-
"""Вичитка назв заклять (12.09): 10 виправлень у наявних рядках.

Порція sn_00/sn_01 виявилася фантомною — усі 59 ID уже були в базі, бо
_chunk_captured_spells.py не звірявся з нею зовсім (полагоджено). Агент
потрактував це як вичитку й знайшов справжні помилки.

Кожна правка має підставу — німецька/французька або домінанта бази, а не смак:

  Spiked Cleats        «Шиповані шипи» — безглуздя; de Stachelstollen,
                       fr Crampons; у garrison та сама здібність = «підошви»
  Darkfuse Explosives  «Темнозаплав» — одрук; домінанта Темнозапал (32)
  Haunted              de Heimgesucht / fr Hantise = переслідування,
                       не одержимість (опис: тіні ходять за гравцем)
  Singular Transit     de Singulärtransit; портал Сингулярності (116 у базі)
  Domanaar             глосарій + база 266 : 2
  Goblin               глосарій 2026: загальні назви через «г»
  Warband Map…         §12: Map = карта, не «мапа»
  Stop Climbing        «дертися» розмовне; база climbing = сходження (19)
  Armor Skills         симетрія з Weapon Skills = «Володіння зброєю»
  Broken Isles…        лише регістр за §11

Запуск: python _fix_spell_qa_0912.py [--apply]
Далі:   python generate_db.py
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
sp = tr.get("spells") or {}

FIX = {
    "473598": "Переслідуваний",
    "362141": "Шиповані підошви",
    "1278244": "Сингулярний перехід",
    "1213982": "Вибухівка Темнозапалу",
    "1236805": "Винахідливість доманаарів",
    # лише Ґ->Г за глосарієм; «клопоти» питоміше за «проблеми» — лишаємо
    "1223745": "Гоблінські клопоти",
    "431280": "Карта Загону Всюди й Водночас",
    "459357": "Припинити сходження",
    "76271": "Володіння бронею",
    # лише регістр за §11; «Слідопит» — добре укр. слово, не міняємо
    "233368": "Слідопит Розбитих Островів",
}

n, skip = 0, []
for sid, ua in FIX.items():
    old = sp.get(sid)
    if old is None:
        skip.append((sid, "немає в базі"))
        continue
    if old == ua:
        skip.append((sid, "уже так"))
        continue
    print(f"  {sid}\n     -  {old}\n     +  {ua}")
    if APPLY:
        sp[sid] = ua
    n += 1
for sid, why in skip:
    print(f"  ! {sid}: {why}")
print(f"\nзмін: {n}")

if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("translations.json записано")
