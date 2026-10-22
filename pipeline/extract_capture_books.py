# -*- coding: utf-8 -*-
"""Об'єднати зібрані СТОРІНКИ КНИГ з усіх файлів збору (db.books[назва][page]),
дедуплікувати за текстом, прибрати ім'я гравця -> {NAME}, розкласти в батчі.

Вихід: data/book_batches/batch_NN.json {en_текст_сторінки: {"_book": назва, "_page": n}}
Переклад -> out_NN.json {en: ua} -> merge у translations.json["bookTexts"].
"""
import json
import glob
from pathlib import Path

from common import DATA_DIR, sv_variable
from parse_capture import LuaParser

OUT = DATA_DIR / "book_batches"
BATCH = 15  # книги довгі — менше на батч

CAPTURE_FILES = glob.glob(str(DATA_DIR.parent / "testerlua" / "*.lua")) + [
    r"F:\Battlenet\World of Warcraft\_retail_\WTF\Account\129089678#1\SavedVariables\WoWUkraine.lua",
]


def parse(p: Path) -> dict:
    text = p.read_text(encoding="utf-8", errors="replace")
    pos = text.find(sv_variable())
    if pos == -1:
        return {}
    pos = text.find("{", pos)
    pr = LuaParser(text)
    pr.i = pos
    return pr.parse_table()


def main():
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    done = tr.get("bookTexts", {})

    pages = {}  # en_text -> {book, page}
    files = 0
    for f in CAPTURE_FILES:
        p = Path(f)
        if not p.exists():
            continue
        try:
            db = parse(p)
        except Exception as e:
            print(f"  ПРОПУСК {p.name}: {e}")
            continue
        files += 1
        pname = (db.get("meta") or {}).get("playerName")
        for title, bk in (db.get("books") or {}).items():
            if not isinstance(bk, dict):
                continue
            for page, text in bk.items():
                if not isinstance(text, str) or not text.strip():
                    continue
                if pname:
                    text = text.replace(pname, "{NAME}")
                if text in done or text in pages:
                    continue
                pages[text] = {"_book": str(title), "_page": page}

    OUT.mkdir(parents=True, exist_ok=True)
    for old in OUT.glob("*.json"):
        old.unlink()
    items = list(pages.items())
    n = 0
    for i in range(0, len(items), BATCH):
        n += 1
        (OUT / f"batch_{n:02d}.json").write_text(
            json.dumps(dict(items[i:i + BATCH]), ensure_ascii=False, indent=1), encoding="utf-8")
    words = sum(len(t.split()) for t in pages)
    print(f"Файлів збору: {files}")
    print(f"Нових сторінок книг: {len(pages)} (~{words} слів) | батчів по {BATCH}: {n}")
    if not pages:
        print("(книг ще не зібрано — почитай книжки в грі, тоді /reload і запусти знову)")


if __name__ == "__main__":
    main()
