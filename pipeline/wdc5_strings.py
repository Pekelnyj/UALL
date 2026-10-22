# -*- coding: utf-8 -*-
"""WDC5 (DB2) екстрактор РЯДКІВ — дістає всі локалізовані текст-значення з db2-файлу
БЕЗ потреби в DBD-визначенні колонок. Для перекладу цього досить: хук матчить за
точним текстом, а не за назвою колонки ([[context-scoped-translation]]).

WDC5-розкладка: magic 'WDC5'(4) + version(4) + schema-string(128) + header + секції.
Рядки лежать у string-block кожної секції (file_offset + record_count*record_size).
Для sparse-таблиць (flag&1) string-block немає — рядки в самих записах (offset-map).

Використання: python pipeline/wdc5_strings.py <file.db2> [--json out.json]
"""
import sys, struct, json, argparse, re


def parse(path):
    d = open(path, "rb").read()
    if d[:4] != b"WDC5":
        raise SystemExit(f"не WDC5: магія={d[:4]!r}")
    version, = struct.unpack_from("<I", d, 4)
    schema = d[8:136].split(b"\0")[0].decode("ascii", "replace")
    o = 136  # після magic+version+schema(128)
    (record_count, field_count, record_size, string_table_size, table_hash,
     layout_hash, min_id, max_id, locale) = struct.unpack_from("<9I", d, o)
    o += 36
    flags, id_index = struct.unpack_from("<2H", d, o); o += 4
    (total_field_count, bitpacked_data_offset, lookup_column_count,
     field_storage_info_size, common_data_size, pallet_data_size,
     section_count) = struct.unpack_from("<7I", d, o)
    o += 28

    sparse = bool(flags & 1)
    # секційні заголовки WDC4/5: 8+4*8 = 40 байт кожен
    SEC = "<QIIIIIIII"  # tact_key(8), file_offset, record_count, string_table_size,
                        # offset_records_end, id_list_size, relationship_data_size,
                        # offset_map_id_count, copy_table_count
    sections = []
    for i in range(section_count):
        vals = struct.unpack_from(SEC, d, o); o += struct.calcsize(SEC)
        sections.append({
            "tact_key": vals[0], "file_offset": vals[1], "record_count": vals[2],
            "string_table_size": vals[3], "offset_records_end": vals[4],
            "id_list_size": vals[5], "rel_size": vals[6],
            "offset_map_count": vals[7], "copy_count": vals[8],
        })

    strings = []
    if sparse:
        # sparse: рядки інлайн у блоці записів [file_offset, offset_records_end)
        for s in sections:
            if s["tact_key"] != 0:
                continue  # зашифрована секція — пропускаємо
            blk = d[s["file_offset"]:s["offset_records_end"]]
            strings += _split_strings(blk)
    else:
        # normal: string-block одразу після записів кожної секції
        for s in sections:
            if s["tact_key"] != 0 or s["string_table_size"] <= 2:
                continue
            start = s["file_offset"] + s["record_count"] * record_size
            blk = d[start:start + s["string_table_size"]]
            strings += _split_strings(blk)

    return {
        "schema": schema, "record_count": record_count, "field_count": field_count,
        "record_size": record_size, "section_count": section_count, "sparse": sparse,
        "locale": locale, "strings": strings,
    }


def _split_strings(blk):
    out = []
    for raw in blk.split(b"\0"):
        if len(raw) < 2:
            continue
        try:
            s = raw.decode("utf-8")
        except UnicodeDecodeError:
            continue
        if re.search(r"[A-Za-z]", s) and s.isprintable():
            out.append(s)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("file")
    ap.add_argument("--json")
    a = ap.parse_args()
    r = parse(a.file)
    uniq = sorted(set(r["strings"]))
    print(f"schema={r['schema']} | записів={r['record_count']} полів={r['field_count']} "
          f"секцій={r['section_count']} sparse={r['sparse']}")
    print(f"унікальних рядків: {len(uniq)}")
    for s in uniq[:30]:
        print("   ", repr(s[:70]))
    if a.json:
        json.dump(uniq, open(a.json, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
        print(f"-> {a.json}")


if __name__ == "__main__":
    main()
