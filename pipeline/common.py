"""Спільні утиліти пайплайна: пошук аддона і його метаданих.

Назва аддона НЕ зашита в коді — вона визначається з імені .toc-файлу
в папці addon/. Перейменування аддона (rename_addon.py) не потребує
жодних змін у скриптах пайплайна.
"""

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ADDON_ROOT = ROOT / "addon"
DATA_DIR = ROOT / "data"


def batch_files(sub, prefix, out=False):
    """Файли батчів у ПРАВИЛЬНОМУ порядку — по всій пайплайні однаково.

    Два роздільні баги, які вже коштували втраченої роботи, обидва тут:

      • маска «PREFIX_[0-9][0-9].json» бачила лише двоцифрові імена, а препи
        роблять сотні файлів. Старі ol_100+ не чистилися й задвоювали чергу;
      • сортування рядками ставить «ol_100» ПЕРЕД «ol_66», тож переклад,
        зроблений за списком, лягав не на ті рядки.

    Тому: маска на будь-яку кількість цифр + сортування ЧИСЛОВЕ.

        for f in batch_files("objlines", "ol"):        # вхідні батчі
        for f in batch_files("objlines", "ol", out=True):  # виходи перекладу
    """
    d = DATA_DIR / "batches" / sub
    if not d.is_dir():
        return []
    pat = f"out_{prefix}_*.json" if out else f"{prefix}_[0-9]*.json"

    def num(p):
        m = re.search(r"(\d+)", p.stem.split("_")[-1])
        return int(m.group(1)) if m else -1

    return sorted(d.glob(pat), key=num)


def find_addon_dir() -> Path:
    """ГОЛОВНА папка аддона — єдина підпапка addon/ з .toc, що НЕ є LoadOnDemand-
    під-аддоном (WoWUkraine_Items/_NpcNames/_Journal тощо мають ## LoadOnDemand)."""
    candidates = [p for p in ADDON_ROOT.iterdir() if p.is_dir() and list(p.glob("*.toc"))]
    if not candidates:
        raise FileNotFoundError(f"Не знайдено папки аддона з .toc у {ADDON_ROOT}")

    def is_lod(p):
        for toc in p.glob("*.toc"):
            if "## LoadOnDemand" in toc.read_text(encoding="utf-8", errors="ignore"):
                return True
        return False

    mains = [p for p in candidates if not is_lod(p)]
    if len(mains) > 1:
        names = ", ".join(p.name for p in mains)
        raise RuntimeError(f"У {ADDON_ROOT} кілька головних аддонів ({names}) — залиште один.")
    if not mains:
        raise FileNotFoundError(f"Не знайдено ГОЛОВНОГО (не-LoD) аддона у {ADDON_ROOT}")
    return mains[0]


def addon_name() -> str:
    return find_addon_dir().name


def toc_path() -> Path:
    return find_addon_dir() / f"{addon_name()}.toc"


def sv_variable() -> str:
    """Назва глобальної змінної збору текстів (…CaptureDB) з .toc.

    У .toc може бути кілька SavedVariables через кому (capture + settings) —
    пайплайну потрібна саме та, що закінчується на CaptureDB.
    """
    for line in toc_path().read_text(encoding="utf-8-sig").splitlines():
        if line.startswith("## SavedVariables:"):
            names = [n.strip() for n in line.split(":", 1)[1].split(",")]
            for name in names:
                if name.endswith("CaptureDB"):
                    return name
            return names[0]
    raise ValueError(f"У {toc_path()} немає рядка '## SavedVariables:'")
