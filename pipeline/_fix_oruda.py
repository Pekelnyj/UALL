# -*- coding: utf-8 -*-
"""Замінити іменник «оруда» на вживаніше слово (вирок користувача 28.08.2026).

Чому. «Під орудою» звучить неприродно носієві, а правило проєкту забороняє
рідковживані слова [[no-rare-words]]. Слово не є мовною ознакою якоїсь раси
— воно розкидане по квестах, журналу й флейворах предметів і всюди передає
англійське `command` / `leadership` / `guidance`.

Слово обираємо НЕ на смак, а за англійським оригіналом:
    command, orders            -> команда      (військове підпорядкування)
    leadership, guidance, rule -> керівництво  (провід, вишкіл, вплив)
    прямого слова немає        -> керівництво

Три місця переписано інакше, бо там жодне з двох не лягає (вирок
користувача):
    42848  «навчалися під її орудою»          -> «навчалися в неї»
    75888  «майстрів під оруду первісників»   -> «у розпорядження первісників»
    13624  «віддати тобі під оруду»           -> «віддати тобі під команду»

Дієслово «орудувати» НЕ чіпаємо — воно нормальне і вживається 20 разів.
Зворот «під проводом» (48 місць) теж лишаємо: там воєначальники й вожді,
а «керівництво» дало б канцелярський відтінок.

Запуск: python _fix_oruda.py [--apply]
Далі: python generate_db.py
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
qsrc = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))

W = re.compile(r"(під\s+(?:\S+\s+){0,2}?)оруд(ою|у|и|а|і)", re.I)
EN_KEY = re.compile(r"\b(command|leadership|guidance|tutelage|rule|charge|"
                    r"orders|behest)\b", re.I)
BY_EN = {"command": "команд", "orders": "команд",
         "leadership": "керівництв", "rule": "керівництв",
         "guidance": "керівництв", "tutelage": "керівництв",
         "charge": "керівництв", "behest": "керівництв"}
# основа -> закінчення за відмінком, у якому стояла «оруда»
ENDING = {"ою": {"команд": "ою", "керівництв": "ом"},
          "у": {"команд": "у", "керівництв": "о"},
          "и": {"команд": "и", "керівництв": "а"},
          "а": {"команд": "а", "керівництв": "о"},
          "і": {"команд": "і", "керівництв": "і"}}

# Переписані цілком (ключ -> (що шукати, на що міняти))
SPECIAL = {
    "42848": ("навчалися під її орудою", "навчалися в неї"),
    "75888": ("під оруду первісників", "у розпорядження первісників"),
    "13624": ("віддати тобі під оруду", "віддати тобі під команду"),
}


def en_for(sec, key, fld):
    if isinstance(key, str) and not key.isdigit():
        m = EN_KEY.search(key)
        if m:
            return m.group(1).lower()
    if sec == "quests":
        e = (qsrc.get(str(key)) or {}).get(fld or "description")
        e = e.get("en") if isinstance(e, dict) else e
        if isinstance(e, str):
            m = EN_KEY.search(e)
            if m:
                return m.group(1).lower()
    return ""


changed = spec = 0
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k, v in list(d.items()):
        fields = [(None, v)] if isinstance(v, str) else (
            [(f, x) for f, x in v.items() if isinstance(x, str)]
            if isinstance(v, dict) else [])
        for fld, s in fields:
            if not W.search(s):
                continue
            new = s
            sp = SPECIAL.get(str(k))
            if sp and sp[0] in new:
                new = new.replace(sp[0], sp[1])
                spec += 1
            stem = BY_EN.get(en_for(sec, k, fld), "керівництв")

            # «Оруда» жіночого роду, «керівництво» — середнього. Присвійник
            # перед ним мусить змінити рід, інакше виходить «під своєю
            # керівництвом». «Команда» жіноча, тож там нічого не чіпаємо.
            POSS = {"ою": {"своєю": "своїм", "моєю": "моїм", "твоєю": "твоїм",
                           "нашою": "нашим", "вашою": "вашим",
                           "їхньою": "їхнім"},
                    "у": {"свою": "своє", "мою": "моє", "твою": "твоє",
                          "нашу": "наше", "вашу": "ваше"}}

            def sub(m):
                head, case = m.group(1), m.group(2).lower()
                if stem == "керівництв":
                    for a, b in POSS.get(case, {}).items():
                        head = re.sub(rf"\b{a}\b", b, head, flags=re.I)
                return head + stem + ENDING[case][stem]

            new = W.sub(sub, new)
            if new == s:
                continue
            i = W.search(s).start() if W.search(s) else 0
            print(f"  [{sec}] {str(k)[:26]}{'.' + fld if fld else ''}")
            print(f"      було : …{s[max(0, i - 40):i + 40]}…")
            j = max(0, i - 40)
            print(f"      стало: …{new[j:j + 80]}…")
            if APPLY:
                if fld is None:
                    d[k] = new
                else:
                    v[fld] = new
            changed += 1

print(f"\nзмінено рядків: {changed} (з них переписано цілком: {spec})")
if APPLY:
    io.open(P, "w", encoding="utf-8", newline="\n").write(
        json.dumps(tr, ensure_ascii=False, indent=1))
    print("translations.json записано")
else:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
