# -*- coding: utf-8 -*-
"""Злиття перекладів секцій (journalSections[EN-raw]=ua) з ПОЗИЦІЙНИМ [link]-фіксом:
дужки [Ability] у UA замінюються на канонічну UA-назву заклять за EN-дужкою з ключа
(незалежно від того, лишив агент англ. чи переклав по-своєму). Потім QA-уніфікація імен."""
import sys, json, glob, re, importlib.util
sys.stdout.reconfigure(encoding="utf-8")

src = json.load(open("data/source/spells.json", encoding="utf-8-sig"))
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
spt = tr.get("spells", {})
js = tr.setdefault("journalSections", {})

# --- EN-назва закляття -> UA (канон зі Stage 1) ---
en2ua = {}
for sid, ua in spt.items():
    e = src.get(str(sid))
    n = (e.get("name") or {}).get("en") if isinstance(e, dict) and isinstance(e.get("name"), dict) else None
    if n and n not in en2ua:
        en2ua[n] = ua
# також уже наявні journalSections-титули (en->ua), якщо короткі (назви)
for en, ua in list(js.items()):
    if isinstance(ua, str) and "\n" not in en and len(en) < 50 and en not in en2ua:
        en2ua[en] = ua

BR = re.compile(r"\[([^\[\]]+)\]")


def lookup(en_name):
    """Точний матч, тоді фолбек на однину (-s / -es)."""
    if en_name in en2ua:
        return en2ua[en_name]
    if en_name.endswith("es") and en_name[:-2] in en2ua:
        return en2ua[en_name[:-2]]
    if en_name.endswith("s") and en_name[:-1] in en2ua:
        return en2ua[en_name[:-1]]
    return None


def fix_links(en_key, ua_val):
    en_br = BR.findall(en_key)
    if not en_br:
        return ua_val
    ua_spans = list(BR.finditer(ua_val))
    if len(ua_spans) == len(en_br):
        # позиційна заміна
        out, last = [], 0
        for i, m in enumerate(ua_spans):
            out.append(ua_val[last:m.start()])
            en_name = en_br[i]
            ua_name = lookup(en_name)
            if not ua_name:
                # дужка вже могла бути перекладена агентом — лишаємо як є
                ua_name = m.group(1)
            out.append("[" + ua_name + "]")
            last = m.end()
        out.append(ua_val[last:])
        return "".join(out)
    # к-сть не збіглась → строкова заміна відомих EN→UA в дужках
    res = ua_val
    for en_name in en_br:
        ua_name = lookup(en_name)
        if ua_name:
            res = res.replace("[" + en_name + "]", "[" + ua_name + "]")
    return res


SECDIR = sys.argv[1] if len(sys.argv) > 1 else "data/jbatch_mid/sec"
merged = mismatch = 0
for f in glob.glob(SECDIR + "/sout_*.json"):
    for en_key, ua_val in json.load(open(f, encoding="utf-8-sig")).items():
        if not isinstance(ua_val, str):
            continue
        fixed = fix_links(en_key, ua_val)
        if len(BR.findall(en_key)) != len(BR.findall(ua_val)):
            mismatch += 1
        js[en_key] = fixed
        merged += 1

json.dump(tr, open("data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"секцій злито: {merged} | дужок-розбіжностей (к-сть): {mismatch} | словник назв: {len(en2ua)}")
