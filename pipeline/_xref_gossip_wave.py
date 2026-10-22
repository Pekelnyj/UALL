# -*- coding: utf-8 -*-
"""Перехресна звірка ґосип-черги з рештою бази.

Вікно балачки перелічує доступні квести і підписує NPC, тож у db.gossip осідають
рядки, які ВЖЕ перекладені — але в інших секціях: назва квесту в quests[qid].title,
ім'я співрозмовника в npcNames. Перекладати їх удруге — це і марна робота, і
джерело різнобою (той самий квест у журналі й у вікні NPC назветься по-різному).

Скрипт розкладає чергу на три купи:
  • quests   — збіг із назвою квесту; переклад БЕРЕТЬСЯ з бази, перекладач не потрібен
  • npc      — збіг з іменем NPC; те саме
  • rest     — справжня робота, лишається в батчах

Запуск: python _xref_gossip_wave.py [--apply]
Без --apply лише звітує.
"""
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR, batch_files

APPLY = "--apply" in sys.argv
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
qsrc = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))
crea = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))

# «(low level)» — суфікс клієнта для застарілих квестів, у назві його немає
LOW = re.compile(r"\s*\((low level|низький рівень)\)\s*$", re.I)


def norm(s):
    return re.sub(r"\s+", " ", LOW.sub("", s)).strip()


# EN назва квесту -> UA (лише там, де назву вже перекладено)
qtitle = {}
for qid, v in qsrc.items():
    en = (v.get("title") or {}).get("en") if isinstance(v, dict) else None
    ua = (tr.get("quests", {}).get(qid) or {}).get("title")
    if en and ua:
        qtitle.setdefault(norm(en), ua)

# EN ім'я NPC -> UA
npc = {}
rows = crea.values() if isinstance(crea, dict) else crea
tn = tr.get("npcNames", {})
for cid, v in (crea.items() if isinstance(crea, dict) else []):
    if not isinstance(v, dict):
        continue
    nm = v.get("name") if isinstance(v.get("name"), dict) else v
    en = nm.get("en") if isinstance(nm, dict) else None
    ua = tn.get(str(cid))
    if en and ua:
        npc.setdefault(norm(en), ua)

BD = DATA_DIR / "batches" / "gossip"
hit_q, hit_n, rest = {}, {}, []
for f in batch_files("gossip", "g"):
    for s in json.loads(f.read_text(encoding="utf-8")):
        k = norm(s)
        if k in qtitle:
            hit_q[s] = qtitle[k]
        elif k in npc:
            hit_n[s] = npc[k]
        else:
            rest.append(s)

print(f"ґосип-черга: {len(hit_q) + len(hit_n) + len(rest)}")
print(f"  • назва квесту (переклад є в quests):   {len(hit_q)}")
print(f"  • ім'я NPC (переклад є в npcNames):     {len(hit_n)}")
print(f"  • справжня робота:                      {len(rest)}")
for s, ua in list(hit_q.items())[:4]:
    print(f"      Q  {s[:44]:<46}-> {ua[:40]}")
for s, ua in list(hit_n.items())[:4]:
    print(f"      N  {s[:44]:<46}-> {ua[:40]}")

if not APPLY:
    print("\n(звіт; щоб застосувати — --apply)")
    sys.exit()

reuse = {**hit_q, **hit_n}
out = BD / "out_g_xref.json"
out.write_text(json.dumps(reuse, ensure_ascii=False, indent=1), encoding="utf-8")
size = 40
for f in batch_files("gossip", "g"):
    f.unlink()
for k in range((len(rest) + size - 1) // size):
    (BD / f"g_{k:02d}.json").write_text(
        json.dumps(rest[k * size:(k + 1) * size], ensure_ascii=False, indent=1),
        encoding="utf-8")
print(f"\n-> out_g_xref.json: {len(reuse)} готових пар (мердж штатним "
      f"_merge_gossip_wave.py)\n-> у чергу лишилось: {len(rest)}")
