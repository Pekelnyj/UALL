# -*- coding: utf-8 -*-
"""Витяг зібраних У ГРІ написів ПОЗНАЧОК МІНІМАПИ -> api_minimap.json.

Читає WoWUkraineCaptureDB.minimap = { ["English Label"]=true } зі SavedVariables.
Відсіює вже відоме (назви предметів, імена NPC, назви квестів) і додає НОВЕ у
data/source/api_minimap.json ({id:{name:{en}}}, id — наскрізний номер; дедуп за назвою).
Це типи позначок («Mailbox»), імена точок інтересу, об'єктів — їх немає у статичних
базах Blizzard, лише збір у грі.

Далі: prep_api_front.py --front minimap -> переклад -> merge_api_front.py --front minimap.

Запуск:  python extract_capture_minimap.py  [--file <шлях до WoWUkraine.lua>]
"""
import argparse, glob, json, re, sys
from common import DATA_DIR
sys.stdout.reconfigure(encoding="utf-8")

DEFAULT = r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua"


def find_block(text, key):
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
    return s.replace('\\"', '"').replace("\\\\", "\\")


def known_english():
    """Множина англ. рядків, які вже перекладені деінде (щоб не дублювати)."""
    known = set()
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    known |= set(tr.get("itemNames", {}).keys())          # itemNames: ключ = англ.
    # імена NPC (англ.) з creatures.json
    cr_path = DATA_DIR / "source" / "creatures.json"
    if cr_path.exists():
        cr = json.loads(cr_path.read_text(encoding="utf-8-sig"))
        for v in cr.values():
            en = (v.get("name") or {}).get("en") if isinstance(v, dict) else None
            if en:
                known.add(en)
    # назви квестів (англ.) з quests.json
    q_path = DATA_DIR / "source" / "quests.json"
    if q_path.exists():
        q = json.loads(q_path.read_text(encoding="utf-8-sig"))
        for v in q.values():
            en = (v.get("title") or {}).get("en") if isinstance(v, dict) else None
            if en:
                known.add(en)
    return known


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

    block = find_block(text, "minimap")
    labels = [unesc(m).strip() for m in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=', block)]
    labels = [s for s in labels if s]
    print("Зібрано написів мінімапи:", len(labels))

    known = known_english()
    out_path = DATA_DIR / "source" / "api_minimap.json"
    out = {}
    if out_path.exists():
        out = json.loads(out_path.read_text(encoding="utf-8-sig"))
    have = {(v.get("name") or {}).get("en") for v in out.values() if isinstance(v, dict)}
    next_id = max((int(k) for k in out if k.isdigit()), default=0) + 1

    added = skipped = 0
    for s in labels:
        if s in have:
            continue
        if s in known:
            skipped += 1
            continue
        out[str(next_id)] = {"name": {"en": s}}
        have.add(s)
        next_id += 1
        added += 1

    out_path.write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Додано НОВИХ: {added} | пропущено відомих: {skipped} | усього: {len(out)}")
    if added:
        print("Далі: python prep_api_front.py --front minimap -> переклад -> merge_api_front.py --front minimap")


if __name__ == "__main__":
    main()
