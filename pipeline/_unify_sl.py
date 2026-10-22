# -*- coding: utf-8 -*-
"""QA-уніфікація рейдів SL: варіант→канон + Kingsmourne (русизм «Скорб»→Кінгсморн regex)."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
FIX=[
 ("Майстер Ксай'мокс","Конструктор Ксай'мокс"),
 ("Займокс","Ксай'мокс"),
 ("Шлякокулак","Багнокулак"),
 ("Мал'Ґаніс","Мал'Ганіс"),
 ("Ґарош","Ґаррош"),
 ("Морокожили","Ґлумвейл"),("Морокожила","Ґлумвейл"),
 ("Грішнопасма","Грішнобій"),
 ("Ск'я","Скія"),
]
KING=re.compile(r"Королівськ[А-Яа-яіїєґ']* Скорб[А-Яа-яіїєґ']*")
def f(v):
    v=KING.sub("Кінгсморн",v)
    for a,b in FIX:
        if a in v: v=v.replace(a,b)
    return v
tr=json.load(open("data/translations.json",encoding="utf-8-sig"))
ch=0
for table in ("descTemplates","journalSections","instanceDesc","spells"):
    d=tr.get(table,{})
    for k,v in list(d.items()):
        if isinstance(v,str):
            nv=f(v)
            if nv!=v: d[k]=nv; ch+=1
for e in (tr.get("journal",{}) or {}).values():
    if isinstance(e,dict):
        for fld in ("name","desc"):
            v=e.get(fld)
            if isinstance(v,str):
                nv=f(v)
                if nv!=v: e[fld]=nv; ch+=1
json.dump(tr,open("data/translations.json","w",encoding="utf-8"),ensure_ascii=False,indent=1)
print("уніфіковано SL:",ch)
