# -*- coding: utf-8 -*-
"""Залити A/B-експеримент з папки _порівняння/<...> у editor.db (розділ «Порівняння»).

Використання:
    python editor/import_comparison.py "<папка>" "МІТКА1=файл1.txt" "МІТКА2=файл2.txt" [...]
        [--db шлях/editor.db] [--slug my-slug]

- Метадані (title/date/verdict) читаються з manifest.json папки (якщо є).
- Варіант-файли — наш стандартний формат `=== [questID] EN Title / НАЗВА: / ОПИС:`;
  шапки-паспорти (`# ...` до першого ===) пропускаються.
- Повторний запуск із тим самим slug ЗАМІНЮЄ вміст експерименту (голоси втрачаються —
  вони прив'язані до item_id; для дозаливки нового експерименту це неважливо).
"""
import sys, os, re, json, sqlite3, time
sys.stdout.reconfigure(encoding="utf-8")

HERE = os.path.dirname(os.path.abspath(__file__))
args = [a for a in sys.argv[1:]]
dbp = os.path.join(HERE, "editor.db")
slug = None
rest = []
i = 0
while i < len(args):
    if args[i] == "--db":
        dbp = args[i + 1]; i += 2
    elif args[i] == "--slug":
        slug = args[i + 1]; i += 2
    else:
        rest.append(args[i]); i += 1
folder = rest[0]
variants = [a.split("=", 1) for a in rest[1:]]
if not variants:
    sys.exit("вкажи хоч один варіант МІТКА=файл.txt")

slug = slug or os.path.basename(os.path.normpath(folder))
meta = {}
mp = os.path.join(folder, "manifest.json")
if os.path.exists(mp):
    meta = json.load(open(mp, encoding="utf-8-sig"))
title = meta.get("experiment") or slug
date = meta.get("date", "")
verdict = meta.get("verdict", "")
expansion = meta.get("expansion", "")
questline = meta.get("questline", "")
if questline and meta.get("questline_id"):
    questline = f'{questline} ({meta["questline_id"]})'


def parse(path):
    t = open(path, encoding="utf-8-sig").read()
    i = t.find("=== [")
    t = t[i:] if i >= 0 else t
    blocks = re.split(r"^=== \[(\d+)\] (.*)$", t, flags=re.M)[1:]
    out = []
    for j in range(0, len(blocks), 3):
        qid, ten, body = blocks[j], blocks[j + 1].strip(), blocks[j + 2].strip()
        mt = re.search(r"НАЗВА:\s*(.+)", body)
        md = re.search(r"ОПИС:\s*\n(.*)", body, re.S)
        out.append((qid, ten, mt.group(1).strip() if mt else "", md.group(1).strip() if md else body))
    return out


con = sqlite3.connect(dbp)
con.execute("""CREATE TABLE IF NOT EXISTS comp_experiments(
    id INTEGER PRIMARY KEY, slug TEXT UNIQUE NOT NULL, title TEXT NOT NULL,
    date TEXT, verdict TEXT, created_at REAL)""")
con.execute("""CREATE TABLE IF NOT EXISTS comp_items(
    id INTEGER PRIMARY KEY, exp_id INTEGER NOT NULL, quest_id TEXT NOT NULL,
    title_en TEXT, label TEXT NOT NULL, title_ua TEXT, body TEXT)""")
con.execute("""CREATE TABLE IF NOT EXISTS comp_votes(
    item_id INTEGER NOT NULL, username TEXT NOT NULL, value INTEGER NOT NULL, ts REAL,
    PRIMARY KEY(item_id, username))""")
ccols = [r[1] for r in con.execute("PRAGMA table_info(comp_experiments)").fetchall()]
for col, ddl in (("expansion", "expansion TEXT DEFAULT ''"), ("questline", "questline TEXT DEFAULT ''")):
    if col not in ccols:
        con.execute(f"ALTER TABLE comp_experiments ADD COLUMN {ddl}")

row = con.execute("SELECT id FROM comp_experiments WHERE slug=?", (slug,)).fetchone()
if row:
    eid = row[0]
    con.execute("DELETE FROM comp_votes WHERE item_id IN (SELECT id FROM comp_items WHERE exp_id=?)", (eid,))
    con.execute("DELETE FROM comp_items WHERE exp_id=?", (eid,))
    con.execute("UPDATE comp_experiments SET title=?, date=?, verdict=?, expansion=?, questline=? WHERE id=?",
                (title, date, verdict, expansion, questline, eid))
    print("існуючий експеримент замінюю:", slug)
else:
    cur = con.execute(
        "INSERT INTO comp_experiments(slug,title,date,verdict,expansion,questline,created_at) "
        "VALUES(?,?,?,?,?,?,?)", (slug, title, date, verdict, expansion, questline, time.time()))
    eid = cur.lastrowid

n = 0
# порядок квестів — за першим варіантом; всередині квесту варіанти в порядку CLI
first = parse(os.path.join(folder, variants[0][1]))
order = [q[0] for q in first]
per = {lbl: {q[0]: q for q in parse(os.path.join(folder, fn))} for lbl, fn in variants}
for qid in order:
    for lbl, _ in variants:
        q = per[lbl].get(qid)
        if not q:
            continue
        con.execute("INSERT INTO comp_items(exp_id,quest_id,title_en,label,title_ua,body) VALUES(?,?,?,?,?,?)",
                    (eid, qid, q[1], lbl, q[2], q[3]))
        n += 1
con.commit()
con.close()
print(f"OK: експеримент «{title}» (slug={slug}) — квестів {len(order)}, варіант-блоків {n}")
