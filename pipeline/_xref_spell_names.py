# -*- coding: utf-8 -*-
"""Зняти з черги заклять ті назви, що вже перекладені деінде.

Більшість «незроблених» заклять — це ремісничі рецепти, чари й накладки, чия
назва збігається з назвою ПРЕДМЕТА, який вони створюють («Arcanum of Focus»,
«Cobrahide Leg Armor»). Такий переклад уже є в itemNames/recipes — перекладати
вдруге означає і марно працювати, і завести різнобій між тултіпом предмета й
назвою закляття.

Беремо переклад лише коли він однозначний (усі входження в базі однакові).

Запуск: python _xref_spell_names.py [--apply]
"""
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))

PREFIX = re.compile(r"^(Create|Combine|Apply|Schematic|Pattern|Recipe|Plans|"
                    r"Design|Formula|Technique|Manual)\s*:?\s+", re.I)


def norm(s):
    return re.sub(r"\s+", " ", s).strip()


en2ua = defaultdict(set)

# Секція spells ключується spellID, а не назвою, тож простий обхід її не бачив
# і класові здібності («Shadowstep», «Prayer of Mending») щоразу потрапляли в
# чергу як нові. Зіставляємо через джерело: ID -> EN-назва.
try:
    ssrc = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))
    ts = tr.get("spells", {})
    for sid, v in ssrc.items():
        nm = v.get("name") if isinstance(v.get("name"), dict) else None
        en = nm.get("en") if nm else None
        ua = ts.get(str(sid))
        if en and isinstance(ua, str) and ua.strip():
            en2ua[norm(en)].add(ua)
except FileNotFoundError:
    pass

for sec in ("itemNames", "recipes", "uiTooltips", "questObjectives"):
    d = tr.get(sec)
    if not isinstance(d, dict):
        continue
    for k, v in d.items():
        if not isinstance(k, str) or not re.search(r"[A-Za-z]{3}", k):
            continue
        ua = v.get("name") if isinstance(v, dict) else v
        if isinstance(ua, str) and ua.strip():
            en2ua[norm(k)].add(ua)

hits, rest, ambig = {}, [], 0
for f in sorted((DATA_DIR / "spell_names").glob("spell_names_*.json")):
    for x in json.loads(f.read_text(encoding="utf-8")):
        en, sid = x["en"], x["id"]
        cand = en2ua.get(norm(en))
        if not cand:
            # «Create Elune Stone» -> предмет «Elune Stone»
            m = PREFIX.match(en)
            if m:
                base = norm(en[m.end():])
                cb = en2ua.get(base)
                if cb and len(cb) == 1:
                    hits[sid] = (m.group(0).strip().rstrip(":") + " "
                                 + next(iter(cb)))
                    continue
            rest.append(x)
            continue
        if len(cand) == 1:
            hits[sid] = next(iter(cand))
        else:
            ambig += 1
            rest.append(x)

print(f"черга заклять: {len(hits) + len(rest)} | переклад є в базі: {len(hits)} "
      f"| неоднозначних: {ambig} | справжня робота: {len(rest)}")
for sid, ua in list(hits.items())[:6]:
    print(f"      ✔ {sid:<9}-> {ua[:52]}")

if not APPLY:
    print("\n(звіт; щоб застосувати — --apply)")
    sys.exit()

out = DATA_DIR / "spell_names_out"
out.mkdir(parents=True, exist_ok=True)
(out / "xref.json").write_text(json.dumps(hits, ensure_ascii=False, indent=1),
                               encoding="utf-8")
size = 150
for f in (DATA_DIR / "spell_names").glob("spell_names_*.json"):
    f.unlink()
for k in range((len(rest) + size - 1) // size):
    (DATA_DIR / "spell_names" / f"spell_names_{k:03d}.json").write_text(
        json.dumps(rest[k * size:(k + 1) * size], ensure_ascii=False, indent=1),
        encoding="utf-8")
print(f"\n-> spell_names_out/xref.json: {len(hits)} | у черзі: {len(rest)}")
