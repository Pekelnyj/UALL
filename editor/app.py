# -*- coding: utf-8 -*-
"""Веб-редактор перекладів WoWUkraine — FastAPI + SQLite/FTS5, з логіном і адмінпанеллю.

Запуск:
    pip install -r editor/requirements.txt
    python editor/import_db.py                  # один раз: побудувати editor.db
    python editor/auth.py create-admin admin <пароль>   # (необов'язково — інакше створиться авто)
    uvicorn editor.app:app --reload             # → http://127.0.0.1:8000

Ролі: admin (усе+панель) · editor (пряма правка) · contributor (лише пропозиції).
Сесія — HttpOnly-cookie 'sid'. На проді постав env WOWUA_SECURE_COOKIE=1 (HTTPS).
"""
import datetime as _dt
import os
import re
import secrets
import sqlite3
import sys
import time
from pathlib import Path

from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import FileResponse, JSONResponse, RedirectResponse
from starlette.concurrency import run_in_threadpool

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))  # щоб validate/auth знаходились при запуску `uvicorn editor.app:app`
from validate import validate
import auth
import staging

DB = HERE / "editor.db"
SECURE_COOKIE = os.environ.get("WOWUA_SECURE_COOKIE", "0") == "1"
LOGIN_WINDOW = 15 * 60   # вікно обліку невдалих спроб входу, сек
LOGIN_IP_MAX = 20        # макс. невдалих спроб з однієї IP за вікно
LOGIN_USER_MAX = 8       # макс. невдалих спроб на один логін за вікно
app = FastAPI(title="WoWUkraine Editor")


@app.middleware("http")
async def security_headers(request: Request, call_next):
    """Захисні заголовки: clickjacking, MIME-sniffing, referrer, CSP."""
    resp = await call_next(request)
    resp.headers["X-Content-Type-Options"] = "nosniff"
    resp.headers["X-Frame-Options"] = "DENY"
    resp.headers["Referrer-Policy"] = "same-origin"
    resp.headers["Content-Security-Policy"] = (
        "default-src 'self'; img-src 'self' data:; "
        "script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; "
        "form-action 'self'; frame-ancestors 'none'; base-uri 'self'"
    )
    # HTML не кешувати: після деплою нові кнопки/сторінки видно БЕЗ Ctrl+F5
    # (браузер кешував index.html — користувачі не бачили нових розділів)
    if resp.headers.get("content-type", "").startswith("text/html"):
        resp.headers["Cache-Control"] = "no-cache"
    return resp


def db():
    con = sqlite3.connect(DB)
    con.row_factory = sqlite3.Row
    return con


def client_ip(request: Request) -> str:
    """Реальна IP клієнта. За зворотним проксі (Caddy) — перший у X-Forwarded-For."""
    xff = request.headers.get("x-forwarded-for", "")
    if xff:
        return xff.split(",")[0].strip()
    return request.client.host if request.client else "?"


# ---- автентифікація ---------------------------------------------------------
def current_user(con, request: Request):
    """sqlite3.Row користувача за cookie-сесією, або None."""
    return auth.user_for_token(con, request.cookies.get("sid"))


def require_user(con, request: Request):
    u = current_user(con, request)
    if not u:
        raise HTTPException(401, "Потрібен вхід")
    return u


def require_role(con, request: Request, *roles):
    u = require_user(con, request)
    if u["role"] not in roles:
        raise HTTPException(403, "Недостатньо прав")
    return u


