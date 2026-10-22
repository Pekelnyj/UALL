# -*- coding: utf-8 -*-
"""ГЕЙТ ГОМОГЛІФІВ: латинська літера всередині українського слова.

«Ороча Окутa Бочка» — тут «a» латинська. Око не бачить різниці, гейт
кирилиці не спрацьовує (кирилиця ж у рядку Є), а в грі такий рядок просто
ніколи не зіставиться з ключем або показує те, що виглядає правильно, але
ламає пошук і сортування.

Шукаємо СЛОВА, де літери обох абеток змішані. Чисто латинські слова
(назви, коди, «PvP», «R0CKY») не чіпаємо — вони законні.

Запуск: python _check_homoglyphs.py [--fix]
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

FIX = "--fix" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))

# Апостроф НЕ належить до жодної абетки: якщо вписати його в кириличний клас,
# «Enforcer's» виглядає як змішане слово (r + ') — так перша версія гейта дала
# 4 835 хибних влучань. Так само спершу треба зняти розмітку: «|cFFFFFFFFДає»
# це код кольору плюс українське слово, а не латиниця в слові.
# Гра приймає маркери і в нижньому, і у верхньому регістрі («|cFF…» і «|CFF…»),
# тож регекс мусить знати обидва — інакше «|CFFffffffВідстрочення» виглядає як
# латиниця всередині українського слова.
MARKUP = re.compile(r"\|[cC][0-9A-Fa-f]{8}|\|[rR]|\|[tT][^|]*\|[tT]|\|[aA][^|]*\|[aA]"
                    r"|\|[hH][^|]*\|[hH]|\|[hH]"
                    r"|\|[nN]"                       # «|n» — перенос рядка гри
                    r"|\\[nrt]"                      # «\n» ДВОМА символами (так
                    # переноси лежать у частині ґосипу). Без цього правила
                    # латинська «n» злипалася з наступним кириличним словом і
                    # гейт 24 рази показував уявний гомогліф «nЩоразу»
                    r"|\$\d+[lL]"                    # «$19505l…» — плюральна форма
                    r"|\$[A-Za-z@<][\w@<>.;/*]*|\$\{[^}]*\}|%[\d$]*[a-zA-Z]|\{[Nn][Aa][Mm][Ee]\}",
                    re.UNICODE)
CYR = "А-Яа-яІіЇїЄєҐґ"
LAT = "A-Za-z"
WORD = re.compile(rf"[{CYR}{LAT}][{CYR}{LAT}'’]*")
# латиниця -> кирилиця для літер, НЕВІДРІЗНЯННИХ на вигляд
HOMO = str.maketrans({"a": "а", "c": "с", "e": "е", "i": "і", "o": "о", "p": "р",
                      "x": "х", "y": "у", "A": "А", "B": "В", "C": "С", "E": "Е",
                      "H": "Н", "I": "І", "K": "К", "M": "М", "O": "О", "P": "Р",
                      "T": "Т", "X": "Х", "Y": "У"})

# НЕВИДИМІ СИМВОЛИ. М'який перенос U+00AD усередині «коваль­ська» знайшов агент
# 18.10: на око слово ціле, а ключ не зіставиться ніколи. Той самий клас, що й
# гомогліфи, тільки гірший — його не видно навіть у diff. Нерозривний пробіл
# теж ламає збіг із тим, що надсилає гра.
INVISIBLE = {"­": "м'який перенос", "​": "нульовий пробіл",
             "‌": "незлучник", "‍": "злучник", "﻿": "BOM-символ",
             " ": "нерозривний пробіл", "⁠": "незримий з'єднувач"}

hits, fixed = [], 0
inv_hits = []
for _sec, _d in tr.items():
    if not isinstance(_d, dict):
        continue
    for _k, _v in _d.items():
        for _s, _why in ((_k, "ключ"), (_v, "значення")):
            if not isinstance(_s, str):
                continue
            for _ch, _name in INVISIBLE.items():
                if _ch in _s:
                    inv_hits.append((_sec, _why, _name, _s[:60]))
print(f"НЕВИДИМІ символи: {len(inv_hits)}")
for _sec, _why, _name, _s in inv_hits[:10]:
    print(f"   [{_sec}] {_why}: {_name} у «{_s}»")

# ЧИСТИМО ЛИШЕ ЗНАЧЕННЯ. У КЛЮЧІ нерозривний пробіл може бути саме тим, що
# надсилає гра («The Harbinger »), і його вилучення РОЗІРВЕ збіг — ключ
# мусить лишатися дзеркалом гри, хай навіть дивним.
_CLEAN = {"­": "", "​": "", "‌": "", "‍": "",
          "﻿": "", "⁠": ""}
_inv_fixed = 0
if FIX:
    for _sec, _d in tr.items():
        if not isinstance(_d, dict):
            continue
        for _k, _v in list(_d.items()):
            if not isinstance(_v, str):
                continue
            _new = _v
            for _ch, _rep in _CLEAN.items():
                _new = _new.replace(_ch, _rep)
            if _new != _v:
                _d[_k] = _new
                _inv_fixed += 1
    print(f"   вичищено невидимих символів у значеннях: {_inv_fixed} "
          f"(ключі не чіпали)")

for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k, v in list(d.items()):
        if not isinstance(v, str):
            continue
        clean = MARKUP.sub(" ", v)
        bad = [w for w in WORD.findall(clean)
               if re.search(f"[{CYR}]", w) and re.search(f"[{LAT}]", w)]
        if not bad:
            continue
        new = v
        for w in bad:
            # міняємо лише ті латинські літери, що мають двійника-гомогліф
            repl = w.translate(HOMO)
            if repl != w and not re.search(rf"[{LAT}]", repl):
                new = new.replace(w, repl)
        hits.append((sec, k, v, bad, new))
        if FIX and new != v:
            d[k] = new
            fixed += 1

print(f"рядків зі змішаними абетками: {len(hits)}")
for sec, k, v, bad, new in hits[:25]:
    mark = "  ->  " + new[:60] if new != v else "   (латиниця законна)"
    print(f"  [{sec}] {k[:44]}\n     «{v[:60]}»  слова: {bad[:3]}{mark}")
if not FIX:
    print("\nЧЕРНЕТКА — нічого не записано, додай --fix")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print(f"виправлено рядків: {fixed} | translations.json записано")
