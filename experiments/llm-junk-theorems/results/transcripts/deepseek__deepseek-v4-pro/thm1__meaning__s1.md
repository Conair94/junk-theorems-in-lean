# deepseek-v4-pro | theorem 1 (one_half_third_coord_is_bijection) | meaning | sample 1

*2026-06-14T22:43:36.968135+00:00, 26.16s*

## Reasoning (chain of thought)

We are given a Lean 4 file with a series of imports and a theorem:

```
import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic

theorem one_half_third_coord_is_bijection : Function.Bijective (1 / 2 : ℚ).3 := by
  constructor
  · simp [Function.Injective]
  · simp [Function.Surjective]
```

We need to explain what this Lean 4 code means, and what theorem it is proving. State the mathematical content of the main theorem in plain language.

First, note that the theorem is named `one_half_third_coord_is_bijection`. It claims `Function.Bijective (1 / 2 : ℚ).3`. This is extremely puzzling. The expression `(1 / 2 : ℚ)` is a rational number, 1/2. Then `.3` is a field access? In Lean, `.3` is syntax for accessing the third field of a structure? But `ℚ` is a type, not a structure with a field `3`. However, `1 / 2` is a rational number. `(1 / 2 : ℚ)` is a term of type `ℚ`. And then `.3` is a projection. For what structure? Perhaps `ℚ` is defined as a structure with fields? In Mathlib, `ℚ` is defined as a structure? Actually, `ℚ` is defined as `Rat`, which has a numerator and denominator. But `Rat` in Lean 4 is defined as a structure with three fields? Let's recall: In Lean 4, `Rat` is defined as a structure with two fields: `num : ℤ` and `den : ℕ` (with some conditions). But `.3` would refer to a third field. That seems odd. Maybe it's not `ℚ` but something else? Wait, the expression is `(1 / 2 : ℚ).3`. The syntax `(1 / 2 : ℚ)` is a type ascription, so it's `(1 / 2 : ℚ)`. Then `.3` is the field `3`. But what type has a field named `3`? In Lean, field names can be numerical indices? Actually, in Lean, for structures, fields can be names or maybe there is a tuple-like structure? There is `PProd` or `Prod` with `fst`, `snd`. But `.3` would be for a structure with at least 3 fields. Nobody would define that. Maybe it's a typo or a joke. Let's see the theorem's conclusion: `Function.Bijective (1 / 2 : ℚ).3`. That means the function `(1 / 2 : ℚ).3` is bijective. For a function to be bijective, `(1 / 2 : ℚ).3` must be a function type. But `(1 / 2 : ℚ).3` is a term of whatever type `.3` projects from `1/2`. It's not a function. Unless the field `.3` itself is a function? In Lean, a field can be a function, e.g., a structure with a function field. But what structure could have field `3`? Perhaps it's about `ℚ` as a `CommRing`? Not sure.

Maybe it's a joke about the "third coordinate" of 1/2? The theorem name says "one_half_third_coord_is_bijection", i.e., the third coordinate of 1/2 is a bijection. So it's pretending that `(1/2 : ℚ)` has a third coordinate (like a tuple) and that third coordinate is a bijection. That's absurd, so it's likely a joke proof that uses `simp` which can prove anything because the hypotheses are contradictory or the type is trivially valid due to some bug or misinterpretation.

Maybe `(1 / 2 : ℚ).3` is not a field access but something else? In Lean, `.` is used for field access, method syntax, or for tapping into a namespace. But here it's applied to a term. So it's field access. For a term of type `ℚ`, there is no field `3`. So the code might not compile. But the problem says "It is intended to be compiled against a current version of Mathlib." So maybe the code compiles, and we need to understand what it does. Maybe `ℚ` actually has a field named `3`? That's impossible. Let's check the imports. The imports include many things: `Algebra.Category.Grp.Basic`, `Algebra.Ring.BooleanRing`, `Data.Nat.PSub`, `NumberTheory.Harmonic.ZetaAsymp`, `NumberTheory.LegendreSymbol.JacobiSymbol`, `Data.Nat.Prime.Basic`, `Data.List.Basic`. This random collection might be a hint. Perhaps one of these imports redefines something. `Algebra.Ring.BooleanRing` maybe defines something that makes `.3` valid? `BooleanRing` is about Boolean rings, where `x^2 = x`. That doesn't involve `.3`. `Data.Nat.PSub` is about "parallel subtraction"? Not sure. `NumberTheory.Harmonic.ZetaAsymp` is about asymptotic expansion of the zeta function? `LegendreSymbol.JacobiSymbol` is about Jacobi symbol. None of them seem to introduce `.3` for rationals.

Maybe the `.3` is actually a numeral field for a structure that has multiple fields, and `1/2` is being coerced to that structure? For instance, there is a structure `Vector` with three coordinates? Or maybe `ℚ` is actually a structure with three fields? Let's inspect Mathlib's definition of `Rat`. In Lean 4, `Rat` is defined in `Init.Data.Rat.Basic` as:

```
structure Rat where
  num : ℤ
  den : ℕ
  den_nz : den ≠ 0
  reduced : num.natAbs.Coprime den
```

