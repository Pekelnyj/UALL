# -*- coding: utf-8 -*-
"""Автентифікація + користувачі для веб-редактора (stdlib-крипто, без зайвих залежностей).

Таблиці (створюються поряд із наявними в editor.db):
    users(id, username UNIQUE, pw_hash, role, active, created_at, created_by)
    sessions(token PK, user_id, created_at, expires_at)

Ролі:
    admin       — усе + адмінпанель
    editor      — пряма правка рядків (з аудитом у history)
    contributor — лише пропозиції (на розгляд адміна)

Хеш пароля: pbkdf2_hmac('sha256'), формат 'pbkdf2$<iter>$<salt_hex>$<hash_hex>'.

CLI:
    python editor/auth.py create-admin <username> <password>
    python editor/auth.py create <username> <password> [role]
    python editor/auth.py set-password <username> <password>
    python editor/auth.py list
    python editor/auth.py unlock [username]      # зняти брутфорс-блокування входу
"""
import hashlib
import hmac
import secrets
import sqlite3
import sys
import time
from pathlib import Path

DB = Path(__file__).resolve().parent / "editor.db"
ROLES = ("admin", "editor", "contributor")
SESSION_TTL = 30 * 24 * 3600      # 30 днів
PBKDF2_ITER = 240_000


def _con():
    con = sqlite3.connect(DB)
    con.row_factory = sqlite3.Row
    return con


def ensure_schema(con):
    """Створити таблиці users/sessions, якщо їх ще немає (без переімпорту бази)."""
    con.executescript("""
    CREATE TABLE IF NOT EXISTS users(
        id INTEGER PRIMARY KEY,
        username TEXT UNIQUE NOT NULL,
        pw_hash TEXT NOT NULL,
        role TEXT NOT NULL DEFAULT 'contributor',
        active INTEGER NOT NULL DEFAULT 1,
        created_at REAL,
        created_by TEXT DEFAULT ''
    );
    CREATE TABLE IF NOT EXISTS sessions(
        token TEXT PRIMARY KEY,
        user_id INTEGER NOT NULL,
        created_at REAL,
        expires_at REAL
    );
    CREATE INDEX IF NOT EXISTS idx_sess_user ON sessions(user_id);
    """)
    con.commit()


# ---- паролі -----------------------------------------------------------------
def hash_password(pw: str) -> str:
    salt = secrets.token_bytes(16)
    dk = hashlib.pbkdf2_hmac("sha256", pw.encode("utf-8"), salt, PBKDF2_ITER)
    return f"pbkdf2${PBKDF2_ITER}${salt.hex()}${dk.hex()}"


def verify_password(pw: str, stored: str) -> bool:
    try:
        algo, iter_s, salt_hex, hash_hex = stored.split("$")
        if algo != "pbkdf2":
            return False
        dk = hashlib.pbkdf2_hmac("sha256", pw.encode("utf-8"), bytes.fromhex(salt_hex), int(iter_s))
        return hmac.compare_digest(dk.hex(), hash_hex)
    except Exception:
        return False


# ---- користувачі ------------------------------------------------------------
def get_user_by_name(con, username):
    return con.execute("SELECT * FROM users WHERE username=?", (username,)).fetchone()


def get_user_by_id(con, uid):
    return con.execute("SELECT * FROM users WHERE id=?", (uid,)).fetchone()


def list_users(con):
    return con.execute(
        "SELECT id,username,role,active,created_at,created_by FROM users ORDER BY username"
    ).fetchall()


def create_user(con, username, password, role="contributor", created_by="", now=None):
    username = (username or "").strip()
    if not username:
        raise ValueError("порожнє ім'я користувача")
    if role not in ROLES:
        raise ValueError(f"невідома роль: {role}")
    if not password or len(password) < 8:
        raise ValueError("пароль закороткий (мін. 8 символів)")
    if get_user_by_name(con, username):
        raise ValueError("користувач уже існує")
    now = time.time() if now is None else now
    cur = con.execute(
        "INSERT INTO users(username,pw_hash,role,active,created_at,created_by) VALUES(?,?,?,1,?,?)",
        (username, hash_password(password), role, now, created_by),
    )
    con.commit()
    return cur.lastrowid


def set_password(con, username, password):
    if not password or len(password) < 8:
        raise ValueError("пароль закороткий (мін. 8 символів)")
    cur = con.execute("UPDATE users SET pw_hash=? WHERE username=?",
                      (hash_password(password), username))
    con.commit()
    return cur.rowcount > 0


