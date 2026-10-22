# -*- coding: utf-8 -*-
"""Готує батчі діалогів (gossip+broadcast) з файлу тестера 24 для перекладу.
Broadcast тягне спікера (db.broadcast = {line: speaker}) для контексту статі/тону."""
import re, json, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

LUA = r"g:/Claude Code/WoWUkraine/testerlua/WoWUkraine (24).lua"
B = Path("g:/Claude Code/WoWUkraine")
s = open(LUA, encoding="utf-8", errors="replace").read()
BACK = chr(92)

def block(name):
    m = re.search(r'\["' + name + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, depth, instr, esc = m.end(), 1, False, False
    while i < len(s) and depth > 0:
        c = s[i]
        if instr:
            if esc: esc = False
            elif c == BACK: esc = True
            elif c == '"': instr = False
        else:
            if c == '"': instr = True
            elif c == "{": depth += 1
            elif c == "}": depth -= 1
        i += 1
    return s[m.end():i - 1]

def un(v):
    return (v.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r").replace("\\t", "\t").replace("\\\\", "\\"))

# broadcast: {line: speaker}
bb = block("broadcast")
PAIR = re.compile(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"')
speaker = {un(k): un(v) for k, v in PAIR.findall(bb)}

gnew = json.loads((B / "data/tester_new/gossip.json").read_text(encoding="utf-8"))
bnew = json.loads((B / "data/tester_new/broadcast.json").read_text(encoding="utf-8"))

items = []
for t in gnew:
    items.append({"type": "gossip", "en": t})
for t in bnew:
    items.append({"type": "broadcast", "speaker": speaker.get(t, ""), "en": t})

OUT = B / "data/_dlg24_in"
OUT.mkdir(exist_ok=True)
# gossip батчі по 16, broadcast по 22
gos = [x for x in items if x["type"] == "gossip"]
bro = [x for x in items if x["type"] == "broadcast"]
bi = 0
batches = []
for i in range(0, len(gos), 16):
    batches.append(gos[i:i+16])
for i in range(0, len(bro), 22):
    batches.append(bro[i:i+22])
for i, ch in enumerate(batches, 1):
    (OUT / f"d_{i}.json").write_text(json.dumps(ch, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"діалог-батчів: {len(batches)} | gossip {len(gos)} ({(len(gos)+15)//16} батчів) + broadcast {len(bro)} ({(len(bro)+21)//22} батчів)")
print(f"спікерів витягнуто: {len([1 for x in bro if x['speaker']])}/{len(bro)}")
