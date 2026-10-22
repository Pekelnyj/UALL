# -*- coding: utf-8 -*-
"""Черга хвилі «назви заклять у лінках» для описів здібностей журналу.

Українське речення в bossAbilities лишає лінк |Hspell:ID|h[English Name]|h.
Переклад назви є в spells[ID], але вставити його сліпо не можна: речення вже
побудоване навколо лінка, і називний відмінок дає «за допомогою Лютий погляд»,
«уникай Повзуча гнилизна». Аудит 13.09: ≥627 лінків після прийменника, 909 з
продовженням речення, 839 з іншим числом/назвою в лінку, 105 конфліктів із
вже перекладеними лінками того самого ID. Безпечних рядків — один.

Тому агент НЕ переписує текст, а повертає:
  • форму назви для кожного лінка (відмінок/число під речення, база — spells[ID]);
  • за потреби — дрібні правки узгодження «старий фрагмент → новий».
Злиття (_merge_spell_links_wave.py) підставляє детерміновано, коди не чіпає.

Вихід: data/batches/spelllinks/sl_NN.json
  [{"n": 0, "text": "<поточне значення>", "links": [{"i","id","en","ua","base_forms"}]}]
Запуск: python _prep_spell_links_wave.py [кількість_порцій=12]
"""
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

PARTS = int(sys.argv[1]) if len(sys.argv) > 1 else 12
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
spells = tr.get("spells") or {}

LINK = re.compile(r"\|Hspell:(\d+)\|h\[([^\]]+)\]\|h")
CYR = re.compile(r"[А-Яа-яІіЇїЄєҐґ]")
LAT = re.compile(r"[A-Za-z]{3,}")


def ua_of(v):
    return v if isinstance(v, str) else (v.get("ua") if isinstance(v, dict) else None)


def substitutable(sid, name):
    return bool(LAT.search(name) and not CYR.search(name) and ua_of(spells.get(sid)))


# як ТОЙ САМИЙ ID уже перекладено в інших лінках бази — для довідки агенту
base_forms = {}
for d in tr.values():
    if isinstance(d, dict):
        for v in d.values():
            if isinstance(v, str) and "|Hspell:" in v:
                for sid, name in LINK.findall(v):
                    if CYR.search(name):
                        base_forms.setdefault(sid, set()).add(name)

items = []
for k, v in tr["bossAbilities"].items():
    if not (isinstance(v, str) and CYR.search(v) and "|Hspell:" in v):
        continue
    links = []
    for i, m in enumerate(LINK.finditer(v)):
        sid, name = m.group(1), m.group(2)
        if substitutable(sid, name):
            links.append({"i": i, "id": sid, "en": name, "ua": ua_of(spells[sid]),
                          "base_forms": sorted(base_forms.get(sid, ()))})
    if links:
        items.append({"key": k, "text": v, "links": links})

# рівні порції за обсягом тексту
items.sort(key=lambda x: x["key"])
total = sum(len(x["text"]) for x in items)
out = DATA_DIR / "batches" / "spelllinks"
out.mkdir(parents=True, exist_ok=True)
for f in out.glob("sl_*.json"):
    f.unlink()
index = {}
part, acc, cur = 0, 0, []
limit = total / PARTS
for n, it in enumerate(items):
    index[str(n)] = it["key"]
    cur.append({"n": n, "text": it["text"], "links": it["links"]})
    acc += len(it["text"])
    if acc >= limit * (part + 1) and part < PARTS - 1:
        (out / f"sl_{part:02d}.json").write_text(
            json.dumps(cur, ensure_ascii=False, indent=1), encoding="utf-8")
        part, cur = part + 1, []
if cur:
    (out / f"sl_{part:02d}.json").write_text(
        json.dumps(cur, ensure_ascii=False, indent=1), encoding="utf-8")
(out / "_index.json").write_text(json.dumps(index, ensure_ascii=False), encoding="utf-8")
print(f"рядків: {len(items)} | лінків: {sum(len(x['links']) for x in items)} | "
      f"символів: {total} | порцій: {part + 1}")
for f in sorted(out.glob("sl_*.json")):
    d = json.loads(f.read_text(encoding="utf-8"))
    print(f"  {f.name}: {len(d)} рядків, n {d[0]['n']}–{d[-1]['n']}, "
          f"{sum(len(x['links']) for x in d)} лінків")
