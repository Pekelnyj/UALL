# -*- coding: utf-8 -*-
import json, sys, re
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
p = ROOT + "/data/translations.json"
tr = json.load(open(p, encoding="utf-8-sig"))

def load(name):
    try: return json.load(open(ROOT + f"/data/tester_new/t25/{name}.json", encoding="utf-8"))
    except FileNotFoundError: return {}

obfix = {**load("QAfix_ob1"), **load("QAfix_ob2")}
utfix = {**load("QAfix_ut1"), **load("QAfix_ut2")}
gbfix = load("QAfix_gb")

qo = tr["questObjectives"]; ut = tr["uiTooltips"]; go = tr["gossip"]
no = 0
for en, ua in obfix.items():
    if en in qo and ua and ua.strip(): qo[en] = ua; no += 1
nu = 0
for en, ua in utfix.items():
    if en in ut and ua and ua.strip(): ut[en] = ua; nu += 1

# gb: розділити gossip vs broadcast
gb_go = 0; gb_bc = {}
for en, ua in gbfix.items():
    if not ua or not ua.strip(): continue
    if en in go: go[en] = ua; gb_go += 1
    else: gb_bc[en] = ua   # broadcast — обробимо окремо

json.dump(tr, open(p, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"questObjectives виправлено: {no}/{len(obfix)}")
print(f"uiTooltips виправлено: {nu}/{len(utfix)}")
print(f"gossip виправлено: {gb_go}, broadcast-фіксів до обробки: {len(gb_bc)}")

# broadcast: оновити майстер + замінити в Broadcast.lua напряму
if gb_bc:
    bp = ROOT + "/data/tester_new/broadcast_out.json"
    m = json.load(open(bp, encoding="utf-8-sig"))
    DB = ROOT + "/addon/WoWUkraine/Database/Broadcast.lua"
    lua = open(DB, encoding="utf-8").read()
    _COMB = re.compile("[̀-ͯ]")
    def esc(s):
        s = _COMB.sub("", s)
        return (s.replace("\\","\\\\").replace('"','\\"').replace("\n","\\n").replace("\r","\\r").replace("\t","\\t"))
    bc_done = 0
    for en, ua in gb_bc.items():
        m[en] = ua
        key = '["' + esc(en) + '"]'
        # замінити значення цього ключа в Lua
        pat = re.compile(re.escape(key) + r'\s*=\s*"(?:[^"\\]|\\.)*"')
        repl = key + ' = "' + esc(ua) + '"'
        new, n = pat.subn(repl, lua)
        if n: lua = new; bc_done += 1
    json.dump(m, open(bp, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    open(DB, "w", encoding="utf-8").write(lua)
    print(f"broadcast оновлено в Lua: {bc_done}/{len(gb_bc)}; баланс {{}}:",
          "OK" if lua.count("{")==lua.count("}") else "ДИСБАЛАНС")
