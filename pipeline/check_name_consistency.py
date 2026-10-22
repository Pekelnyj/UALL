import json, re, os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
T = json.load(open(os.path.join(ROOT, "data", "translations.json"), encoding="utf-8"))

CYR = "Ѐ-ӿҐґЄєІіЇї"
cyr_re = re.compile("[" + CYR + "]")
name_re = re.compile(r"^[A-Z][a-zA-Z']+ [A-Z][a-zA-Z']+$")

EN_KEYED = ["questObjectives", "gossip", "itemNames", "itemFlavors",
            "achievements", "spells", "descTemplates", "bookTexts"]

def en_pairs():
    for sec in EN_KEYED:
        d = T.get(sec, {})
        if isinstance(d, dict):
            for k, v in d.items():
                if isinstance(k, str) and isinstance(v, str):
                    yield sec, k, v

# еталонні імена: ключ = "First Last" -> кириличне значення
refs = {}
for sec, en, ua in en_pairs():
    if name_re.match(en) and cyr_re.search(ua) and len(ua.split()) >= 2:
        refs.setdefault(en, ua)

def stem(w):
    w = re.sub("[^" + CYR + "']", "", w)
    return w[:-2] if len(w) > 5 else w

# індекс: перше слово імені -> список (full_en, stem_ua)
from collections import defaultdict
by_first = defaultdict(list)
for en, ua in refs.items():
    st = stem(ua.split()[-1])
    if len(st) >= 4:
        by_first[en.split()[0]].append((en, st))

print("ref names (2-word):", len(refs))

# один прохід; токенізуємо ключ і дивимось лише імена, чиє перше слово СЕРЕД токенів
word_re = re.compile(r"[A-Za-z']+")
pairs = list(en_pairs())
hits = []
for sec, ken, kua in pairs:
    toks = set(word_re.findall(ken))
    for first in toks:
        for en, st in by_first.get(first, ()):
            if en != ken and en in ken and st not in kua:
                hits.append((en, refs[en], sec, ken, kua))

seen, uniq = set(), []
for h in hits:
    key = (h[0], h[3])
    if key not in seen:
        seen.add(key)
        uniq.append(h)

print("mismatches:", len(uniq))
with open(os.path.join(ROOT, "data", "_name_mismatches.txt"), "w", encoding="utf-8") as f:
    f.write("\n\n".join(f"NAME: {e} = {u}  [{sec}]\n  KEY: {k}\n   -> {v}" for e, u, sec, k, v in uniq))
print("written -> data/_name_mismatches.txt")
