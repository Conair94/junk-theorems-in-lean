# deepseek-chat | theorem 9 (riemannZeta_one') | meaning | sample 1

*2026-06-14T22:58:16.195359+00:00, 7.47s*

## Response

This file defines a theorem in Lean 4 about the Riemann zeta function at `1`. Let's break it down.

The theorem in question is:

```lean4
theorem riemannZeta_one' :
    riemannZeta 1 = (Real.eulerMascheroniConstant - Complex.log (4 * Real.pi)) / 2 :=
  riemannZeta_one
```

### What the code means

- **`riemannZeta`**: This is the complex Riemann zeta function `ζ(s)`, defined in Mathlib's `NumberTheory` folder for complex arguments.
- **`riemannZeta 1`**: This is ζ(1). Mathematically, ζ(1) is the harmonic series, which diverges to infinity. However, in complex analysis the Riemann zeta function has a simple pole at `s = 1` with residue 1.
- **`Real.eulerMascheroniConstant`**: This is γ, the Euler–Mascheroni constant (≈ 0.5772).
- **`Complex.log (4 * Real.pi)`**: The natural logarithm of `4π`.
- **The equation**:  
  ζ(1) = (γ - log(4π)) / 2

The proof is given as `riemannZeta_one`, which means this is simply a re‑statement or a notation variant of an earlier theorem already present in Mathlib called `riemannZeta_one`.

### Mathematical content in plain language

The theorem asserts:

> The value of the Riemann zeta function at s = 1, when interpreted using the analytic continuation (i.e., taking the finite part / constant term in the Laurent expansion), equals (γ - ln(4π)) / 2.

However, there is an important nuance: ζ(s) has a pole at s = 1, so ζ(1) is not a finite complex number. In contexts where this theorem is stated, `riemannZeta 1` should be understood as the constant term in the Laurent expansion of ζ(s) about s = 1 (the so-called "regularized value" or "zeta-regularized product"), not the naive divergent sum. More precisely, the expansion is:

\[
\zeta(s) = \frac{1}{s-1} + \gamma - \ln(2\pi) + O(s-1)
\]

But some conventions, particularly in number theory, write the constant term as:

\[
\zeta(1)_{\text{finite}} = \gamma - \frac{\ln(4\pi)}{2}
\]

This matches the theorem if you compare it to the more common expansion (since `- ln(2π) = - (ln(4π) / 2)` when factoring differently). Actually a direct check:  
The more standard Laurent expansion is:

\[
\zeta(s) = \frac{1}{s-1} + \gamma - \ln(2\pi) + \cdots
\]

But here the constant term is `(γ - ln(4π))/2`. The two forms would be equivalent if the definition of «riemannZeta» in Lean uses a different normalization or is computing something akin to the "completed zeta function" or a finite part regularization.  

In any case, the theorem is stating a finite value obtained from the analytic continuation of ζ, giving an explicit expression in terms of γ and π.