@app.on_event("startup")
def _startup():
    if not DB.exists():
        raise RuntimeError("Немає editor.db — спершу: python editor/import_db.py")
    con = db()
    # історія правок + тригери синхронізації FTS (правка UA оновлює пошук)
    con.executescript("""
    CREATE TABLE IF NOT EXISTS history(
        id INTEGER PRIMARY KEY, string_id INTEGER, old_ua TEXT, new_ua TEXT,
        comment TEXT DEFAULT '', author TEXT DEFAULT 'local', ts REAL,
        status TEXT NOT NULL DEFAULT 'pending');
    CREATE INDEX IF NOT EXISTS idx_hist_author ON history(author);
    CREATE INDEX IF NOT EXISTS idx_hist_string ON history(string_id);
    CREATE TRIGGER IF NOT EXISTS strings_fts_au AFTER UPDATE ON strings BEGIN
        INSERT INTO strings_fts(strings_fts, rowid, en, ua) VALUES('delete', old.id, old.en, old.ua);
        INSERT INTO strings_fts(rowid, en, ua) VALUES(new.id, new.en, new.ua);
    END;
    """)
    # OCC: версія рядка для виявлення одночасних правок (без зайвих локів)
    cols = [r["name"] for r in con.execute("PRAGMA table_info(strings)").fetchall()]
    if "rev" not in cols:
        con.execute("ALTER TABLE strings ADD COLUMN rev INTEGER NOT NULL DEFAULT 0")
        con.commit()
    # курація: статус правки (pending -> accepted). Для старих БД додати колонку.
    hcols = [r["name"] for r in con.execute("PRAGMA table_info(history)").fetchall()]
    if "status" not in hcols:
        con.execute("ALTER TABLE history ADD COLUMN status TEXT NOT NULL DEFAULT 'pending'")
    for col, ddl in (("review_comment", "review_comment TEXT DEFAULT ''"),
                     ("reviewed_by", "reviewed_by TEXT DEFAULT ''"),
                     ("reviewed_at", "reviewed_at REAL")):
        if col not in hcols:
            con.execute(f"ALTER TABLE history ADD COLUMN {ddl}")
    con.commit()
    con.execute("CREATE INDEX IF NOT EXISTS idx_hist_status ON history(status)")  # після ALTER
    con.commit()
    # рев'ю пропозицій: коментар адміна (напр. ЧОМУ відхилено) + хто/коли
    scols = [r["name"] for r in con.execute("PRAGMA table_info(suggestions)").fetchall()]
    for col, ddl in (("review_comment", "review_comment TEXT DEFAULT ''"),
                     ("reviewed_by", "reviewed_by TEXT DEFAULT ''"),
                     ("reviewed_at", "reviewed_at REAL")):
        if col not in scols:
            con.execute(f"ALTER TABLE suggestions ADD COLUMN {ddl}")
    con.commit()
    # глосарій: терміни (EN→UA) з аргументацією й джерелом; approved=канон (благословив адмін)
    con.execute("""CREATE TABLE IF NOT EXISTS glossary(
        id INTEGER PRIMARY KEY,
        term_en TEXT NOT NULL, term_ua TEXT NOT NULL,
        rationale TEXT DEFAULT '', source_url TEXT DEFAULT '',
        author TEXT DEFAULT '', approved INTEGER NOT NULL DEFAULT 0,
        created_at REAL, updated_at REAL)""")
    con.execute("CREATE INDEX IF NOT EXISTS idx_gloss_en ON glossary(term_en)")
    con.commit()
    # захист від брутфорсу: журнал невдалих спроб входу
    con.execute("""CREATE TABLE IF NOT EXISTS login_attempts(
        id INTEGER PRIMARY KEY, ip TEXT, username TEXT, ts REAL)""")
    con.execute("CREATE INDEX IF NOT EXISTS idx_la_ts ON login_attempts(ts)")
    # спільнота: голоси (👍/👎/❓) і коментарі під пропозиціями
    con.execute("""CREATE TABLE IF NOT EXISTS suggestion_votes(
        suggestion_id INTEGER NOT NULL, username TEXT NOT NULL, value INTEGER NOT NULL, ts REAL,
        PRIMARY KEY(suggestion_id, username))""")
    con.execute("""CREATE TABLE IF NOT EXISTS suggestion_comments(
        id INTEGER PRIMARY KEY, suggestion_id INTEGER NOT NULL, author TEXT, text TEXT, ts REAL)""")
    con.execute("CREATE INDEX IF NOT EXISTS idx_sc_sug ON suggestion_comments(suggestion_id)")
    # порівняння: A/B-експерименти перекладу (варіанти того самого квесту поруч + голоси)
    con.execute("""CREATE TABLE IF NOT EXISTS comp_experiments(
        id INTEGER PRIMARY KEY, slug TEXT UNIQUE NOT NULL, title TEXT NOT NULL,
        date TEXT, verdict TEXT, created_at REAL)""")
    con.execute("""CREATE TABLE IF NOT EXISTS comp_items(
        id INTEGER PRIMARY KEY, exp_id INTEGER NOT NULL, quest_id TEXT NOT NULL,
        title_en TEXT, label TEXT NOT NULL, title_ua TEXT, body TEXT)""")
    con.execute("CREATE INDEX IF NOT EXISTS idx_ci_exp ON comp_items(exp_id)")
    con.execute("""CREATE TABLE IF NOT EXISTS comp_votes(
        item_id INTEGER NOT NULL, username TEXT NOT NULL, value INTEGER NOT NULL, ts REAL,
        PRIMARY KEY(item_id, username))""")
    # ієрархія для сотень прогонів: доповнення → квест-лінія → експеримент
    ccols = [r["name"] for r in con.execute("PRAGMA table_info(comp_experiments)").fetchall()]
    for col, ddl in (("expansion", "expansion TEXT DEFAULT ''"),
                     ("questline", "questline TEXT DEFAULT ''")):
        if col not in ccols:
            con.execute(f"ALTER TABLE comp_experiments ADD COLUMN {ddl}")
    con.commit()
    auth.ensure_schema(con)
    auth.purge_expired(con)
    # bootstrap: якщо немає жодного користувача — створити адміна
    if not auth.list_users(con):
        pw = os.environ.get("WOWUA_ADMIN_PW") or secrets.token_urlsafe(9)
        auth.create_user(con, "admin", pw, role="admin", created_by="bootstrap")
        print("=" * 60)
        print("  СТВОРЕНО АДМІНА:  логін=admin")
        print(f"  ПАРОЛЬ:           {pw}")
        print("  (зміни його в адмінпанелі; або задай env WOWUA_ADMIN_PW)")
        print("=" * 60)
    con.close()


# ---- сторінки ---------------------------------------------------------------
@app.get("/login")
def login_page():
    return FileResponse(HERE / "static" / "login.html")


# ---- завантаження релізу аддона (ПУБЛІЧНО, без авторизації) ------------------
# Zip-и релізів кладемо в editor/releases/UALL-<версія>.zip; віддаємо найновіший
# за версією. Доступно і з екрана входу (тестери качають без логіна).
RELEASE_DIR = HERE / "releases"


# WoW: Forever (окремий аддон UALLF, проєкт WoWForever) — своя тека й свій префікс.
# glob основного релізу НЕ рекурсивний, тож архіви з releases/forever/ ніколи не
# потраплять у /download ретейлу (03.10.2026).
FOREVER_DIR = RELEASE_DIR / "forever"
FOREVER_PREFIX = "UALL-Forever-"


def _latest_release(folder=None, prefix="UALL-"):
    folder = folder or RELEASE_DIR
    if not folder.is_dir():
        return None
    zips = list(folder.glob(prefix + "*.zip"))
    if not zips:
        return None
    return max(zips, key=lambda p: [int(x) for x in re.findall(r"\d+", p.stem)])


# ── Rate-limit завантажень за IP: щоб одна особа не забивала канал повторними
# повними викачками. Рахуємо лише ПОЧАТОК завантаження (без Range або bytes=0-),
# щоб не карати легітимні докачки/паралельні чанки менеджерів (offset>0).
import time as _time
from collections import defaultdict, deque

_DL_HITS = defaultdict(deque)   # ip -> deque[timestamps]
_DL_WINDOW = 600                # вікно, сек (10 хв)
_DL_MAX = 6                     # макс. початків завантаження на IP за вікно


def _client_ip(request: Request) -> str:
    # за реверс-проксі (Caddy) реальний IP — у X-Forwarded-For; сокет = 127.0.0.1
    xff = request.headers.get("x-forwarded-for") or request.headers.get("x-real-ip")
    if xff:
        return xff.split(",")[0].strip()
    return request.client.host if request.client else "?"


def _dl_rate_ok(ip: str) -> bool:
    now = _time.time()
    dq = _DL_HITS[ip]
    while dq and now - dq[0] > _DL_WINDOW:
        dq.popleft()
    if len(dq) >= _DL_MAX:
        return False
    dq.append(now)
    # легка чистка мапи від давно неактивних IP (щоб не росла безмежно)
    if len(_DL_HITS) > 5000:
        for k in [k for k, v in list(_DL_HITS.items()) if not v or now - v[-1] > _DL_WINDOW]:
            _DL_HITS.pop(k, None)
    return True


def _send_release(request: Request, z, rate_key: str = ""):
    if not z:
        return JSONResponse({"detail": "Реліз зараз недоступний."}, status_code=404)
    rng = (request.headers.get("range") or "").replace(" ", "")
    is_start = (not rng) or rng.startswith("bytes=0-")
    if is_start and not _dl_rate_ok(rate_key + _client_ip(request)):
        return JSONResponse(
            {"detail": "Забагато завантажень з вашої адреси. Спробуйте за кілька хвилин."},
            status_code=429, headers={"Retry-After": str(_DL_WINDOW)})
    # FileResponse із filename= сам ставить Content-Disposition: attachment
    return FileResponse(z, media_type="application/zip", filename=z.name)


