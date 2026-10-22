# -*- coding: utf-8 -*-
# Готує батчі НЕперекладених заклять: назви + описи (шаблони). З контекстом en/de/fr
# і skillLine. Фільтрує службовий шум (тест/DND/сервер-онлі/без літер). Дедуп описів за en.
# Запуск: python pipeline/prep_spells.py
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
def load(p): return json.loads((DATA / p).read_text(encoding="utf-8-sig"))

spells = load("source/spells.json")
tr = load("translations.json")
done_names = set(tr.get("spells", {}))          # ключ — spellID
done_desc = set(tr.get("descTemplates", {}))     # ключ — EN-текст опису

# Шум: службові/тестові закляття, які гравець не бачить.
NOISE = re.compile(r"\b(test|debug|dnd|unused|deprecated|placeholder|qa|\[ph\]|"
                   r"server[- ]only|do not use|don't use|old|copy of|proc|trigger)\b", re.I)
# Те, що попередній фільтр пропускав і що чесно псувало підрахунок обсягу:
# «PH Goblin Hovercraft (Blue)», «REUSE», «NYI», «zzOld…» та внутрішні рядки
# розробників із версією на початку («9.0 Transmute: 04»).
NOISE2 = re.compile(r"\bPH\b|\bREUSE\b|\bNYI\b|\bDNT\b|\(PH\)|\(DND\)|\(OLD\)|"
                    r"^zz|^\[|^<|^\d+\.[\dx]\s|"
                    # службова машинерія, якої гравець не бачить: керівні аури,
                    # манекени, токени масштабування, технічні підганяння
                    r"\bDriver\b|\bDummy\b|\bScaling Token\b|"
                    r"^Item - |^Stat Negation|\bAdjustment\b")
# «$@spelldesc212336» — перехресне посилання на опис іншого закляття, а не
# текст. Уся черга описів складалася саме з них, тобто роботи там нема.
XREF = re.compile(r"^\s*\$@\w+")


def is_noise(en):
    if not en or not en.strip(): return True
    if not re.search(r"[A-Za-z]", en): return True
    if XREF.match(en): return True
    if NOISE.search(en): return True
    if NOISE2.search(en): return True
    return False

# ---- НАЗВИ ----
name_items = []
seen_name = set()
for sid, s in spells.items():
    en = (s.get("name") or {}).get("en")
    if not en or sid in done_names or is_noise(en): continue
    if en in seen_name: continue           # дедуп за текстом назви
    seen_name.add(en)
    name_items.append({
        "id": sid, "en": en,
        "de": (s.get("name") or {}).get("de", ""),
        "fr": (s.get("name") or {}).get("fr", ""),
        "skill": s.get("skillLine", ""),
    })

# ---- ОПИСИ (дедуп за en) ----
desc_map = {}
for sid, s in spells.items():
    en = (s.get("description") or {}).get("en")
    if not en or en in done_desc or is_noise(en): continue
    if en in desc_map: continue
    desc_map[en] = {
        "en": en,
        "de": (s.get("description") or {}).get("de", ""),
        "fr": (s.get("description") or {}).get("fr", ""),
        "skill": s.get("skillLine", ""),
    }
desc_items = list(desc_map.values())

print(f"НАЗВИ до перекладу (унік., без шуму): {len(name_items)}")
print(f"ОПИСИ до перекладу (унік., без шуму): {len(desc_items)}")

# Скільки відсіяно як шум
noise_names = sum(1 for sid, s in spells.items()
                  if (s.get('name') or {}).get('en') and sid not in done_names
                  and is_noise((s.get('name') or {}).get('en')))
print(f"(відсіяно назв-шуму: {noise_names})")

def write_batches(items, sub, size):
    d = DATA / sub
    d.mkdir(exist_ok=True)
    for f in d.glob("*.json"): f.unlink()
    n = 0
    for i in range(0, len(items), size):
        (d / f"{sub}_{n:03d}.json").write_text(
            json.dumps(items[i:i+size], ensure_ascii=False, indent=1), encoding="utf-8")
        n += 1
    print(f"  {sub}: {n} батчів по {size}")
    return n

write_batches(name_items, "spell_names", 150)
write_batches(desc_items, "spell_descs", 80)
