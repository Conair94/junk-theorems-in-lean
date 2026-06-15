# gpt-5.5 | theorem 2 (polynomial_factorization_30) | meaning | sample 2

*2026-06-14T23:02:27.682569+00:00, 16.43s*

## Response

This Lean theorem proves a small identity between:

1. the coefficient function of a polynomial over `ℕ`, and  
2. the prime factorization of the natural number `30`.

The theorem is:

```lean
theorem polynomial_factorization_30 :
    (Polynomial.X^2 * (Polynomial.X^3 + Polynomial.X + 1)).1 = (30).factorization := by
```

In plain mathematical language, it says:

> The polynomial  
> \[
> X^2(X^3 + X + 1)
> \]
> has nonzero coefficients exactly in degrees \(2\), \(3\), and \(5\), each with coefficient \(1\). This coefficient data is the same as the prime factorization data of \(30\), namely  
> \[
> 30 = 2 \cdot 3 \cdot 5.
> \]

More explicitly,

\[
X^2(X^3 + X + 1) = X^5 + X^3 + X^2.
\]

So its coefficient function is

\[
\{2 \mapsto 1,\; 3 \mapsto 1,\; 5 \mapsto 1\}.
\]

On the other hand,

\[
30 = 2^1 3^1 5^1,
\]

so `Nat.factorization 30` is also the finitely supported function

\[
\{2 \mapsto 1,\; 3 \mapsto 1,\; 5 \mapsto 1\}.
\]

Thus the theorem proves that these two finitely supported functions are equal.

A slightly more literal statement is:

> For every natural number \(n\), the coefficient of \(X^n\) in \(X^2(X^3 + X + 1)\) is equal to the exponent of \(n\) in the prime factorization of \(30\).

Of course, the only nonzero values occur at \(n = 2, 3, 5\), where the value is \(1\).