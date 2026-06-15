# gpt-5.5 | theorem 12 (Theorem_12.rational_polynomial_coordinates) | meaning | sample 0

*2026-06-14T23:36:09.930466+00:00, 38.59s*

## Response

This file defines two concrete objects and proves that they have the expected ordinary mathematical values.

### Definitions

```lean
def r : ℚ := {
  num := 1,
  den := 2,
  den_nz := by finiteness,
  reduced := by abel
}
```

This defines a rational number `r` by explicitly giving its internal representation:

- numerator `1`,
- denominator `2`,
- proof that the denominator is nonzero,
- proof that the fraction is reduced.

Mathematically, this is just

\[
r = \frac12.
\]

---

```lean
def P : Polynomial ℕ := ⟨{
  support := {2},
  toFun :=
    fun n ↦ match n with
             | .succ (.succ 0) => 2
             | _ => 0,
  mem_support_toFun := by grind
}⟩
```

This defines a polynomial `P` over `ℕ` by giving its coefficient function explicitly.

Its support is `{2}`, and its coefficient function is

\[
a_n =
\begin{cases}
2 & \text{if } n = 2, \\
0 & \text{otherwise}.
\end{cases}
\]

So mathematically,

\[
P = 2X^2 \in \mathbb{N}[X].
\]

---

### Main theorem

```lean
theorem rational_polynomial_coordinates :
  r = 1 / 2
  ∧ P = Polynomial.C 2 * Polynomial.X^2
  ∧ let A := P.1.3 2;
    let B := A.1
    ∃ z, (∀ w, z = w)
        ∧ B z = r.3 := by
```

The theorem proves a conjunction of three facts.

The first two are the meaningful mathematical statements:

1. The rational number `r` is equal to `1 / 2`.

   \[
   r = \frac12.
   \]

2. The polynomial `P` is equal to the monomial polynomial `2 * X^2`.

   \[
   P = 2X^2.
   \]

The third conjunct is mostly about Lean’s internal representation of polynomials and rationals. It accesses internal proof fields:

```lean
let A := P.1.3 2
let B := A.1
∃ z, (∀ w, z = w) ∧ B z = r.3
```

Here:

- `P.1` is the underlying finitely supported function representing the polynomial.
- `P.1.3` is the proof that membership in the support is equivalent to having nonzero coefficient.
- `P.1.3 2` is the specialization of that proof at degree `2`.
- `A.1` is the forward implication: if `2` is in the support, then the coefficient at `2` is nonzero.
- `r.3` is the stored proof that the denominator of `r` is nonzero.

So the third part says that there exists a proof `z` that `2` is in the support of `P`, and this proof behaves trivially/uniquely as a proof object, and the resulting proof that the coefficient of `P` at `2` is nonzero agrees with the proof that the denominator of `r` is nonzero.

That third statement has essentially no ordinary mathematical content; it is about Lean proof objects and implementation details.

### Plain-language mathematical content

The theorem says:

> The explicitly defined rational number `r` is \( \frac12 \), and the explicitly defined polynomial `P` over the natural numbers is \( 2X^2 \).

The remaining conjunct is a technical Lean-internal assertion about proof objects associated with the support of the polynomial and the nonzero denominator proof of the rational.