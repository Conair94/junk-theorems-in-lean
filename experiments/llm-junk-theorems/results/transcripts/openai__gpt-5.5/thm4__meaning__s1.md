# gpt-5.5 | theorem 4 (set_of_nonzero_reals_is_continuous_nonmono_surjection) | meaning | sample 1

*2026-06-14T23:11:14.034367+00:00, 19.47s*

## Response

This Lean file treats a subset `{z : ℝ | z ≠ 0}` as its characteristic predicate/function

```lean
fun z : ℝ => z ≠ 0
```

whose codomain is `Prop`. So the main theorem is not saying that the set of nonzero reals is a continuous map in the usual sense of a real-valued function. It is saying that the predicate “`z` is nonzero” is a function

```lean
ℝ → Prop
```

and has three properties: it is continuous, it is not monotone, and it is surjective onto `Prop`.

The main theorem is:

```lean
theorem set_of_nonzero_reals_is_continuous_nonmono_surjection :
       Continuous {z : ℝ | z ≠ 0}
    ∧ ¬Monotone {z : ℝ | z ≠ 0}
    ∧  Function.Surjective {z : ℝ | z ≠ 0}
```

In plain mathematical language:

> The predicate on real numbers defined by “`z ≠ 0`”, viewed as a function from `ℝ` to the two truth values `Prop`, is continuous, is not monotone with respect to the usual order on `ℝ` and implication on propositions, and is surjective onto the truth values.

More explicitly:

1. **Continuity**  
   The function

   \[
   f : \mathbb{R} \to \mathrm{Prop}, \qquad f(z) := (z \neq 0)
   \]

   is continuous for Lean’s topology on `Prop`. In that topology, the relevant nontrivial open set is `{True}`. Its preimage under `f` is

   \[
   \{z : \mathbb{R} \mid z \neq 0\},
   \]

   which is open in `ℝ`.

2. **Not monotone**  
   A function `ℝ → Prop` is monotone if whenever `x ≤ y`, truth of `f x` implies truth of `f y`.

   Here that would mean:

   \[
   x \le y \text{ and } x \neq 0 \implies y \neq 0.
   \]

   This is false: take `x = -1` and `y = 0`. We have

   \[
   -1 \le 0,
   \]

   and `-1 ≠ 0`, but `0 ≠ 0` is false.

3. **Surjective onto `Prop`**  
   The predicate attains both truth values:

   * it is `True` at `z = 1`, since `1 ≠ 0`;
   * it is `False` at `z = 0`, since `0 ≠ 0` is false.

   Therefore every truth value in `Prop` is hit.

The auxiliary lemma

```lean
lemma Prop.isOpen_iff (X : Set Prop) :
  IsOpen X ↔ X = ∅ ∨ X = {⊤} ∨ X = Set.univ
```

classifies the open subsets of `Prop` in the topology being used: the only open sets are the empty set, `{True}`, and the whole space. This is then used to prove continuity of the predicate `z ≠ 0`.