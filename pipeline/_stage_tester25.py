# -*- coding: utf-8 -*-
"""Підготовка staging для tester25: objLines->questObjectives, uitooltip->uiTooltips.
Витягує НОВЕ (нема ніде в БД), чистить сміття, чанкує для хвиль перекладу."""
import re, json, os, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
s = open(ROOT + "/testerlua/WoWUkraine (25).lua", encoding="utf-8", errors="replace").read()
BACK = chr(92)

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
def un(v): return (v.replace('\\"','"').replace("\\n","\n").replace("\\r","\r").replace("\\t","\t").replace("\\\\","\\"))
def keys(nm):
    seen=set(); out=[]
    for k in KEY.findall(block(nm)):
        u=un(k)
        if u not in seen: seen.add(u); out.append(u)
    return out

tr = json.load(open(ROOT + "/data/translations.json", encoding="utf-8-sig"))
def cyr(x): return bool(re.search(r"[А-Яа-яІЇЄҐіїєґ]", x))
def transl(x): return bool(re.search(r"[A-Za-z]", x)) and not cyr(x) and len(x)>=3
def junk(x):
    t=re.sub(r"\|T.-\|t","",x); t=re.sub(r"\|[Aa].-\|[Aa]","",t)
    t=re.sub(r"\|c%x+","",t).replace("|r","").replace("|H","").strip()
    if not t: return True
    if re.match(r"^[\d\s/%:.,\-x]+$", t): return True
    return len(re.findall(r"[A-Za-z]{3,}", t))==0
def norm(x):
    t=re.sub(r"\|T.-\|t","",x); t=re.sub(r"\|[Aa].-\|[Aa]","",t)
    t=re.sub(r"\|c%x+","",t).replace("|r","")
    t=re.sub(r"\|H.-\|h","",t).replace("|h","")
    return t.strip()

allkeys=set()
for sect,val in tr.items():
    if isinstance(val,dict):
        for k in val.keys():
            allkeys.add(k); allkeys.add(norm(k))
def known(x): return x in allkeys or norm(x) in allkeys

ob=[k for k in keys("objLines") if transl(k) and not junk(k) and not known(k)]
ut=[k for k in keys("uitooltip") if transl(k) and not junk(k) and not known(k)]
# uitooltip: прибрати ті, що збігаються з objLines (їх перекладемо в objectives)
obset=set(ob)
ut=[k for k in ut if k not in obset]

os.makedirs(ROOT+"/data/tester_new/t25", exist_ok=True)
def dump(name,lst):
    json.dump({k:"" for k in lst}, open(ROOT+f"/data/tester_new/t25/{name}.json","w",encoding="utf-8"), ensure_ascii=False, indent=1)
def chunk(prefix,lst,n):
    sz=(len(lst)+n-1)//n
    files=[]
    for i in range(n):
        part=lst[i*sz:(i+1)*sz]
        if not part: continue
        fn=f"{prefix}_{i+1}"
        dump(fn,part); files.append(fn)
    return files

dump("objlines_all", ob)
dump("uitooltip_all", ut)
of=chunk("ob", ob, 10)
uf=chunk("ut", ut, 12)
print(f"objLines нових: {len(ob)} -> {len(of)} чанків {of}")
print(f"uitooltip нових (мінус objLines): {len(ut)} -> {len(uf)} чанків")
print("staging у data/tester_new/t25/")
