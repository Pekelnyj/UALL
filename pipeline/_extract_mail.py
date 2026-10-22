# -*- coding: utf-8 -*-
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
CAPS = [Path("F:/Battlenet/World of Warcraft/_retail_/WTF/Account/129089678#1/SavedVariables/WoWUkraine.lua"),
        B / "testerlua/WoWUkraine (20).lua"]


def block(s, key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, depth, instr, esc = m.end(), 1, False, False
    while i < len(s) and depth > 0:
        c = s[i]
        if instr:
            if esc: esc = False
            elif c == "\\": esc = True
            elif c == '"': instr = False
        else:
            if c == '"': instr = True
            elif c == "{": depth += 1
            elif c == "}": depth -= 1
        i += 1
    return s[m.end():i - 1]


KV = re.compile(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"')
def cyr(x): return bool(re.search(r"[А-Яа-яІЇЄҐ]", x))


def union_keys(key):
    out = set()
    for p in CAPS:
        if p.exists():
            for k, v in KV.findall(block(p.read_text(encoding="utf-8", errors="replace"), key)):
                if not cyr(k) and len(k) > 2:
                    out.add(k)
            # також ключі-only (масиви)
            for k in re.findall(r'\["((?:[^"\\]|\\.)*)"\]', block(p.read_text(encoding="utf-8", errors="replace"), key)):
                if not cyr(k) and len(k) > 2 and not k.isdigit():
                    out.add(k)
    return out


# ПОШТА: subjects + bodies + mail (нема секції -> усе нове)
mail = union_keys("subjects") | union_keys("bodies") | union_keys("mail")
mail = sorted(m for m in mail if m not in ("subjects", "bodies", "mail") and len(m) > 3)
(B / "data/_fin_in/mail.json").write_text(json.dumps(mail, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"ПОШТА (нових тем/тіл): {len(mail)}")
for m in mail[:6]:
    print(f"   • {m[:75]}")

# books проти bookTexts
bk = union_keys("books")
btr = set(tr.get("bookTexts", {}))
bk_new = sorted(b for b in bk if b not in btr)
print(f"\nBOOKS нових: {len(bk_new)} -> {bk_new[:6]}")

# верифікація gossip/renown (фальш?)
g = union_keys("gossip"); gtr = set(tr.get("gossip", {}))
print(f"\nGOSSIP: зібрано {len(g)} | реально не в tr['gossip']: {len([x for x in g if x not in gtr])}")
