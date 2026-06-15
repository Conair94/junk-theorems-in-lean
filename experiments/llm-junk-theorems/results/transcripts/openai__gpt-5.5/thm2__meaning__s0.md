# gpt-5.5 | theorem 2 (polynomial_factorization_30) | meaning | sample 0

*2026-06-14T23:01:56.855750+00:00, 16.15s*

## Response

This Lean theorem proves that the polynomial

\[
X^2 (X^3 + X + 1)
\]

over `ℕ` has coefficient support exactly matching the prime factorization of `30`.

More explicitly,

\[
X^2 (X^3 + X + 1) = X^5 + X^3 + X^2,
\]

so its coefficients are `1` in degrees `2`, `3`, and `5`, and `0` elsewhere.

On the other hand,

\[
30 = 2 \cdot 3 \cdot 5,
\]

so the prime factorization of `30` is also the finitely supported function sending

\[
2 \mapsto 1,\quad 3 \mapsto 1,\quad 5 \mapsto 1,
\]

and every other natural number to `0`.

The theorem statement is:

```lean
theorem polynomial_factorization_30 :
    (Polynomial.X^2 * (Polynomial.X^3 + Polynomial.X + 1)).1 = (30).factorization
```

Here:

- `Polynomial.X` is the polynomial variable `X`.
- `.1` extracts the underlying finitely supported coefficient function of the polynomial.
- `(30).factorization` is the finitely supported function recording the prime exponents in the prime factorization of `30`.

So in plain mathematical language, the theorem says:

> The coefficient function of the polynomial \(X^2(X^3 + X + 1)\) over the natural numbers is equal to the prime factorization function of \(30\). Equivalently, both are the finitely supported function with value `1` at `2`, `3`, and `5`, and value `0` elsewhere.

It is not proving a usual factorization of a polynomial. Rather, it observes that the monomial degrees appearing in the polynomial are exactly the prime factors of `30`.