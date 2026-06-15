# gpt-5.5 | theorem 4 (set_of_nonzero_reals_is_continuous_nonmono_surjection) | meaning | sample 0

*2026-06-14T23:11:06.253681+00:00, 28.26s*

## Response

This Lean file treats a set as its characteristic predicate.

In Lean/Mathlib,

```lean
{z : ℝ | z ≠ 0}
```

has type

```lean
Set ℝ
```

but `Set ℝ` is definitionally the same as

```lean
ℝ → Prop
```

so it can be viewed as the function

\[
f : \mathbb R \to \mathrm{Prop}, \qquad f(z) := (z \neq 0).
\]

So the theorem is not saying that a subset of `ℝ` is a continuous function in the usual sense; it is saying that the predicate “`z ≠ 0`” is a continuous map from `ℝ` to `Prop`, where `Prop` carries Mathlib’s topology.

The auxiliary lemma

```lean
lemma Prop.isOpen_iff (X : Set Prop) :
  IsOpen X ↔ X = ∅ ∨ X = {⊤} ∨ X = Set.univ
```

characterizes the open subsets of `Prop`. In Mathlib’s topology on `Prop`, the open sets are exactly

\[
\varnothing,\quad \{\text{True}\},\quad \mathrm{Prop}.
\]

The main theorem is:

```lean
theorem set_of_nonzero_reals_is_continuous_nonmono_surjection :
       Continuous {z : ℝ | z ≠ 0}
    ∧ ¬Monotone {z : ℝ | z ≠ 0}
    ∧ Function.Surjective {z : ℝ | z ≠ 0}
```

In plain mathematical language:

> The function  
> \[
> f : \mathbb R \to \mathrm{Prop}, \qquad f(z) := (z \neq 0),
> \]
> is continuous, is not monotone, and is surjective.

More explicitly:

1. **Continuity**:  
   The only nontrivial open subset of `Prop` is `{True}`. Its preimage under `f` is
   \[
   f^{-1}(\{\text{True}\}) = \{z \in \mathbb R : z \neq 0\},
   \]
   which is open in `ℝ`.

2. **Not monotone**:  
   Monotonicity would mean that if `x ≤ y` and `x ≠ 0`, then `y ≠ 0`. But
   \[
   -1 \le 0,\qquad -1 \neq 0,\qquad 0 = 0,
   \]
   so monotonicity fails.

3. **Surjective**:  
   The function hits both truth values:
   \[
   f(1) = \text{True}, \qquad f(0) = \text{False}.
   \]

So the theorem proves that the predicate “being a nonzero real number”, regarded as a map from `ℝ` to `Prop`, is a continuous, non-monotone, surjective map.