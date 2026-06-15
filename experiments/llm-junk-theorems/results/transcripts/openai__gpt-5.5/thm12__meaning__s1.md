# gpt-5.5 | theorem 12 (Theorem_12.rational_polynomial_coordinates) | meaning | sample 1

*2026-06-14T23:36:30.540849+00:00, 26.48s*

## Response

This Lean file defines two objects inside the namespace `Theorem_12`:

1. A rational number

```lean
def r : ℚ := {
  num := 1,
  den := 2,
  den_nz := by finiteness,
  reduced := by abel
}
```

This is the rational number whose numerator is `1` and denominator is `2`, with proofs that the denominator is nonzero and that the fraction is reduced. Mathematically, this is just

\[
r = \frac12.
\]

2. A polynomial over `ℕ`

```lean
def P : Polynomial ℕ := ...
```

This polynomial has coefficient `2` at degree `2` and coefficient `0` everywhere else. So mathematically,

\[
P(X) = 2X^2.
\]

The main theorem is:

```lean
theorem rational_polynomial_coordinates :
  r = 1 / 2
  ∧ P = Polynomial.C 2 * Polynomial.X^2
  ∧ let A := P.1.3 2;
    let B := A.1
    ∃ z, (∀ w, z = w) ∧ B z = r.3 := by
  ...
```

In plain mathematical language, the theorem proves:

> The rational number `r` is equal to \(1/2\), and the polynomial `P` is equal to \(2X^2\). Additionally, a certain internal Lean proof object witnessing that the coefficient of `P` at degree `2` is nonzero can be chosen so that it agrees, by proof irrelevance, with the proof that the denominator of `r` is nonzero.

The first two parts are the real mathematical content:

\[
r = \frac12
\]

and

\[
P = 2X^2.
\]

The third part is not really ordinary mathematical content. It talks about Lean’s internal representation of finite-support functions and proof terms. Roughly, `P.1.3 2` is the proof that degree `2` belongs to the support of `P` exactly when the coefficient at degree `2` is nonzero. Its forward direction gives a proof that the coefficient at degree `2` is nonzero. Since that coefficient is `2`, this is a proof of

\[
2 \neq 0.
\]

The denominator of `r` is also `2`, so `r.3` is likewise a proof of

\[
2 \neq 0.
\]

Lean’s proof irrelevance principle says all proofs of the same proposition are equal, so the theorem can assert equality between these proof objects.

So the main theorem is essentially:

> The explicitly defined rational number is \(1/2\), and the explicitly defined polynomial over the natural numbers is \(2X^2\). The remaining conjunct is a Lean-internal proof-object statement with no substantial mathematical content beyond proof irrelevance.