@app.get("/download")
def download_release(request: Request):
    return _send_release(request, _latest_release())


@app.get("/download/forever")
def download_forever(request: Request):
    # окремий лічильник ліміту: завантаження Forever не з'їдають ліміт ретейлу
    return _send_release(request, _latest_release(FOREVER_DIR, FOREVER_PREFIX), "forever:")


@app.get("/api/release/forever")
def release_info_forever():
    return _release_meta(_latest_release(FOREVER_DIR, FOREVER_PREFIX), FOREVER_PREFIX)


@app.get("/api/release")
def release_info():
    """Метадані для кнопки: назва файлу й версія (або null, якщо релізу нема)."""
    return _release_meta(_latest_release(), "UALL-")


def _release_meta(z, prefix):
    if not z:
        return {"available": False}
    ver = z.stem[len(prefix):] if z.stem.startswith(prefix) else z.stem
    st = z.stat()
    return {"available": True, "file": z.name, "version": ver,
            "size": st.st_size,
            # час викладення релізу (mtime файлу) — показуємо під версією,
            # щоб тестер бачив, наскільки збірка свіжа. UTC, ISO-8601 із «Z»,
            # щоб браузер сам перевів у місцевий час гравця.
            "mtime": int(st.st_mtime),
            "published": _dt.datetime.fromtimestamp(st.st_mtime, _dt.timezone.utc)
                            .strftime("%Y-%m-%dT%H:%M:%SZ")}


# no-cache: браузер мусить ревалідувати (через ETag) — інакше старий theme.js
# зі старим списком тем кешується й нові теми не працюють.
_REVALIDATE = {"Cache-Control": "no-cache"}


@app.get("/theme.css")
def theme_css():
    return FileResponse(HERE / "static" / "theme.css", media_type="text/css", headers=_REVALIDATE)


@app.get("/theme.js")
def theme_js():
    return FileResponse(HERE / "static" / "theme.js", media_type="application/javascript", headers=_REVALIDATE)


@app.get("/")
def index(request: Request):
    con = db()
    u = current_user(con, request)
    con.close()
    if not u:
        return RedirectResponse("/login")
    return FileResponse(HERE / "static" / "index.html")


@app.get("/admin")
def admin_page(request: Request):
    con = db()
    u = current_user(con, request)
    con.close()
    if not u:
        return RedirectResponse("/login")
    if u["role"] != "admin":
        return RedirectResponse("/")
    return FileResponse(HERE / "static" / "admin.html")


@app.get("/mine")
def mine_page(request: Request):
    con = db()
    u = current_user(con, request)
    con.close()
    if not u:
        return RedirectResponse("/login")
    return FileResponse(HERE / "static" / "mine.html")


@app.get("/suggestions")
def suggestions_page(request: Request):
    con = db()
    u = current_user(con, request)
    con.close()
    if not u:
        return RedirectResponse("/login")
    return FileResponse(HERE / "static" / "suggestions.html")


# ---- логін/сесія ------------------------------------------------------------
@app.post("/api/login")
async def login(request: Request):
    body = await request.json()
    username = (body.get("username") or "").strip()
    ip = client_ip(request)
    con = db()
    now = time.time()
    con.execute("DELETE FROM login_attempts WHERE ts < ?", (now - LOGIN_WINDOW,))  # чистка старого
    edge = now - LOGIN_WINDOW
    ip_fails = con.execute("SELECT COUNT(*) FROM login_attempts WHERE ip=? AND ts>=?", (ip, edge)).fetchone()[0]
    user_fails = (con.execute("SELECT COUNT(*) FROM login_attempts WHERE username=? AND ts>=?",
                              (username, edge)).fetchone()[0] if username else 0)
    # брутфорс-гейт: занадто багато невдалих спроб (по IP або по логіну) -> 429, ще до перевірки пароля
    if ip_fails >= LOGIN_IP_MAX or user_fails >= LOGIN_USER_MAX:
        con.commit(); con.close()
        raise HTTPException(429, "Забагато невдалих спроб входу. Спробуйте за 15 хвилин.",
                            headers={"Retry-After": str(LOGIN_WINDOW)})
    u = auth.authenticate(con, username, body.get("password") or "")
    if not u:
        con.execute("INSERT INTO login_attempts(ip,username,ts) VALUES(?,?,?)", (ip, username, now))
        con.commit(); con.close()
        raise HTTPException(401, "Неправильний логін або пароль")
    con.execute("DELETE FROM login_attempts WHERE ip=? OR username=?", (ip, username))  # успіх -> скинути
    token = auth.create_session(con, u["id"])
    con.commit(); con.close()
    resp = JSONResponse({"ok": True, "user": {"name": u["username"], "role": u["role"]}})
    resp.set_cookie("sid", token, httponly=True, samesite="lax",
                    secure=SECURE_COOKIE, max_age=auth.SESSION_TTL, path="/")
    return resp


@app.post("/api/logout")
async def logout(request: Request):
    tok = request.cookies.get("sid")
    if tok:
        con = db(); auth.delete_session(con, tok); con.close()
    resp = JSONResponse({"ok": True})
    resp.delete_cookie("sid", path="/")
    return resp


@app.get("/api/me")
def me(request: Request):
    con = db()
    u = current_user(con, request)
    con.close()
    if not u:
        raise HTTPException(401, "Потрібен вхід")
    return {"name": u["username"], "role": u["role"]}


# ---- пошук/секції (будь-який залогінений) -----------------------------------
@app.get("/api/sections")
def sections(request: Request):
    con = db()
    require_user(con, request)
    rows = con.execute("SELECT section, COUNT(*) c FROM strings GROUP BY section ORDER BY c DESC").fetchall()
    con.close()
    return [{"section": r["section"], "count": r["c"]} for r in rows]


