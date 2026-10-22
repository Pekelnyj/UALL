# -*- coding: utf-8 -*-
"""Детектор гендер-помилок у ВЖЕ перекладених квестах.
Сигнал ЖІНКА-мовець: французька чітко маркує рід 1-ї особи (je suis prête/venue/
heureuse/contente). Якщо FR каже жінка, а UA вжив ЧОЛОВІЧИЙ 1-особовий рід
(я готовий/зробив/прийшов) — кандидат на виправлення.
Дзеркально: FR-чоловік + UA-жіночий — теж прапор."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

q = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
tq = tr["quests"]

# FR жіночі/чоловічі 1-особові маркери (предикатив + дієприкметник -ée)
FR_FEM = re.compile(r"\bje suis (?:enfin |déjà |bien |très |si |une )?"
                    r"(?:\w+ée|prête|heureuse|contente|fière|sûre|désolée|ravie|certaine|"
                    r"convaincue|prisonnière|seule|vieille|morte|chasseresse|guérisseuse|"
                    r"\w+euse|\w+ière|\w+trice)\b"
                    r"|\bje me suis \w+ée\b|\bmoi seule\b", re.I)
FR_MASC = re.compile(r"\bje suis (?:enfin |déjà |bien |très |si |un )?"
                     r"(?:\w+é|prêt|heureux|content|fier|sûr|désolé|ravi|certain|convaincu|"
                     r"prisonnier|seul|vieux|mort)\b"
                     r"|\bje me suis \w+é\b", re.I)

# UA 1-особові: загальний минулий час + предикативи
UA_MASC = re.compile(r"\bя (?:вже |нарешті |тут |сам |особисто )?"
                     r"[а-яіїєґ']*(?:ив|ав|ув|ів|вся|нувся|шов)\b"
                     r"|\bя (?:готовий|радий|певен|певний|змушений|винний|зобов'язаний|сам)\b", re.I)
UA_FEM = re.compile(r"\bя (?:вже |нарешті |тут |сама |особисто )?"
                    r"[а-яіїєґ']*(?:ила|ала|ула|іла|лася|нулася|йшла)\b"
                    r"|\bя (?:готова|рада|певна|змушена|винна|зобов'язана|сама)\b", re.I)


def txt(d, lang):
    return ((d.get("title", {}) or {}).get(lang, "") + " " +
            (d.get("description", {}) or {}).get(lang, ""))


cands = []
for qid, qd in q.items():
    t = tq.get(qid)
    if not t:
        continue
    fr = txt(qd, "fr")
    ua = (t.get("title", "") or "") + " " + (t.get("description", "") or "")
    if not fr or not ua:
        continue
    fr_fem = bool(FR_FEM.search(fr))
    fr_masc = bool(FR_MASC.search(fr))
    ua_masc = bool(UA_MASC.search(ua))
    ua_fem = bool(UA_FEM.search(ua))
    if fr_fem and ua_masc and not ua_fem:
        cands.append((qid, "FEM_but_MASC", FR_FEM.search(fr).group(0), UA_MASC.search(ua).group(0)))
    elif fr_masc and ua_fem and not ua_masc:
        cands.append((qid, "MASC_but_FEM", FR_MASC.search(fr).group(0), UA_FEM.search(ua).group(0)))

json.dump([c[0] for c in cands], open(DATA_DIR / "_gender_cands.json", "w", encoding="utf-8"),
          ensure_ascii=False)
print(f"кандидатів на гендер-фікс: {len(cands)}")
for qid, kind, frm, uam in cands[:25]:
    print(f"  [{qid}] {kind}: FR«{frm}» / UA«{uam}»")
