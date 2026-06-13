#!/usr/bin/env python3
"""Run the junk-theorems LLM study.

Asks each configured model two independent questions about each junk-theorem
snippet (does it compile? / what does it mean?), N samples per condition.
Each (model, theorem, question, sample) condition is one fresh, stateless
chat-completions call.

Results are appended as JSON Lines to results/raw/<provider>__<model>.jsonl.
The runner is resumable: conditions that already have a successful record are
skipped, so it is safe to re-run after interruptions, rate limits, or to
retry failed calls.

Usage:
  python run_experiment.py --smoke-test          # 1 tiny call per model to validate keys/ids
  python run_experiment.py --dry-run             # print the run matrix, no API calls
  python run_experiment.py                       # full run (default 3 samples/condition)
  python run_experiment.py --models gpt-4o --theorems 1 10.5 --samples 1
"""

import argparse
import hashlib
import json
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parent
RAW_DIR = ROOT / "results" / "raw"

REQUEST_TIMEOUT_S = 900  # reasoning models can think for minutes
SDK_RETRIES = 3          # openai SDK retries 429/5xx with exponential backoff

write_lock = threading.Lock()


def load_json(name: str):
    with open(ROOT / name, encoding="utf-8") as f:
        return json.load(f)


def load_env():
    try:
        from dotenv import load_dotenv
    except ImportError:
        sys.exit("Missing dependency. Run: pip install -r requirements.txt")
    load_dotenv(ROOT / ".env")


def model_slug(spec: dict) -> str:
    return f"{spec['provider']}__{spec['model'].replace('/', '_')}"


def condition_id(spec: dict, theorem_id: str, question_id: str, sample: int) -> str:
    return f"{spec['provider']}|{spec['model']}|{theorem_id}|{question_id}|{sample}"


def build_conditions(args, models, theorems, prompts):
    """Cartesian product of model x theorem x question x sample, minus filters."""
    conditions = []
    for spec in models:
        if args.models and not any(s in spec["model"] for s in args.models):
            continue
        for thm in theorems:
            if args.theorems and thm["id"] not in args.theorems:
                continue
            code = (ROOT / "theorems" / thm["file"]).read_text(encoding="utf-8")
            for question_id, template in prompts["questions"].items():
                if args.questions and question_id not in args.questions:
                    continue
                user_prompt = template.replace("{code}", code.rstrip("\n"))
                for sample in range(args.samples):
                    conditions.append({
                        "spec": spec,
                        "theorem_id": thm["id"],
                        "theorem_name": thm["theorem_name"],
                        "question_id": question_id,
                        "sample": sample,
                        "user_prompt": user_prompt,
                    })
    return conditions


def load_done_ids() -> set:
    """Condition ids that already have a successful (error-free) record."""
    done = set()
    for path in RAW_DIR.glob("*.jsonl"):
        with open(path, encoding="utf-8") as f:
            for line in f:
                try:
                    rec = json.loads(line)
                except json.JSONDecodeError:
                    continue
                if rec.get("error") is None:
                    done.add(rec["condition_id"])
    return done


def make_clients(providers: dict, needed: set) -> dict:
    import os
    from openai import OpenAI

    clients = {}
    for name in needed:
        cfg = providers[name]
        key = os.environ.get(cfg["api_key_env"], "")
        if not key:
            sys.exit(
                f"Missing API key: set {cfg['api_key_env']} in "
                f"{ROOT / '.env'} (see .env.example)"
            )
        clients[name] = OpenAI(
            api_key=key,
            base_url=cfg["base_url"],
            timeout=REQUEST_TIMEOUT_S,
            max_retries=SDK_RETRIES,
        )
    return clients


def call_model(client, spec: dict, system_prompt: str, user_prompt: str) -> dict:
    messages = []
    if system_prompt:
        messages.append({"role": "system", "content": system_prompt})
    messages.append({"role": "user", "content": user_prompt})

    start = time.monotonic()
    resp = client.chat.completions.create(model=spec["model"], messages=messages)
    latency = time.monotonic() - start

    choice = resp.choices[0]
    msg = choice.message
    # DeepSeek (and some compat endpoints) return chain-of-thought separately.
    reasoning = getattr(msg, "reasoning_content", None)
    if reasoning is None and msg.model_extra:
        reasoning = msg.model_extra.get("reasoning_content")
    return {
        "response": msg.content,
        "reasoning": reasoning,
        "finish_reason": choice.finish_reason,
        "usage": resp.usage.model_dump() if resp.usage else None,
        "response_model": resp.model,
        "latency_s": round(latency, 2),
    }


