# -*- coding: utf-8 -*-
# Швидка БЕЗПЕЧНА нормалізація крос-батчевих розбіжностей у translations.json.
# ЛИШЕ однозначні заміни (без контекстних колізій). Ризиковані (Nether→Нижній Світ,
# бо «Нетерокрилі» правильні) ЛИШАЮТЬСЯ на повний адверсивний QA.
# Запуск: python pipeline/qa_normalize.py
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
p = DATA / "translations.json"
tr = json.loads(p.read_text(encoding="utf-8-sig"))

# (патерн, заміна, мітка). \b з кирилицею в re працює за межами слова.
RULES = [
    (re.compile("Штормвінд"), "Стормвінд", "Stormwind"),
    (re.compile("Тінокрай"), "Тіньокрай", "Shadowlands-друк"),
    (re.compile("Острови Драконів"), "Драконові Острови", "Dragon Isles"),
    (re.compile("Зимовий Серпанок"), "Зимова Завіса", "Winter Veil-1"),
    (re.compile("Серпанок Зими"), "Зимова Завіса", "Winter Veil-2"),
    (re.compile("Зимова Завіса Серпанок"), "Зимова Завіса", "Winter Veil-3"),
    # накопичені прапорці сесії квестів
    (re.compile("Тісалі Кров\\b"), "Тісалі Кроу", "Crow-помилка"),
    (re.compile("Десвятіть це вогнище"), "Опоганьте це вогнище", "Desecrate-1"),
    (re.compile("Опогань це вогнище"), "Опоганьте це вогнище", "Desecrate-2"),
    (re.compile("Опоганити це вогнище"), "Опоганьте це вогнище", "Desecrate-3"),
    (re.compile("Опоганьте це вогнище!?"), "Опоганьте це вогнище!", "Desecrate-norm"),
    (re.compile("Школомансія"), "Сколомансія", "Scholomance"),
    (re.compile("Фіолетова Цитадель"), "Фіолетова Фортеця", "Violet Hold"),
    (re.compile("Чорний Оплот"), "Чорна Фортеця", "Ebon Hold"),
    (re.compile("Темнобережжя"), "Темне Узбережжя", "Darkshore"),
    # хвиля 8
    (re.compile("Кровосоч?не Око"), "Закривавлене Урочище", "Bleeding Hollow"),
    (re.compile("[Лл]ейстон\\b"), "лейстоун", "Leystone"),
    (re.compile("Сократар"), "Сокретар", "Socrethar"),
    (re.compile("Блек[- ]Рук Голд|Твердиня Чорний Рук"), "Твердиня Чорного Грака", "Black Rook Hold"),
    (re.compile("Палац Сакренуар|Сакренуар"), "Нічна Твердиня", "Nighthold"),
    # русизм «помож-» (усі форми: поможи/поможе/поможеш/поможу/поможіть) → «допомож-».
    # \b не дасть зачепити «допомож-» (стем тоді не на межі слова). Нема укр. слова на «помож».
    (re.compile("\\bПомож"), "Допомож", "помож-вел"),
    (re.compile("\\bпомож"), "допомож", "помож-мал"),
]

counts = {lbl: 0 for _, _, lbl in RULES}

def fix(s):
    if not isinstance(s, str):
        return s
    for rx, rep, lbl in RULES:
        s2, n = rx.subn(rep, s)
        if n:
            counts[lbl] += n
            s = s2
    return s

def walk(obj):
    if isinstance(obj, dict):
        return {k: walk(v) for k, v in obj.items()}
    if isinstance(obj, list):
        return [walk(v) for v in obj]
    return fix(obj)

tr = walk(tr)
p.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print("Нормалізовано:")
for lbl, n in counts.items():
    print(f"  {lbl:18} {n}")
print(f"Разом замін: {sum(counts.values())}")
