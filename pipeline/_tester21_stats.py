# -*- coding: utf-8 -*-
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
s = (B / "testerlua/WoWUkraine (21).lua").read_text(encoding="utf-8", errors="replace")


def block(key):
    m = re.search(r'\["' + re.escape(key) + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, d, instr, esc = m.end(), 1, False, False
    while i < len(s) and d > 0:
        c = s[i]
        if instr:
            if esc: esc = False
            elif c == "\\": esc = True
            elif c == '"': instr = False
        else:
            if c == '"': instr = True
            elif c == "{": d += 1
            elif c == "}": d -= 1
        i += 1
    return s[m.end():i - 1]


KV = re.compile(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"')
def cyr(x): return bool(re.search(r"[А-Яа-яІЇЄҐ]", x))

# npc by ID
nb = block("npc")
pairs = re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', nb)
npcN = tr["npcNames"]
new_npc = [(i, n) for i, n in pairs if i not in npcN]
print(f"МОБИ: зібрано {len(pairs)} | НОВІ (по ID): {len(new_npc)}")
for i, n in new_npc[:8]:
    print(f"   {i} -> {n}")

# renown
rb = block("renown")
ren = KV.findall(rb)
rtr = tr.get("renown", {})
ren_new = [n for n, dsc in ren if dsc and (dsc.encode().decode('unicode_escape','ignore') if '\\' in dsc else dsc) not in rtr]
print(f"\nRENOWN: зібрано {len(ren)} | descs не в tr: {len(ren_new)}")

# mail
mb = block("subjects"); bb = block("bodies"); mm = block("mail")
mail_keys = set(re.findall(r'\["((?:[^"\\]|\\.)*)"\]', mb + bb + mm))
mtr = set(tr.get("mail", {}))
mail_new = [k for k in mail_keys if k not in mtr and len(k) > 3 and not cyr(k) and k not in ("subjects", "bodies", "mail")]
print(f"\nПОШТА: нових {len(mail_new)}")
for k in mail_new[:5]:
    print(f"   • {k[:60]}")

# books
bk = set(re.findall(r'\["((?:[^"\\]|\\.)*)"\]', block("books")))
bktr = set(tr.get("bookTexts", {}))
bk_new = [k for k in bk if k not in bktr and len(k) > 3 and not cyr(k)]
print(f"\nКНИГИ: нових {len(bk_new)} -> {bk_new[:5]}")

# топ-категорії
root = s[re.search(r"WoWUkraineCaptureDB\s*=\s*\{", s).end():]
top = re.findall(r'\n\s*\["([a-zA-Z_]+)"\]\s*=\s*\{', root)
print(f"\nкатегорії: {top}")
