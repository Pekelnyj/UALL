# -*- coding: utf-8 -*-
"""Полагодити баги $p-токенів: -шов/-йшов (знайшов/знайшла), подвійні хвости,
літеральні (ла)/(ий:а)."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
P = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(P.read_text(encoding="utf-8-sig"))
DOL = "$"
PT = DOL + "p"

cnt = {"shov": 0, "tail": 0, "lit": 0, "oe": 0}


def fix(s):
    if PT not in s and "(" not in s:
        return s
    # A) "шо$p(в:ла)" → "ш$p(ов:ла)"  (знайшов/знайшла, пішов/пішла, прийшов/прийшла)
    def a(m):
        cnt["shov"] += 1
        return m.group(1) + "ш" + PT + "(ов:ла)"
    s = re.sub(r"(\w*?)шо\$p\(в:ла\)", a, s)
    # A2) інші о/е перед $p(в:ла) (рідкісні; плив→пливла): "Xо$p(в:ла)"/"Xе$p(в:ла)"
    #     для плив-типу: "пли в"→"плив$p(:ла)"? тут о/е лишилось лише не-шов → лог
    # B) подвійний хвіст: "$p(в:ла)(ла)" → "$p(в:ла)";  "$p(ий:а)(а)" → "$p(ий:а)"
    def b(m):
        cnt["tail"] += 1
        return m.group(0).split(")(")[0] + ")"
    s = re.sub(r"\$p\([^)]*\)\([А-Яа-яІЇЄҐ]+\)", b, s)
    # C) літеральні ручні форми перекладача: "Xв(ла)"→"X$p(в:ла)", "Xвся(лася)"→...,
    #    "Xий(а)"/"Xий/а"→"X$p(ий:а)" — лише типові гендерні хвости
    def c1(m):
        cnt["lit"] += 1
        return m.group(1) + PT + "(в:ла)"
    s = re.sub(r"(\w+?[аяиіуї])в\(ла\)", c1, s)        # зробив(ла)→зроби$p(в:ла)
    def c2(m):
        cnt["lit"] += 1
        return m.group(1) + PT + "(вся:лася)"
    s = re.sub(r"(\w+?)вся\(лася\)", c2, s)
    def c3(m):
        cnt["lit"] += 1
        return m.group(1) + PT + "(ий:а)"
    s = re.sub(r"(\w+?)ий\((?:а|ла)\)", c3, s)          # готовий(а)→готов$p(ий:а)
    return s


def walk(v):
    if isinstance(v, str):
        return fix(v)
    if isinstance(v, dict):
        return {k: walk(x) for k, x in v.items()}
    if isinstance(v, list):
        return [walk(x) for x in v]
    return v


tr = walk(tr)
P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print("фіксів:", cnt)
# контроль
blob = json.dumps(tr["quests"], ensure_ascii=False)
print("лишилось 'шо$p(в:ла)':", len(re.findall(r"шо\$p\(в:ла\)", blob)))
print("лишилось подвійних хвостів:", len(re.findall(r"\$p\([^)]*\)\([А-Яа-я]+\)", blob)))
print("о/е перед $p(в:ла) (перевір):", len(re.findall(r"[ое]\$p\(в:ла\)", blob)))
