# -*- coding: utf-8 -*-
"""Пропозиція ремонту пар «ключ ≠ переклад» у uiTooltips (нічого не змінює).

ЩО СТАЛОСЬ. Якась партія влилася зшиванням двох по-різному впорядкованих
списків: ключі отримали переклади чужих ключів. Знайшов агент хвиління
неймплейтів на парі
    ["Use: Submit the Relic Fragments to Archivist Roh-Suir…"] = "Бойова
    барабанщиця Зурула"

ЧОМУ НЕ ПРОСТО «ПОВЕРНУТИ НА N ПОЗИЦІЙ». Я спершу вивів сталий зсув +21 із
чотирьох якорів, але на всьому блоці він розсипається: «Полонянка Бойової
матері» поїхала б на ключ «Warlock - Demonology». Сталого числа немає, тож
кожну пару розбираємо окремо.

ЯК РОЗБИРАЄМО
  1. ХИБНА ПАРА — англійський ключ на 8+ слів, а переклад на 2–3: переклад
     фізично не може бути від цього ключа.
  2. БЕЗПРИТУЛЬНИЙ ДУБЛІКАТ — те саме значення вже лежить під іншим ключем, і
     там воно доречне (збіг множини слів ≥ 0.6). Таку пару знімаємо: нічого не
     втрачається, бо правильна копія вже є.
        [Vaultbot] = «Варґарбл Злий Норов», а [Whargarble the Ill-Tempered]
        уже має цей самий переклад.
  3. СИРОТА — переклад існує ЛИШЕ в хибній парі. Його треба переспарувати
     вручну; тут лише вказуємо найправдоподібнішого власника серед ключів,
     чиє власне значення теж під підозрою.

Зняти хибну пару НЕ гірше, ніж лишити: без перекладу гравець побачить
англійський рядок, а з чужим перекладом — «Полонянку Бойової матері» на
тултіпі харчів.

Запуск: python _propose_uitooltip_repair.py
Вихід:  data/wago_bulk/_ui_repair.json (пропозиція, не правка)
"""
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
ui = tr["uiTooltips"]

EN = re.compile(r"[A-Za-z']+")
W = re.compile(r"[А-Яа-яІіЇїЄєҐґA-Za-z0-9]{3,}")


def bag(s):
    return {w.lower() for w in W.findall(s)}


def broken(k, v):
    """Переклад не може бути від цього ключа: 8+ англійських слів проти 2–3."""
    nk, nv = len(EN.findall(k)), len(W.findall(v))
    return nk >= 8 and nv and nv / nk < 0.3


suspect = {k: v for k, v in ui.items()
           if isinstance(k, str) and isinstance(v, str) and v
           and re.search("[А-Яа-яІіЇїЄєҐґ]", v) and broken(k, v)}
print(f"хибних пар: {len(suspect)}")

ok = [(k, v) for k, v in ui.items()
      if k not in suspect and isinstance(v, str) and v]

drop, orphan = [], []
for k, v in suspect.items():
    bv = bag(v)
    best, bestk = 0.0, None
    for k2, v2 in ok:
        b2 = bag(v2)
        if not b2:
            continue
        j = len(bv & b2) / len(bv | b2)
        if j > best:
            best, bestk = j, k2
    if best >= 0.6:
        drop.append({"key": k, "value": v, "copy_at": bestk, "match": round(best, 2)})
    else:
        orphan.append({"key": k, "value": v})

print(f"  безпритульних дублікатів (знімати безпечно): {len(drop)}")
print(f"  сиріт (переклад лише тут, треба переспарувати): {len(orphan)}")

out = DATA_DIR / "wago_bulk" / "_ui_repair.json"
out.write_text(json.dumps({"drop": drop, "orphan": orphan},
                          ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\n-> {out}")

print("\n--- знімаємо (копія вже є) ---")
for it in drop[:10]:
    print(f"  [{it['key'][:46]}]\n     = {it['value'][:44]!r}  копія під {it['copy_at'][:40]!r}")
print("\n--- сироти (переклад треба врятувати) ---")
for it in orphan[:14]:
    print(f"  [{it['key'][:46]}]\n     = {it['value'][:52]!r}")
