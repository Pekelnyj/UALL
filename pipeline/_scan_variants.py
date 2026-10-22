# -*- coding: utf-8 -*-
import json, re, sys
sys.stdout.reconfigure(encoding="utf-8")
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
dt = tr["descTemplates"]
variants = ["Хімерус", "Кречпайн", "Скелесосн", "Воразій", "Вораcі", "Гнилобагн",
            "Світлокров", "Нульзон", "Формувач Порожнеч", "Пащ Порожнеч", "Вейлкрил",
            "Велґор", "Ваелґор", "Вейлгор", "Беламі", "Беллемі", "Безодній Формувач",
            "Безодній Творець"]
WORDCH = "[А-Яа-яІіЇїЄєҐґ'’]*"
forms = {}
for en, ua in dt.items():
    for v in variants:
        for m in re.findall(re.escape(v) + WORDCH, ua):
            forms.setdefault(v, {}).setdefault(m, 0)
            forms[v][m] += 1
for v in variants:
    if v in forms:
        print(v, "->", dict(sorted(forms[v].items())))
