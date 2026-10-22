# -*- coding: utf-8 -*-
"""Витяг НОВИХ db.uitooltip (делв/мапа UI) з капчурів, дедуп проти
translations.uiTooltips, фільтр сміття (юніт-тултіпи гравця/координати).

Приймає КІЛЬКА файлів і об'єднує їх; без аргументів бере живий SavedVariables.
Раніше шлях був жорстко зашитий на один файл, тож зі збірки тестерів у чергу
не потрапляло нічого [[patch-refresh-gotchas]].

Запуск: python _extract_uitt.py ["<файл1>" "<файл2>" ...]
"""
import sys, re, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

paths = sys.argv[1:] or glob.glob(
    r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")
sv = "\n".join(open(p, encoding="utf-8", errors="replace").read() for p in paths)
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
ui = tr.get("uiTooltips", {})

def uitt_block(text):
    """Тіло db.uitooltip одного файлу (з урахуванням вкладених дужок і рядків)."""
    m = re.search(r'\["uitooltip"\]\s*=\s*\{', text)
    if not m:
        return ""
    i, depth, start = m.end(), 1, m.end()
    instr = esc = False
    while i < len(text) and depth > 0:
        c = text[i]
        if instr:
            if esc: esc = False
            elif c == "\\": esc = True
            elif c == '"': instr = False
        else:
            if c == '"': instr = True
            elif c == "{": depth += 1
            elif c == "}": depth -= 1
        i += 1
    return text[start:i - 1]


# Кожен файл розбираємо ОКРЕМО: у склеєному тексті re.search знайшов би лише
# перший блок, а решта зборів мовчки загубилася б.
keys = []
for _p in paths:
    keys += re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=',
                       uitt_block(open(_p, encoding="utf-8",
                                       errors="replace").read()))


def un(s):
    return s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r").replace("\\t", "\t").replace("\\\\", "\\")


JUNK = re.compile(r"\(Player\)|^Level \d+|^\(\d|^[\d,.\s/x%-]+$")
new = []
for k in keys:
    s = un(k)
    if s in ui or JUNK.search(s) or not re.search(r"[A-Za-z]{3}", s) or len(s) < 3:
        continue
    new.append(s)
new = sorted(set(new))
json.dump(new, open(DATA_DIR / "tester_all" / "uitt.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"db.uitooltip усього: {len(keys)} | НОВИХ корисних: {len(new)}")
for s in new[:8]:
    print("   ", repr(s[:70]))
