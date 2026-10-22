# -*- coding: utf-8 -*-
import sys, json, glob
sys.stdout.reconfigure(encoding="utf-8")
indir = sys.argv[1]
pat = sys.argv[2] if len(sys.argv) > 2 else "dout_*.json"
src = json.load(open("data/source/spells.json", encoding="utf-8-sig"))
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
dt = tr.setdefault("descTemplates", {})

# QA-уніфікація імен до канонічних журнальних (Midnight 4 данжі)
FIX = [
    ("Скарбохапун", "Скарбохапач"),
    ("Кістія", "Кистія"),
    ("Сіндерф'юрі", "Жаргнів"), ("Жаролють", "Жаргнів"),
    ("Зіеккетт", "Зіккет"), ("Зіккетт", "Зіккет"),
    ("Таз'Рах", "Таз'Ра"),
    ("Лісіель", "Літіель"),
    ("Лайтвардена", "Світловартового"), ("Лайтварден", "Світловартовий"),
    ("Вартова Зими", "Вартовий Зими"),
    ("Ніблз", "Кусака"),
    ("Меіттік", "Меіттік"),
]


def fix(s):
    for a, b in FIX:
        if a != b:
            s = s.replace(a, b)
    return s


def den(sid):
    e = src.get(str(sid))
    return (e.get("description") or {}).get("en") if isinstance(e, dict) and isinstance(e.get("description"), dict) else None


merged = noen = 0
for f in glob.glob(indir + "/" + pat):
    for sid, ua in json.load(open(f, encoding="utf-8-sig")).items():
        en = den(sid)
        if en:
            dt[en] = fix(ua); merged += 1
        else:
            noen += 1
json.dump(tr, open("data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"описів злито: {merged} | без EN у source: {noen}")
