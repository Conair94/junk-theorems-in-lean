# gpt-5.5 | theorem 3 (polynomials_within_polynomials) | meaning | sample 0

*2026-06-14T23:06:07.439815+00:00, 17.24s*

## Response

This Lean file is proving a very concrete fact about polynomial expansion.

The main theorem is:

```lean
theorem polynomials_within_polynomials :
  ((.X 0 + .X 1 + .X 2)^3 : MvPolynomial _ _).2
    (.X^2 + .X + .C 1 : Polynomial _).1 = 6
```

In plain mathematical language:

> In the multivariable polynomial  
> \[
> (X_0 + X_1 + X_2)^3
> \]
> over the natural numbers, the coefficient of the monomial  
> \[
> X_0 X_1 X_2
> \]
> is \(6\).

The slightly unusual part is how the monomial \(X_0X_1X_2\) is specified. In Mathlib, a monomial of an `MvPolynomial ℕ ℕ` is indexed by a finitely supported function

\[
\mathbb N \to \mathbb N
\]

recording the exponent of each variable. The monomial \(X_0X_1X_2\) corresponds to the exponent vector

\[
0 \mapsto 1,\quad 1 \mapsto 1,\quad 2 \mapsto 1,
\]

and all other variables map to \(0\).

The univariate polynomial

\[
X^2 + X + 1
\]

has exactly the same underlying finitely supported function: coefficients \(1\) at degrees \(0,1,2\), and \(0\) elsewhere. So the theorem uses

```lean
(.X^2 + .X + .C 1 : Polynomial _).1
```

as a way of producing the exponent vector

```lean
Finsupp.single 0 1 + Finsupp.single 1 1 + Finsupp.single 2 1
```

which represents the monomial \(X_0X_1X_2\).

So the theorem says:

\[
[(X_0X_1X_2)](X_0+X_1+X_2)^3 = 6.
\]

This is the familiar multinomial coefficient fact:

\[
(X_0+X_1+X_2)^3
=
X_0^3+X_1^3+X_2^3
+3X_0^2X_1+3X_0^2X_2
+3X_1^2X_0+3X_1^2X_2
+3X_2^2X_0+3X_2^2X_1
+6X_0X_1X_2.
\]

The earlier lemmas `poly_1` through `poly_11` build up the proof by rewriting both the univariate polynomial and the multivariable polynomial into their underlying `Finsupp` representations. The final theorem then evaluates the coefficient function at the exponent vector corresponding to \(X_0X_1X_2\), obtaining \(6\).