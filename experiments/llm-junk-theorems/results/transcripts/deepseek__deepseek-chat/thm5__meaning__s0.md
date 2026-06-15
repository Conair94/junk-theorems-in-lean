# deepseek-chat | theorem 5 (Riemann_hypothesis_in_closure_of_not_not) | meaning | sample 0

*2026-06-14T22:57:43.722691+00:00, 6.13s*

## Response

This Lean 4 code is a playful "proof" of a statement about the Riemann Hypothesis. Let me break down what it's actually doing:

**The mathematical content:**

The theorem `Riemann_hypothesis_in_closure_of_not_not` claims:

> The Riemann Hypothesis (as a proposition) is in the topological closure of the set consisting of the proposition "not not" (where "not not" is interpreted as a propositional value).

**What the code actually shows:**

1. **Topology on Prop:** The code first establishes a topology on the type `Prop` (propositions). It proves that the open sets in this topology are exactly: the empty set, the singleton `{⊤}` (where `⊤` represents "true"), and the whole set `Set.univ`.

2. **Closed sets:** Correspondingly, the closed sets are: empty, `{⊥}` (where `⊥` represents "false"), and the whole set `Set.univ`.

3. **Closure computation:** It proves that the closure of `{⊤}` (the singleton containing "true") is the whole universe `Set.univ`.

4. **Final step:** It identifies `(¬¬ ·)` (the set containing the double negation of any proposition) with `{⊤}`, since in classical logic, `¬¬P` is equivalent to `P` for any proposition `P`, but here it's specifically interpreted as being just the singleton `{⊤}`.

Since the closure of `{⊤}` is `Set.univ`, and `RiemannHypothesis` is some proposition that lives in `Set.univ`, it follows that `RiemannHypothesis ∈ closure(¬¬ ·)`.

**In plain language:**

The theorem is essentially saying: "The Riemann Hypothesis is in the closure of the set consisting of the proposition `¬¬` (interpreted as a truth value)." 

This is a triviality—it's true for *any* proposition because the closure of `{⊤}` is everything. The "proof" is a mathematical joke: it shows that the Riemann Hypothesis belongs to this closure not because of any deep number theory, but simply because the closure contains all propositions.

The joke is that it sounds like it might be saying something about the Riemann Hypothesis being "approached" or "implied" by double negation, but it's actually a vacuous topological statement. The "proof" avoids any actual number theory by abstracting the Riemann Hypothesis into a mere proposition label.