# -*- coding: utf-8 -*-
import sys, json, glob, re
sys.stdout.reconfigure(encoding="utf-8")
indir = sys.argv[1] if len(sys.argv) > 1 else "data/mid_names"
src = json.load(open("data/source/spells.json", encoding="utf-8-sig"))
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
spt = tr.setdefault("spells", {})
js = tr.setdefault("journalSections", {})


def en(d):
    return d.get("en") if isinstance(d, dict) else d


def canon(s):
    s = re.sub(r'\|c[0-9a-fA-F]{8}', '', s); s = s.replace('|r', '')
    s = re.sub(r'\|H.*?\|h(.*?)\|h', r'\1', s)
    s = s.replace('$bullet;', '').replace('|n', ' ')
    s = re.sub(r'[\r\n]+', ' ', s); s = re.sub(r'\d[\d,.]*', '#', s)
    return re.sub(r'\s+', ' ', s).strip()


new = {}
for f in glob.glob(indir + "/out_*.json"):
    new.update(json.load(open(f, encoding="utf-8-sig")))
# id→en з need.json (у source ці captured-спели мають порожню name:{})
need_en = {str(e["id"]): e["en"] for e in json.load(open(indir + "/need.json", encoding="utf-8-sig"))}

en2ua = {}
direct = 0
for sid, ua in new.items():
    spt[str(sid)] = ua; direct += 1  # ПРЯМО для $@spellname-резолву
    n = need_en.get(str(sid))
    if n:
        en2ua.setdefault(n, ua)
        # populate порожню назву в source (для by_en + майбутніх лукапів)
        if isinstance(src.get(str(sid)), dict):
            src[str(sid)].setdefault("name", {})
            if isinstance(src[str(sid)]["name"], dict) and not src[str(sid)]["name"].get("en"):
                src[str(sid)]["name"]["en"] = n

applied = direct
for sid, v in src.items():
    n = en(v.get("name")) if isinstance(v, dict) else None
    if n and n in en2ua and sid not in spt:
        spt[sid] = en2ua[n]; applied += 1
json.dump(src, open("data/source/spells.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)

titles = 0
for n, ua in en2ua.items():
    k = canon(n)
    if k and k not in js:
        js[k] = ua; titles += 1

json.dump(tr, open("data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"new={len(new)} унік_en={len(en2ua)} | spell-ID застосовано={applied} | титулів={titles}")
