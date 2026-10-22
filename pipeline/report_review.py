"""Зведення знахідок «злого рецензента» в один документ для рішень.

Читає data/review_batches/out_NN.json, групує за словом (повтори зливає),
сортує за severity. Результат: data/review_findings.md

Використання:
    python report_review.py
"""

import json
import io
from collections import OrderedDict

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "review_batches"
OUT = DATA_DIR / "review_findings.md"

ORDER = {"high": 0, "medium": 1, "low": 2}


def main():
    findings = []
    for out in sorted(BATCH_DIR.glob("out_*.json")):
        data = json.loads(out.read_text(encoding="utf-8-sig"))
        if isinstance(data, list):
            findings.extend(f for f in data if isinstance(f, dict) and f.get("word"))

    # Групуємо за словом: те саме слово в багатьох місцях — один пункт.
    groups = OrderedDict()
    for f in findings:
        key = f["word"].strip().lower()
        g = groups.setdefault(key, {"word": f["word"].strip(), "items": [],
                                    "severity": f.get("severity", "low")})
        g["items"].append(f)
        if ORDER.get(f.get("severity", "low"), 2) < ORDER.get(g["severity"], 2):
            g["severity"] = f.get("severity", "low")

    ordered = sorted(groups.values(),
                     key=lambda g: (ORDER.get(g["severity"], 2), -len(g["items"])))

    lines = [f"# Вичитка «злого рецензента» — {len(findings)} знахідок, "
             f"{len(ordered)} унікальних слів\n",
             "Рішення по кожному пункту ухвалює людина. Формат: слово — "
             "пропозиція заміни; нижче приклади вживання.\n"]
    counts = {"high": 0, "medium": 0, "low": 0}
    for g in ordered:
        counts[g["severity"]] = counts.get(g["severity"], 0) + 1
    lines.append(f"**high: {counts['high']} | medium: {counts['medium']} | "
                 f"low: {counts['low']}**\n")

    num = 0
    for sev in ("high", "medium", "low"):
        block = [g for g in ordered if g["severity"] == sev]
        if not block:
            continue
        lines.append(f"\n## {sev.upper()} ({len(block)})\n")
        for g in block:
            num += 1
            first = g["items"][0]
            sugg = first.get("suggestion", "—")
            lines.append(f"### {num}. «{g['word']}» → {sugg}  "
                         f"({len(g['items'])} місць)\n")
            lines.append(f"_{first.get('opinion', '')}_\n")
            for it in g["items"][:4]:
                lines.append(f"- `{it.get('type', '?')}/{it.get('id', '?')}`: "
                             f"…{it.get('fragment', '')}…")
            if len(g["items"]) > 4:
                lines.append(f"- … і ще {len(g['items']) - 4} місць")
            lines.append("")

    OUT.write_text("\n".join(lines), encoding="utf-8")
    print(f"Знахідок: {len(findings)} | унікальних слів: {len(ordered)} | "
          f"high: {counts['high']}, medium: {counts['medium']}, low: {counts['low']}")
    print(f"-> {OUT}")


if __name__ == "__main__":
    main()