@app.get("/api/strings")
def search(request: Request, section: str = "", q: str = "", untr: int = 0,
           offset: int = 0, limit: int = 100):
    limit = max(1, min(limit, 200))
    con = db()
    require_user(con, request)
    params, where = [], []
    if section:
        where.append("s.section = ?"); params.append(section)
    if q.strip():
        term = '"' + q.replace('"', '""') + '"' + "*"
        where.append("s.id IN (SELECT rowid FROM strings_fts WHERE strings_fts MATCH ?)")
        params.append(term)
    if untr:
        # неперекладені: порожнє ua або англійська лишилась (ua збігається з en)
        where.append("(s.ua IS NULL OR s.ua = '' OR (s.en <> '' AND s.ua = s.en))")
    wsql = (" WHERE " + " AND ".join(where)) if where else ""
    try:
        total = con.execute(f"SELECT COUNT(*) FROM strings s{wsql}", params).fetchone()[0]
        rows = con.execute(
            f"SELECT s.id,s.section,s.item_key,s.field,s.en,s.de,s.fr,s.ua,s.rev FROM strings s{wsql} "
            f"ORDER BY s.section,s.item_key LIMIT ? OFFSET ?", params + [limit, offset]).fetchall()
    except sqlite3.OperationalError:
        # некоректний FTS-запит (напр. самотні лапки) -> порожньо, без 500
        con.close()
        return {"total": 0, "rows": []}
    con.close()
    return {"total": total, "rows": [dict(r) for r in rows]}


# ---- пряма правка (editor/admin) --------------------------------------------
@app.put("/api/strings/{sid}")
async def update(sid: int, request: Request):
    body = await request.json()
    ua = (body.get("ua") or "").rstrip("\n")
    comment = body.get("comment", "")
    base_rev = body.get("base_rev")
    force = bool(body.get("force"))
    con = db()
    user = require_role(con, request, "editor", "admin")
    row = con.execute("SELECT en, ua, rev FROM strings WHERE id=?", (sid,)).fetchone()
    if not row:
        con.close(); raise HTTPException(404, "Немає такого рядка")
    # OCC: рядок змінили після того, як клієнт його завантажив -> конфлікт (не затираємо мовчки)
    if not force and base_rev is not None and int(base_rev) != row["rev"]:
        last = con.execute(
            "SELECT author FROM history WHERE string_id=? ORDER BY id DESC LIMIT 1", (sid,)).fetchone()
        con.close()
        raise HTTPException(409, {
            "conflict": True,
            "current_ua": row["ua"],
            "current_rev": row["rev"],
            "by": last["author"] if last else "",
        })
    warnings = validate(row["en"], ua)
    con.execute("INSERT INTO history(string_id,old_ua,new_ua,comment,author,ts) VALUES(?,?,?,?,?,?)",
                (sid, row["ua"], ua, comment, user["username"], time.time()))
    con.execute("UPDATE strings SET ua=?, rev=rev+1 WHERE id=?", (ua, sid))
    con.commit(); con.close()
    return {"ok": True, "warnings": warnings, "rev": row["rev"] + 1}


# ---- пропозиція (будь-який залогінений, у т.ч. contributor) -----------------
@app.post("/api/suggestions")
async def suggest(request: Request):
    body = await request.json()
    sid = int(body.get("string_id") or 0)
    ua = (body.get("ua") or "").rstrip("\n")
    comment = body.get("comment", "")
    con = db()
    user = require_user(con, request)
    row = con.execute("SELECT en, ua FROM strings WHERE id=?", (sid,)).fetchone()
    if not row:
        con.close(); raise HTTPException(404, "Немає такого рядка")
    warnings = validate(row["en"], ua)
    con.execute(
        "INSERT INTO suggestions(string_id,suggested_ua,comment,author,status,created_at) "
        "VALUES(?,?,?,?,'pending',?)", (sid, ua, comment, user["username"], str(time.time())))
    con.commit(); con.close()
    return {"ok": True, "warnings": warnings, "suggested": True}


# ---- спільнота: пропозиції (читають усі) + голоси + коментарі ----------------
def _vote_tally(con, sgid):
    v = {row[0]: row[1] for row in con.execute(
        "SELECT value, COUNT(*) FROM suggestion_votes WHERE suggestion_id=? GROUP BY value", (sgid,))}
    return {"up": v.get(1, 0), "down": v.get(-1, 0), "neutral": v.get(0, 0)}


@app.get("/api/suggestions")
def suggestions_list(request: Request, status: str = "pending", limit: int = 300):
    limit = max(1, min(limit, 1000))
    con = db()
    user = require_user(con, request)
    rows = con.execute(
        "SELECT g.*, s.section, s.item_key, s.field, s.en, s.ua AS current_ua FROM suggestions g "
        "LEFT JOIN strings s ON s.id=g.string_id WHERE g.status=? ORDER BY g.id DESC LIMIT ?",
        (status, limit)).fetchall()
    out = []
    for r in rows:
        d = dict(r)
        d.update(_vote_tally(con, r["id"]))
        mv = con.execute("SELECT value FROM suggestion_votes WHERE suggestion_id=? AND username=?",
                         (r["id"], user["username"])).fetchone()
        d["my_vote"] = mv["value"] if mv else None
        d["n_comments"] = con.execute(
            "SELECT COUNT(*) FROM suggestion_comments WHERE suggestion_id=?", (r["id"],)).fetchone()[0]
        out.append(d)
    con.close()
    return out


@app.post("/api/suggestions/{sgid}/vote")
async def suggestion_vote(sgid: int, request: Request):
    val = int((await request.json()).get("value", 0))
    if val not in (1, -1, 0):
        raise HTTPException(400, "value має бути 1, -1 або 0")
    con = db()
    user = require_user(con, request)
    if not con.execute("SELECT 1 FROM suggestions WHERE id=?", (sgid,)).fetchone():
        con.close(); raise HTTPException(404, "Немає такої пропозиції")
    cur = con.execute("SELECT value FROM suggestion_votes WHERE suggestion_id=? AND username=?",
                      (sgid, user["username"])).fetchone()
    if cur and cur["value"] == val:   # повторний той самий голос -> зняти (toggle)
        con.execute("DELETE FROM suggestion_votes WHERE suggestion_id=? AND username=?", (sgid, user["username"]))
        my = None
    else:
        con.execute("INSERT INTO suggestion_votes(suggestion_id,username,value,ts) VALUES(?,?,?,?) "
                    "ON CONFLICT(suggestion_id,username) DO UPDATE SET value=excluded.value, ts=excluded.ts",
                    (sgid, user["username"], val, time.time()))
        my = val
    tally = _vote_tally(con, sgid)
    con.commit(); con.close()
    return {"ok": True, "my_vote": my, **tally}


@app.get("/api/suggestions/{sgid}/comments")
def suggestion_comments(sgid: int, request: Request):
    con = db()
    require_user(con, request)
    rows = con.execute(
        "SELECT * FROM suggestion_comments WHERE suggestion_id=? ORDER BY id", (sgid,)).fetchall()
    con.close()
    return [dict(r) for r in rows]


