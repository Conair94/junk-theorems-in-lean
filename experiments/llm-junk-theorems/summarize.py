#!/usr/bin/env python3
"""Build human-readable reports from results/raw/*.jsonl.

Produces:
  results/summary.md       - accuracy table for the 'compiles' question
                             (ground truth: every snippet compiles), plus an
                             index of 'meaning' transcripts for manual grading
  results/all_results.csv  - flat index of every record
  results/transcripts/     - one markdown file per (model, theorem, question, sample)
"""

import csv
import json
import re
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent
RAW_DIR = ROOT / "results" / "raw"
OUT_DIR = ROOT / "results"
TRANSCRIPTS = OUT_DIR / "transcripts"

VERDICT_RE = re.compile(r"VERDICT:\s*(DOES\s+NOT\s+COMPILE|COMPILES)", re.IGNORECASE)


def parse_verdict(text: str | None) -> str:
    """Return 'compiles', 'not_compiles', or 'unparsed' from the model's answer."""
    if not text:
        return "unparsed"
    matches = VERDICT_RE.findall(text)
    if not matches:
        return "unparsed"
    last = matches[-1].upper()
    return "not_compiles" if "NOT" in last else "compiles"


def load_records():
    records = []
    for path in sorted(RAW_DIR.glob("*.jsonl")):
        with open(path, encoding="utf-8") as f:
            for line in f:
                try:
                    records.append(json.loads(line))
                except json.JSONDecodeError:
                    continue
    # Keep only the latest record per condition (re-runs may retry errors).
    latest = {}
    for rec in records:
        latest[rec["condition_id"]] = rec
    return list(latest.values())


def theorem_order():
    manifest = json.loads((ROOT / "theorems" / "manifest.json").read_text(encoding="utf-8"))
    return [t["id"] for t in manifest["theorems"]]


def write_transcripts(records):
    for rec in records:
        if rec.get("error"):
            continue
        slug = f"{rec['provider']}__{rec['model'].replace('/', '_')}"
        out = TRANSCRIPTS / slug
        out.mkdir(parents=True, exist_ok=True)
        thm = rec["theorem_id"].replace(".", "_")
        path = out / f"thm{thm}__{rec['question_id']}__s{rec['sample']}.md"
        parts = [
            f"# {rec['model']} | theorem {rec['theorem_id']} ({rec['theorem_name']}) | "
            f"{rec['question_id']} | sample {rec['sample']}",
            f"\n*{rec['timestamp']}, {rec.get('latency_s', '?')}s*",
        ]
        if rec.get("reasoning"):
            parts.append("\n## Reasoning (chain of thought)\n\n" + rec["reasoning"])
        parts.append("\n## Response\n\n" + (rec.get("response") or "*(empty)*"))
        path.write_text("\n".join(parts), encoding="utf-8")


def write_csv(records):
    fields = ["condition_id", "provider", "model", "tier", "theorem_id", "theorem_name",
              "question_id", "sample", "verdict", "finish_reason", "latency_s",
              "timestamp", "error"]
    with open(OUT_DIR / "all_results.csv", "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fields, extrasaction="ignore")
        writer.writeheader()
        for rec in sorted(records, key=lambda r: r["condition_id"]):
            row = dict(rec)
            row["verdict"] = (parse_verdict(rec.get("response"))
                              if rec["question_id"] == "compiles" and not rec.get("error")
                              else "")
            writer.writerow(row)


def write_summary(records):
    models = sorted({(r["provider"], r["model"]) for r in records})
    thm_ids = theorem_order()

    # cell[(model, theorem)] -> list of verdicts
    compiles = defaultdict(list)
    meaning_counts = defaultdict(int)
    errors = defaultdict(int)
    for rec in records:
        key = (rec["provider"], rec["model"])
        if rec.get("error"):
            errors[key] += 1
            continue
        if rec["question_id"] == "compiles":
            compiles[(key, rec["theorem_id"])].append(parse_verdict(rec.get("response")))
        elif rec["question_id"] == "meaning":
            meaning_counts[key] += 1

    lines = ["# Junk-theorem study: results summary", ""]
    lines.append("Ground truth: **every snippet compiles** (verified with "
                 "`lake env lean` against Mathlib v4.26.0-rc2).")
    lines.append("")
    lines.append("## Q1 — \"Does this compile?\" (correct answers / samples)")
    lines.append("")
    header = "| Model | " + " | ".join(f"T{t}" for t in thm_ids) + " | Total |"
    lines.append(header)
    lines.append("|" + "---|" * (len(thm_ids) + 2))
    for key in models:
        provider, model = key
        cells, correct, total = [], 0, 0
        for t in thm_ids:
            verdicts = compiles.get((key, t), [])
            c = sum(1 for v in verdicts if v == "compiles")
            unparsed = sum(1 for v in verdicts if v == "unparsed")
            total += len(verdicts)
            correct += c
            cell = f"{c}/{len(verdicts)}" if verdicts else "—"
            if unparsed:
                cell += f" ({unparsed}?)"
            cells.append(cell)
        pct = f" ({100 * correct / total:.0f}%)" if total else ""
        lines.append(f"| {model} | " + " | ".join(cells) + f" | {correct}/{total}{pct} |")
    lines.append("")
    lines.append("Cell = samples answering COMPILES (the correct verdict) out of samples run; "
                 "`(n?)` = n samples with no parseable VERDICT line.")
    lines.append("")
    lines.append("## Q2 — \"What does it mean?\" (manual grading)")
    lines.append("")
    lines.append("| Model | Responses collected | Errors (all questions) |")
    lines.append("|---|---|---|")
    for key in models:
        provider, model = key
        slug = f"{provider}__{model.replace('/', '_')}"
        lines.append(f"| {model} | [{meaning_counts[key]} transcripts](transcripts/{slug}/) "
                     f"| {errors[key]} |")
    lines.append("")
    lines.append("Read the `meaning` transcripts in `results/transcripts/<model>/` and grade "
                 "against `theorems/manifest.json` (`informal_statement` is the human-level "
                 "junk reading; the interesting question is whether the model notices the "
                 "statement is junk/misleading).")

    (OUT_DIR / "summary.md").write_text("\n".join(lines) + "\n", encoding="utf-8")


def main():
    records = load_records()
    if not records:
        print(f"No records found in {RAW_DIR}. Run run_experiment.py first.")
        return
    write_transcripts(records)
    write_csv(records)
    write_summary(records)
    n_err = sum(1 for r in records if r.get("error"))
    print(f"{len(records)} records ({n_err} errors) ->")
    print(f"  {OUT_DIR / 'summary.md'}")
    print(f"  {OUT_DIR / 'all_results.csv'}")
    print(f"  {TRANSCRIPTS}/")


if __name__ == "__main__":
    main()
