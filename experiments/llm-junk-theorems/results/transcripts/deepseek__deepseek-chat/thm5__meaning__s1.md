# deepseek-chat | theorem 5 (Riemann_hypothesis_in_closure_of_not_not) | meaning | sample 1

*2026-06-14T22:57:43.962210+00:00, 5.75s*

## Response

This Lean 4 code is a **joke** (or a mathematical spoof) that "proves" the Riemann Hypothesis by embedding it into the trivial topology on the set of propositions.  

Let’s break it down:

## Mathematical content

The file defines a **topology on the set `Prop`** (the type of all propositions in Lean).  
The lemmas `Prop.isOpen_iff` and `Prop.isClosed_iff` classify the open and closed subsets of `Prop`.  
The result is that:

- The only open subsets are `∅`, `{⊤}` (the singleton containing `True`), and the whole set `Prop`.
- The only closed subsets are `∅`, `{⊥}` (the singleton containing `False`), and `Prop`.

Then `Prop.closure_singleton_true_univ` shows that the closure (in this topology) of `{⊤}` is the entire set `Prop`.

## The main "theorem"

```lean
theorem Riemann_hypothesis_in_closure_of_not_not : RiemannHypothesis ∈ closure (¬¬ ·) := ...
```

Here, `(¬¬ ·)` is the set of all propositions of the form `¬¬ P` for some `P`, but the proof reinterprets it as the singleton `{⊤}` because every `¬¬ P` is equivalent to `P` in classical logic (and semantically equal to `⊤` if `P` is true, but the code is playing fast and loose).  

Then using `closure {⊤} = univ`, it deduces that **`RiemannHypothesis` is in the closure**, which in this topology is trivial because **everything** is in the closure of `{⊤}`.  

## Plain language summary

> In the trivial topology on the set of all propositions, where the only nontrivial closed set is the singleton `{False}`, every proposition (including the Riemann Hypothesis) belongs to the closure of `{True}`. Therefore the Riemann Hypothesis is “topologically near” the truth—a purely formal observation with no actual number-theoretic content.

It's a humorous demonstration of how one can "prove" deep open problems by choosing a degenerate mathematical structure.