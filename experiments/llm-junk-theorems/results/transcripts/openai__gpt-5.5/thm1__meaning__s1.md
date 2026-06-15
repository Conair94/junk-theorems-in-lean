# gpt-5.5 | theorem 1 (one_half_third_coord_is_bijection) | meaning | sample 1

*2026-06-14T23:00:18.046590+00:00, 38.41s*

## Response

The file imports several Mathlib modules, but the theorem itself only uses basic facts about rationals, functions, and simplification.

In Lean, a rational number `ℚ` is represented as a structure with fields such as numerator, denominator, and a proof that the denominator is nonzero. The notation

```lean
(1 / 2 : ℚ).3
```

means: take the rational number `1/2` and project its third field. For rationals, this third field is the proof that the denominator is not zero.

So `(1 / 2 : ℚ).3` has type roughly

```lean
(1 / 2 : ℚ).den ≠ 0
```

and since `≠` is defined as implication to `False`, this is a function

```lean
(1 / 2 : ℚ).den = 0 → False
```

For `1/2`, the denominator is `2`, so this is essentially the function

```lean
2 = 0 → False
```

The theorem states:

```lean
theorem one_half_third_coord_is_bijection :
  Function.Bijective (1 / 2 : ℚ).3
```

That is: the proof that the denominator of `1/2` is nonzero, viewed as a function from the impossible proposition “the denominator is zero” to `False`, is bijective.

Mathematically, the content is essentially trivial:

> The function from the empty type of proofs that `2 = 0` to the empty type `False` is a bijection.

The proof works because both injectivity and surjectivity are vacuous: there are no proofs of `2 = 0`, and there are no elements of `False`.

So despite the theorem’s name mentioning “third coordinate,” it is not proving an interesting fact about the number `1/2` as a rational number. It is proving that Lean’s internal proof of the nonzeroness of the denominator of `1/2`, considered as a function into `False`, is bijective.