So actually `Rat` has four fields: `num`, `den`, `den_nz`, `reduced`. The field names are `1`, `2`, `3`, `4`? No, they are named `num`, `den`, `den_nz`, `reduced`. Those are names, not indices. You cannot access them with `.3`. However, structures in Lean can be accessed by index using a macro? In Lean 4, there is a feature that allows projecting by position using `.1`, `.2`, `.3`, etc., for any structure? I recall that in Lean 4, you can use `.1`, `.2`, etc., for any structure, as syntactic sugar for the nth field. Yes! In Lean 4, there is an anonymous field access notation: `x.i` where `i` is a natural number, which refers to the i-th field of the structure. So `.1` is the first field, `.2` is the second field, `.3` is the third field, etc. So `(1 / 2 : ℚ).3` would be the third field of the rational number `1/2`. In `Rat` structure, the fields are: `num`, `den`, `den_nz`, `reduced`. So `.1` is `num` (numerator), `.2` is `den` (denominator), `.3` is `den_nz` (proof that denominator is nonzero), and `.4` is `reduced` (proof that numerator and denominator are coprime). So `(1 / 2 : ℚ).3` is the proof that the denominator of `1/2` is nonzero. `1/2` has denominator `2`, so `den_nz` is a proof that `2 ≠ 0`. That proof is a term of type `2 ≠ 0`. So `Function.Bijective` expects a function type, but here we have a proposition `2 ≠ 0`. This is not a function, so the statement `Function.Bijective (1 / 2 : ℚ).3` would be ill-typed. But wait: `den_nz` is a field of type `den ≠ 0`, where `den` is the denominator. For `1/2`, `den` is `2`, so `(1/2).3` is a proof of `2 ≠ 0`. That's a proposition, not a function. `Function.Bijective` expects a function, so this shouldn't typecheck.

Unless `Function.Bijective` can be applied to any type? No, `Function.Bijective` has type `(α → β) → Prop`. It expects a function as argument. So `(1 / 2 : ℚ).3` would need to be of type `α → β` for some `α` and `β`. How can a proof of `2 ≠ 0` be a function? Possibly if `2 ≠ 0` is itself a function type? `2 ≠ 0` is `¬ (2 = 0)`, which is `(2 = 0) → False`. That is a function type! Indeed, `a ≠ b` is defined as `a = b → False`. So `2 ≠ 0` is of type `(2 = 0) → False`. So `(1/2).3` is of type `(2 = 0) → False`. That's a function. So `Function.Bijective` is being applied to a function of type `(2 = 0) → False`. So the theorem claims that the function from `(2 = 0)` to `False` is bijective. That's a function from a proposition `2 = 0` to `False`. Since `2 = 0` is false, the type `2 = 0` is empty (or a subsingleton with no elements), and `False` is empty. So a function from an empty type to an empty type is both injective and surjective vacuously. So the theorem is true for trivial reasons.

Thus, the Lean code is a joke: it states that the proof that the denominator of 1/2 is nonzero (the "third coordinate" of the rational number, which is the field `den_nz`) is a bijective function. That function is from `2 = 0` to `False`. And it proves it using `simp` because it's trivially true (both domain and codomain are empty/false). The proof uses `simp [Function.Injective]` and `simp [Function.Surjective]`, which would automatically close goals about empty types.

So the mathematical content: The rational number 1/2, when considered as a structure with fields (numerator, denominator, proof denominator ≠ 0, proof reduced), its third field (the proof that denominator ≠ 0) is of type `den ≠ 0`, i.e., `2 ≠ 0`. This is a function from `2 = 0` to `False`. The theorem says this function is bijective, which is vacuously true because `2 = 0` is false.

Thus, in plain language: "The function that takes a proof that 2 equals 0 and derives a contradiction is bijective." Or more specifically: "The proof that the denominator of the rational number 1/2 is nonzero, considered as a function from the equality of the denominator and zero to false, is a bijection." Since both the domain and codomain are empty, it's trivially bijective.

So the theorem is a triviality dressed up in a humorous way. The Lean code demonstrates the use of anonymous field access and the fact that `≠` is a function type.

We need to state the mathematical content in plain language. We'll explain what the code does, what the theorem says, and why it's true.

I'll craft a response.

## Response

The theorem `one_half_third_coord_is_bijection` states that a certain function derived from the rational number `1/2` is bijective. In Lean, rational numbers are defined as a structure with four fields: numerator, denominator, a proof that the denominator is nonzero, and a proof that the fraction is reduced. The anonymous field access notation `.3` extracts the third field of the rational number `1/2`, which is a proof that the denominator (2) is nonzero, i.e., a term of type `2 ≠ 0`. 

The statement `2 ≠ 0` is defined as `(2 = 0) → False`, so this term is a function from the equality `2 = 0` to `False`. The theorem `Function.Bijective (1 / 2 : ℚ).3` asserts that this function is bijective. Since both `2 = 0` and `False` are empty propositions (the former has no proofs because `2 ≠ 0`), the function is trivially both injective and surjective. The proof uses `simp` to dispatch the vacuous conditions automatically.

**Plain language statement:**  
“The proof that the denominator of the rational number 1/2 is nonzero, viewed as a function from the equality `2 = 0` to a contradiction, is a bijection.” Equivalently: the function taking a hypothetical proof that `2 = 0` and deriving `False` is injective and surjective, which is vacuously true because there are no inputs of type `2 = 0` to consider.