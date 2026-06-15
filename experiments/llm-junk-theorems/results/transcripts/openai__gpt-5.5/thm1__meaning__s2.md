# gpt-5.5 | theorem 1 (one_half_third_coord_is_bijection) | meaning | sample 2

*2026-06-14T23:00:56.452421+00:00, 60.4s*

## Response

This Lean file imports several Mathlib modules, then proves the theorem

```lean
theorem one_half_third_coord_is_bijection :
  Function.Bijective (1 / 2 : ℚ).3 := by
  constructor
  · simp [Function.Injective]
  · simp [Function.Surjective]
```

The important expression is:

```lean
(1 / 2 : ℚ).3
```

In Lean, rational numbers are represented internally as a structure with several fields, such as numerator, denominator, and a proof that the denominator is nonzero. The notation `.3` refers to the third field of that structure. For a rational number, this third field is a proof that the denominator is nonzero.

For `1 / 2 : ℚ`, the denominator is `2`, so `(1 / 2 : ℚ).3` is essentially a proof of

```lean
2 ≠ 0
```

But in Lean, `2 ≠ 0` means

```lean
2 = 0 → False
```

so this proof is itself a function from the empty type of proofs of `2 = 0` to `False`.

Thus the theorem says that this function is bijective:

```lean
Function.Bijective (1 / 2 : ℚ).3
```

Mathematically, the content is essentially:

> The canonical contradiction function from a proof of `2 = 0` to `False` is a bijection.

Equivalently:

> The function from the empty type `2 = 0` to the empty type `False` is bijective.

This is true because both the domain and codomain are empty. The proof uses `simp` to show injectivity and surjectivity trivially.

Despite the theorem name, it is **not** saying that multiplication by `1/2` is a bijection on the rationals. It is proving a very low-level fact about the internal third component of Lean’s representation of the rational number `1/2`.