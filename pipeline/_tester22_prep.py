# -*- coding: utf-8 -*-
"""Витягти НОВІ моби(id->en), renown-описи, книги з файлу 22 для перекладу."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
s = (B / "testerlua/WoWUkraine (22).lua").read_text(encoding="utf-8", errors="replace")
OUT = B / "data" / "tester_new"
OUT.mkdir(exist_ok=True)


def block(key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, d, instr, esc = m.end(), 1, False, False
    while i < len(s) and d > 0:
        c = s[i]
        if instr:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                instr = False
        else:
            if c == '"':
                instr = True
            elif c == "{":
                d += 1
            elif c == "}":
                d -= 1
        i += 1
    return s[m.end():i - 1]


def un(v):
    return (v.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
             .replace("\\t", "\t").replace("\\\\", "\\"))


# МОБИ: нові id->en
nb = block("npc")
pairs = re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', nb)
npcN = tr["npcNames"]
mobs = [{"id": i, "en": un(n)} for i, n in pairs if i not in npcN]
json.dump(mobs, open(OUT / "mobs.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)

# RENOWN: descs не в tr
KV = re.compile(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"')
ren = KV.findall(block("renown"))
rtr = tr.get("renown", {})
ren_new = [{"en": un(d)} for n, d in ren if d and un(d) not in rtr and re.search(r"[A-Za-z]", d) and not re.search(r"[А-Яа-яІЇЄҐ]", d)]
# dedupe
seen = set()
ren_u = []
for r in ren_new:
    if r["en"] not in seen:
        seen.add(r["en"]); ren_u.append(r)
json.dump(ren_u, open(OUT / "renown.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)

# КНИГИ
bk = KV.findall(block("books"))
bktr = tr.get("bookTexts", {})
bk_new = [{"key": un(k), "text": un(v)} for k, v in bk if un(k) not in bktr and re.search(r"[A-Za-z]", k)]
json.dump(bk_new, open(OUT / "books.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)

print(f"моби нових: {len(mobs)} | renown нових: {len(ren_u)} | книги нових: {len(bk_new)}")
print("моби приклади:", [m["en"] for m in mobs[:6]])
print("renown приклади:", [r["en"][:40] for r in ren_u[:3]])
