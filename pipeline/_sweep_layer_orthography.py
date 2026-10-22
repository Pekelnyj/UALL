# -*- coding: utf-8 -*-
"""Звести шари там, де вирок НЕ потрібен: орфографія, русизми, одруки.

Хвиля неймплейтів 18.10.2026 показала, що плашка й квест часто розходяться не
через вибір слова, а через помилку в одному з шарів. Такі випадки правимо
машинно — вибору тут немає:

  Безядерн-     -> Без'ядерн-   (без + я вимагає апострофа; у базі вже є
                                 правильний «Без'ядерний геоменталь», решта 9
                                 згадок без апострофа)
  Торґаст       -> Торгаст      (265 : 41 і канон; ґ лишаємо власним назвам,
                                 де так вирішено окремо)
  джіро/Джіро   -> джиро/Джиро  (правило дев'ятки, як Зул'джин; 28 : 20)
  РОЗШУК:       -> РОЗШУКУЄТЬСЯ: (глосарій; questLines розійшлися з цілями)
  Душопивц-     -> Душепивц-    (одрук «о» замість «е» в предметі)
  суккуб-       -> сукуб-       (подвоєння не передається)
  Грехопад      -> Гріхопад     (русизм через «е»)
  Возвишен-     -> Піднесен-    (русизм; канон Ascended = піднесений)
  Кси'рат       -> Ксай'рат     (канон Xy' = Ксай': Ксай'мокс, Ксай'вокс…)
  Зайрат/Зай'рат-> Ксай'рат     (той самий персонаж третьою формою)
  Твіджин       -> Твіґін       (ім'я від twig; ціль і опис уже «Твіґін»)

ЧОГО ТУТ НЕМА. Вибір слова (аргалі/арґалі/архар, Flayedwing, порядок
Mawsworn, Caretaker, Aspirant) — це вирок власника, не орфографія
[[questline-context-method]]. Такі пари лишаються в списку на розсуд.

Правимо ЛИШЕ значення, ніколи ключі: ключ мусить збігатися з тим, що надсилає
гра. Broadcast-секцію теж чіпаємо тут, але потім ОБОВ'ЯЗКОВО
`_rebuild_broadcast_lua.py --apply`, бо майстер — Lua-файл.

Запуск: python _sweep_layer_orthography.py [--apply]
"""
import io
import json
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))

# (що шукаємо, на що міняємо, у яких секціях — None = всюди)
RULES = [
    ("Безядерн", "Без'ядерн", None),
    ("безядерн", "без'ядерн", None),
    ("Торґаст", "Торгаст", None),
    ("Джіро", "Джиро", None),
    ("джіро", "джиро", None),
    ("РОЗШУК: ", "РОЗШУКУЄТЬСЯ: ", ("questLines",)),
    ("Душопивц", "Душепивц", None),
    ("душопивц", "душепивц", None),
    ("Суккуб", "Сукуб", None),
    ("суккуб", "сукуб", None),
    ("Грехопад", "Гріхопад", None),
    ("грехопад", "гріхопад", None),
    ("Возвишен", "Піднесен", None),
    ("возвишен", "піднесен", None),
    ("Кси'рат", "Ксай'рат", None),
    ("Зай'рат", "Ксай'рат", None),
    ("Зайрат", "Ксай'рат", None),
    ("Твіджин", "Твіґін", None),
]

hits = Counter()
examples = {}
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k, v in list(d.items()):
        if not isinstance(v, str) or not v:
            continue
        new = v
        for a, b, only in RULES:
            if only and sec not in only:
                continue
            if a in new:
                # «РОЗШУК:» не повинен з'їсти вже правильне «РОЗШУКУЄТЬСЯ:»
                if a == "РОЗШУК: " and "РОЗШУКУЄТЬСЯ" in new:
                    continue
                hits[a] += new.count(a)
                examples.setdefault(a, (sec, k, v))
                new = new.replace(a, b)
        if new != v and APPLY:
            d[k] = new

print(f"{'правило':<16}{'замін':>7}  приклад")
for a, b, _ in RULES:
    n = hits.get(a, 0)
    if not n:
        continue
    sec, k, v = examples[a]
    print(f"  {a:<14}{n:>7}  [{sec}] {v[:58]}")
print(f"\nусього замін: {sum(hits.values())}")
if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("translations.json записано")
print("ДАЛІ: python _rebuild_broadcast_lua.py --apply && python generate_db.py")
