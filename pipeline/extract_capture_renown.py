# -*- coding: utf-8 -*-
"""Витяг зібраних У ГРІ нагород визнання (Renown) -> api_renown.json.

Читає WoWUkraineCaptureDB.renown = { ["English Name"]="English Desc" | true }
зі SavedVariables і додає НОВІ у data/source/api_renown.json
({id:{name:{en}, desc?:{en}}}, id — наскрізний номер; дедуп за англ. назвою).
Blizzard НЕ віддає це через Game Data API — лише збір у грі (C_MajorFactions).

Далі звичайний конвеєр для name(+desc)-фронтів:
    prep_api_front.py --front renown -> переклад -> merge_api_front.py --front renown
    -> generate_db.py (generate_renown).

Запуск:  python extract_capture_renown.py  [--file <шлях до WoWUkraine.lua>]
"""
import argparse, glob, json, re, sys
from common import DATA_DIR
sys.stdout.reconfigure(encoding="utf-8")

DEFAULT = r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua"


def find_block(text, key):
    """Витягти вміст ["key"] = { ... } зі сканом дужок (стрічки пропускаємо)."""
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', text)
    if not m:
        return ""
    i, depth, instr, esc, start = m.end(), 1, False, False, m.end()
    while i < len(text) and depth > 0:
        c = text[i]
        if instr:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                instr = False
        else:
            if c == '"':
                instr = True
            elif c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
        i += 1
    return text[start:i - 1]


def unesc(s):
    return s.replace('\\"', '"').replace("\\\\", "\\").replace("\\n", "\n").replace("\\r", "")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--file", help="шлях до SavedVariables/WoWUkraine.lua")
    args = ap.parse_args()

    path = args.file
    if not path:
        hits = glob.glob(DEFAULT)
        if not hits:
            print("НЕ знайдено WoWUkraine.lua у WTF. Вкажи --file.")
            return
        path = hits[0]
    print("Читаю:", path)
    text = open(path, encoding="utf-8", errors="replace").read()

    block = find_block(text, "renown")
    # ["Name"] = "Desc"  АБО  ["Name"] = true
    pairs = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*(?:"((?:[^"\\]|\\.)*)"|(true))', block)
    captured = {}
    for name, desc, _true in pairs:
        n = unesc(name).strip()
        if n:
            captured[n] = unesc(desc).strip() if desc else ""
    print("Зібрано в грі нагород визнання:", len(captured))

    out_path = DATA_DIR / "source" / "api_renown.json"
    out = {}
    if out_path.exists():
        out = json.loads(out_path.read_text(encoding="utf-8-sig"))
    have = {(v.get("name") or {}).get("en") for v in out.values() if isinstance(v, dict)}
    next_id = max((int(k) for k in out if k.isdigit()), default=0) + 1

    added = 0
    for name, desc in captured.items():
        if name in have:
            continue
        rec = {"name": {"en": name}}
        if desc:
            rec["desc"] = {"en": desc}
        out[str(next_id)] = rec
        have.add(name)
        next_id += 1
        added += 1

    out_path.write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Додано НОВИХ у api_renown.json: {added} | усього: {len(out)}")
    if added:
        print("Далі: python prep_api_front.py --front renown -> переклад -> merge_api_front.py --front renown -> generate_db.py")


if __name__ == "__main__":
    main()
