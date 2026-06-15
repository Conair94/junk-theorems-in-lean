# gpt-5.5 | theorem 2 (polynomial_factorization_30) | meaning | sample 1

*2026-06-14T23:02:13.006998+00:00, 14.68s*

## Response

This Lean theorem is comparing two finitely supported functions `ℕ →₀ ℕ`.

The left-hand side

```lean
(Polynomial.X^2 * (Polynomial.X^3 + Polynomial.X + 1)).1
```

is the underlying finitely supported coefficient function of the polynomial

\[
X^2(X^3 + X + 1) \in \mathbb N[X].
\]

Since

\[
X^2(X^3 + X + 1) = X^5 + X^3 + X^2,
\]

its coefficient function is:

\[
n \mapsto
\begin{cases}
1 & n = 2,3,5,\\
0 & \text{otherwise}.
\end{cases}
\]

The right-hand side

```lean
(30).factorization
```

is `Nat.factorization 30`, the finitely supported function giving the exponents in the prime factorization of `30`. Since

\[
30 = 2 \cdot 3 \cdot 5,
\]

this function is also:

\[
n \mapsto
\begin{cases}
1 & n = 2,3,5,\\
0 & \text{otherwise}.
\end{cases}
\]

So the theorem proves that the coefficient function of the polynomial

\[
X^2(X^3 + X + 1)
\]

is exactly the same as the prime factorization function of `30`.

In plain mathematical language:

> The polynomial \(X^2(X^3 + X + 1) = X^2 + X^3 + X^5\) has coefficients encoding the prime factorization of \(30 = 2 \cdot 3 \cdot 5\): it has coefficient `1` in degrees `2`, `3`, and `5`, and coefficient `0` elsewhere.