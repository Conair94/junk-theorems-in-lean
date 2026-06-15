# LLM junk-theorem study

How do LLMs react to *junk theorems* — Lean 4 theorems that are formally true
but whose informal reading is misleading nonsense? Each model is shown one of
the 15 numbered junk theorems from [`JunkTheorems.lean`](../../JunkTheorems.lean)
(theorems 1–14 plus 10.5) and asked, in **separate, fresh conversations**:

1. **`compiles`** — Does this Lean 4 code compile?
2. **`meaning`** — What does this code mean, and what theorem is it proving?

Ground truth for Q1: **every snippet compiles** — verified with
`lake env lean` against Mathlib `v4.26.0-rc2` using the lakefile's Lean
options. Q2 is graded manually against the `informal_statement` field in
[`theorems/manifest.json`](theorems/manifest.json).

## Results — run 1 (2026-06-14)

First run covered the four DeepSeek + OpenAI models (Gemini was dropped after
its key's Google Cloud project turned out not to have the Generative Language
API enabled). **360 calls, 0 errors, 0 unparseable verdicts.** Full data lives
in [`results/`](results/): per-call records in
[`results/raw/`](results/raw/), the flat index in
[`results/all_results.csv`](results/all_results.csv), the generated grid in
[`results/summary.md`](results/summary.md), and all 360 answers (including
separated chain-of-thought) as markdown in
[`results/transcripts/`](results/transcripts/).

### Headline: junk theorems fool models into predicting they *won't* compile

Every snippet compiles, yet on the `compiles` question three of the four models
answered "DOES NOT COMPILE" most of the time — the statement *reads* like
nonsense ("the third coordinate of ½ is a bijection"), and that semantic
"this is absurd" reaction overrides actually tracing the type-checking.

| Model | Tier | Said COMPILES (correct) | Said DOES NOT | Accuracy |
| --- | --- | --- | --- | --- |
| `gpt-5.5` | frontier | 26 | 19 | **58 %** |
| `gpt-4o` | legacy | 8 | 37 | 18 % |
| `deepseek-v4-pro` | frontier | 2 | 43 | 4 % |
| `deepseek-chat` | legacy | 2 | 43 | 4 % |

(45 compile-question samples per model = 15 theorems × 3.) Capability tracks
model strength sharply: `gpt-5.5` is the only model above a coin flip, while
the two DeepSeek models — frontier `v4-pro` and the smaller `chat` alias — are
indistinguishable here, both reflexively answering "does not compile."

### Per-theorem signal

Aggregating correct `COMPILES` answers across all four models (out of 12 = 4
models × 3 samples) shows which junk is *believed*:

- **Most believed:** Theorem 10 (`psub`, 8/12) and Theorem 9 (`riemannZeta_one`,
  7/12) — both *read* like ordinary true statements (T9 is an actual Mathlib
  theorem), so they don't trip the "this is junk" reflex.
- **Universally disbelieved (0/12):** Theorem 4 (the set `{z ≠ 0}` "is a
  continuous non-monotone surjection") and Theorem 12 (the `ℚ`/polynomial
  coordinate chain) — *no* model, including `gpt-5.5`, believed these compile.

### Q2 (`meaning`) — graded

All 180 `meaning` answers were graded by hand (single grader, one pass) on a
0–2 scale focused on the study's core question — does the model see through the
junk? Per-response grades are in
[`results/meaning_grades.csv`](results/meaning_grades.csv).

**Rubric**

- **2 — sees the junk:** correctly explains the real (formal) meaning *and*
  flags that the statement is misleading / a type-theoretic artifact / not the
  thing its surface reading suggests.
- **1 — partial:** correct formal reading but presents it straight without
  flagging the junk, *or* flags the junk but with a materially wrong
  explanation (e.g. correctly senses it's a "joke" but wrongly claims it is
  ill-typed).
- **0 — misses it:** fails to grasp the real meaning — takes the surface
  reading at face value, or wrongly declares the code malformed / a typo /
  uncompilable when it is in fact well-typed.

A compile-doubt aside was *not* penalized on its own as long as the meaning was
explained correctly — that failure mode is already measured by Q1.

| Model | Tier | Mean (0–2) | Fully sees junk (grade 2) |
| --- | --- | --- | --- |
| `gpt-5.5` | frontier | **2.00** | 45 / 45 |
| `deepseek-v4-pro` | frontier | **1.91** | 42 / 45 |
| `deepseek-chat` | legacy | 1.51 | 27 / 45 |
| `gpt-4o` | legacy | 0.89 | 7 / 45 |

**The cross-cut finding: understanding the joke ≠ trusting that it compiles.**
The `meaning` ranking is *not* the `compile` ranking. The two DeepSeek models
answered "DOES NOT COMPILE" ~96 % of the time (Q1 accuracy 4 %), yet they
explain the junk's actual content well — `deepseek-v4-pro` scores 1.91/2 on
meaning, second only to `gpt-5.5`. In other words DeepSeek *gets the joke* but
doesn't believe it type-checks. The clearest cases are answers that correctly
unpack the type-theoretic trick and then add "...so of course this would not
compile" — the comprehension is real, the compile intuition is just wrong.

