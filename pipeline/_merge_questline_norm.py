# -*- coding: utf-8 -*-
"""Злити нормалізацію гілок: out_qn_*.json -> translations.quests.

Хвиля мала ЗМІНИТИ ЛИШЕ ІМ'Я, а не перекласти рядок наново. Тому тут
заслони, яких не було в інших хвиль:

  [1] id завдання мусить бути в батчі (той самий заслін, що врятував
      хвилю гілок від підміни [[kv-shift-substitution]]);
  [2] правки мають бути ТОЧКОВІ. Рахуємо частку спільного тексту зі старим
      рядком: якщо змінилося більш ніж чверть — це вже переписування, а не
      зведення форми, і в базу воно не йде;
  [3] токени й розмітка недоторкані: `{NAME}`, `{class}`, `|cFF…|r`, числа,
      кількість переносів. Втрата токена ламає підстановку в грі мовчки
      [[class-token-mechanism]].

Запуск: python _merge_questline_norm.py [--apply]
Далі: python generate_db.py
"""
import io
import json
import re
import sys
from difflib import SequenceMatcher

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
D = DATA_DIR / "batches" / "qlnorm"
CYR = re.compile("[Ѐ-ӿ]")
# Жорсткі плейсхолдери: гра підставляє в них значення, тож їхній набір
# мусить лишитися тотожним.
TOKEN = re.compile(r"\{[A-Za-z_:]+\}|\|c[Ff][Ff0-9A-Fa-f]{6}|\|r")
# Токен статі — ІНША річ: вичитка має право його ДОДАТИ, бо саме так
# лікується запечений чоловічий рід («ти зробив» -> «ти зроби$p(в:ла)»).
# Прибирати не можна: це відкат до однієї статі.
PTOK = re.compile(r"\$p\([^()]*\)")
NUM = re.compile(r"\d+")
MIN_SAME = 0.75          # менше — це вже не правка імені

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
quests = tr.setdefault("quests", {})

# що просили
asked = {}
for f in sorted(D.glob("qn_*.json")):
    for row in json.loads(f.read_text(encoding="utf-8-sig")):
        for q in row["quests"]:
            asked[q["id"]] = q

pending, rej = {}, []
files = sorted(D.glob("out_qn_*.json"))
for f in files:
    data = json.loads(f.read_text(encoding="utf-8-sig"))
    for qid, fields in data.items():
        if qid not in asked:
            rej.append((f.name, qid, "-", "id не був у завданні"))
            continue
        cur = quests.get(str(qid))
        if not isinstance(cur, dict):
            rej.append((f.name, qid, "-", "завдання немає в базі"))
            continue
        for fld, new in (fields or {}).items():
            if fld not in ("title", "description"):
                rej.append((f.name, qid, fld, "поле поза мандатом"))
                continue
            old = cur.get(fld)
            if not isinstance(old, str) or not isinstance(new, str):
                rej.append((f.name, qid, fld, "не рядок"))
                continue
            if new == old:
                continue
            if not new.strip() or not CYR.search(new):
                rej.append((f.name, qid, fld, "порожнє або без кирилиці"))
                continue
            # autojunk=False обов'язково: за замовчуванням SequenceMatcher
            # для послідовностей від 200 елементів оголошує часті символи
            # «сміттям» і зіставляє їх навмання. Через це правка одного
            # символа в описі квеста давала схожість 52% — і заслін
            # відхиляв цілком правильну зміну.
            same = SequenceMatcher(None, old, new, autojunk=False).ratio()
            if same < MIN_SAME:
                rej.append((f.name, qid, fld,
                            f"переписано ({same:.0%} спільного)"))
                continue
            if sorted(TOKEN.findall(old)) != sorted(TOKEN.findall(new)):
                rej.append((f.name, qid, fld, "змінилися плейсхолдери/розмітка"))
                continue
            if not set(PTOK.findall(old)) <= set(PTOK.findall(new)):
                rej.append((f.name, qid, fld, "зник токен статі"))
                continue
            if sorted(NUM.findall(old)) != sorted(NUM.findall(new)):
                rej.append((f.name, qid, fld, "змінилися числа"))
                continue
            if old.count("\n") != new.count("\n"):
                rej.append((f.name, qid, fld, "змінилася кількість переносів"))
                continue
            pending.setdefault(qid, {})[fld] = new

print(f"файлів-відповідей: {len(files)} | завдань у завданні: {len(asked)}")
print(f"до запису: {sum(len(v) for v in pending.values())} рядків "
      f"у {len(pending)} завданнях | відхилено: {len(rej)}")
for f, qid, fld, why in rej[:20]:
    print(f"    ✖ [{f}] {qid}.{fld}: {why}")
if len(rej) > 20:
    print(f"    …ще {len(rej) - 20}")

for qid, fields in list(pending.items())[:6]:
    for fld, new in fields.items():
        old = quests[qid][fld]
        sm = SequenceMatcher(None, old, new)
        for tag, i1, i2, j1, j2 in sm.get_opcodes():
            if tag != "equal":
                print(f"    ~ {qid}.{fld}: {old[i1:i2]!r} -> {new[j1:j2]!r}")

if APPLY:
    for qid, fields in pending.items():
        quests[qid].update(fields)
    io.open(P, "w", encoding="utf-8", newline="\n").write(
        json.dumps(tr, ensure_ascii=False, indent=1))
    print(f"\nзаписано завдань: {len(pending)}")
else:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
