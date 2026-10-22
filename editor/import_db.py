# -*- coding: utf-8 -*-
"""Імпорт майстра перекладів у SQLite (FTS5) для веб-редактора.

Поєднує UA з data/translations.json з англ.(+de/fr) оригіналом із data/source/*.
Типи секцій:
  • EN-ключ + рядок (broadcast, gossip, descTemplates, itemFlavors, …): en=ключ, ua=значення.
  • ID-ключ + рядок (spells, npcNames, itemSets): en із джерела (spells.json/creatures.json).
  • ID-ключ + dict (quests, achievements, mounts, …): рядок на кожне текстове поле;
    для quests/achievements беремо en/de/fr із джерела.

iter_rows()/load_sources() — спільні з update_db.py (інкрементне доповнення).

Запуск: python editor/import_db.py    →  editor/editor.db (повна перебудова)
"""
import json
import sqlite3
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
SRC = DATA / "source"
DB = Path(__file__).resolve().parent / "editor.db"

DICT_FIELDS = ("title", "description", "desc", "name", "objectives", "progress", "completion")


def load(p):
    return json.loads(Path(p).read_text(encoding="utf-8-sig")) if Path(p).exists() else {}


def load_sources():
    """en/de/fr оригінали для ID-секцій."""
    return {
        "quests": load(SRC / "quests.json"),       # {qid:{title:{en,de,fr},description:{...}}}
        "creatures": load(SRC / "creatures.json"),  # {id:{name:{en,de,fr}}}
        "spells": load(SRC / "spells.json"),        # {id:{name:{en,..},description:{..}}}
        "ach": load(SRC / "achievements.json"),     # {id:{title:{en,de,fr},desc:{en,de,fr}}}
    }


def src_en_defr(srcs, section, key, field):
    """en/de/fr оригіналу для ID-секцій (best-effort)."""
    if section == "quests":
        q = srcs["quests"].get(str(key)) or {}
        f = q.get("title" if field == "title" else "description" if field == "description" else field)
        if isinstance(f, dict):
            return f.get("en", ""), f.get("de", ""), f.get("fr", "")
    elif section == "npcNames":
        n = (srcs["creatures"].get(str(key)) or {}).get("name") or {}
        return n.get("en", ""), n.get("de", ""), n.get("fr", "")
    elif section == "spells":
        n = (srcs["spells"].get(str(key)) or {}).get("name") or {}
        if isinstance(n, dict):
            return n.get("en", ""), n.get("de", ""), n.get("fr", "")
    elif section == "achievements":
        a = srcs["ach"].get(str(key)) or {}
        f = a.get("title" if field == "title" else "desc")
        if isinstance(f, dict):
            return f.get("en", ""), f.get("de", ""), f.get("fr", "")
    return "", "", ""


def iter_rows(tr, srcs):
    """Генерує (section, item_key, field, en, de, fr, ua) для всіх перекладів майстра."""
    for section, d in tr.items():
        if not isinstance(d, dict):
            continue
        for key, val in d.items():
            key_is_en = not str(key).isdigit()
            if isinstance(val, str):
                if key_is_en:
                    yield (section, key, "", key, "", "", val)            # EN=ключ
                else:
                    en, de, fr = src_en_defr(srcs, section, key, "")
                    yield (section, str(key), "", en, de, fr, val)         # ID-ключ
            elif isinstance(val, dict):
                for field, fv in val.items():
                    if not isinstance(fv, str) or field not in DICT_FIELDS:
                        continue
                    if key_is_en:
                        yield (section, key, field, key, "", "", fv)
                    else:
                        en, de, fr = src_en_defr(srcs, section, key, field)
                        yield (section, str(key), field, en, de, fr, fv)


def main():
    tr = load(DATA / "translations.json")
    srcs = load_sources()

    if DB.exists():
        # Запобіжник: повний переімпорт перезаписує id рядків і ЗНИЩИВ БИ дані
        # користувачів/правок/пропозицій (вони живуть у тій самій editor.db).
        risky = 0
        try:
            c0 = sqlite3.connect(f"file:{DB}?mode=ro", uri=True)
            for t in ("users", "history", "suggestions"):
                if c0.execute("SELECT name FROM sqlite_master WHERE name=?", (t,)).fetchone():
                    risky += c0.execute(f"SELECT COUNT(*) FROM {t}").fetchone()[0]
            c0.close()
        except Exception:
            risky = 0
        if risky and "--force" not in sys.argv:
            raise SystemExit(
                f"СТОП: editor.db містить дані користувачів/правок/пропозицій ({risky} записів).\n"
                "Повний переімпорт ЗНИЩИТЬ їх і змінить id рядків.\n"
                "  • ДОДАТИ нові рядки без втрат:     python editor/update_db.py\n"
                "  • оновити EN-оригінал без втрат:   python editor/enrich_en.py\n"
                "  • вивантажити правки перед цим:    адмінпанель → Експорт, або export_db.py\n"
                "  • усе одно з нуля (втрата даних):  додай --force")
        DB.unlink()
    con = sqlite3.connect(DB)
    con.executescript("""
    CREATE TABLE strings(
        id INTEGER PRIMARY KEY,
        section TEXT NOT NULL, item_key TEXT NOT NULL, field TEXT NOT NULL DEFAULT '',
        en TEXT DEFAULT '', de TEXT DEFAULT '', fr TEXT DEFAULT '', ua TEXT DEFAULT '',
        rev INTEGER NOT NULL DEFAULT 0,
        UNIQUE(section, item_key, field)
    );
    CREATE VIRTUAL TABLE strings_fts USING fts5(en, ua, content='strings', content_rowid='id', tokenize='unicode61');
    CREATE TABLE suggestions(
        id INTEGER PRIMARY KEY, string_id INTEGER NOT NULL,
        suggested_ua TEXT NOT NULL, comment TEXT DEFAULT '', author TEXT DEFAULT 'local',
        status TEXT NOT NULL DEFAULT 'pending', created_at TEXT DEFAULT '',
        review_comment TEXT DEFAULT '', reviewed_by TEXT DEFAULT '', reviewed_at REAL,
        FOREIGN KEY(string_id) REFERENCES strings(id)
    );
    CREATE INDEX idx_sect ON strings(section);
    """)

    rows = list(iter_rows(tr, srcs))
    con.executemany(
        "INSERT OR IGNORE INTO strings(section,item_key,field,en,de,fr,ua) VALUES(?,?,?,?,?,?,?)", rows)
    con.execute("INSERT INTO strings_fts(rowid,en,ua) SELECT id,en,ua FROM strings")
    con.commit()

    n = con.execute("SELECT COUNT(*) FROM strings").fetchone()[0]
    print(f"Імпортовано рядків: {n}")
    for sect, c in con.execute("SELECT section,COUNT(*) FROM strings GROUP BY section ORDER BY 2 DESC LIMIT 8"):
        print(f"  {sect}: {c}")
    con.close()
    print(f"-> {DB}")


if __name__ == "__main__":
    main()
