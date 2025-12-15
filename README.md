# Some Junk Theorems in Lean

This is a small collection of formally verified junk theorems provable in Lean 4 + Mathlib that, in my experience, are quite surprising and upsetting to mathematicians who are not familiar with type theory (and in the case of Theorems 13 and 14, also to mathematicians who are familiar with type theory). [See the main .lean file here.](JunkTheorems.lean)

### Coding

> **Theorem 1.** *The third coordinate of the rational number $`\frac{1}{2}`$ is a bijection.*

> **Theorem 2.**  *The first coordinate of the polynomial $`X^2(X^3 + X + 1)`$ is equal to the prime factorization of $`30`$.*

> **Theorem 3.** *Let $`P`$ be the multivariate polynomial $`(X_0 + X_1 + X_2)^3`$. Let $`Q`$ be the univariate polynomial $`X^2 + X + 1`$. The second coordinate of $`P`$ applied to the first coordinate of $`Q`$ is equal to the natural number $`6`$.*

### Sets and Logic

> **Theorem 4.** *The set $`\{z : \mathbb{R} | z \neq 0\}`$ is a continuous, non-monotone surjection.*

> **Theorem 5.** *The Riemann hypothesis is in the topological closure of the set not not.*

Note though that showing that the Riemann hypothesis is in the topological closure of not will win you a million dollars.

> **Theorem 6.** *The following are equivalent: The binary expansion of $`7`$.*

> **Theorem 7.** *The dot product of not with itself. Moreover, the matrix determinant of or. However, not the determinant of and.*

> **Theorem 8.** *The existential quantifier on the category of groups is a non-measurable set.*

### Partiality

Famously, Lean, like many proof assistants, defines division so that $`\frac{1}{0} = 0`$ and subtraction on the natural numbers so that $`2 - 3 = 0`$. In the first case, this leads to the following theorem (which is already in Mathlib).

