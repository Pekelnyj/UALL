# -*- coding: utf-8 -*-
"""Єдиний препроцесор тестерських файлів (кілька зразу): об'єднує gossip/broadcast/
quests з усіх переданих файлів, дедупить проти бази, нормалізує playerName→{NAME},
пише батчі. Викл.: python _prep_tester_wave.py "<file1>" "<file2>" ..."""
import sys, re, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import nick_regex
import capfilter

files = sys.argv[1:]
if not files:
    print("вкажи файли"); sys.exit()

# ЄДИНИЙ регекс ніків на всі файли: раніше токенізувався лише playerName
# ПОТОЧНОГО файлу і лише в broadcast, тож та сама репліка з іменем іншого
# гравця щоразу поверталася в чергу як «нова» й до того ж не працювала в грі
# (хук шукає ключ із токеном).
NICK = nick_regex(min_len=4)

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
g_done = tr.get("gossip", {})
b_done = tr.get("broadcast", {})
tq = tr.get("quests", {})
qsrc = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))


def block(sv, key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', sv)
    if not m:
        return ""
    i, depth, start = m.end(), 1, m.end()
    instr = esc = False
    while i < len(sv) and depth > 0:
        c = sv[i]
        if instr:
            if esc: esc = False
            elif c == "\\": esc = True
            elif c == '"': instr = False
        else:
            if c == '"': instr = True
            elif c == "{": depth += 1
            elif c == "}": depth -= 1
        i += 1
    return sv[start:i - 1]


def un(s):
    return (s.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r")
             .replace("\\t", "\t").replace("\\\\", "\\"))


gossip_new = {}
bcast_new = {}   # en_norm -> speaker
qfields = {}     # qid -> {field: en}

for path in files:
    sv = open(path, encoding="utf-8", errors="replace").read()
    pm = re.search(r'\["playerName"\]\s*=\s*"([^"]+)"', sv)
    PN = pm.group(1) if pm else None

    # gossip: ключі-тексти
    gb = block(sv, "gossip")
    for k in re.findall(r'\["((?:[^"\\]|\\.)*)"\]', gb):
        s = NICK.sub("{name}", un(k))
        if s and s not in g_done and re.search(r"[A-Za-z]{3}", s):
            gossip_new[s] = True

    # broadcast: ["text"]=speaker|true
    bb = block(sv, "broadcast")
    for en_raw, sp_raw in re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*(?:"((?:[^"\\]|\\.)*)"|true)', bb):
        en = un(en_raw)
        if not en or "%" in en or not re.search(r"[A-Za-z]{3}", en):
            continue
        en_norm = NICK.sub("{NAME}", en)
        if PN and PN in en_norm:
            en_norm = en_norm.replace(PN, "{NAME}")
        if en_norm in b_done or en_norm in bcast_new:
            continue
        bcast_new[en_norm] = un(sp_raw) if sp_raw else ""

    # quests: [qid]={field=en}
    qb = block(sv, "quests")
    for mm in re.finditer(r'\[(\d+)\]\s*=\s*\{', qb):
        qid = mm.group(1)
        j, d2, s2 = mm.end(), 1, mm.end()
        ins = es = False
        while j < len(qb) and d2 > 0:
            c = qb[j]
            if ins:
                if es: es = False
                elif c == "\\": es = True
                elif c == '"': ins = False
            else:
                if c == '"': ins = True
                elif c == "{": d2 += 1
                elif c == "}": d2 -= 1
            j += 1
        body = qb[s2:j - 1]
        have = tq.get(qid, {}) or {}
        for f, v in re.findall(r'\["?(\w+)"?\]\s*=\s*"((?:[^"\\]|\\.)*)"', body):
            if f in ("title", "description", "objectives", "progress", "completion"):
                # Квестові поля теж треба токенізувати: сервер підставляє в них
                # ім'я гравця («Do not let it get close, <нік>»), а
                # QuestHooks.lua міняє {NAME} назад на ім'я вже при показі.
                # Без цього переклад показував би всім нік тестера.
                v = NICK.sub("{NAME}", un(v))
                if v and not have.get(f):
                    qfields.setdefault(qid, {})[f] = v

# ---- батчі ----
def chunk(items, sub, name, size):
    OUT = DATA_DIR / "batches" / sub
    OUT.mkdir(parents=True, exist_ok=True)
    for f in OUT.glob(name + "_*.json"):
        f.unlink()
    nb = (len(items) + size - 1) // size
    for k in range(nb):
        (OUT / f"{name}_{k:02d}.json").write_text(
            json.dumps(items[k * size:(k + 1) * size], ensure_ascii=False, indent=1), encoding="utf-8")
    return nb


# broadcast
bc_items = [{"en": e, "speaker": s} for e, s in sorted(bcast_new.items())]
bc_items, bc_drop = capfilter.split(bc_items, key=lambda x: x["en"])
print("broadcast:")
capfilter.report(bc_drop)
nb_bc = chunk(bc_items, "broadcast", "bc", 48)
# gossip
g_items, g_drop = capfilter.split(sorted(gossip_new))
print("gossip:")
capfilter.report(g_drop)
nb_g = chunk(g_items, "gossip", "g", 40)
# quests
q_items = []
for qid, flds in sorted(qfields.items()):
    s = qsrc.get(qid, {})
    ctx_en = ((s.get("title") or {}).get("en", "") + " | " + (s.get("description") or {}).get("en", ""))[:400]
    have = tq.get(qid, {}) or {}
    ctx_ua = ((have.get("title") or "") + " | " + (have.get("description") or ""))[:400]
    q_items.append({"qid": qid, "fields": flds, "ctx_en": ctx_en, "ctx_ua": ctx_ua})
nb_q = chunk(q_items, "qcap", "qc", 20)

print(f"broadcast нових: {len(bc_items)} -> bc-батчів {nb_bc}")
print(f"gossip нових: {len(g_items)} -> g-батчів {nb_g}")
if nb_bc or nb_g:
    # Дедуп проти бази порівнює СИРИЙ рядок, а в базі лежить ШАБЛОН
    # («A treasure chest has spawned for {NAME}!»). Тому кожен збір повертав
    # ті самі репліки з новими іменами, і черга не закривалася ніколи.
    # Шаблонізуємо одразу тут: слот доводиться самими даними, не словником
    # [[capture-wave-playername-leaks]].
    # Клас гравця запікається в ключ так само, як ім'я («…, paladin.»), а в
    # базі лежить {class} [[class-token-mechanism]] — тож і його шаблонізуємо
    # тут, інакше кожен тестер іншого класу повертає ті самі репліки.
    print("-> шаблонізація слотів (імена, потім клас):")
    import subprocess
    for script in ("_tokenize_slots_wave.py", "_tokenize_class_wave.py"):
        for sub, pre, n in (("broadcast", "bc", nb_bc), ("gossip", "g", nb_g)):
            if n:
                subprocess.run([sys.executable, script, sub, pre, "--apply"],
                               check=False)
print(f"quest-записів: {len(q_items)} (полів {sum(len(x['fields']) for x in q_items)}) -> qc-батчів {nb_q}")
