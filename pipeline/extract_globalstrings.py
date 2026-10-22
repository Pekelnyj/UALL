# -*- coding: utf-8 -*-
"""Витяг GlobalStrings (інтерфейс гри) зі SavedVariables -> globalstrings.json.

Читає WoWUkraineCaptureDB.globalStrings = { ["NAME"]="English value" } (дамп
командою /wowukraine dumpgs). Це авторитетні рядки інтерфейсу ЦІЄЇ версії гри.
Виход: data/source/globalstrings.json = {NAME: en}. Далі prep -> переклад
(ЗБЕРІГАТИ %d/%s/%1$s/|4(...)) -> merge -> generate_db (файл-перевизначення).

Запуск:  python extract_globalstrings.py  [--file <шлях>]
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
    return (s.replace('\\"', '"').replace("\\\\", "\\")
             .replace("\\n", "\n").replace("\\r", "\r").replace("\\t", "\t"))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--file")
    args = ap.parse_args()
    path = args.file or (glob.glob(DEFAULT) or [None])[0]
    if not path:
        print("НЕ знайдено WoWUkraine.lua. Вкажи --file.")
        return
    print("Читаю:", path)
    text = open(path, encoding="utf-8", errors="replace").read()
    block = find_block(text, "globalStrings")
    pairs = re.findall(r'\["([A-Z][A-Z0-9_]*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', block)

    out = {}
    skipped = 0
    for name, val in pairs:
        v = unesc(val).strip()
        # пропускаємо порожні/без літер (роздільники, символи) — нема що перекладати
        if not v or not re.search(r"[A-Za-z]", v):
            skipped += 1
            continue
        out[name] = v
    (DATA_DIR / "source" / "globalstrings.json").write_text(
        json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"GlobalStrings: {len(out)} (пропущено без тексту: {skipped}) "
          f"-> data/source/globalstrings.json")
    if out:
        print("Далі: prep -> переклад (зберігати %d/%s/%1$s/|4) -> merge -> generate_db.")


if __name__ == "__main__":
    main()