@app.post("/api/suggestions/{sgid}/comments")
async def suggestion_comment_add(sgid: int, request: Request):
    text = ((await request.json()).get("text") or "").strip()
    con = db()
    user = require_user(con, request)
    if not text:
        con.close(); raise HTTPException(400, "Порожній коментар")
    if not con.execute("SELECT 1 FROM suggestions WHERE id=?", (sgid,)).fetchone():
        con.close(); raise HTTPException(404, "Немає такої пропозиції")
    con.execute("INSERT INTO suggestion_comments(suggestion_id,author,text,ts) VALUES(?,?,?,?)",
                (sgid, user["username"], text, time.time()))
    con.commit(); con.close()
    return {"ok": True}


@app.delete("/api/suggestions/comments/{cid}")
def suggestion_comment_del(cid: int, request: Request):
    con = db()
    user = require_user(con, request)
    c = con.execute("SELECT author FROM suggestion_comments WHERE id=?", (cid,)).fetchone()
    if not c:
        con.close(); raise HTTPException(404, "Немає коментаря")
    if user["role"] != "admin" and c["author"] != user["username"]:
        con.close(); raise HTTPException(403, "Можна видаляти лише свої коментарі")
    con.execute("DELETE FROM suggestion_comments WHERE id=?", (cid,))
    con.commit(); con.close()
    return {"ok": True}


@app.delete("/api/suggestions/{sgid}")
def suggestion_delete(sgid: int, request: Request):
    """Видалити пропозицію (разом із голосами й коментарями). Автор — свою; адмін — будь-чию."""
    con = db()
    user = require_user(con, request)
    g = con.execute("SELECT author FROM suggestions WHERE id=?", (sgid,)).fetchone()
    if not g:
        con.close(); raise HTTPException(404, "Немає такої пропозиції")
    if user["role"] != "admin" and g["author"] != user["username"]:
        con.close(); raise HTTPException(403, "Можна видаляти лише свої пропозиції")
    con.execute("DELETE FROM suggestion_votes WHERE suggestion_id=?", (sgid,))
    con.execute("DELETE FROM suggestion_comments WHERE suggestion_id=?", (sgid,))
    con.execute("DELETE FROM suggestions WHERE id=?", (sgid,))
    con.commit(); con.close()
    return {"ok": True}


# ---- адмін: користувачі -----------------------------------------------------
@app.get("/api/admin/users")
def admin_users(request: Request):
    con = db()
    require_role(con, request, "admin")
    rows = auth.list_users(con)
    con.close()
    return [dict(r) for r in rows]


@app.post("/api/admin/users")
async def admin_create_user(request: Request):
    body = await request.json()
    con = db()
    me_u = require_role(con, request, "admin")
    try:
        uid = auth.create_user(con, body.get("username", ""), body.get("password", ""),
                               role=body.get("role", "contributor"), created_by=me_u["username"])
    except ValueError as e:
        con.close(); raise HTTPException(400, str(e))
    con.close()
    return {"ok": True, "id": uid}


@app.post("/api/admin/users/{uid}/reset")
async def admin_reset_pw(uid: int, request: Request):
    body = await request.json()
    con = db()
    require_role(con, request, "admin")
    try:
        ok = auth.set_password_by_id(con, uid, body.get("password", ""))
    except ValueError as e:
        con.close(); raise HTTPException(400, str(e))
    con.close()
    if not ok:
        raise HTTPException(404, "Немає такого користувача")
    return {"ok": True}


@app.post("/api/admin/users/{uid}/role")
async def admin_set_role(uid: int, request: Request):
    body = await request.json()
    new_role = body.get("role", "")
    con = db()
    me_u = require_role(con, request, "admin")
    if uid == me_u["id"] and new_role != "admin":
        con.close(); raise HTTPException(400, "Не можна зняти роль admin із себе")
    tgt = auth.get_user_by_id(con, uid)
    if (tgt and tgt["role"] == "admin" and new_role != "admin"
            and auth.count_active_admins(con, exclude_id=uid) == 0):
        con.close(); raise HTTPException(400, "Це останній активний адмін — роль змінити не можна")
    try:
        auth.set_role(con, uid, new_role)
    except ValueError as e:
        con.close(); raise HTTPException(400, str(e))
    con.close()
    return {"ok": True}


@app.post("/api/admin/users/{uid}/active")
async def admin_set_active(uid: int, request: Request):
    body = await request.json()
    active = bool(body.get("active"))
    con = db()
    me_u = require_role(con, request, "admin")
    if not active:
        if uid == me_u["id"]:
            con.close(); raise HTTPException(400, "Не можна вимкнути самого себе")
        tgt = auth.get_user_by_id(con, uid)
        if tgt and tgt["role"] == "admin" and auth.count_active_admins(con, exclude_id=uid) == 0:
            con.close(); raise HTTPException(400, "Це останній активний адмін — вимкнути не можна")
    auth.set_active(con, uid, active)
    con.close()
    return {"ok": True}


@app.delete("/api/admin/users/{uid}")
def admin_delete_user(uid: int, request: Request):
    con = db()
    me_u = require_role(con, request, "admin")
    if uid == me_u["id"]:
        con.close(); raise HTTPException(400, "Не можна видалити самого себе")
    tgt = auth.get_user_by_id(con, uid)
    if not tgt:
        con.close(); raise HTTPException(404, "Немає такого користувача")
    if tgt["role"] == "admin" and auth.count_active_admins(con, exclude_id=uid) == 0:
        con.close(); raise HTTPException(400, "Це останній активний адмін — видалити не можна")
    auth.delete_user(con, uid)
    con.close()
    return {"ok": True}


# ---- адмін: аудит і пропозиції ----------------------------------------------
@app.get("/api/admin/history")
def admin_history(request: Request, author: str = "", status: str = "", limit: int = 200):
    limit = max(1, min(limit, 1000))
    con = db()
    require_role(con, request, "admin")
    where, params = [], []
    if author:
        where.append("h.author=?"); params.append(author)
    if status:
        where.append("h.status=?"); params.append(status)
    wsql = (" WHERE " + " AND ".join(where)) if where else ""
    rows = con.execute(
        "SELECT h.*, s.section, s.item_key, s.field, s.en FROM history h "
        f"LEFT JOIN strings s ON s.id=h.string_id{wsql} ORDER BY h.ts DESC LIMIT ?",
        params + [limit]).fetchall()
    con.close()
    return [dict(r) for r in rows]


@app.post("/api/admin/history/accept")
async def admin_history_accept(request: Request):
    body = await request.json()
    ids = [int(x) for x in (body.get("ids") or [])]
    con = db()
    require_role(con, request, "admin")
    if not ids:
        con.close(); return {"ok": True, "accepted": 0}
    qs = ",".join("?" * len(ids))
    cur = con.execute(f"UPDATE history SET status='accepted' WHERE id IN ({qs})", ids)
    con.commit(); con.close()
    return {"ok": True, "accepted": cur.rowcount}


