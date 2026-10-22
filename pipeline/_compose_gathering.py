# -*- coding: utf-8 -*-
"""Скласти переклади збиральних спелів (префікс+база з узгодженням роду) і додати в spells."""
import json, io, sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")

rec = json.load(open("data/_gathering_recipes.json", encoding="utf-8"))  # EN -> recipeID

# база: (UA, рід, родовий_для_Seam)
BASES = {
    "Tranquility Bloom": ("Квіт спокою", "m", "квіту спокою"),
    "Sanguithorn":       ("Кривавошип", "m", "кривавошипу"),
    "Azeroot":           ("Азекорінь", "m", "азекореня"),
    "Argentleaf":        ("Срібнолист", "m", "срібнолисту"),
    "Mana Lily":         ("Маналілея", "f", "маналілеї"),
    "Brilliant Silver":  ("Осяйне срібло", "n", "осяйного срібла"),
    "Refulgent Copper":  ("Сяйлива мідь", "f", "сяйливої міді"),
    "Umbral Tin":        ("Тіняве олово", "n", "тінявого олова"),
}
PREFIX = {
    "Lightfused": {"m": "Світлозлитий", "f": "Світлозлита", "n": "Світлозлите"},
    "Lush":       {"m": "Буйний", "f": "Буйна", "n": "Буйне"},
    "Primal":     {"m": "Первісний", "f": "Первісна", "n": "Первісне"},
    "Voidbound":  {"m": "Порожнечний", "f": "Порожнечна", "n": "Порожнечне"},
    "Wild":       {"m": "Дикий", "f": "Дика", "n": "Дике"},
    "Rich":       {"m": "Багатий", "f": "Багата", "n": "Багате"},
}


def compose(en):
    if en.endswith(" Seam"):
        base = en[:-5]
        uab, g, gen = BASES[base]
        return "Жила " + gen
    # знайти базу як суфікс
    for base in sorted(BASES, key=len, reverse=True):
        if en == base:
            return BASES[base][0]
        if en.endswith(" " + base):
            pref = en[:-(len(base) + 1)].strip()
            uab, g, gen = BASES[base]
            if pref in PREFIX:
                return PREFIX[pref][g] + " " + uab
            raise ValueError("невідомий префікс: " + pref + " у " + en)
    raise ValueError("невідома база: " + en)


out = {}
for en, rid in rec.items():
    ua = compose(en)
    out[str(rid)] = ua

# показати
for en in sorted(rec, key=lambda x: (x.split()[-1], x)):
    print(f"  {en:28s} -> {compose(en)}")
print(f"\nВсього: {len(out)}")

# додати в translations.spells
TR = json.load(open("data/translations.json", encoding="utf-8"))
sp = TR.setdefault("spells", {})
added = 0
for rid, ua in out.items():
    if sp.get(rid) != ua:
        sp[rid] = ua
        added += 1
json.dump(TR, open("data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"Додано/оновлено в spells: {added}")
