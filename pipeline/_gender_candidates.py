# -*- coding: utf-8 -*-
"""Знаходить квести з ймовірною ПОМИЛКОЮ РОДУ: UA має ЧОЛОВІЧИЙ першоособовий
минулий час, а ФРАНЦУЗЬКИЙ текст має ЖІНОЧІ маркери узгодження (спікер = жінка).
Виводить кандидатів у data/gender/cand.json для агентської правки."""
import sys, re, json, os
sys.stdout.reconfigure(encoding="utf-8")

tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
src = json.load(open("data/source/quests.json", encoding="utf-8-sig"))
q = tr.get("quests", {})

# UA: чоловічий першоособовий минулий — «я ...в/вся» (НЕ ...ла/лася)
UA_MASC = re.compile(r'(?:^|[\s.,!?…—\-])[Яя]\s+(?:[а-яіїєґ\']+\s+){0,2}[а-яіїєґ\']+(?<![оі])в(?:ся)?\b')

# FR жіночі маркери першоособового спікера (узгодження з «je» жін.)
FR_FEM_WORDS = (r"venue|n[ée]e|all[ée]e|partie|rest[ée]e|devenue|morte|arriv[ée]e|tomb[ée]e|"
                r"entr[ée]e|sortie|mont[ée]e|descendue|retourn[ée]e|revenue|pr[êe]te|seule|"
                r"certaine|s[ûu]re|heureuse|fi[èe]re|d[ée]sol[ée]e|contente|fatigu[ée]e|bless[ée]e|"
                r"prisonni[èe]re|ravie|forc[ée]e|condamn[ée]e|charg[ée]e|envoy[ée]e|appel[ée]e|"
                r"oblig[ée]e|pi[ée]g[ée]e|coinc[ée]e|perdue|venge[ée]?e|d[ée]termin[ée]e")
# ЛИШЕ сильний маркер: «je suis/me suis/j'étais ... <жіночий дієприкметник руху/стану>».
# Це однозначно жінка-СПІКЕР (не гравець, не третя особа, не дієслово).
FR_FEM = re.compile(r"\b(?:je suis|je me suis|je m['’]étais|j['’]étais|je fus)\b[^.!?]{0,35}?\b(?:" + FR_FEM_WORDS + r")\b", re.I)


def frtext(qid):
    e = src.get(str(qid))
    if isinstance(e, dict):
        d = e.get("description")
        return d.get("fr") if isinstance(d, dict) else None
    return None


# UA жіночий першоособовий — «я ...ла/лася» (для виявлення ВНУТРІШНЬОЇ неузгодженості)
UA_FEM = re.compile(r'(?:^|[\s.,!?…—\-])[Яя]\s+(?:[а-яіїєґ\']+\s+){0,2}[а-яіїєґ\']+л(?:а|ася)\b')

cand = []
ua_masc_total = 0
for qid, v in q.items():
    ua = v.get("description", "") if isinstance(v, dict) else ""
    if not ua:
        continue
    has_masc = bool(UA_MASC.search(ua))
    has_fem = bool(UA_FEM.search(ua))
    if has_masc:
        ua_masc_total += 1
    fr = frtext(qid) or ""
    reason = None
    if has_masc and has_fem:
        reason = "ВНУТР.НЕУЗГОДЖ (маск+фем в одному квесті)"
    elif has_masc and FR_FEM.search(fr):
        reason = "FR=жінка-спікер"
    if reason:
        cand.append({"id": qid, "ua": ua, "fr": fr, "reason": reason})

os.makedirs("data/gender", exist_ok=True)
json.dump(cand, open("data/gender/cand.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"квестів з чол. першоособовим UA: {ua_masc_total}")
print(f"  з них FR вказує на ЖІНКУ-спікера (кандидати на правку): {len(cand)}")
for c in cand[:8]:
    print(f"\n  [{c['id']}]")
    print(f"   UA: {c['ua'][:90]!r}")
    print(f"   FR: {c['fr'][:90]!r}")
