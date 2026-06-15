# gpt-5.5 | theorem 5 (Riemann_hypothesis_in_closure_of_not_not) | meaning | sample 1

*2026-06-14T23:14:37.096042+00:00, 21.14s*

## Response

This Lean file is doing a small topology argument about the type `Prop` (the type of propositions), using Mathlib’s topology on `Prop`.

### What topology is being used?

Mathlib has a topological space structure on `Prop`. In that topology, the open subsets of `Prop` are exactly

\[
\varnothing,\quad \{\top\},\quad \mathrm{univ}.
\]

Here `⊤ : Prop` means `True`, and `⊥ : Prop` means `False`.

So the file proves:

```lean
lemma Prop.isOpen_iff (X : Set Prop) :
  IsOpen X ↔ X = ∅ ∨ X = {⊤} ∨ X = Set.univ
```

In words: the only open subsets of `Prop` are the empty set, the singleton `{True}`, and all of `Prop`.

Then it proves the corresponding classification of closed sets:

```lean
lemma Prop.isClosed_iff (X : Set Prop) :
  IsClosed X ↔ X = ∅ ∨ X = {⊥} ∨ X = Set.univ
```

So the closed subsets of `Prop` are

\[
\varnothing,\quad \{\bot\},\quad \mathrm{univ}.
\]

### Closure of `{True}`

The next lemma is:

```lean
lemma Prop.closure_singleton_true_univ :
  closure ({⊤} : Set Prop) = Set.univ
```

This says that the closure of the singleton set `{True}` is the whole space `Prop`.

Indeed, since the only closed set containing `True` is `Set.univ`, the closure of `{True}` must be all of `Prop`.

### The main theorem

The final theorem is:

```lean
theorem Riemann_hypothesis_in_closure_of_not_not :
  RiemannHypothesis ∈ closure (¬¬ ·)
```

Here `(¬¬ ·)` is being used as a set of propositions:

```lean
fun P : Prop => ¬¬ P
```

So it is the set

\[
\{P : \mathrm{Prop} \mid \neg\neg P\}.
\]

Classically, this is just the set of true propositions, i.e. `{⊤}`. The proof shows:

```lean
have h3 : (¬¬ ·) = ({⊤} : Set Prop)
```

Then it rewrites the goal using the fact that

```lean
closure ({⊤} : Set Prop) = Set.univ
```

and concludes trivially that `RiemannHypothesis` is an element of `Set.univ`.

### Plain-language mathematical content

The main theorem says:

> In the standard topology on the type of propositions `Prop`, the proposition `RiemannHypothesis` lies in the closure of the set of propositions satisfying double negation.

Equivalently:

> Since the closure of the set of true propositions is all of `Prop`, every proposition — including the Riemann hypothesis — belongs to that closure.

This does **not** prove the Riemann hypothesis. It proves a topological statement about the proposition `RiemannHypothesis` as a point of the space `Prop`. The result is true for every proposition whatsoever, not specifically because of any number-theoretic property of the Riemann hypothesis.