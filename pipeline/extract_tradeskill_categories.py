# -*- coding: utf-8 -*-
import requests, csv, io, json, sys
sys.stdout.reconfigure(encoding="utf-8")
B="12.0.7.68235"; ROOT="g:/Claude Code/WoWUkraine"
def fetch(loc):
    r=requests.get("https://wago.tools/db2/TradeSkillCategory/csv",params={"locale":loc,"build":B},timeout=300)
    r.raise_for_status(); return list(csv.DictReader(io.StringIO(r.text)))
en=fetch("enUS"); de=fetch("deDE"); fr=fetch("frFR")
dd={r["ID"]:(r.get("Name_lang") or "").strip() for r in de}
fd={r["ID"]:(r.get("Name_lang") or "").strip() for r in fr}
tr=json.load(open(ROOT+"/data/translations.json",encoding="utf-8-sig"))
gs=tr.get("globalStrings",{})
existing=set(gs.keys())
allnames={}; new=[]
for r in en:
    nm=(r.get("Name_lang") or "").strip()
    if not nm: continue
    allnames[nm]=True
    if nm not in existing and nm not in [x["en"] for x in new]:
        new.append({"en":nm,"de":dd.get(r["ID"]) or None,"fr":fd.get(r["ID"]) or None})
print("усього TradeSkillCategory назв:",len(allnames))
print("уже в globalStrings:",sum(1 for n in allnames if n in existing))
print("НОВИХ (перекласти):",len(new))
json.dump(new,open(ROOT+"/data/wago_bulk/_tradeskillcat_new.json","w",encoding="utf-8"),ensure_ascii=False,indent=1)
import re
sec=[x for x in new if re.match(r"^Section ",x["en"])]
print("з них 'Section ...':",len(sec))
for x in new[:25]: print("   ",x["en"])
