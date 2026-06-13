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
