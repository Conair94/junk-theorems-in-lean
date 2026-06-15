# gpt-5.5 | theorem 10 (two_minus_three_eq_infty) | meaning | sample 0

*2026-06-14T23:27:41.019745+00:00, 15.77s*

## Response

This Lean file imports several Mathlib modules, but the main relevant one is:

```lean
import Mathlib.Data.Nat.PSub
```

which defines partial subtraction on natural numbers.

The theorem is:

```lean
theorem two_minus_three_eq_infty : (2).psub 3 = (⊤ : ℕ∞) := rfl
```

In Lean, `ℕ∞` denotes the natural numbers extended with a top element `⊤`, often thought of as “infinity.” The operation `.psub` is a form of partial subtraction: for natural numbers `a` and `b`, `a.psub b` returns the usual difference `a - b` when `b ≤ a`, but returns `⊤` when the subtraction would go below zero.

So `(2).psub 3` means “subtract 3 from 2 using partial subtraction.” Since `3 > 2`, the result is undefined as a natural number, and Mathlib represents that failure as `⊤ : ℕ∞`.

The proof is:

```lean
:= rfl
```

meaning the statement holds by definitional equality: after unfolding the definition of `psub`, Lean computes both sides to the same expression.

Mathematically, the theorem says:

> In partial subtraction on natural numbers, `2 - 3` is not a natural number, so its value is the distinguished infinity/top element `⊤` in `ℕ∞`.

Equivalently:

> Since one cannot subtract `3` from `2` within the natural numbers, `2.psub 3` is defined to be `∞`.