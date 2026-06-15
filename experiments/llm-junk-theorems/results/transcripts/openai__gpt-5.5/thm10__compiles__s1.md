# gpt-5.5 | theorem 10 (two_minus_three_eq_infty) | compiles | sample 1

*2026-06-14T23:27:16.909493+00:00, 68.47s*

## Response

Yes. In current Mathlib, `Mathlib.Data.Nat.PSub` defines `Nat.psub : ℕ → ℕ → ℕ∞`, a partial subtraction on naturals returning `⊤` when the subtraction would be negative.

The expression

```lean
(2).psub 3
```

elaborates as

```lean
Nat.psub 2 3
```

with result type `ℕ∞`. By the recursive definition of `Nat.psub`, this reduces definitionally:

```lean
2.psub 3 = 1.psub 2 = 0.psub 1 = ⊤
```

So the equality is true by reflexivity, and `rfl` proves it.

VERDICT: COMPILES