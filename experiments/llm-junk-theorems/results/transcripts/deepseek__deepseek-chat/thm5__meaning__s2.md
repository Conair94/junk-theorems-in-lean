# deepseek-chat | theorem 5 (Riemann_hypothesis_in_closure_of_not_not) | meaning | sample 2

*2026-06-14T22:57:44.018475+00:00, 5.64s*

## Response

This Lean 4 code is a playful proof that **the Riemann hypothesis is in the closure of the set of propositions that are "not not" true**. Let’s break this down step by step.

The code defines a topological structure on the type `Prop` (propositions) and then uses it to make a statement about the Riemann hypothesis. The main theorem at the bottom is:

```lean4
theorem Riemann_hypothesis_in_closure_of_not_not : RiemannHypothesis ∈ closure (¬¬ ·) := ...
```

### Mathematical content in plain language

The code first shows that the only open sets of `Prop` (when equipped with a certain topology) are:

- The empty set
- The singleton `{True}`
- The whole set `Prop`

From this it deduces that the only closed sets are the empty set, `{False}`, and the whole set `Prop`.

Then it shows that the closure of the singleton `{True}` is the whole space `Prop`. In other words, every proposition is in the closure of `{True}`.

Since `¬¬ ·` is interpreted as the set `{True}` (because in classical logic, `¬¬P` is equivalent to `P`, but here the set notation turns the predicate `¬¬` into the set of propositions for which `¬¬` holds — which is just `{True}`), the code concludes that the Riemann hypothesis is in the closure of that set.

**But this is a triviality, not a deep number-theoretic result.** It is a joke formalization: because the topology is so coarse, every proposition is in the closure of `{True}`. Therefore, the Riemann hypothesis is "close" to being true in a completely vacuous topological sense.

In summary, the theorem says:

> **The Riemann hypothesis lies in the topological closure of the set of propositions that are "not not" true.**  
> However, this is only because the topology on `Prop` is so trivial that every proposition is in the closure of `{True}`. The result is mathematically vacuous, but amusing in its formal dressing-up of a triviality.