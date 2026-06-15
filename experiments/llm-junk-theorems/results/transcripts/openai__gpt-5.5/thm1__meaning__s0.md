# gpt-5.5 | theorem 1 (one_half_third_coord_is_bijection) | meaning | sample 0

*2026-06-14T22:59:20.072607+00:00, 57.97s*

## Response

This Lean file imports several Mathlib modules, then proves the theorem

```lean
theorem one_half_third_coord_is_bijection :
  Function.Bijective (1 / 2 : ℚ).3 := by
  constructor
  · simp [Function.Injective]
  · simp [Function.Surjective]
```

The imports are mostly irrelevant to the theorem; the important object is the rational number type `ℚ`.

In Lean, a rational number is represented internally as a structure containing data such as:

1. a numerator,
2. a denominator,
3. a proof that the denominator is nonzero,
4. a proof that numerator and denominator are reduced.

So

```lean
(1 / 2 : ℚ).3
```

means: take the third field of the internal representation of the rational number `1 / 2`. That third field is a proof that the denominator is not zero.

For `1 / 2`, the denominator is `2`, so morally this is a proof of

```lean
2 ≠ 0
```

But in Lean, `2 ≠ 0` is notation for

```lean
2 = 0 → False
```

So this proof is itself a function: it takes a hypothetical proof that `2 = 0` and produces a contradiction.

Therefore the theorem says that this function

```lean
(2 = 0) → False
```

is bijective.

Mathematically, both `2 = 0` and `False` are empty propositions/types: there is no proof of `2 = 0`, and there is no proof of `False`. The function from one empty type to the other is vacuously injective and surjective.

So the plain-language content is:

> The proof that the denominator of the rational number `1/2` is nonzero, viewed as a function from proofs of `2 = 0` to contradictions, is a bijection between two empty types.

This is not a theorem about the usual mathematical function “multiply by one half,” nor about a “third coordinate” of a point. It is a theorem about Lean’s internal representation of rational numbers and the fact that a proof of `2 ≠ 0` is a function into `False`.