"""Парсер SavedVariables: WoWUkraine.lua -> data/capture.json.

Аддон записує зустрінуті англійські тексти квестів у файл
WTF/Account/<АКАУНТ>/SavedVariables/WoWUkraine.lua. Цей скрипт читає його
і зберігає як JSON для подальшого перекладу (translate.py).

Використання:
    python parse_capture.py                        # авто-пошук у стандартному шляху WoW
    python parse_capture.py path/to/WoWUkraine.lua # явний шлях
"""

import argparse
import glob
import json
import sys
from pathlib import Path

from common import DATA_DIR, addon_name, sv_variable

# Ім'я SV-файлу у WTF збігається з назвою аддона — підставляється динамічно.
DEFAULT_SV_GLOBS = [
    r"F:\Battlenet\World of Warcraft\_retail_\WTF\Account\*\SavedVariables\{name}.lua",
    r"C:\Program Files (x86)\World of Warcraft\_retail_\WTF\Account\*\SavedVariables\{name}.lua",
]


class LuaParser:
    """Мінімальний парсер Lua-таблиць у форматі, який пише Blizzard-серіалізатор."""

    def __init__(self, text: str):
        self.text = text
        self.i = 0

    def error(self, msg: str):
        line = self.text.count("\n", 0, self.i) + 1
        raise ValueError(f"{msg} (рядок {line})")

    def skip_ws(self):
        text, n = self.text, len(self.text)
        while self.i < n:
            c = text[self.i]
            if c in " \t\r\n":
                self.i += 1
            elif text.startswith("--", self.i):
                nl = text.find("\n", self.i)
                self.i = n if nl == -1 else nl + 1
            else:
                break

    def parse_value(self):
        self.skip_ws()
        c = self.text[self.i]
        if c == "{":
            return self.parse_table()
        if c == '"':
            return self.parse_string()
        if c.isdigit() or c == "-":
            return self.parse_number()
        for literal, value in (("true", True), ("false", False), ("nil", None)):
            if self.text.startswith(literal, self.i):
                self.i += len(literal)
                return value
        self.error(f"неочікуваний символ {c!r}")

    def parse_number(self):
        start = self.i
        while self.i < len(self.text) and (self.text[self.i] in "-+.eExX" or self.text[self.i].isalnum()):
            self.i += 1
        token = self.text[start:self.i]
        try:
            return int(token)
        except ValueError:
            return float(token)

    def parse_string(self):
        assert self.text[self.i] == '"'
        self.i += 1
        out = []
        text = self.text
        while True:
            c = text[self.i]
            if c == '"':
                self.i += 1
                return "".join(out)
            if c == "\\":
                self.i += 1
                e = text[self.i]
                if e == "n":
                    out.append("\n")
                    self.i += 1
                elif e == "t":
                    out.append("\t")
                    self.i += 1
                elif e == "r":
                    out.append("\r")
                    self.i += 1
                elif e.isdigit():  # десяткові escape-послідовності Lua: \ddd
                    num = ""
                    while len(num) < 3 and text[self.i].isdigit():
                        num += text[self.i]
                        self.i += 1
                    out.append(chr(int(num)))
                else:  # \" \\ \| та інші — як є
                    out.append(e)
                    self.i += 1
            else:
                out.append(c)
                self.i += 1

    def parse_table(self):
        assert self.text[self.i] == "{"
        self.i += 1
        result: dict = {}
        array_index = 1
        while True:
            self.skip_ws()
            c = self.text[self.i]
            if c == "}":
                self.i += 1
                return result
            if c == "[":
                self.i += 1
                key = self.parse_value()
                self.skip_ws()
                if self.text[self.i] != "]":
                    self.error("очікувалась ']'")
                self.i += 1
                self.skip_ws()
                if self.text[self.i] != "=":
                    self.error("очікувалось '='")
                self.i += 1
                result[key] = self.parse_value()
            else:
                result[array_index] = self.parse_value()
                array_index += 1
            self.skip_ws()
            if self.text[self.i] == ",":
                self.i += 1


def parse_saved_variables(path: Path) -> dict:
    text = path.read_text(encoding="utf-8")
    marker = sv_variable()  # назва змінної береться з .toc аддона
    pos = text.find(marker)
    if pos == -1:
        raise ValueError(f"У файлі {path} немає змінної {marker}")
    pos = text.find("{", pos)
    parser = LuaParser(text)
    parser.i = pos
    return parser.parse_table()


def find_sv_file() -> Path | None:
    name = addon_name()
    for pattern in DEFAULT_SV_GLOBS:
        matches = glob.glob(pattern.format(name=name))
        if matches:
            # Якщо акаунтів декілька — беремо найсвіжіший файл.
            return Path(max(matches, key=lambda p: Path(p).stat().st_mtime))
    return None


def main():
    ap = argparse.ArgumentParser(description="SavedVariables -> capture.json")
    ap.add_argument("sv_path", nargs="?", help="Шлях до WoWUkraine.lua (SavedVariables)")
    ap.add_argument("-o", "--output", default=str(DATA_DIR / "capture.json"))
    args = ap.parse_args()

    sv_path = Path(args.sv_path) if args.sv_path else find_sv_file()
    if not sv_path or not sv_path.exists():
        sys.exit(
            "Не знайдено файл SavedVariables. Вкажіть шлях явно:\n"
            f"  python parse_capture.py \"<WoW>\\_retail_\\WTF\\Account\\<АКАУНТ>\\SavedVariables\\{addon_name()}.lua\""
        )

    db = parse_saved_variables(sv_path)
    quests = db.get("quests", {})
    # JSON-ключі — рядки; зберігаємо questID як рядки одразу.
    out = {
        "meta": db.get("meta", {}),
        "quests": {str(qid): entry for qid, entry in sorted(quests.items())},
    }

    out_path = Path(args.output)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(json.dumps(out, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Прочитано {sv_path}")
    print(f"Квестів зібрано: {len(out['quests'])} -> {out_path}")


if __name__ == "__main__":
    main()
