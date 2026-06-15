# gpt-5.5 | theorem 5 (Riemann_hypothesis_in_closure_of_not_not) | meaning | sample 2

*2026-06-14T23:14:41.191882+00:00, 19.15s*

## Response

This Lean file is doing a small topological argument about the type `Prop`.

In Mathlib, `Prop` has a natural topology (the Sierpiński topology). In that topology, the open subsets of `Prop` are exactly

\[
\varnothing,\quad \{\top\},\quad \mathrm{univ}.
\]

Equivalently, the closed subsets are exactly

\[
\varnothing,\quad \{\bot\},\quad \mathrm{univ}.
\]

The file proves these facts:

```lean
lemma Prop.isOpen_iff (X : Set Prop) :
  IsOpen X ↔ X = ∅ ∨ X = {⊤} ∨ X = Set.univ
```

and

```lean
lemma Prop.isClosed_iff (X : Set Prop) :
  IsClosed X ↔ X = ∅ ∨ X = {⊥} ∨ X = Set.univ
```

Then it proves:

```lean
lemma Prop.closure_singleton_true_univ :
  closure ({⊤} : Set Prop) = Set.univ
```

That is, the closure of the singleton set containing `True` is all of `Prop`. This happens because the only closed set containing `True` is the whole space.

Finally, the theorem is:

```lean
theorem Riemann_hypothesis_in_closure_of_not_not :
  RiemannHypothesis ∈ closure (¬¬ ·)
```

Here `(¬¬ ·)` is the set of propositions `P : Prop` such that `¬¬ P` holds. Classically, this is the same subset of `Prop` as `{⊤}`, because `¬¬ P` is equivalent to `P`, and any true proposition is equal to `True` by propositional extensionality.

So the theorem says:

> The proposition `RiemannHypothesis` lies in the topological closure, inside `Prop`, of the set of propositions satisfying double negation.

In plain mathematical language:

> In the Sierpiński topology on the space of propositions, every proposition is in the closure of the point `True`; therefore the proposition expressing the Riemann Hypothesis is in that closure.

Importantly, this does **not** prove the Riemann Hypothesis. It proves a topological statement about the type `Prop`. Since the closure of `{True}` is all of `Prop` in this topology, every proposition lies in that closure, including `RiemannHypothesis`, `False`, or any other proposition.