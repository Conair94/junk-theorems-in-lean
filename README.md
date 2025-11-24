# Some Junk Theorems in Lean

This is a small collection of formally verified junk theorems provable in Lean 4 + Mathlib that, in my experience, are quite surprising and upsetting to mathematicians who are not familiar with type theory.

> **Theorem 1.** *The set $`\{z : \mathbb{R} | z \neq 0\}`$ is a surjection.*

> **Theorem 2.** *One divided by zero is equal to zero.*

> **Theorem 3.** *$`\zeta(1) = (\gamma - \log 4 \pi) / 2`$, where $`\zeta(s)`$ is the Riemann zeta function.*

In the following theorem, $`\div`$ is the partial division function on $`\mathbb{R}`$ defined using Lean's partial function monad `PFun` (which would be the standard way to avoid $`1/0 = 0`$).

> **Theorem 4.** *For any real numbers $`x`$ and $`y`$ (including $`0`$), there are $`a`$ and $`b`$ such that $`x \div y`$ is equal to the pair $`\langle \neg a, b\rangle`$, where every element of $`\neg a`$ is a bijection and $`b`$ is a proper injection.*

In the following theorem, $`\mathsf{QR}`$ stands for quadratic reciprocity, $`\mathsf{BCT}`$ stands for the Baire category theorem, and $`\mathsf{SAFT}`$ stands for the special adjoint functor theorem.

> **Theorem 5.** *The unique proof $`p`$ of quadratic reciprocity satisfies the following: There exists a bijection $`q`$ from the Baire category theorem to the special adjoint functor theorem such that the pair $`\langle \mathsf{QR},p\rangle`$ is equal to the pair $`\langle \mathsf{BCT} \to \mathsf{SAFT},q\rangle`$.*

> **Theorem 6.** *The unique proof that quadratic reciprocity isn't false is a bijection.*

And in particular, despite the fact that $`\mathsf{QR} = \neg\neg \mathsf{QR}`$ and $`\langle \mathsf{QR},p\rangle = \langle\neg\neg\mathsf{QR},q\rangle`$ are both provable (where $`p`$ is the unique proof of $`\mathsf{QR}`$ and $`q`$ is the unique proof of $`\neg\neg \mathsf{QR}`$), one cannot even form the sentence 'The unique proof of quadratic reciprocity is a bijection.' in Lean, because this would be as absurd as the sentence 'The natural number $`2`$ is a bijection.'

Finally, using the axiom of choice (in an essential way, mind), we can build three terms $`a`$, $`b`$, and $`c`$ and prove the following:

> **Theorem 7.** *$`a`$ is equal to $`b`$, and $`b`$ is equal to $`c`$.*

Now this may not seem so strange, but the issue is that the terms $`a`$ and $`c`$ do not have the same type, so, again, the question of whether $`a`$ is equal to $`c`$ is as absurd as the question of whether the Banach space $`\ell^2`$ is equal to the monster group. It does make sense to ask whether they're 'heterogeneously equal' (i.e., if $`A`$ is the type of $`a`$ and $`C`$ is the type of $`c`$, then is it the case that $`\langle A, a \rangle = \langle C, c\rangle`$?), but it also makes sense to ask whether $`\langle \text{Banach spaces}, \ell^2 \rangle`$ is equal to $`\langle \text{groups}, \text{monster group}\rangle`$. The only formal difference is that, while you can prove $`\langle A, a \rangle = \langle C, c\rangle`$, $`\langle \text{Banach spaces}, \ell^2 \rangle = \langle \text{groups}, \text{monster group}\rangle`$ is independent of Lean.

[See the main .lean file here.](JunkTheorems.lean)
