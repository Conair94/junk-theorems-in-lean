# Some Junk Theorems in Lean

This is a small collection of formally verified junk theorems provable in Lean 4 + Mathlib that, in my experience, are quite surprising and upsetting to mathematicians who are not familiar with type theory (and in the case of Theorem 13, also to mathematicians who are familiar with type theory). [See the main .lean file here.](JunkTheorems.lean)

### Coding

> **Theorem 1.** *The third coordinate of the rational number $`1/2`$ is a bijection.*

> **Theorem 2.** *Let $`P`$ be the polynomial $`X^2(X^3 + X + 1)`$.*
> * *The first coordinate of $`P`$ is equal to the prime factorization of $`30`$.*
> * *Let $`A`$ be the third coordinate of the first coordinate of $`P`$. Fix a natural number $`n`$, and let $`B`$ and $`C`$ be the first and second coordinates of $`A(n)`$, respectively. Then*
>     * *$`C`$ is the inverse of $`B`$ and*
>     * *for any $`z`$ in the domain of $`B`$, $`B(z)`$ is a bijection.*

### Sets and Logic

> **Theorem 3.** *The set $`\{z : \mathbb{R} | z \neq 0\}`$ is a continuous, non-monotone surjection.*

> **Theorem 4.** *The Riemann hypothesis is in the topological closure of the set not not.*

Note though that showing that the Riemann hypothesis is in the topological closure of not will win you a million dollars.

> **Theorem 5.** *The existential quantifier on the category of groups is a nonmeasurable set.*

> **Theorem 6.** *The following are equivalent: The binary expansion of $`7`$.*

> **Theorem 7.** *The dot product of not with itself. Moreover, the matrix determinant of or. However, not the determinant of and.*

### Partiality

> **Theorem 8.** *One divided by zero is equal to zero.*

> **Theorem 9.** ([`riemannZeta_one`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/NumberTheory/Harmonic/ZetaAsymp.html#riemannZeta_one)) *$`\zeta(1) = (\gamma - \log 4 \pi) / 2`$, where $`\zeta(s)`$ is the Riemann zeta function.*

> **Theorem 10.** *Two minus three is equal to zero.*

If we try to avoid this with the partial subtraction function `psub`, we get the following.

> **Theorem 11.** *Two minus three, where subtraction is understood to be a partial function on $`\mathbb{N}`$, is equal to the extended natural number $`+\infty`$.*

### Equality

In this next theorem, $`\mathsf{QR}`$ stands for quadratic reciprocity and $`\mathsf{BCT}`$ stands for the Baire category theorem.

> **Theorem 12.** *Let $`p`$ be the unique proof of quadratic reciprocity, and let $`q`$ be the unique proof that the Baire category theorem isn't false. The pair $`\langle \mathsf{QR},p\rangle`$ is equal to the pair $`\langle\neg\neg\mathsf{BCT},q\rangle`$ (in the sense of pointed types). Moreovoer, $`q`$ is a bijection.*

However, one cannot even form the sentence 'The unique proof of quadratic reciprocity is a bijection.' in Lean, because this would be as nonsensical as the sentence 'The natural number $`2`$ is a bijection.'

Finally, using the axiom of choice (in a meaningful way, mind), we can build three terms $`a`$, $`b`$, and $`c`$ and prove the following:

> **Theorem 13.** *$`a`$ is equal to $`b`$, and $`b`$ is equal to $`c`$.*

This may not seem so strange, but the issue is that if we now consider the obvious corollary $`a = c`$, Lean will tell us that $`a`$ and $`c`$ don't have the same type, so the question of whether $`a`$ is equal to $`c`$ is as absurd as the question of whether the Banach space $`\ell^2`$ is equal to the monster group. (And, yes, $`a`$ and $`b`$ have the same type and $`b`$ and $`c`$ have the same type; there is no type coercion happening here.)

It does make sense to ask whether $`a`$ and $`c`$ are 'heterogeneously equal' (i.e., is it the case that $`\langle A, a \rangle = \langle C, c\rangle`$, where $`A`$ is the type of $`a`$ and $`C`$ is the type of $`c`$?), but it also makes sense to ask whether $`\langle \text{Banach spaces}, \ell^2 \rangle`$ is equal to $`\langle \text{groups}, \text{monster group}\rangle`$ or to ask whether $`\langle\mathsf{Prop},\text{quadratic reciprocity}\rangle`$ is equal to $`\langle \mathsf{Fin} 2, 0 \rangle`$ (where $`\mathsf{Prop}`$ is the type of propositions and $`\mathsf{Fin} 2`$ is the type of natural numbers less than $`2`$). The only formal difference is that, while you can prove $`\langle A, a \rangle = \langle C, c\rangle`$ easily (since equality is transitive, after all), the statements $`\langle \text{Banach spaces}, \ell^2 \rangle = \langle \text{groups}, \text{monster group}\rangle`$ and $`\langle \mathsf{Prop},\text{quadratic reciprocity}\rangle = \langle \mathsf{Fin} 2, 0 \rangle`$ are independent of Lean.

---

I should clarify some things. Theorems 1-11 are artifacts of particular definitions made in Mathlib, although Theorems 8 seems to be considered best practice (classically) for dealing with the fact that division is a partial function (despite the fact that it leads to things like Theorem 9), and Theorem 10 is common in proof assistants. Theorem 12 is not an artifact of particular definitions, but rather follows very directly from the treatment of propositions in type theory. (It's even provable constructively in type theories with propositional extensionality, such as HoTT.) Theorem 13 is unique to Lean and arises from some of its design decisions (i.e., definitional proof irrelevance and its computational rules for quotient types), which also lead to the failure of subject reduction. In other proof assistants based on dependent type theory (e.g., Rocq and Agda), judgmental/definitional equality is transitive, so nothing like Theorem 13 can happen, even assuming choice.