@app.post("/api/admin/history/unaccept")
async def admin_history_unaccept(request: Request):
    body = await request.json()
    ids = [int(x) for x in (body.get("ids") or [])]
    con = db()
    require_role(con, request, "admin")
    if not ids:
        con.close(); return {"ok": True}
    qs = ",".join("?" * len(ids))
    con.execute(f"UPDATE history SET status='pending' WHERE id IN ({qs})", ids)
    con.commit(); con.close()
    return {"ok": True}


@app.post("/api/admin/history/{hid}/reject")
async def admin_history_reject(hid: int, request: Request):
    """Відхилити пряму правку: позначити rejected + причина, і ПОВЕРНУТИ текст до того,
    що було до правки (лише якщо вона досі поточне значення — щоб не затерти новіші)."""
    review = (await _opt_body(request)).get("comment", "")
    con = db()
    me_u = require_role(con, request, "admin")
    h = con.execute("SELECT * FROM history WHERE id=?", (hid,)).fetchone()
    if not h:
        con.close(); raise HTTPException(404, "Немає такого запису")
    reverted = False
    cur = con.execute("SELECT ua FROM strings WHERE id=?", (h["string_id"],)).fetchone()
    if cur and cur["ua"] == h["new_ua"] and h["new_ua"] != h["old_ua"]:
        con.execute("UPDATE strings SET ua=?, rev=rev+1 WHERE id=?", (h["old_ua"], h["string_id"]))
        reverted = True
    con.execute("UPDATE history SET status='rejected', review_comment=?, reviewed_by=?, reviewed_at=? WHERE id=?",
                (review, me_u["username"], time.time(), hid))
    con.commit(); con.close()
    return {"ok": True, "reverted": reverted}


@app.delete("/api/history/{hid}")
def delete_history(hid: int, request: Request):
    """Видалити запис правки з журналу. Адмін — будь-який; користувач — лише свій."""
    con = db()
    user = require_user(con, request)
    row = con.execute("SELECT author FROM history WHERE id=?", (hid,)).fetchone()
    if not row:
        con.close(); raise HTTPException(404, "Немає такого запису")
    if user["role"] != "admin" and row["author"] != user["username"]:
        con.close(); raise HTTPException(403, "Можна видаляти лише свої правки")
    con.execute("DELETE FROM history WHERE id=?", (hid,))
    con.commit(); con.close()
    return {"ok": True}


@app.get("/api/my/history")
def my_history(request: Request, limit: int = 200):
    """Власні правки поточного користувача (для видалення своїх)."""
    limit = max(1, min(limit, 1000))
    con = db()
    user = require_user(con, request)
    rows = con.execute(
        "SELECT h.*, s.section, s.item_key, s.field, s.en FROM history h "
        "LEFT JOIN strings s ON s.id=h.string_id WHERE h.author=? ORDER BY h.ts DESC LIMIT ?",
        (user["username"], limit)).fetchall()
    con.close()
    return [dict(r) for r in rows]


@app.get("/api/my/suggestions")
def my_suggestions(request: Request, limit: int = 200):
    """Власні пропозиції користувача зі статусом і коментарем рев'ю (чому відхилено/ухвалено)."""
    limit = max(1, min(limit, 1000))
    con = db()
    user = require_user(con, request)
    rows = con.execute(
        "SELECT g.*, s.section, s.item_key, s.field, s.en, s.ua AS current_ua FROM suggestions g "
        "LEFT JOIN strings s ON s.id=g.string_id WHERE g.author=? ORDER BY g.id DESC LIMIT ?",
        (user["username"], limit)).fetchall()
    con.close()
    return [dict(r) for r in rows]


@app.get("/api/admin/suggestions")
def admin_suggestions(request: Request, status: str = "pending", limit: int = 200):
    limit = max(1, min(limit, 500))
    con = db()
    require_role(con, request, "admin")
    rows = con.execute(
        "SELECT g.*, s.section, s.item_key, s.field, s.en, s.ua AS current_ua FROM suggestions g "
        "LEFT JOIN strings s ON s.id=g.string_id WHERE g.status=? ORDER BY g.id DESC LIMIT ?",
        (status, limit)).fetchall()
    con.close()
    return [dict(r) for r in rows]


async def _opt_body(request: Request):
    try:
        return await request.json()
    except Exception:
        return {}


@app.post("/api/admin/suggestions/{gid}/approve")
async def admin_approve(gid: int, request: Request):
    review = (await _opt_body(request)).get("comment", "")
    con = db()
    me_u = require_role(con, request, "admin")
    g = con.execute("SELECT * FROM suggestions WHERE id=? AND status='pending'", (gid,)).fetchone()
    if not g:
        con.close(); raise HTTPException(404, "Немає такої пропозиції (або вже опрацьована)")
    row = con.execute("SELECT ua FROM strings WHERE id=?", (g["string_id"],)).fetchone()
    old_ua = row["ua"] if row else ""
    con.execute(
        "INSERT INTO history(string_id,old_ua,new_ua,comment,author,ts,status) VALUES(?,?,?,?,?,?,'accepted')",
        (g["string_id"], old_ua, g["suggested_ua"],
         f"[ухвалив {me_u['username']}] {g['comment']}", g["author"], time.time()))
    con.execute("UPDATE strings SET ua=? WHERE id=?", (g["suggested_ua"], g["string_id"]))
    con.execute("UPDATE suggestions SET status='approved', review_comment=?, reviewed_by=?, reviewed_at=? WHERE id=?",
                (review, me_u["username"], time.time(), gid))
    con.commit(); con.close()
    return {"ok": True}


@app.post("/api/admin/suggestions/{gid}/reject")
async def admin_reject(gid: int, request: Request):
    review = (await _opt_body(request)).get("comment", "")
    con = db()
    me_u = require_role(con, request, "admin")
    cur = con.execute(
        "UPDATE suggestions SET status='rejected', review_comment=?, reviewed_by=?, reviewed_at=? "
        "WHERE id=? AND status='pending'", (review, me_u["username"], time.time(), gid))
    con.commit(); con.close()
    if cur.rowcount == 0:
        raise HTTPException(404, "Немає такої пропозиції (або вже опрацьована)")
    return {"ok": True}


