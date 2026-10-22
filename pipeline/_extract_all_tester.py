# -*- coding: utf-8 -*-
"""Витяг НОВОГО gossip+broadcast+objectives+npc з УСІХ testerlua/*.lua."""
import sys, re, json, glob, os
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
gtr = tr.get("gossip", {})
qo = tr.get("questObjectives", {})
CYR = re.compile(r"[Ѐ-ӿ]")
bl = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua").read_text(encoding="utf-8")


def setblock(s, key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, depth, instr, esc = m.end(), 1, False, False
    while i < len(s) and depth > 0:
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
                depth += 1
            elif c == "}":
                depth -= 1
        i += 1
    return s[m.end():i - 1]


def keys(block):
    return re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=', block)


def vals_objectives(block):
    return re.findall(r'\["objectives"\]\s*=\s*"((?:[^"\\]|\\.)*)"', block)


def un(v):
    return v.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r").replace("\\t", "\t").replace("\\\\", "\\")


def esc(s):
    return s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n").replace("\r", "\\r")


allg, allb, allo, alln = set(), set(), set(), {}
for f in glob.glob(str(DATA_DIR.parent / "testerlua" / "*.lua")):
    s = open(f, encoding="utf-8", errors="replace").read()
    for k in keys(setblock(s, "gossip")):
        allg.add(un(k))
    for k in keys(setblock(s, "broadcast")):
        allb.add(un(k))
    for o in vals_objectives(s):
        allo.add(un(o))
    for i, n in re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', setblock(s, "npc")):
        alln[i] = un(n)


def translatable(t):
    return bool(t) and bool(re.search(r"[A-Za-z]", t)) and not CYR.search(t) and len(t) >= 3


newg = [t for t in allg if translatable(t) and t not in gtr]
newb = [t for t in allb if translatable(t) and '["' + esc(t) + '"]' not in bl]
newo = [t for t in allo if translatable(t) and t not in qo]
newn = {i: n for i, n in alln.items() if translatable(n)}

os.makedirs(DATA_DIR / "tester_all", exist_ok=True)
for name, data in [("gossip", newg), ("broadcast", newb), ("objectives", newo), ("npc", newn)]:
    json.dump(data, open(DATA_DIR / "tester_all" / (name + ".json"), "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"УСІ файли тестера, НОВЕ: gossip {len(newg)} | broadcast {len(newb)} | objectives {len(newo)} | npc {len(newn)}")