> **Theorem 9.** ([`riemannZeta_one`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/NumberTheory/Harmonic/ZetaAsymp.html#riemannZeta_one)) *$`\zeta(1) = \frac{1}{2}(\gamma - \log 4 \pi)`$, where $`\zeta(s)`$ is the Riemann zeta function.*

If we try to avoid the junk theorem $`2 - 3 = 0`$ with the partial subtraction function `psub`, we get the following.

> **Theorem 10.** *Two minus three, where subtraction is understood to be a partial function on $`\mathbb{N}`$, is equal to the extended natural number $`+\infty`$.*

### Equality

In this next theorem, $`\mathsf{QR}`$ stands for quadratic reciprocity and $`\mathsf{BCT}`$ stands for the Baire category theorem.

> **Theorem 11.** *Let $`p`$ be the unique proof of quadratic reciprocity, and let $`q`$ be the unique proof that the Baire category theorem isn't false. The pair $`\langle \mathsf{QR},p\rangle`$ is equal to the pair $`\langle\neg\neg\mathsf{BCT},q\rangle`$ (in the sense of pointed types). Moreover, $`q`$ is a bijection.*

However, one cannot even form the sentence 'The unique proof of quadratic reciprocity is a bijection.' in Lean, because this would be as nonsensical as the sentence 'The natural number $`2`$ is a bijection.'

Similarly, we can build an element $`r`$ of $`\mathbb{Q}`$ and a polynomial $`P`$ with coefficients in $`\mathbb{N}`$, and prove the following.

> **Theorem 12.**
> * *$`r`$ is equal to $`\frac{1}{2}`$.*
> * *$`P`$ is equal to $`2X^2`$.*
> * *Let $`A`$ be the result of applying the third coordinate of the first coordinate of $`P`$ to the natural number $`2`$. Let $`B`$ be the first coordinate of $`A`$. For the unique $`z`$ in the domain of $`B`$, $`B(z)`$ is equal to the third coordinate of $`r`$.*

Given the first two bullets of Theorem 12, it is perhaps surprising that we can't just take $`r`$ to literally be $`\frac{1}{2}`$ and $`P`$ to literally be $`2X^2`$. If we try to do this, Lean will inform us that the resulting proposition does not typecheck. In particular, the last sentence of the statement

* Let $`A`$ be the result of applying the third coordinate of the first coordinate of $`2X^2`$ to the natural number $`2`$. Let $`B`$ be the first coordinate of $`A`$. For the unique $`z`$ in the domain of $`B`$, $`B(z)`$ is equal to the third coordinate of $`\frac{1}{2}`$.'

is completely meaningless, unlike the last sentence of Theorem 12.

Finally, using the axiom of choice (in a meaningful way, mind), we can build three terms $`a`$, $`b`$, and $`c`$ and prove the following:

> **Theorem 13.** *$`a`$ is equal to $`b`$, and $`b`$ is equal to $`c`$.*

This may not seem so strange, but the issue is that if we now consider the obvious corollary $`a = c`$, Lean will tell us that $`a`$ and $`c`$ don't have the same type, so the question of whether $`a`$ is equal to $`c`$ is as absurd as the question of whether the Banach space $`\ell^2`$ is equal to the monster group. (And, yes, $`a`$ and $`b`$ have the same type and $`b`$ and $`c`$ have the same type; there is no type coercion happening here.)

It does make sense to ask whether $`a`$ and $`c`$ are 'heterogeneously equal' (i.e., is it the case that $`\langle A, a \rangle = \langle C, c\rangle`$, where $`A`$ is the type of $`a`$ and $`C`$ is the type of $`c`$?), but it also makes sense to ask whether $`\langle \text{Banach spaces}, \ell^2 \rangle`$ is equal to $`\langle \text{groups}, \text{monster group}\rangle`$ or to ask whether $`\langle\mathsf{Prop},\text{quadratic reciprocity}\rangle`$ is equal to $`\langle \mathsf{Fin} 2, 0 \rangle`$ (where $`\mathsf{Prop}`$ is the type of propositions and $`\mathsf{Fin} 2`$ is the type of natural numbers less than $`2`$). The only formal difference is that, while you can prove $`\langle A, a \rangle = \langle C, c\rangle`$ easily (since equality is transitive, after all), the statements $`\langle \text{Banach spaces}, \ell^2 \rangle = \langle \text{groups}, \text{monster group}\rangle`$ and $`\langle \mathsf{Prop},\text{quadratic reciprocity}\rangle = \langle \mathsf{Fin} 2, 0 \rangle`$ are independent of Lean.

### Beyond Mathlib

This last theorem requires a proof tactic that is (reasonably) banned in Mathlib (i.e., the infamous `native_decide`) as well as an explicit extra axiomatic assumption. (Think of this as being like an exotic counterexample in real analysis that requires $`\mathsf{CH}`$.)

> **Theorem 14.** Assuming axiomatically that $`\mathbb{Z} = \mathbb{N}`$ and that [we trust the Lean compiler](https://leanprover-community.github.io/mathlib4_docs/Init/Core.html#Lean.trustCompiler), the integer $`-1`$ is (heterogeneously) equal to the natural number $`4,294,967,295`$ (i.e., the pair $`\langle \mathbb{Z}, -1\rangle`$ is equal to the pair $`\langle \mathbb{N}, 4,294,967,295\rangle`$).

Note that this is not a vacuous implication. The assumption that $`\mathbb{Z}`$ is equal to $`\mathbb{N}`$ is consistent with Lean.

---

I should clarify some things. Theorems 1-10 (and to some extent Theorem 12) are artifacts of particular definitions made in Mathlib, although the convention that leads to Theorem 9 seems to be considered best practice (classically) for dealing with the fact that division is a partial function. Theorem 11 is not an artifact of particular definitions, but rather follows very directly from the treatment of propositions in type theory. (It's even provable constructively in type theories with propositional extensionality, such as HoTT.)

Theorems 13 and 14 are unique to Lean and arise from some of its design decisions. Theorem 13 relies on definitional proof irrelevance and Lean's computational rules for quotient types, which also lead to the failure of subject reduction. In other proof assistants based on dependent type theory (e.g., Rocq and Agda), judgmental/definitional equality is transitive, so nothing like Theorem 13 can happen, even assuming choice. Theorem 14 relies on low-level implementation details of the Lean compiler (although one might argue that all junk theorems are, at the end of the day, the result of low-level implementation details bubbling up to the surface).

