# -*- coding: utf-8 -*-
"""Витяг зібраних У ГРІ імен істот -> creatures.json.

Читає WoWUkraineCaptureDB.npc = { ["creatureID"]="English Name", ... } зі
SavedVariables і додає НОВІ записи в data/source/creatures.json
({creatureID:{name:{en}}}). Далі — звичайний конвеєр:
    prep_creature_batches.py -> переклад -> merge_creature_names.py -> generate_db.py

Запуск:  python extract_capture_creatures.py   [--file <шлях до WoWUkraine.lua>]
"""
import argparse, glob, json, re, sys
from common import DATA_DIR
sys.stdout.reconfigure(encoding="utf-8")

DEFAULT = r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua"


def meta_name(text):
    """Ім'я персонажа, чий це збір (meta.playerName) — або None."""
    m = re.search(r'\["playerName"\]\s*=\s*"([^"]+)"', text)
    return m.group(1) if m else None


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


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--file", help="шлях до SavedVariables/WoWUkraine.lua")
    args = ap.parse_args()

    # КІЛЬКА ФАЙЛІВ ЗА РАЗ. Раніше брався один шлях, тож прогін по теці зборів
    # вимагав 136 запусків, і кожен перечитував-перезаписував creatures.json.
    # Ім'я власника збору (meta.playerName) потрібне ОКРЕМО на кожен файл —
    # ним відсівають слуг цього гравця, — тому тримаємо пари (текст, зібране).
    paths = glob.glob(args.file) if args.file else glob.glob(DEFAULT)
    if args.file and not paths:
        paths = [args.file]
    if not paths:
        print("НЕ знайдено файлів зборів. Вкажи --file.")
        return
    print(f"файлів: {len(paths)}")

    per_file, captured = [], {}
    for path in paths:
        try:
            text = open(path, encoding="utf-8", errors="replace").read()
        except OSError as e:
            print("  !!", path, e)
            continue
        pairs = re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"',
                           find_block(text, "npc"))
        got = {cid: nm.replace('\\"', '"').replace("\\\\", "\\")
               for cid, nm in pairs if nm not in ("Unknown", "")}
        per_file.append((meta_name(text), got))
        captured.update(got)
    print("Зібрано в грі імен істот:", len(captured))

    cr_path = DATA_DIR / "source" / "creatures.json"
    cr = json.loads(cr_path.read_text(encoding="utf-8-sig"))
    have_en = {(v.get("name") or {}).get("en") for v in cr.values() if isinstance(v, dict)}

    # ЗАСЛІН ВІД ІМЕН ГРАВЦІВ. Збір бере імена з плашок, а плашка буває і в
    # гравця — так у ДАТАМАЙН потрапили «<нік>» (256292) і «<нік>»
    # (190254), обидва голими записами без de/fr. Шкода не в двох рядках:
    # creatures.json служить ЗАСЛОНОМ у всіх відсівах («слово є іменем істоти —
    # не чіпати»), тож занесений туди нік починає вигороджувати сам себе, і
    # звірка стає коловою [[guild-names-never-translate]].
    from playernames import known_nicks
    nicks = known_nicks(min_len=3, drop_ambiguous=False)

    # власники зборів: ім'я кожного тестера відсіває ЙОГО слуг у будь-якому файлі
    owners = {o for o, _ in per_file if o and len(o) >= 3}

    added, skipped = 0, []
    for cid, en in captured.items():
        if cid in cr or en in have_en:
            continue
        # Нік буває не лише ЦІЛОЮ назвою, а й усередині неї: труп гравця гра
        # називає «<Нік>'s Body», і точний збіг такого не ловить — «<нік>'s
        # Body» проліз у датамайн саме так [[guild-names-never-translate]].
        #
        # АЛЕ «нік будь-де в рядку» рубав і справжніх NPC: «Duke Vielle»,
        # «Provisioner Klaus», «Darlene Stokx», «Anub'esska» (07.10) — бо
        # Vielle/Klaus/Darlene хтось колись узяв собі за нік. Спирається на те,
        # що ім'я гравця — ЗАВЖДИ одне слово без пробілу: тож голий нік ловимо
        # точним збігом, а всередині рядка — лише присвійну форму («<Нік>'s …»)
        # і ім'я ВЛАСНИКА цього збору (його слуги: «Margaritkade's Assassin»).
        if en in nicks \
                or any(re.search(r"\b" + re.escape(n) + r"['’]s\b", en)
                       for n in nicks if len(n) >= 4) \
                or any(re.search(r"\b" + re.escape(o), en) for o in owners):
            skipped.append(en)
            continue
        cr[cid] = {"name": {"en": en}}
        have_en.add(en)
        added += 1
    if skipped:
        print(f"Відсіяно імен гравців: {len(skipped)} -> {sorted(set(skipped))}")

    cr_path.write_text(json.dumps(cr, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Додано НОВИХ у creatures.json: {added} | усього: {len(cr)}")
    if added:
        print("Далі: python prep_creature_batches.py  ->  переклад  ->  merge_creature_names.py  ->  generate_db.py")


if __name__ == "__main__":
    main()
