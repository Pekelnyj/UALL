# -*- coding: utf-8 -*-
"""Калькохвиля 8: будуємо кандидатів (зліплені UA-новотвори в назвах предметів),
віднімаємо все, що вже показували у хвилях 2..7, решту ріжемо на батчі."""
import json
import re
import glob
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")

tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
itn = tr["itemNames"]  # {en: ua}

# --- en -> (de, fr) з items.json (keyed by id: {en,de,fr,...}) ---
items = json.loads((B / "data/source/items.json").read_text(encoding="utf-8-sig"))
en2 = {}
for v in items.values():
    if not isinstance(v, dict):
        continue
    nm = v.get("name")
    if not isinstance(nm, dict):
        continue
    en = nm.get("en")
    if en and en not in en2:
        en2[en] = (nm.get("de", ""), nm.get("fr", ""))

# --- сигнатура кальки: «1 EN-зліплене слово → 1 UA-зліплений новотвір» ---
# UA-зліплення: одне слово, кирилиця, >=9 літер, з'єднувальний о/е в середині,
#   НЕ дефісне, НЕ транслітерація (має корінь-місток).
CONNECT = re.compile(r"[бвгґджзклмнпрстфхцчшщ][ое][бвгґджзклмнпрстфхцчшщ]", re.I)

def ua_fused(w):
    if "-" in w or len(w) < 9:
        return False
    if not re.fullmatch(r"[А-Яа-яІіЇїЄєҐґ']+", w):
        return False
    return bool(CONNECT.search(w))

def en_compound(en):
    # EN-токен (одне слово) як закритий компаунд: >=9 літер, лише букви,
    # внутрішня велика літера (CamelCase) АБО хвіст калькопастки.
    for t in re.findall(r"[A-Za-z']+", en):
        if len(t) >= 9 and re.search(r"[a-z][A-Z]", t):
            return True
    TAIL = ("bane","blade","breaker","render","ripper","flayer","maw","jaw",
            "fang","claw","hide","hoof","horn","wing","song","fire","frost",
            "flame","blood","bone","heart","soul","brew","snap","splitter",
            "shaper","bringer","weaver","binder","caller","seeker","stalker",
            "slicer","crusher","smasher","reaver","cleaver","gutter","piercer",
            "stinger","biter","render","wrecker","saur","scale","claw","tooth")
    # хвіст-пастка лише наприкінці ОКРЕМОГО токена (закритий компаунд)
    for t in re.findall(r"[A-Za-z']+", en):
        tl = t.lower().replace("'", "")
        if len(tl) >= 8 and any(tl.endswith(x) and tl != x for x in TAIL):
            return True
    return False

cands = []
for en, ua in itn.items():
    if not isinstance(ua, str) or not ua:
        continue
    if re.search(r"[A-Za-z]{3}", ua):  # лишилась латинка — інший борг
        continue
    toks = re.findall(r"[А-Яа-яІіЇїЄєҐґ'-]+", ua)
    if any(ua_fused(w) for w in toks) and en_compound(en):
        cands.append(en)

cands = sorted(set(cands))

# --- віднімаємо все вже показане у хвилях 2..7 ---
seen = set()
for f in glob.glob(str(B / "data/_cq[2-7]_*.json")):
    if "_out_" in f or f.endswith("_all.json") or "_distinct" in f or "v_" in Path(f).name:
        # пропускаємо вихідні/агрегати/верифікаційні
        pass
    try:
        arr = json.loads(Path(f).read_text(encoding="utf-8"))
    except Exception:
        continue
    if isinstance(arr, list):
        for x in arr:
            if isinstance(x, dict) and "en" in x:
                seen.add(x["en"])

remaining = [e for e in cands if e not in seen]
print(f"всього кандидатів-зліплень: {len(cands)} | вже оброблено (хвилі 2-7): {len(cands)-len(remaining)} | ЗАЛИШИЛОСЯ: {len(remaining)}")

# --- батчі по 30, до 12 батчів цієї хвилі ---
IN = B / "data"
batch = []
for en in remaining:
    de, fr = en2.get(en, ("", ""))
    batch.append({"en": en, "ua": itn[en], "de": de, "fr": fr})

NB = 12
per = 30
wave = batch[:NB * per]
for i in range(NB):
    chunk = wave[i * per:(i + 1) * per]
    if not chunk:
        break
    (IN / f"_cq8_{i+1}.json").write_text(json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"батчів цієї хвилі: {min(NB, (len(wave)+per-1)//per)} по {per} | у роботі цієї хвилі: {len(wave)} | хвиль ще треба: ~{(len(remaining)+NB*per-1)//(NB*per)}")
