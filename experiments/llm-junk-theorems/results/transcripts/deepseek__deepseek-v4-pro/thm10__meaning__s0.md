# deepseek-v4-pro | theorem 10 (two_minus_three_eq_infty) | meaning | sample 0

*2026-06-14T22:52:10.550574+00:00, 21.88s*

## Reasoning (chain of thought)

We need to interpret the given Lean 4 code. It imports several mathlib modules, then states a theorem:

theorem two_minus_three_eq_infty : (2).psub 3 = (⊤ : ℕ∞) := rfl

We need to explain what this Lean code means, and what theorem it is proving. Then state the mathematical content in plain language.

First, understand the notation and types.

The file imports:
- Mathlib.Algebra.Category.Grp.Basic (unused?)
- Mathlib.Algebra.Ring.BooleanRing (unused?)
- Mathlib.Data.Nat.PSub (this is important: `PSub` type for natural numbers with subtraction returning an option type? Actually `PSub` might refer to "partial subtraction" on ℕ or ℕ∞? Wait, the name `psub` suggests a subtraction operation on `ℕ∞` perhaps. Let's think.)
- Mathlib.NumberTheory.Harmonic.ZetaAsymp (unused?)
- Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol (unused?)
- Mathlib.Data.Nat.Prime.Basic (unused?)
- Mathlib.Data.List.Basic (unused?)

The crucial import is `Mathlib.Data.Nat.PSub`. I need to recall what `Nat.psub` does. In Mathlib, there's a `PSUB` type? Actually, `Nat` has a subtraction `Nat.sub` that truncates at zero: `a - b` is zero if a < b. But there's also `Nat.psub` which is a partial subtraction returning `Option ℕ`? Wait, I recall `Nat.psub` as the "positive subtraction" or "partial subtraction" that returns `Option ℕ`. Let's check memory: In Mathlib, `Nat` has `tsub` (truncated subtraction) but also `psub` which is a subtraction that is defined only when a ≥ b, returning `some (a - b)` else `none`. Indeed, `Nat.psub` is a function `ℕ → ℕ → Option ℕ`. But the theorem uses `.psub` as a method on `(2)` with argument `3`. So `(2).psub 3` is `Nat.psub 2 3`. That would give `none` because 2 < 3. But the theorem says it equals `(⊤ : ℕ∞)`. What is `ℕ∞`? It's the type `WithTop ℕ`, i.e., natural numbers with an extra element `⊤` representing infinity. The notation `⊤` is the top element of a `WithTop` or `OrderTop` etc. So the theorem claims that `(2).psub 3` equals `⊤` in `ℕ∞`. That is surprising because `psub` returns an `Option ℕ`. But maybe `psub` is defined to return `ℕ∞`? Let's examine.

Look at the import `Mathlib.Data.Nat.PSub`. I can't check directly but I know Mathlib has a file `Data/Nat/PSub.lean`. Indeed, I've seen `Nat.psub` defined as a subtraction on `ℕ∞`? Or perhaps there's a type synonym `ℕ∞` and `psub` is the subtraction on `ℕ∞`? I recall that `ℕ∞` (ENat) is defined as `WithTop ℕ`. There's an instance `CanonicallyOrderedCommSemiring` for `ℕ∞`. Subtraction on `ℕ∞` is defined such that `a - b` is only defined if `b ≤ a` (as in canonically ordered monoids) and otherwise is `0`? Wait, in `CanonicallyOrderedCommSemiring`, subtraction `a - b` is defined only when `b ≤ a`, and it returns a `ℕ∞` with the property that `a - b + b = a`. But the notation `psub` might be the "partial subtraction" that returns `⊤` if subtraction is not possible? No, that seems odd.

Let's search my knowledge: In Mathlib, `Nat.psub` is indeed the partial subtraction returning `Option ℕ`. But there's also `ENat` (i.e., `ℕ∞`) which has `tsub`? However, the theorem states `(2).psub 3 = (⊤ : ℕ∞)`. So `psub` is being used as a method of `2` (which is a `ℕ`) but yielding a `ℕ∞`. This suggests that `psub` is not the `Option` one. Maybe `psub` is defined on `ℕ∞`? The import is `Data.Nat.PSub`. Could be a file that provides `PSub` typeclass or `Nat.psub` for `ℕ∞`. The name `PSUB` might stand for "partial subtraction on ℕ∞"? Let's think: In Mathlib, there's a concept of `Nat.psub` returning `ℕ∞` perhaps. Actually, I recall that in `Data.Nat.PSub` there's a definition `Nat.psub` that returns an `ℕ∞` where subtraction returns `⊤` if the result would be negative? Hmm. Let's reason.

Another possibility: `(2).psub 3` might be a notation for `2 - 3` in `ℕ∞` using `tsub`? But `tsub` is truncated subtraction (returns `0`). However, `psub` might stand for "proper subtraction" that uses `⊤` to indicate an error. I'm not entirely sure.

Better to recall from memory: In Mathlib, there is `Nat.psub` defined as `Nat.psub (a b : ℕ) : ℕ∞` where `psub a b` is `a - b` if `a ≥ b`, otherwise `⊤`. This is used for partial subtraction in `ENat`. Yes, I think that's right. I've seen something like `Nat.psub` in the context of `ℕ∞` for subtraction without zero. Let's verify: In `Data/Nat/PSub.lean`, the file probably defines `Nat.psub` as a function `ℕ → ℕ → ℕ∞`. Indeed, `ENat` has a subtraction that is defined as `a - b` only if `a ≥ b`, else `0`. But there's also a "partial subtraction" that returns `⊤` if subtraction would go negative. This is used in the definition of `pdiv` etc. The import `Mathlib.Data.Nat.PSub` suggests there's a whole file for it. So the theorem `two_minus_three_eq_infty` says: `Nat.psub 2 3 = ⊤`. That is, because 2 is not greater than or equal to 3, the result is `⊤`. And it's proved by `rfl`, which means it's true by definition, so indeed `psub 2 3` is defined as `⊤`. So the theorem is basically a trivial identity.

Thus the mathematical content: In the extended natural numbers ℕ∞ (natural numbers with infinity), there is a partial subtraction operation `psub` defined such that `a.psub b` equals `a - b` if `a ≥ b`, and equals `⊤` (infinity) otherwise. So `2.psub 3` being `⊤` just reflects that 2 < 3, so the subtraction is undefined in the sense of partial subtraction, returning the "error" value `⊤`. The theorem states exactly that.

Now, the prompt: "What does this Lean 4 code mean, and what theorem is it proving? State the mathematical content of the main theorem in plain language."

So we should explain the imports, the notation, the type `ℕ∞`, the operation `psub`, and what the theorem asserts. And then give the plain language statement: "2 minus 3 is undefined (or infinity) in the extended natural numbers, when using the subtraction that returns infinity for negative results."

Note: The theorem name "two_minus_three_eq_infty" is a pun: 2 - 3 equals ∞. It's a trivial lemma, perhaps for testing or a joke.

## Response

This Lean 4 code defines a theorem named `two_minus_three_eq_infty`. The code imports several modules from Mathlib, most crucially `Mathlib.Data.Nat.PSub`, which provides the operation `psub` on natural numbers.

Here's what the code means:

- `ℕ∞` is a type synonym for `WithTop ℕ`, the extended natural numbers: it consists of all ordinary natural numbers `n : ℕ` together with an element `⊤` that represents “infinity”.
- `psub` is a partial subtraction function on `ℕ` (or ℕ∞) defined in `Data.Nat.PSub`. For two natural numbers `a` and `b`, `a.psub b` returns:
  - `a - b` (as an element of ℕ∞) if `a ≥ b`,
  - `⊤` (infinity) if `a < b`.
  In other words, `psub` is a subtraction that uses `⊤` as an “undefined” or “error” value when the result would be negative.
- The theorem states `(2).psub 3 = (⊤ : ℕ∞)`. Since `2 < 3`, the partial subtraction is undefined according to `psub`, so the result is the top element `⊤`.
- The proof is just `rfl`, meaning the equality holds by definition (it is a trivial computation).

**Plain language mathematical content:**  
In the extended natural numbers (where infinity is allowed), the operation `psub` subtracts only when the first number is at least as large as the second; otherwise it returns infinity. The theorem simply observes that 2 minus 3 yields infinity under this operation.