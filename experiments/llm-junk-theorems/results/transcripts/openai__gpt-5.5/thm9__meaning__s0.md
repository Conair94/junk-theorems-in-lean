# gpt-5.5 | theorem 9 (riemannZeta_one') | meaning | sample 0

*2026-06-14T23:26:09.928459+00:00, 91.09s*

## Response

This Lean file imports several Mathlib modules and then declares a theorem:

```lean
theorem riemannZeta_one' :
    riemannZeta 1 = (Real.eulerMascheroniConstant - Complex.log (4 * Real.pi)) / 2 :=
  riemannZeta_one
```

It defines a new theorem named `riemannZeta_one'`. The proof is simply the existing Mathlib theorem `riemannZeta_one`, so this theorem is just a renamed/restated version of a theorem already available from the imports.

In plain mathematical language, the theorem says:

> The value of Mathlib’s `riemannZeta` function at `1` is
> \[
> \frac{\gamma - \log(4\pi)}{2},
> \]
> where \(\gamma\) is the Euler–Mascheroni constant and \(\log\) is the complex logarithm.

Since \(4\pi > 0\), the complex logarithm here agrees with the usual real natural logarithm, so the right-hand side is the real number

\[
\frac{\gamma - \ln(4\pi)}{2}.
\]

A caveat: this should not be interpreted as saying that the classical Dirichlet series

\[
\sum_{n=1}^{\infty} \frac{1}{n^s}
\]

converges at \(s = 1\). The usual Riemann zeta function has a pole at \(s = 1\). The theorem is about Mathlib’s particular definition/normalization of `riemannZeta` at that point, and the code proves the value assigned there by invoking the existing theorem `riemannZeta_one`.