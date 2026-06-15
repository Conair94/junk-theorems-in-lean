# gpt-5.5 | theorem 4 (set_of_nonzero_reals_is_continuous_nonmono_surjection) | meaning | sample 2

*2026-06-14T23:11:33.504372+00:00, 19.6s*

## Response

The Lean file treats the set

\[
\{z : \mathbb R \mid z \ne 0\}
\]

as a function

\[
\mathbb R \to \mathrm{Prop},
\qquad
z \mapsto (z \ne 0).
\]

In Lean, a `Set ℝ` is definitionally a predicate `ℝ → Prop`, so this set can also be viewed as a map from real numbers to propositions.

The auxiliary lemma

```lean
lemma Prop.isOpen_iff (X : Set Prop) :
  IsOpen X ↔ X = ∅ ∨ X = {⊤} ∨ X = Set.univ
```

says that the open subsets of `Prop` are exactly

\[
\varnothing,\quad \{\text{True}\},\quad \mathrm{Prop}.
\]

So `Prop` is being regarded with the Sierpiński topology: `{True}` is open, but `{False}` is not.

The main theorem is:

```lean
theorem set_of_nonzero_reals_is_continuous_nonmono_surjection :
       Continuous {z : ℝ | z ≠ 0}
    ∧ ¬Monotone {z : ℝ | z ≠ 0}
    ∧  Function.Surjective {z : ℝ | z ≠ 0}
```

Mathematically, this says:

> The predicate \(z \mapsto (z \ne 0)\), viewed as a function \(\mathbb R \to \mathrm{Prop}\), is continuous, not monotone, and surjective.

More explicitly:

1. **Continuity**:  
   The map

   \[
   f : \mathbb R \to \mathrm{Prop}, \qquad f(z) = (z \ne 0)
   \]

   is continuous when `Prop` has the Sierpiński topology. The only nontrivial open set to check is `{True}`, whose preimage is

   \[
   f^{-1}(\{\text{True}\}) = \mathbb R \setminus \{0\},
   \]

   which is open in \(\mathbb R\).

2. **Not monotone**:  
   With the usual order on \(\mathbb R\) and the logical order on propositions, where \(P \le Q\) means \(P \to Q\), the function is not monotone. Indeed,

   \[
   -1 \le 0,
   \]

   but

   \[
   f(-1) = \text{True}, \qquad f(0) = \text{False}.
   \]

   So monotonicity would imply `True → False`, a contradiction.

3. **Surjective**:  
   The function hits both truth values in `Prop`:

   \[
   f(1) = \text{True}
   \]

   because \(1 \ne 0\), and

   \[
   f(0) = \text{False}
   \]

   because \(0 \ne 0\) is false.

So in plain language, the theorem proves:

> The subset of nonzero real numbers, regarded as its characteristic predicate \(\mathbb R \to \mathrm{Prop}\), is a continuous surjective map to `Prop` with the Sierpiński topology, but it is not monotone.