# ---- адмін: експорт артефакту правок -----------------------------------------
@app.get("/api/admin/export")
def admin_export(request: Request, scope: str = "edits"):
    """Завантажити правки артефактом. Кожен запис несе точні координати
    (section · item_key · field), тож apply_edits.py підставить його рівно на місце.
        scope=edits — лише змінені рядки (остання правка з history) + автор/час/коментар;
        scope=full  — усі непорожні переклади (повний знімок).
    """
    con = db()
    require_role(con, request, "admin")
    if scope == "full":
        rows = con.execute(
            "SELECT section, item_key, field, en, ua FROM strings "
            "WHERE ua IS NOT NULL AND ua <> '' ORDER BY section, item_key, field").fetchall()
        edits = [{"section": r["section"], "item_key": r["item_key"], "field": r["field"],
                  "en": r["en"], "ua": r["ua"]} for r in rows]
    else:
        scope = "edits"
        # лише ПРИЙНЯТІ правки: остання accepted на кожен рядок, значення = ухвалене new_ua
        rows = con.execute("""
            SELECT s.section, s.item_key, s.field, s.en, h.new_ua AS ua,
                   h.author, h.ts, h.comment
            FROM strings s
            JOIN (SELECT string_id, MAX(id) AS mid FROM history
                  WHERE status='accepted' GROUP BY string_id) last
              ON last.string_id = s.id
            JOIN history h ON h.id = last.mid
            ORDER BY s.section, s.item_key, s.field""").fetchall()
        edits = [{"section": r["section"], "item_key": r["item_key"], "field": r["field"],
                  "en": r["en"], "ua": r["ua"], "author": r["author"], "ts": r["ts"],
                  "comment": r["comment"]} for r in rows]
    con.close()
    artifact = {
        "_meta": {
            "format": "wowukraine-edits-v1",
            "scope": scope,
            "exported_at": time.time(),
            "count": len(edits),
            "note": "застосувати: python editor/apply_edits.py <файл>; "
                    "координати section·item_key·field точно відповідають translations.json",
        },
        "edits": edits,
    }
    fname = f"wowukraine-{scope}-{time.strftime('%Y%m%d-%H%M%S')}.json"
    return JSONResponse(artifact, headers={"Content-Disposition": f'attachment; filename="{fname}"'})


# ---- глосарій (терміни EN→UA з аргументацією й джерелом) ---------------------
@app.get("/glossary")
def glossary_page(request: Request):
    con = db()
    u = current_user(con, request)
    con.close()
    if not u:
        return RedirectResponse("/login")
    return FileResponse(HERE / "static" / "glossary.html")


def _valid_url(u: str) -> bool:
    return isinstance(u, str) and (u.startswith("http://") or u.startswith("https://")) and len(u) < 2000


@app.get("/api/glossary")
def glossary_list(request: Request, q: str = "", limit: int = 1000):
    limit = max(1, min(limit, 5000))
    con = db()
    require_user(con, request)
    if q.strip():
        like = f"%{q.strip()}%"
        rows = con.execute(
            "SELECT * FROM glossary WHERE term_en LIKE ? OR term_ua LIKE ? OR rationale LIKE ? "
            "ORDER BY approved DESC, term_en COLLATE NOCASE LIMIT ?", (like, like, like, limit)).fetchall()
    else:
        rows = con.execute(
            "SELECT * FROM glossary ORDER BY approved DESC, term_en COLLATE NOCASE LIMIT ?", (limit,)).fetchall()
    con.close()
    return [dict(r) for r in rows]


@app.post("/api/glossary")
async def glossary_add(request: Request):
    body = await request.json()
    term_en = (body.get("term_en") or "").strip()
    term_ua = (body.get("term_ua") or "").strip()
    rationale = (body.get("rationale") or "").strip()
    source_url = (body.get("source_url") or "").strip()
    con = db()
    user = require_user(con, request)
    if not term_en or not term_ua:
        con.close(); raise HTTPException(400, "Потрібні і термін (EN), і переклад (UA)")
    if source_url and not _valid_url(source_url):
        con.close(); raise HTTPException(400, "Посилання має починатися з http:// або https://")
    approved = 1 if user["role"] == "admin" else 0   # адмін одразу канон, решта — пропозиція
    now = time.time()
    cur = con.execute(
        "INSERT INTO glossary(term_en,term_ua,rationale,source_url,author,approved,created_at,updated_at) "
        "VALUES(?,?,?,?,?,?,?,?)", (term_en, term_ua, rationale, source_url, user["username"], approved, now, now))
    con.commit(); gid = cur.lastrowid; con.close()
    return {"ok": True, "id": gid, "approved": approved}


@app.put("/api/glossary/{gid}")
async def glossary_edit(gid: int, request: Request):
    body = await request.json()
    con = db()
    user = require_user(con, request)
    g = con.execute("SELECT * FROM glossary WHERE id=?", (gid,)).fetchone()
    if not g:
        con.close(); raise HTTPException(404, "Немає запису")
    if user["role"] != "admin" and g["author"] != user["username"]:
        con.close(); raise HTTPException(403, "Можна редагувати лише свої записи")
    term_en = (body.get("term_en") if body.get("term_en") is not None else g["term_en"]).strip()
    term_ua = (body.get("term_ua") if body.get("term_ua") is not None else g["term_ua"]).strip()
    rationale = (body.get("rationale") if body.get("rationale") is not None else g["rationale"]).strip()
    source_url = (body.get("source_url") if body.get("source_url") is not None else g["source_url"]).strip()
    if not term_en or not term_ua:
        con.close(); raise HTTPException(400, "Потрібні і термін (EN), і переклад (UA)")
    if source_url and not _valid_url(source_url):
        con.close(); raise HTTPException(400, "Посилання має починатися з http:// або https://")
    con.execute("UPDATE glossary SET term_en=?,term_ua=?,rationale=?,source_url=?,updated_at=? WHERE id=?",
                (term_en, term_ua, rationale, source_url, time.time(), gid))
    con.commit(); con.close()
    return {"ok": True}


@app.delete("/api/glossary/{gid}")
def glossary_delete(gid: int, request: Request):
    con = db()
    user = require_user(con, request)
    g = con.execute("SELECT author FROM glossary WHERE id=?", (gid,)).fetchone()
    if not g:
        con.close(); raise HTTPException(404, "Немає запису")
    if user["role"] != "admin" and g["author"] != user["username"]:
        con.close(); raise HTTPException(403, "Можна видаляти лише свої записи")
    con.execute("DELETE FROM glossary WHERE id=?", (gid,))
    con.commit(); con.close()
    return {"ok": True}


