# -*- coding: utf-8 -*-
"""КРОС-КВЕСТ консистентність ІМЕН: одне EN-ім'я має давати одну UA-форму скрізь.
Канон = npcNames (id->en через creatures.json). Корпус-лінійно: проходимо квести
раз, витягуємо кандидати-імена (послідовності великих слів / апостроф-імена),
шукаємо в індексі. Для кожного імені рахуємо квести, де канон-UA-стем Є / НЕМАЄ.
МІШАНІ (десь є, десь нема) = ймовірна розбіжність форми."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
qsrc = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))
cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
tq = tr.get("quests", {})
npc = tr.get("npcNames", {})
id2en = {cid: (v.get("name") or {}).get("en", "") for cid, v in cr.items() if isinstance(v, dict)}

# Загальні слова-ролі — не імена (відкидаємо як окремі кандидати/стартові слова).
GENERIC = {"The", "And", "Of", "Guard", "Scout", "Captain", "Soldier", "Warrior",
           "Citizen", "Spirit", "Ghost", "Lord", "Lady", "King", "Queen", "Master",
           "Commander", "General", "High", "Elder", "Prince", "Princess", "Baron",
           "Sergeant", "Marshal", "Private", "Protector", "Watcher", "Chief", "Sir",
           "Madame", "Foreman", "Innkeeper", "Far", "Grand", "Great", "Dark"}

# Індекс канон-імен: EN(точний регістр) -> (ua_canon, stem). Лише надійно матчувані:
# багатослівні (First Last) або апостроф-імена (Kael'thas, Zul'jin).
name_index = {}
for cid, ua in npc.items():
    en = id2en.get(cid, "")
    if not en or len(en) < 4 or not ua:
        continue
    multiword = bool(re.search(r"^[A-Z][\w']+ [A-Z]", en))
    apost = "'" in en and bool(re.match(r"^[A-Z][\w']{3,}$", en))
    if not (multiword or apost):
        continue
    words = [w for w in re.findall(r"[А-Яа-яЇїІіЄєҐґ']+", ua) if len(w) >= 4]
    if not words:
        continue
    name_index.setdefault(en, (ua, words[0][:5].lower()))

# кандидати з тексту: апостроф-слова (Zul'jin) + рани 1-3 великих слів
CAND = re.compile(r"[A-Z][a-z]+(?:'[a-z]+)?(?:\s+[A-Z][a-z]+(?:'[a-z]+)?){0,2}")
stats = {}  # en -> {"present":[qid], "absent":[qid]}
for qid, qd in qsrc.items():
    if qid not in tq:
        continue
    qen = ((qd.get("title", {}) or {}).get("en", "") + "\n" +
           (qd.get("description", {}) or {}).get("en", ""))
    t = tq[qid]
    qua = ((t.get("title", "") or "") + "\n" + (t.get("description", "") or "")).lower()
    seen = set()
    for m in CAND.finditer(qen):
        toks = m.group(0).split()
        # усі суцільні під-послідовності 1..3 слів
        for i in range(len(toks)):
            for j in range(i + 1, min(i + 4, len(toks) + 1)):
                cand = " ".join(toks[i:j])
                if cand in name_index and cand not in seen:
                    seen.add(cand)
    for cand in seen:
        ua_canon, stem = name_index[cand]
        st = stats.setdefault(cand, {"present": [], "absent": []})
        (st["present"] if stem in qua else st["absent"]).append(qid)

mixed, allmiss = [], []
for en, st in stats.items():
    n = len(st["present"]) + len(st["absent"])
    if n < 2:
        continue
    ua_canon, stem = name_index[en]
    if st["present"] and st["absent"]:
        mixed.append({"en": en, "ua": ua_canon, "stem": stem,
                      "present": st["present"], "absent": st["absent"]})
    elif st["absent"]:
        allmiss.append({"en": en, "ua": ua_canon, "n": len(st["absent"]),
                        "absent": st["absent"][:8]})

mixed.sort(key=lambda x: -(len(x["present"]) + len(x["absent"])))
allmiss.sort(key=lambda x: -x["n"])
json.dump({"mixed": mixed, "allmiss": allmiss},
          open(DATA_DIR / "_name_consist.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)

print(f"канон-імен в індексі: {len(name_index)} | імен у ≥2 квестах: {sum(1 for s in stats.values() if len(s['present'])+len(s['absent'])>=2)}")
print(f"\nМІШАНІ (десь канон-форма Є, десь НЕМА = ймовірна розбіжність): {len(mixed)}")
for m in mixed[:25]:
    print(f"  {m['en']:26s} '{m['ua'][:22]:22s}' є:{len(m['present'])} нема:{len(m['absent'])}  нема→{m['absent'][:4]}")
print(f"\nКАНОН НІДЕ не вжито (системна розбіжність/омонім/титул-only): {len(allmiss)}")
for a in allmiss[:15]:
    print(f"  {a['en']:26s} '{a['ua'][:22]:22s}' квестів:{a['n']}  {a['absent'][:3]}")
