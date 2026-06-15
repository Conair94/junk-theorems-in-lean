# deepseek-chat | theorem 9 (riemannZeta_one') | meaning | sample 2

*2026-06-14T22:58:16.296296+00:00, 6.24s*

## Response

This Lean code is proving a (non-)theorem about the Riemann zeta function at the special value `s = 1`.  

Let me break it down:

1. **Imports:** The file imports a variety of Mathlib modules, including categories, boolean rings, number theory (zeta, Legendre/Jacobi symbols), and basic list and prime theory. Most are irrelevant to the main theorem; the key one is `Mathlib.NumberTheory.Harmonic.ZetaAsymp`, which presumably defines `riemannZeta`.

2. **The theorem:**  
   ```lean
   theorem riemannZeta_one' :
       riemannZeta 1 = (Real.eulerMascheroniConstant - Complex.log (4 * Real.pi)) / 2 :=
     riemannZeta_one
   ```
   This states that the value of the Riemann zeta function at `1` equals  
   \[
   \frac{\gamma - \log(4\pi)}{2}
   \]
   where \(\gamma\) is the Euler–Mascheroni constant and the log is the complex logarithm.  
   The proof simply refers to an existing theorem called `riemannZeta_one`.

3. **Mathematical meaning / what's actually happening:**  
   The Riemann zeta function \(\zeta(s)\) has a **simple pole** at \(s = 1\) with residue 1. That means it's not defined as a finite complex number at \(s=1\); the value \(\zeta(1)\) is infinite in the usual sense.  

   However, one can define a **regularized** or **finite part** of \(\zeta(s)\) at \(s=1\) by considering the expansion:
   \[
   \zeta(s) = \frac{1}{s-1} + \gamma + O(s-1)
   \]
   The constant term in this expansion is the Euler–Mascheroni constant \(\gamma\), not \(\frac{\gamma - \log(4\pi)}{2}\).

   The expression shown here actually corresponds to a different function: it's the value of the **derivative** of the Riemann zeta function at zero (or related to the functional equation), not \(\zeta(1)\).

**Conclusion:**  
The theorem as stated is mathematically false if `riemannZeta` is the usual Riemann zeta function. It likely relies on a nonstandard definition of `riemannZeta` inside Mathlib—possibly one that has been analytically continued and normalized differently. In plain language, the code claims:

> "The Riemann zeta function at 1 equals half of Euler's constant minus the natural logarithm of \(4\pi\)."

But this does not correspond to the standard mathematical fact about \(\zeta(1)\), which is undefined (has a pole).