def run_condition(clients, system_prompt, cond) -> dict:
    spec = cond["spec"]
    record = {
        "condition_id": condition_id(spec, cond["theorem_id"], cond["question_id"], cond["sample"]),
        "provider": spec["provider"],
        "model": spec["model"],
        "tier": spec.get("tier"),
        "theorem_id": cond["theorem_id"],
        "theorem_name": cond["theorem_name"],
        "question_id": cond["question_id"],
        "sample": cond["sample"],
        "system_prompt": system_prompt,
        "user_prompt": cond["user_prompt"],
        "prompt_sha256": hashlib.sha256(cond["user_prompt"].encode()).hexdigest(),
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "error": None,
    }
    try:
        record.update(call_model(clients[spec["provider"]], spec, system_prompt, cond["user_prompt"]))
    except Exception as e:  # noqa: BLE001 - record and continue, runner is resumable
        record["error"] = f"{type(e).__name__}: {e}"
    return record


def append_record(record: dict, spec: dict):
    path = RAW_DIR / f"{model_slug(spec)}.jsonl"
    with write_lock:
        with open(path, "a", encoding="utf-8") as f:
            f.write(json.dumps(record, ensure_ascii=False) + "\n")


def smoke_test(models, providers):
    clients = make_clients(providers, {m["provider"] for m in models})
    print("Smoke test: one trivial call per model.\n")
    failures = 0
    for spec in models:
        try:
            out = call_model(clients[spec["provider"]], spec, "", "Reply with exactly: OK")
            text = (out["response"] or "").strip().replace("\n", " ")[:60]
            print(f"  [ok]   {spec['provider']:<9} {spec['model']:<28} -> {text!r} ({out['latency_s']}s)")
        except Exception as e:  # noqa: BLE001
            failures += 1
            print(f"  [FAIL] {spec['provider']:<9} {spec['model']:<28} -> {type(e).__name__}: {e}")
    sys.exit(1 if failures else 0)


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--samples", type=int, default=3, help="samples per condition (default 3)")
    parser.add_argument("--models", nargs="*", help="substring filter on model id, e.g. --models gpt-4o gemini")
    parser.add_argument("--theorems", nargs="*", help="theorem ids, e.g. --theorems 1 10.5 13")
    parser.add_argument("--questions", nargs="*", choices=["compiles", "meaning"], help="question ids")
    parser.add_argument("--workers", type=int, default=4, help="parallel requests (default 4)")
    parser.add_argument("--dry-run", action="store_true", help="print run matrix and one rendered prompt, no API calls")
    parser.add_argument("--smoke-test", action="store_true", help="validate API keys and model ids with one tiny call each")
    args = parser.parse_args()

    models_cfg = load_json("models.json")
    prompts = load_json("prompts.json")
    theorems = load_json("theorems/manifest.json")["theorems"]
    models = models_cfg["models"]

    if args.smoke_test:
        load_env()
        smoke_test(models, models_cfg["providers"])

    conditions = build_conditions(args, models, theorems, prompts)
    RAW_DIR.mkdir(parents=True, exist_ok=True)
    done = load_done_ids()
    pending = [
        c for c in conditions
        if condition_id(c["spec"], c["theorem_id"], c["question_id"], c["sample"]) not in done
    ]

    n_models = len({model_slug(c["spec"]) for c in conditions}) if conditions else 0
    print(f"Run matrix: {n_models} models x "
          f"{len({c['theorem_id'] for c in conditions})} theorems x "
          f"{len({c['question_id'] for c in conditions})} questions x "
          f"{args.samples} samples = {len(conditions)} conditions "
          f"({len(conditions) - len(pending)} already done, {len(pending)} to run)\n")

    if args.dry_run:
        if conditions:
            c = conditions[0]
            print(f"--- example rendered prompt ({c['spec']['model']}, theorem {c['theorem_id']}, "
                  f"{c['question_id']}) ---\n")
            print(f"[system] {prompts['system']}\n")
            print(f"[user]\n{c['user_prompt']}")
        return

    if not pending:
        print("Nothing to do. Run summarize.py to build the report.")
        return

    load_env()
    clients = make_clients(models_cfg["providers"], {c["spec"]["provider"] for c in pending})

    ok = err = 0
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        futures = {
            pool.submit(run_condition, clients, prompts["system"], cond): cond
            for cond in pending
        }
        for i, future in enumerate(as_completed(futures), 1):
            cond = futures[future]
            record = future.result()
            append_record(record, cond["spec"])
            if record["error"]:
                err += 1
                status = f"ERROR {record['error'][:80]}"
            else:
                ok += 1
                status = f"ok {record['latency_s']}s"
            print(f"[{i}/{len(pending)}] {cond['spec']['model']:<28} "
                  f"thm {cond['theorem_id']:<4} {cond['question_id']:<8} "
                  f"s{cond['sample']} {status}")

    print(f"\nDone: {ok} ok, {err} errors.")
    if err:
        print("Re-run the same command to retry failed conditions (successes are skipped).")
    print("Next: python summarize.py")


if __name__ == "__main__":
    main()
