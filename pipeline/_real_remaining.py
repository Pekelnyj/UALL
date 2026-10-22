# -*- coding: utf-8 -*-
"""РЕАЛЬНИЙ залишок перекладу по всіх категоріях (правильно — за наявністю ключа/значення)."""
import json
import sys
import re
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))


def L(f):
    p = B / "data/source" / f
    return json.loads(p.read_text(encoding="utf-8-sig")) if p.exists() else {}


def untr_by_id(src, section):
    """src: {id:{name:{en}}}; section: id->ua. Неперекл. = id з en-назвою, якого нема в section."""
    sec = tr.get(section, {})
    n = 0
    for k, v in src.items():
        en = (v.get("name") or {}).get("en") if isinstance(v, dict) else None
        if en and str(k) not in sec:
            n += 1
    return n, len(src), len(sec)


rows = []
# id->name джерела
for label, f, sec in [
    ("Маунти", "api_mounts.json", "mounts"),
    ("Улюбленці", "api_pets.json", "pets"),
    ("Валюти", "currencies.json", "currencies"),
    ("Титули", "api_titles.json", "titles"),
    ("Фракції", "api_factions.json", "factions"),
    ("Досягнення", "achievements.json", "achievements"),
    ("Журнал-боси", "api_journal.json", "journal"),
    ("Журнал-секції(інст)", "api_journal_instances.json", "journal_instances"),
    ("Професії", "api_professions.json", "professions"),
    ("Афікси", "api_affixes.json", "affixes"),
    ("InstanceDesc", "api_instance_desc.json", "instanceDesc"),
]:
    src = L(f)
    if not src:
        continue
    left, tot, done = untr_by_id(src, sec)
    rows.append((label, tot, done, left))

# спец: spells descriptions (за EN-текстом у descTemplates)
sp = L("spells.json")
dt = set(tr.get("descTemplates", {}))
sp_desc_left = len({(v.get("description") or {}).get("en", "").strip()
                    for v in sp.values() if (v.get("description") or {}).get("en", "").strip()} - dt)
# «Описи заклять» роками показували 636 неперекладених. Насправді 614 із них —
# перехресні посилання «$@spelldesc12345» («показати опис іншого закляття»), а
# ще 22 — самі коди без тексту. Перекладати там нема чого, і такі рядки МАЮТЬ
# лишатися як є. Рахуємо лише те, що містить людський текст.
_XREF = re.compile(r"^\$@spell(desc|name|icon)\d+$", re.I)
_CODE = re.compile(r"^[\s$@?a-z0-9\[\]|;:<>/*+.-]*$", re.I)
_left_desc = {d for d in ({(v.get("description") or {}).get("en", "").strip()
                           for v in sp.values()
                           if isinstance(v, dict)
                           and (v.get("description") or {}).get("en", "").strip()} - dt)
              if not _XREF.match(d) and not _CODE.match(d)}
rows.append(("Закляття-описи(унік)", "-", "-", len(_left_desc)))

# Renown. Раніше тут стояв ЗАХАРДКОДЖЕНИЙ рядок «~645 / зроблено 0» з часів,
# коли секції renown ще не існувало. Він не перераховувався ніколи, тож звіт
# роками показував 645 «неперекладених», хоча насправді їх 3: секція renown
# уже має 2295 записів і generate_db вливає її в ns.uiTooltips.
# Знаменник — самі зібрані ключі, а не пам'ять про давній дамп.
_ren = tr.get("renown", {})
_ren_src = B / "data" / "batches" / "renown" / "_seen.json"
if _ren_src.exists():
    _seen = set(json.loads(_ren_src.read_text(encoding="utf-8")))
else:
    # без свіжого збору чесніше показати наявне, ніж вигадану цифру
    _seen = set(_ren)
rows.append(("Renown", len(_seen), len(_seen & set(_ren)), len(_seen - set(_ren))))
rows.append(("GameObjects(не в грі)", 141, 141, "0 (треба хук)"))

print(f"{'Категорія':<22}{'Джерело':>9}{'Зробл.':>9}{'ЛИШИЛОСЬ':>10}")
print("-" * 50)
for label, tot, done, left in rows:
    print(f"{label:<22}{str(tot):>9}{str(done):>9}{str(left):>10}")
