# Some Junk Theorems in Lean

This is a small collection of formally verified junk theorems provable in Lean 4 + Mathlib that, in my experience, are quite surprising and upsetting to mathematicians who are not familiar with type theory. [See the main .lean file here.](JunkTheorems.lean)

> **Theorem 1.** *The set $`\{z : \mathbb{R} | z \neq 0\}`$ is a surjection.*

> **Theorem 2.** *One divided by zero is equal to zero.*

> **Theorem 3.** *$`\zeta(1) = (\gamma - \log 4 \pi) / 2`$, where $`\zeta(s)`$ is the Riemann zeta function.*

In the following theorem, $`\div`$ is the partial division function on $`\mathbb{R}`$ defined using Lean's partial function monad `PFun` (which would be the standard way to avoid $`1/0 = 0`$).

> **Theorem 4.** *For any real numbers $`x`$ and $`y`$ (including $`0`$), there are $`a`$ and $`b`$ such that $`x \div y`$ is equal to the pair $`\langle \neg a, b\rangle`$, where every element of $`\neg a`$ is a bijection and $`b`$ is a proper injection.*

In the following theorem, $`\mathsf{QR}`$ stands for quadratic reciprocity, $`\mathsf{BCT}`$ stands for the Baire category theorem, and $`\mathsf{SAFT}`$ stands for the special adjoint functor theorem.

> **Theorem 5.** *The unique proof $`p`$ of quadratic reciprocity satisfies the following: There exists a bijection $`q`$ from the Baire category theorem to the special adjoint functor theorem such that the pair $`\langle \mathsf{QR},p\rangle`$ is equal to the pair $`\langle \mathsf{BCT} \to \mathsf{SAFT},q\rangle`$.*

> **Theorem 6.** *The unique proof that quadratic reciprocity isn't false is a bijection.*

And in particular, despite the fact that $`\mathsf{QR} = \neg\neg \mathsf{QR}`$ and $`\langle \mathsf{QR},p\rangle = \langle\neg\neg\mathsf{QR},q\rangle`$ are both provable (where $`p`$ is the unique proof of $`\mathsf{QR}`$ and $`q`$ is the unique proof of $`\neg\neg \mathsf{QR}`$), one cannot even form the sentence 'The unique proof of quadratic reciprocity is a bijection.' in Lean, because this would be as nonsensical as the sentence 'The natural number $`2`$ is a bijection.' and type theory is all about avoiding mathematical nonsense.

Finally, using the axiom of choice (in an essential way, mind), we can build three terms $`a`$, $`b`$, and $`c`$ and prove the following:

> **Theorem 7.** *$`a`$ is equal to $`b`$, and $`b`$ is equal to $`c`$.*

Now this may not seem so strange, but the issue is that the terms $`a`$ and $`c`$ do not have the same type, so the question of whether $`a`$ is equal to $`c`$ is as absurd as the question of whether the Banach space $`\ell^2`$ is equal to the monster group. It does make sense to ask whether they're 'heterogeneously equal' (i.e., is it the case that $`\langle A, a \rangle = \langle C, c\rangle`$, where $`A`$ is the type of $`a`$ and $`C`$ is the type of $`c`$?), but it also makes sense to ask whether $`\langle \text{Banach spaces}, \ell^2 \rangle`$ is equal to $`\langle \text{groups}, \text{monster group}\rangle`$ or to ask whether $`\langle\mathsf{Prop},\mathsf{QR}\rangle`$ is equal to $`\langle \mathsf{Fin} 2, 0 \rangle`$ (where $`\mathsf{Prop}`$ is the type of propositions and $`\mathsf{Fin} 2`$ is the type of natural numbers less than $`2`$). The only formal difference is that, while you can prove $`\langle A, a \rangle = \langle C, c\rangle`$, the statements $`\langle \text{Banach spaces}, \ell^2 \rangle = \langle \text{groups}, \text{monster group}\rangle`$ and $`\langle \mathsf{Prop}, \mathsf{QR}\rangle = \langle \mathsf{Fin} 2, 0 \rangle`$ are independent of Lean.

---

I should clarify some things. Theorems 1-4 are artifacts of particular definitions made in Mathlib, although Theorem 2 seems to be considered best practice for dealing with the fact that division is not a partial function and avoiding something like Theorem 4 with a `PFun`-style monad (as opposed to a `maybe`/`option`-style monad) seems difficult. Theorems 5 and 6 are not artifacts of particular definitions, but rather follow very directly from the treatment of propositions in type theory. (They're even provable constructively in type theories with propositional extensionality, such as HoTT.) Theorem 7 is unique to Lean and arise from some of its design decisions (i.e., definitional proof irrelevance and its treatment of quotient types). In other proof assistants based on dependent type theory (e.g., Rocq and Agda), judgmental/definitional equality is transitive, so nothing like Theorem 7 can happen.
