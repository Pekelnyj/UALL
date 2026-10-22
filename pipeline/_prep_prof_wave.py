# -*- coding: utf-8 -*-
"""Витягти db.profui (UI-лейбли) + db.profdesc (описи спеціалізацій) з капчура у батчі.
profui -> data/batches/profui/pu_NN.json [англ.рядок]   (мердж у globalStrings)
profdesc -> data/batches/profdesc/pd_NN.json [англ.рядок] (мердж у profDesc)
Дедуп проти вже наявного; фільтр сміття."""
import sys, re, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

# Приймає КІЛЬКА капчурів. Раніше брався лише sys.argv[1], тож зі збірки
# тестерів у чергу потрапляв один файл із трьох [[patch-refresh-gotchas]].
paths = sys.argv[1:]
s = ""   # block() читає глобальний s; перевизначаємо його на кожен файл нижче
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
gs = set(tr.get("globalStrings", {}))
pd_done = set(tr.get("profDesc", {}))


def block(key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, depth = m.end(), 1
    instr = esc = False
    st = i
    while i < len(s) and depth > 0:
        c = s[i]
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
    return s[st:i - 1]


def un(x):
    x = x.replace("\\\\", "\x00")
    x = x.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r").replace("\\t", "\t")
    return x.replace("\x00", "\\")


def chunk(items, sub, name, size):
    d = DATA_DIR / "batches" / sub
    d.mkdir(parents=True, exist_ok=True)
    for f in d.glob(name + "_*.json"):
        f.unlink()
    for f in d.glob("out_" + name + "_*.json"):
        f.unlink()
    nb = (len(items) + size - 1) // size if items else 0
    for k in range(nb):
        (d / f"{name}_{k:02d}.json").write_text(
            json.dumps(items[k * size:(k + 1) * size], ensure_ascii=False, indent=1),
            encoding="utf-8")
    return nb


# profui: UI-лейбли (пропускаємо вже в globalStrings; лишаємо все з літерами)
_raw_pu, _raw_pd = [], []
for _p in paths:
    s = open(_p, encoding="utf-8", errors="replace").read()
    _raw_pu += re.findall(r'\["((?:[^"\\]|\\.)*)"\]', block("profui"))
    _raw_pd += re.findall(r'\["((?:[^"\\]|\\.)*)"\]', block("profdesc"))

pu = []
for k in _raw_pu:
    u = un(k)
    if u in gs or not re.search(r"[A-Za-z]{2}", u):
        continue
    pu.append(u)
pu = sorted(set(pu))
# Вікно ремесла показує лічильники реагентів: «10/5 Soul Sprocket». Кожне
# число — окремий ключ, тож така черга не закривається ніколи. Це той самий
# рантайм, який відсіюють решта препів; тут фільтра просто не було.
import capfilter
pu, _drop = capfilter.split(pu)
capfilter.report(_drop)

# Вікно замовлень показує ЗАМОВНИКА — тобто ім'я живого гравця («Fhftuy»).
# Такий ключ мертвий для всіх, крім одного, і водночас витік
# [[player-name-leak-gate]]. Гейт той самий, що в _prep_uitt_wave.py: спершу
# відомі ніки, далі — голе Ім'я одним словом без якоря в creatures.json.
from playernames import nick_regex
_NICK = nick_regex(min_len=4)
_b = len(pu)
pu = [s for s in pu if not _NICK.search(s)]
_crea = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
_npc_words = set()
for _v in (_crea.values() if isinstance(_crea, dict) else _crea):
    if not isinstance(_v, dict):
        continue
    _nm = _v.get("name") if isinstance(_v.get("name"), dict) else _v
    _en = _nm.get("en") if isinstance(_nm, dict) else None
    if _en:
        _npc_words |= set(re.findall(r"[A-Za-zÀ-ÿ']{3,}", _en))
_known = {k for d in tr.values() if isinstance(d, dict) for k in d if isinstance(k, str)}
_SOLO = re.compile(r"[A-ZÀ-Þ][A-Za-zÀ-ÿ']{2,}")
pu = [s for s in pu
      if not (_SOLO.fullmatch(s.strip())
              and s.strip() not in _npc_words and s not in _known)]
if _b != len(pu):
    print(f"  відсіяно імен гравців (замовники, без NPC-якоря): {_b - len(pu)}")

# profdesc: описи (пропускаємо вже в profDesc)
pd = []
for k in _raw_pd:
    u = un(k)
    if u in pd_done or len(u) < 10:
        continue
    pd.append(u)
pd = sorted(set(pd))
# У profdesc осідає не лише опис спеціалізації, а й рядки вартості/зиску
# («To Craft: 1,006g Profit: …») та лічильник ремесел із таймером. Це рантайм:
# 424 з 426 рядків черги були саме ним.
pd, _dropd = capfilter.split(pd)
capfilter.report(_dropd)

n1 = chunk(pu, "profui", "pu", 30)
n2 = chunk(pd, "profdesc", "pd", 10)
print(f"profui: {len(pu)} -> pu-батчів {n1}")
print(f"profdesc: {len(pd)} -> pd-батчів {n2}")