def set_password_by_id(con, uid, password):
    if not password or len(password) < 8:
        raise ValueError("пароль закороткий (мін. 8 символів)")
    cur = con.execute("UPDATE users SET pw_hash=? WHERE id=?", (hash_password(password), uid))
    con.commit()
    return cur.rowcount > 0


def set_role(con, uid, role):
    if role not in ROLES:
        raise ValueError(f"невідома роль: {role}")
    con.execute("UPDATE users SET role=? WHERE id=?", (role, uid))
    con.commit()


def set_active(con, uid, active):
    con.execute("UPDATE users SET active=? WHERE id=?", (1 if active else 0, uid))
    if not active:  # вимикаємо користувача -> прибиваємо його сесії
        con.execute("DELETE FROM sessions WHERE user_id=?", (uid,))
    con.commit()


def count_active_admins(con, exclude_id=None):
    """Скільки активних адмінів (можна виключити одного — того, кого збираємось чіпати)."""
    if exclude_id is None:
        return con.execute("SELECT COUNT(*) FROM users WHERE role='admin' AND active=1").fetchone()[0]
    return con.execute(
        "SELECT COUNT(*) FROM users WHERE role='admin' AND active=1 AND id<>?", (exclude_id,)).fetchone()[0]


def delete_user(con, uid):
    """Видалити користувача та його сесії. Історія правок лишається (author — рядок)."""
    con.execute("DELETE FROM sessions WHERE user_id=?", (uid,))
    cur = con.execute("DELETE FROM users WHERE id=?", (uid,))
    con.commit()
    return cur.rowcount > 0


# ---- сесії ------------------------------------------------------------------
def authenticate(con, username, password):
    u = get_user_by_name(con, username)
    if not u or not u["active"] or not verify_password(password, u["pw_hash"]):
        return None
    return u


def create_session(con, user_id, now=None):
    now = time.time() if now is None else now
    token = secrets.token_urlsafe(32)
    con.execute("INSERT INTO sessions(token,user_id,created_at,expires_at) VALUES(?,?,?,?)",
                (token, user_id, now, now + SESSION_TTL))
    con.commit()
    return token


def user_for_token(con, token, now=None):
    if not token:
        return None
    now = time.time() if now is None else now
    return con.execute(
        """SELECT u.* FROM sessions s JOIN users u ON u.id = s.user_id
           WHERE s.token=? AND s.expires_at > ? AND u.active = 1""",
        (token, now),
    ).fetchone()


def delete_session(con, token):
    con.execute("DELETE FROM sessions WHERE token=?", (token,))
    con.commit()


def purge_expired(con, now=None):
    now = time.time() if now is None else now
    con.execute("DELETE FROM sessions WHERE expires_at <= ?", (now,))
    con.commit()


# ---- CLI --------------------------------------------------------------------
def _cli():
    sys.stdout.reconfigure(encoding="utf-8")
    if len(sys.argv) < 2:
        print(__doc__)
        return
    con = _con()
    ensure_schema(con)
    cmd = sys.argv[1]
    try:
        if cmd == "create-admin":
            uid = create_user(con, sys.argv[2], sys.argv[3], role="admin", created_by="cli")
            print(f"Адміна створено (id={uid}): {sys.argv[2]}")
        elif cmd == "create":
            role = sys.argv[4] if len(sys.argv) > 4 else "contributor"
            uid = create_user(con, sys.argv[2], sys.argv[3], role=role, created_by="cli")
            print(f"Користувача створено (id={uid}, роль={role}): {sys.argv[2]}")
        elif cmd == "set-password":
            ok = set_password(con, sys.argv[2], sys.argv[3])
            print("Пароль змінено." if ok else "Немає такого користувача.")
        elif cmd == "list":
            for u in list_users(con):
                flag = "" if u["active"] else "  [ВИМКНЕНО]"
                print(f"  {u['id']:>3}  {u['username']:<24} {u['role']}{flag}")
        elif cmd == "unlock":
            con.execute("""CREATE TABLE IF NOT EXISTS login_attempts(
                id INTEGER PRIMARY KEY, ip TEXT, username TEXT, ts REAL)""")
            if len(sys.argv) > 2:
                n = con.execute("DELETE FROM login_attempts WHERE username=?", (sys.argv[2],)).rowcount
                print(f"Знято блокування входу для «{sys.argv[2]}»: очищено {n} спроб.")
            else:
                n = con.execute("DELETE FROM login_attempts").rowcount
                print(f"Знято всі блокування входу: очищено {n} спроб.")
            con.commit()
        else:
            print(f"Невідома команда: {cmd}")
            print(__doc__)
    except (IndexError, ValueError) as e:
        print(f"Помилка: {e}")
    finally:
        con.close()


if __name__ == "__main__":
    _cli()
