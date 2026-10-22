# -*- coding: utf-8 -*-
"""Зібрати ЗІСТАВЛЕННЯ.txt для папки експерименту в _порівняння/.

Кожен варіант-файл має блоки:  === [questID] EN Title / НАЗВА: ... / ОПИС: ...
Генератор інтерлівить ПО-КВЕСТНО (той самий квест → усі версії підряд) — саме так
їх можна порівнювати очима і через 1000 ранів, бо кожен блок самоідентифікований.

Використання:
  python tools/build_comparison.py "_порівняння/2026-07-02_переклад-6300_fable-vs-opus" \
      "FABLE5=ПЕРЕКЛАД_FABLE5.txt" "OPUS48=ПЕРЕКЛАД_OPUS48.txt" "СТАРИЙ=ПЕРЕКЛАД_ПОТОЧНИЙ.txt"

Пише: <папка>/ЗІСТАВЛЕННЯ.txt (+ оновлює manifest.json переліком варіантів).
"""
import sys, os, re, json
sys.stdout.reconfigure(encoding="utf-8")

folder = sys.argv[1]
variants = []  # (label, filename)
for a in sys.argv[2:]:
    label, fn = a.split("=", 1)
    variants.append((label, fn))


def parse(path):
    t = open(path, encoding="utf-8-sig").read()
    # відкинути шапку-паспорт, якщо є (усе до першого ===)
    i = t.find("=== [")
    t = t[i:] if i >= 0 else t
    blocks = re.split(r"^=== \[(\d+)\] (.*)$", t, flags=re.M)[1:]
    out = {}
    order = []
    for j in range(0, len(blocks), 3):
        qid, title_en, body = blocks[j], blocks[j + 1].strip(), blocks[j + 2].strip()
        out[qid] = (title_en, body)
        order.append(qid)
    return out, order


parsed = {}
order = []
for label, fn in variants:
    p = os.path.join(folder, fn)
    parsed[label], o = parse(p)
    if len(o) > len(order):
        order = o

lines = []
lines.append("ЗІСТАВЛЕННЯ ПО-КВЕСТНО — той самий квест, усі версії підряд.")
lines.append("Папка: %s" % os.path.basename(os.path.abspath(folder)))
lines.append("Варіанти: " + ", ".join(l for l, _ in variants))
lines.append("=" * 72)
for qid in order:
    # EN-назва з першого варіанта, де є
    ten = next((parsed[l][qid][0] for l, _ in variants if qid in parsed[l]), "?")
    lines.append("")
    lines.append("#" * 72)
    lines.append("### КВЕСТ [%s] %s" % (qid, ten))
    lines.append("#" * 72)
    for label, _ in variants:
        if qid not in parsed[label]:
            lines.append("--- %s: (нема блоку) ---" % label)
            continue
        lines.append("")
        lines.append("--- %s " % label + "-" * (66 - len(label)))
        lines.append(parsed[label][qid][1])
out = os.path.join(folder, "ЗІСТАВЛЕННЯ.txt")
open(out, "w", encoding="utf-8").write("\n".join(lines))

# manifest.json — доливаємо перелік варіантів (решту полів кладе автор експерименту)
mp = os.path.join(folder, "manifest.json")
m = {}
if os.path.exists(mp):
    m = json.load(open(mp, encoding="utf-8-sig"))
m.setdefault("variants", {})
for label, fn in variants:
    m["variants"][label] = fn
m["interleaved"] = "ЗІСТАВЛЕННЯ.txt"
json.dump(m, open(mp, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("OK:", out, "| квестів:", len(order), "| варіантів:", len(variants))
