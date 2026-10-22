# -*- coding: utf-8 -*-
"""Staging для db.uitooltip: витяг нового (нема в БД), чистка, чанк для хвилі."""
import re, json, os, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
SV = r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/129089678#1/SavedVariables/WoWUkraine.lua"
BACK = chr(92)
s = open(SV, encoding="utf-8", errors="replace").read()
def block(name):
    m = re.search(r'\["' + name + r'"\]\s*=\s*\{', s)
    if not m: return ""
    i, depth, instr, esc = m.end(), 1, False, False
    while i < len(s) and depth > 0:
        c = s[i]
        if instr:
            if esc: esc=False
            elif c==BACK: esc=True
            elif c=='"': instr=False
        else:
            if c=='"': instr=True
            elif c=="{": depth+=1
            elif c=="}": depth-=1
        i+=1
    return s[m.end():i-1]
KEY = re.compile(r'\["((?:[^"\\]|\\.)*)"\]')
def un(v): return v.replace('\\"','"').replace("\\n","\n").replace("\\r","\r").replace("\\t","\t").replace("\\\\","\\")
def keys(b):
    seen=set(); out=[]
    for k in KEY.findall(b):
        u=un(k)
        if u not in seen: seen.add(u); out.append(u)
    return out
tr = json.load(open(ROOT+"/data/translations.json", encoding="utf-8-sig"))
def cyr(x): return bool(re.search(r"[А-Яа-яІЇЄҐіїєґ]", x))
def transl(x): return bool(re.search(r"[A-Za-z]", x)) and not cyr(x) and len(x)>=3
def junk(x):
    t=re.sub(r"\|T.-\|t","",x); t=re.sub(r"\|[Aa].-\|[Aa]","",t)
    t=re.sub(r"\|c%x+","",t).replace("|r","").replace("|H","").strip()
    if not t: return True
    if re.match(r"^[\d\s/%:.,\-x]+(Day|Days|Hour|Hours|Min|sec)?s?$", t): return True
    return len(re.findall(r"[A-Za-z]{3,}", t))==0
def norm(x):
    t=x.replace("\r\n","\n").replace("\r","\n")
    t=re.sub(r"\|T.-\|t","",t); t=re.sub(r"\|[Aa].-\|[Aa]","",t)
    t=re.sub(r"\|c%x+","",t).replace("|r","")
    t=re.sub(r"\|H.-\|h","",t).replace("|h","")
    return t.strip()
allkeys=set()
for sect,v in tr.items():
    if isinstance(v,dict):
        for k in v.keys(): allkeys.add(k); allkeys.add(norm(k))
def known(x): return x in allkeys or norm(x) in allkeys

clean=[k for k in keys(block("uitooltip")) if transl(k) and not junk(k) and not known(k)]
os.makedirs(ROOT+"/data/tester_new/ut", exist_ok=True)
json.dump({k:"" for k in clean}, open(ROOT+"/data/tester_new/ut/_all.json","w",encoding="utf-8"), ensure_ascii=False, indent=1)
N=10; sz=(len(clean)+N-1)//N
for i in range(N):
    part=clean[i*sz:(i+1)*sz]
    if part: json.dump({k:"" for k in part}, open(ROOT+f"/data/tester_new/ut/u{i+1:02d}.json","w",encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"db.uitooltip нових: {len(clean)} -> {min(N,(len(clean)+sz-1)//sz)} чанків по ~{sz}")
