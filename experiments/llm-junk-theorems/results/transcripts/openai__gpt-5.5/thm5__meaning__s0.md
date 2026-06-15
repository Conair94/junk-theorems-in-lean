# gpt-5.5 | theorem 5 (Riemann_hypothesis_in_closure_of_not_not) | meaning | sample 0

*2026-06-14T23:14:04.237416+00:00, 32.86s*

## Response

This Lean file is doing a small topological argument in the type `Prop`.

In Mathlib, `Prop` has a topology: its open sets are exactly

```lean
∅, {⊤}, Set.univ
```

where `⊤ : Prop` is `True`. So `Prop` is being viewed as the two-point Sierpiński-like space of truth values, where `{True}` is open but not closed.

The file proves three preliminary facts:

1. **Classification of open subsets of `Prop`:**

   ```lean
   lemma Prop.isOpen_iff (X : Set Prop) :
     IsOpen X ↔ X = ∅ ∨ X = {⊤} ∨ X = Set.univ
   ```

   So every open set of `Prop` is either empty, `{True}`, or all of `Prop`.

2. **Classification of closed subsets of `Prop`:**

   ```lean
   lemma Prop.isClosed_iff (X : Set Prop) :
     IsClosed X ↔ X = ∅ ∨ X = {⊥} ∨ X = Set.univ
   ```

   The closed sets are empty, `{False}`, or all of `Prop`.

3. **The closure of `{True}` is all of `Prop`:**

   ```lean
   lemma Prop.closure_singleton_true_univ :
     closure ({⊤} : Set Prop) = Set.univ
   ```

   Since the only closed set containing `{True}` is `Set.univ`, the closure of `{True}` is the whole space.

The main theorem is:

```lean
theorem Riemann_hypothesis_in_closure_of_not_not :
  RiemannHypothesis ∈ closure (¬¬ ·)
```

Here `(¬¬ ·)` is the set of propositions `P : Prop` such that `¬¬ P`. In other words,

```lean
(¬¬ ·) = {P : Prop | ¬¬ P}
```

Using classical logic, this set is equal to `{⊤}`, because `¬¬ P` is equivalent to `P`, and any true proposition is equal to `True` as an element of `Prop`.

So the proof rewrites

```lean
closure (¬¬ ·)
```

as

```lean
closure ({⊤} : Set Prop)
```

and then uses the lemma that this closure is `Set.univ`. Therefore every proposition belongs to it, including `RiemannHypothesis`.

Plain mathematical content:

> In the topology on the space of propositions where the closure of `{True}` is all of `Prop`, the proposition `RiemannHypothesis` lies in the closure of the set of double-negation-true propositions.

Equivalently:

> The Riemann Hypothesis is in the closure of `{P : Prop | ¬¬P}`.

This does **not** prove the Riemann Hypothesis. It only proves a topological statement about the point corresponding to `RiemannHypothesis` inside the topological space `Prop`. Since `{True}` is dense in this topology, every proposition — true or false — lies in its closure.