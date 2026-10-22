# -*- coding: utf-8 -*-
"""Застосувати артефакт правок редактора до data/translations.json — точно за координатами.

Артефакт (з адмінпанелі, /api/admin/export):
    {"_meta": {"format":"wowukraine-edits-v1", ...}, "edits": [
        {"section":..., "item_key":..., "field":..., "ua":..., "en":..., "author":..., ...}, ...]}

Розкладка — точний реверс імпорту (як у export_db.py):
    field == ""   ->  tr[section][item_key]        = ua     (EN-/ID-ключ, рядок)
    field != ""   ->  tr[section][item_key][field] = ua     (dict-секції)
Якщо під ключем уже є НЕ-dict значення, а правка вимагає dict — пропускаємо (не псуємо).

Запуск:
    python editor/apply_edits.py <артефакт.json>            # застосувати + записати
    python editor/apply_edits.py <артефакт.json> --dry      # лише показати, що зміниться
    python editor/apply_edits.py <артефакт.json> --build     # + запустити pipeline/generate_db.py
"""
import json
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
TRANSLATIONS = ROOT / "data" / "translations.json"


def main():
    argv = sys.argv[1:]
    paths = [a for a in argv if not a.startswith("--")]
    if not paths:
        print(__doc__)
        return
    dry = "--dry" in argv
    build = "--build" in argv

    art = json.loads(Path(paths[0]).read_text(encoding="utf-8-sig"))
    edits = art.get("edits") if isinstance(art, dict) else art
    if not isinstance(edits, list):
        raise SystemExit("Невідомий формат артефакту: немає списку 'edits'.")
    meta = art.get("_meta", {}) if isinstance(art, dict) else {}
    print(f"Артефакт: формат={meta.get('format','?')} scope={meta.get('scope','?')} "
          f"записів={len(edits)}")

    tr = json.loads(TRANSLATIONS.read_text(encoding="utf-8-sig"))

    changed = 0   # реально змінили значення
    same = 0      # уже таке саме
    skipped = 0   # неповний запис
    bad = 0       # конфлікт структури
    samples = []

    for e in edits:
        section = e.get("section")
        key = e.get("item_key")
        field = e.get("field", "") or ""
        ua = e.get("ua")
        if not section or key is None or ua is None:
            skipped += 1
            continue
        sect = tr.setdefault(section, {})
        if field == "":
            old = sect.get(key)
            if old == ua:
                same += 1
            else:
                if len(samples) < 12:
                    samples.append(f"{section}·{key}: {_short(old)} -> {_short(ua)}")
                sect[key] = ua
                changed += 1
        else:
            entry = sect.get(key)
            if not isinstance(entry, dict):
                if entry is not None:
                    bad += 1
                    continue
                entry = {}
                sect[key] = entry
            old = entry.get(field)
            if old == ua:
                same += 1
            else:
                if len(samples) < 12:
                    samples.append(f"{section}·{key}·{field}: {_short(old)} -> {_short(ua)}")
                entry[field] = ua
                changed += 1

    print(f"Змінено: {changed} | без змін: {same} | пропущено(неповні): {skipped}"
          + (f" | конфлікт структури: {bad}" if bad else ""))
    if samples:
        print("Приклади:")
        for s in samples:
            print("  " + s)

    if dry:
        print("\nDRY — нічого не записано.")
        return

    TRANSLATIONS.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"-> {TRANSLATIONS}")

    if build:
        print("\n== generate_db.py ==")
        res = subprocess.run([sys.executable, "generate_db.py"], cwd=ROOT / "pipeline")
        if res.returncode != 0:
            raise SystemExit(f"generate_db.py завершився з кодом {res.returncode}")
    else:
        print("далі: python pipeline/generate_db.py")


def _short(s, n=42):
    if s is None:
        return "∅"
    s = str(s).replace("\n", "⏎")
    return s if len(s) <= n else s[:n] + "…"


if __name__ == "__main__":
    main()