`gpt-4o` is the genuine weak link on comprehension (0.89/2): its recurring
failure mode is declaring the snippet "nonsensical," a "typo," or a category
error *instead of* decoding it — e.g. on Theorem 6 it cannot see the
`Bool → Prop` coercion that makes `List.TFAE (7).bits` meaningful, and on
Theorem 10.5 it thinks `head!` on the empty list raises an error rather than
returning the junk value `0`. `gpt-5.5` saw the junk in every one of its 45
answers.

**Hardest junk to *explain*** (lowest mean grade across all four models, out of
2): Theorem 4 (1.17 — `Set ℝ ≡ ℝ → Prop` coercion), Theorem 6 (1.17 —
`Bool → Prop`), Theorem 7 (1.17 — Boolean functions as vectors/matrices over
the Boolean ring), and Theorem 1 (1.25 — `.3` is a proof field). These all hinge
on spotting a silent coercion or projection. **Easiest:** Theorem 13 (2.00 —
elaborate quotient/choice scaffolding collapsing to a trivial `0 = 0` in
`Fin 1`), which every model saw through; then Theorems 5 and 10 (1.83).

Caveat: these are one grader's judgments on a 3-sample run; treat the 0–2 means
as directional, not precise. The full responses are in
[`results/transcripts/`](results/transcripts/) for independent re-grading.

## Design

- **Theorem units** ([`theorems/`](theorems/)): one `.lean` file per numbered
  theorem. Each is self-contained: a uniform import header (identical across
  all units, so the header leaks no information about which theorem it is),
  the prerequisite `def`s/`lemma`s the theorem needs, and the theorem with its
  full proof. All comments and docstring exposition are stripped — the model
  never sees the human explanation of the junk.
- **Models** ([`models.json`](models.json)): two per provider — newest/largest
  ("frontier") and older/smaller ("legacy"):

  | Provider | Frontier | Legacy |
  | --- | --- | --- |
  | Gemini | `gemini-3.1-pro-preview` | `gemini-2.5-flash` |
  | DeepSeek | `deepseek-v4-pro` | `deepseek-chat` |
  | OpenAI | `gpt-5.5` | `gpt-4o` |

  All three providers expose OpenAI-compatible chat-completions endpoints, so
  a single client library covers all of them (only `base_url` + key differ).
- **Sampling**: 3 independent samples per (model, theorem, question)
  condition at provider-default temperature.
  15 theorems × 2 questions × 6 models × 3 samples = **540 calls**.
- **Prompts** ([`prompts.json`](prompts.json)): the `compiles` prompt asks for
  a final machine-parseable `VERDICT:` line; `meaning` is open-ended.

## Running

```sh
cd experiments/llm-junk-theorems
source .venv/bin/activate   # venv already created; or: python3 -m venv .venv && pip install -r requirements.txt
cp .env.example .env        # then fill in the three API keys

python run_experiment.py --smoke-test   # validate keys + model ids (6 tiny calls)
python run_experiment.py --dry-run      # inspect the run matrix and a rendered prompt
python run_experiment.py                # full run; resumable, safe to re-run
python summarize.py                     # build results/summary.md, CSV, transcripts
```

Useful flags: `--samples N`, `--models <substr>...`, `--theorems 1 10.5 13`,
`--questions compiles`, `--workers N`.

The runner appends one JSON record per call to
`results/raw/<provider>__<model>.jsonl` (full prompt, response, separated
chain-of-thought where the API returns it, token usage, latency, errors).
Interrupted or failed calls are retried simply by re-running the command —
successful conditions are skipped.

## Caveats / parked decisions

- **`deepseek-chat` is not a true "older" model**: as of mid-2026 it is an
  alias for `deepseek-v4-flash` (non-thinking) and is scheduled for retirement
  on 2026-07-24. The genuinely old V3-era DeepSeek models are no longer served
  first-party; if a true old/small DeepSeek matters for the study, add it via
  OpenRouter as a fourth provider entry in `models.json`. Revive trigger: when
  analyzing the DeepSeek tier gap, or if the alias stops working before the
  full run is finished.
- **Theorem 10.5 unit** includes only its true prerequisite
  (`primes_gt_3_even_list`). The file's neighboring `empty_list_has_zero` and
  `first_prime_gt_3_is_5` are illustration, not dependencies, and including
  them would hint at the `[].head! = 0` trick. Edit
  `theorems/theorem_10_5.lean` if you want the hinted variant as a separate
  condition.
- **Namespace names** `Theorem_12`/`Theorem_13` were kept verbatim for
  fidelity; they leak that the snippet is "numbered theorem N of some
  collection" but nothing about the junk content.
- Theorem 13's companion `a_heq_c` and the `#check_failure` demos are excluded
  (per study design: the numbered theorems only).
- **Theorem 14 is a special case**: its snippet contains an explicit `axiom`
  and a `native_decide` proof of `0 = 1`. It still compiles (the ground truth
  is unchanged), but "what is this proving?" answers should be graded with the
  axiom in mind — noticing the axiom is the whole game.