@app.post("/api/glossary/{gid}/approve")
async def glossary_approve(gid: int, request: Request):
    approved = 1 if (await _opt_body(request)).get("approved", True) else 0
    con = db()
    require_role(con, request, "admin")
    cur = con.execute("UPDATE glossary SET approved=?, updated_at=? WHERE id=?", (approved, time.time(), gid))
    con.commit(); con.close()
    if cur.rowcount == 0:
        raise HTTPException(404, "Немає запису")
    return {"ok": True, "approved": approved}


# ---- доставка нової бази (завантаження → перевірка → атомарна підміна + 24h відкат) ----
@app.post("/api/admin/base/upload")
async def base_upload(request: Request, note: str = "", gz: int = 0):
    """Тіло запиту = файл пакета (build_base_package.py). Додаємо нові рядки в копію живої БД,
    перевіряємо і підміняємо; стара лишається на відкат 24 год."""
    con = db()
    require_role(con, request, "admin")
    con.close()
    data = await request.body()
    if not data:
        raise HTTPException(400, "Порожній файл")
    if len(data) > 300 * 1024 * 1024:   # 300 МБ: захист від OOM (на додачу до ліміту Caddy)
        raise HTTPException(413, "Завеликий файл (>300 МБ)")
    uploads = HERE / "uploads"
    uploads.mkdir(exist_ok=True)
    dest = uploads / (f"pkg-{int(time.time())}" + (".jsonl.gz" if gz else ".jsonl"))
    dest.write_bytes(data)
    try:
        result = await run_in_threadpool(staging.stage_and_swap, str(dest), note)
    finally:
        try:
            dest.unlink()
        except Exception:
            pass
    if not result.get("ok"):
        raise HTTPException(400, "Перевірка не пройдена — підміну скасовано: "
                            + "; ".join(result.get("problems", [])))
    return result


@app.get("/api/admin/base/status")
def base_status(request: Request):
    con = db()
    require_role(con, request, "admin")
    try:
        ups = [dict(r) for r in con.execute(
            "SELECT * FROM base_updates ORDER BY id DESC LIMIT 10").fetchall()]
    except Exception:
        ups = []
    con.close()
    return {"updates": ups, "backups": staging.list_backups()}


@app.post("/api/admin/base/rollback")
async def base_rollback(request: Request):
    con = db()
    require_role(con, request, "admin")
    con.close()
    result = await run_in_threadpool(staging.rollback)
    if not result.get("ok"):
        raise HTTPException(400, result.get("error", "не вдалося відкотити"))
    return result


# ---- порівняння (A/B-експерименти перекладу) --------------------------------
@app.get("/comparisons")
def comparisons_page(request: Request):
    con = db()
    u = current_user(con, request)
    con.close()
    if not u:
        return RedirectResponse("/login")
    return FileResponse(HERE / "static" / "comparisons.html")


@app.get("/api/comparisons")
def comparisons_list(request: Request):
    con = db()
    require_user(con, request)
    rows = con.execute(
        "SELECT e.*, (SELECT COUNT(DISTINCT quest_id) FROM comp_items i WHERE i.exp_id=e.id) AS quests "
        "FROM comp_experiments e ORDER BY e.expansion, e.id DESC").fetchall()
    out = []
    for r in rows:
        d = dict(r)
        # живий підсумок голосів по варіантах — «хто веде» видно зі списку
        tal = con.execute(
            "SELECT i.label, "
            " SUM(CASE WHEN v.value=1 THEN 1 ELSE 0 END) AS up, "
            " SUM(CASE WHEN v.value=-1 THEN 1 ELSE 0 END) AS down "
            "FROM comp_items i LEFT JOIN comp_votes v ON v.item_id=i.id "
            "WHERE i.exp_id=? GROUP BY i.label", (d["id"],)).fetchall()
        d["tally"] = [dict(t) for t in tal]
        out.append(d)
    con.close()
    return out


@app.get("/api/comparisons/{eid}")
def comparison_detail(eid: int, request: Request):
    con = db()
    user = require_user(con, request)
    exp = con.execute("SELECT * FROM comp_experiments WHERE id=?", (eid,)).fetchone()
    if not exp:
        con.close(); raise HTTPException(404, "Немає такого порівняння")
    items = con.execute(
        "SELECT i.*, "
        " (SELECT COUNT(*) FROM comp_votes v WHERE v.item_id=i.id AND v.value=1)  AS up, "
        " (SELECT COUNT(*) FROM comp_votes v WHERE v.item_id=i.id AND v.value=-1) AS down, "
        " (SELECT value FROM comp_votes v WHERE v.item_id=i.id AND v.username=?)  AS my_vote "
        "FROM comp_items i WHERE i.exp_id=? ORDER BY i.id", (user["username"], eid)).fetchall()
    con.close()
    quests, order = {}, []
    for r in items:
        d = dict(r)
        qid = d["quest_id"]
        if qid not in quests:
            quests[qid] = {"quest_id": qid, "title_en": d["title_en"], "variants": []}
            order.append(qid)
        quests[qid]["variants"].append({k: d[k] for k in
                                        ("id", "label", "title_ua", "body", "up", "down", "my_vote")})
    return {"experiment": dict(exp), "quests": [quests[q] for q in order]}


@app.post("/api/comp/{item_id}/vote")
async def comp_vote(item_id: int, request: Request):
    val = int((await request.json()).get("value", 0))
    if val not in (1, -1):
        raise HTTPException(400, "value має бути 1 або -1")
    con = db()
    user = require_user(con, request)
    if not con.execute("SELECT 1 FROM comp_items WHERE id=?", (item_id,)).fetchone():
        con.close(); raise HTTPException(404, "Немає такого варіанта")
    cur = con.execute("SELECT value FROM comp_votes WHERE item_id=? AND username=?",
                      (item_id, user["username"])).fetchone()
    if cur and cur["value"] == val:   # повторний той самий голос -> зняти (toggle)
        con.execute("DELETE FROM comp_votes WHERE item_id=? AND username=?", (item_id, user["username"]))
        my = None
    else:
        con.execute("INSERT INTO comp_votes(item_id,username,value,ts) VALUES(?,?,?,?) "
                    "ON CONFLICT(item_id,username) DO UPDATE SET value=excluded.value, ts=excluded.ts",
                    (item_id, user["username"], val, time.time()))
        my = val
    up = con.execute("SELECT COUNT(*) FROM comp_votes WHERE item_id=? AND value=1", (item_id,)).fetchone()[0]
    down = con.execute("SELECT COUNT(*) FROM comp_votes WHERE item_id=? AND value=-1", (item_id,)).fetchone()[0]
    con.commit(); con.close()
    return {"ok": True, "my_vote": my, "up": up, "down": down}
