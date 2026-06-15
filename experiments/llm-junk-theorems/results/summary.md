# Junk-theorem study: results summary

Ground truth: **every snippet compiles** (verified with `lake env lean` against Mathlib v4.26.0-rc2).

## Q1 — "Does this compile?" (correct answers / samples)

| Model | T1 | T2 | T3 | T4 | T5 | T6 | T7 | T8 | T9 | T10 | T10.5 | T11 | T12 | T13 | T14 | Total |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| deepseek-chat | 0/3 | 0/3 | 0/3 | 0/3 | 0/3 | 0/3 | 0/3 | 0/3 | 1/3 | 1/3 | 0/3 | 0/3 | 0/3 | 0/3 | 0/3 | 2/45 (4%) |
| deepseek-v4-pro | 0/3 | 0/3 | 0/3 | 0/3 | 0/3 | 0/3 | 0/3 | 0/3 | 0/3 | 2/3 | 0/3 | 0/3 | 0/3 | 0/3 | 0/3 | 2/45 (4%) |
| gpt-4o | 0/3 | 0/3 | 1/3 | 0/3 | 0/3 | 0/3 | 0/3 | 1/3 | 3/3 | 2/3 | 0/3 | 0/3 | 0/3 | 0/3 | 1/3 | 8/45 (18%) |
| gpt-5.5 | 3/3 | 3/3 | 2/3 | 0/3 | 1/3 | 3/3 | 2/3 | 0/3 | 3/3 | 3/3 | 2/3 | 2/3 | 0/3 | 1/3 | 1/3 | 26/45 (58%) |

Cell = samples answering COMPILES (the correct verdict) out of samples run; `(n?)` = n samples with no parseable VERDICT line.

## Q2 — "What does it mean?" (manual grading)

| Model | Responses collected | Errors (all questions) |
|---|---|---|
| deepseek-chat | [45 transcripts](transcripts/deepseek__deepseek-chat/) | 0 |
| deepseek-v4-pro | [45 transcripts](transcripts/deepseek__deepseek-v4-pro/) | 0 |
| gpt-4o | [45 transcripts](transcripts/openai__gpt-4o/) | 0 |
| gpt-5.5 | [45 transcripts](transcripts/openai__gpt-5.5/) | 0 |

Read the `meaning` transcripts in `results/transcripts/<model>/` and grade against `theorems/manifest.json` (`informal_statement` is the human-level junk reading; the interesting question is whether the model notices the statement is junk/misleading).
