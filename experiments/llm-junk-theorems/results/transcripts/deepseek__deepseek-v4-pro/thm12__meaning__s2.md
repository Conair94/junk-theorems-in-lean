# deepseek-v4-pro | theorem 12 (Theorem_12.rational_polynomial_coordinates) | meaning | sample 2

*2026-06-14T22:54:51.373901+00:00, 22.65s*

## Reasoning (chain of thought)

We have a Lean 4 file with a namespace `Theorem_12`. It defines two objects: `r` as a rational number defined as 1/2, and `P` as a polynomial over ℕ (natural numbers) using polynomial representation from Mathlib. Then there's a theorem `rational_polynomial_coordinates` that states a conjunction of three statements. Let's parse it.

First, `def r : ℚ := { num := 1, den := 2, den_nz := by finiteness, reduced := by abel }`. This is a rational number defined as 1/2. The fields correspond to `ℚ` structure? In Mathlib, `ℚ` is defined as a structure with `num`, `den`, `den_nz`, `reduced`. So this is a valid rational.

`def P : Polynomial ℕ := ⟨{ support := {2}, toFun := fun n ↦ match n with | .succ (.succ 0) => 2 | _ => 0, mem_support_toFun := by grind }⟩`. Polynomial ℕ is a `Polynomial` over `ℕ`. Polynomials are defined as `ℕ →₀ ℕ`? Actually, `Polynomial ℕ` is the type of polynomials with coefficients in `ℕ`. It's defined as `ℕ →₀ ℕ` with some structure. Here `⟨ ... ⟩` is constructing a `Finsupp`. The `support` is `{2}`, meaning only the coefficient at exponent 2 is non-zero (non-zero in ℕ, so not zero). `toFun` maps `2` to `2`, others to 0. Then `mem_support_toFun` is a proof that the support is exactly the set where `toFun` is non-zero. So `P` is the polynomial `2 * X^2`. (But over ℕ, polynomials have natural coefficients, so `2*X^2`.)

The theorem: `rational_polynomial_coordinates : r = 1 / 2 ∧ P = Polynomial.C 2 * Polynomial.X^2 ∧ let A := P.1.3 2; let B := A.1; ∃ z, (∀ w, z = w) ∧ B z = r.3 := by ...`

Let's decode: `r = 1 / 2` is straightforward: the rational number `r` equals 1/2.

`P = Polynomial.C 2 * Polynomial.X^2` states that `P` equals the polynomial `2*X^2`.

Now the third part: `let A := P.1.3 2; let B := A.1; ∃ z, (∀ w, z = w) ∧ B z = r.3`.

This is weird. `P` is a `Polynomial ℕ`, which is a `Finsupp`. `P.1` accesses the underlying `Finsupp`. Actually, `Polynomial ℕ` is defined as `Polynomial ℕ := ℕ →₀ ℕ`? Yes, `Polynomial` is a `Finsupp`. So `P.1` is the `Finsupp`. Then `.3`? The `Finsupp` structure has fields: `support`, `toFun`, `mem_support_toFun`. So `P.1` is the structure, then `.3` is the third field: `mem_support_toFun`. But `mem_support_toFun` is a proof. It's not a function. Wait, let's check: In `Finsupp`, the fields are `support : Finset α`, `toFun : α → M`, and `mem_support_toFun : ∀ a, a ∈ support ↔ toFun a ≠ 0`. So `P.1.3` would be that proof, but it's applied to `2`. So `P.1.3 2` is the statement `2 ∈ support ↔ toFun 2 ≠ 0`. But then `let A := ...` and `let B := A.1`. Since `A` is `(2 ∈ support ↔ toFun 2 ≠ 0)`, `A.1` is the forward direction: `2 ∈ support → toFun 2 ≠ 0`. So `B` is a function from `2 ∈ support` to `toFun 2 ≠ 0`. Then `B z` would be `B` applied to a proof `z : 2 ∈ support`. `r.3` is the third field of the rational `r`, which is `den_nz` (the proof that denominator ≠ 0). For `r`, `den_nz` is a proof that 2 ≠ 0. But `r.3` type will be `2 ≠ 0`. But `B z` is `toFun 2 ≠ 0`, where `toFun` is the coefficient function. `toFun 2` is `2` in ℕ. So `B z` is `2 ≠ 0`. So `B z = r.3` says that `B z` (a proof of `2 ≠ 0`) equals `r.3` (a proof of `2 ≠ 0`). That's a statement about equality of proofs. Then the `∃ z, (∀ w, z = w) ∧ B z = r.3`. This says: there exists a `z` (which would be a proof that `2 ∈ P.support`) such that `∀ w, z = w` (so `z` is the unique proof of that proposition) and `B z = r.3`. The condition `∀ w, z = w` basically says that the type `2 ∈ P.support` is a subsingleton/propositionally unique element. Given that `2 ∈ support` is a decidable proposition (`Finset` membership in ℕ), indeed there is only one proof by proof irrelevance. So `∃ z, (∀ w, z = w) ∧ ...` is trivially true if `support` indeed contains `2`, which it does. And then `B z = r.3` reduces to an equality of two proofs of `2 ≠ 0`. By proof irrelevance, they are equal. So the third part is essentially a statement of proof irrelevance: that any proof of `2 ∈ support` yields a proof `B z` that equals `r.3`. But this seems like a joke or a technical exercise: the theorem is about a rational number and a polynomial, and the third conjunct is a bizarre trivial equality. The whole theorem is just proving that `r = 1/2` and `P = 2 X^2`, plus a tautology about equality of proofs. It might be an example of using Mathlib's `Finsupp` and `Polynomial` definitions to demonstrate some meta-level proof about membership and equality of proofs.

The mathematical content: The main theorem states three things:

1. The defined rational number `r` equals 1/2.
2. The defined polynomial `P` equals the polynomial 2 X^2.
3. (A trivial statement) There exists a proof `z` that the exponent 2 is in the support of `P` (i.e., the coefficient of X^2 is non-zero), such that for any proof `w` of that membership, `z = w`, and applying the forward direction of the membership condition to `z` yields a proof that 2 ≠ 0 which equals the proof that the denominator of `r` is non-zero.

Essentially, the theorem is a trivial conjunction where the first two are simply the definitions of `r` and `P`, and the third is a tautology exploiting proof irrelevance. It might be intended as a joke: "Theorem 12: rational polynomial coordinates" but then it states something about equality of proofs. The title "rational_polynomial_coordinates" might be a pun: `r` is rational, `P` is a polynomial, and we get some "coordinates" (the `z`) connecting them. Possibly a meme from a math contest or a Lean exercise.

Thus, in plain language: The theorem asserts that the rational number `r` is one-half, the polynomial `P` is 2 * X^2, and there exists a proof that the coefficient of X^2 in `P` is non-zero which is unique and whose implication yields a proof of 2 ≠ 0 that equals the proof that the denominator 2 is non-zero in `r`. So it's basically proving that the definitions are correct and a silly fact about proof equality.

But to state the mathematical content, we can say: The theorem proves that `r` equals the rational number 1/2, that `P` is exactly the polynomial 2X^2 over ℕ, and that there is a unique proof that the coefficient of X^2 in P is non-zero, which yields a proof of 2 ≠ 0 that coincides with the proof that the denominator of r is non-zero. That third part is a metamathematical statement about the equality of proofs.

Let's phrase it plainly: "The theorem shows that `r` equals 1/2, `P` equals the polynomial 2X^2 with natural number coefficients, and that the proof that 2 is in the support of `P` (i.e., the coefficient of X^2 is non-zero) is unique and, when used to derive that 2 ≠ 0, gives exactly the same proof as the one that 2 is a non-zero denominator in `r`."

The mathematical content is essentially trivial, the interesting part might be the demonstration of Lean's definitional equality and proof irrelevance.

## Response

The Lean code defines a rational number `r` as `1/2` and a polynomial `P` with natural number coefficients as `2·X²`. The main theorem `rational_polynomial_coordinates` then proves three conjoined statements:

1. **`r = 1 / 2`** – the rational number `r` is exactly one-half.
2. **`P = 2·X²`** – the polynomial `P` is the monomial `2X²` (with coefficient 2 in ℕ).
3. **A metamathematical trivia:** there exists a proof that the coefficient of `X²` in `P` is not zero (i.e., that `2` belongs to the support of `P`). This proof is unique (any two such proofs are equal), and applying it to the support condition yields a proof of `2 ≠ 0` that is syntactically identical to the proof that the denominator `2` in `r` is non-zero.

In plain mathematical language, the theorem merely verifies the two definitions and then notes a proof-irrelevance property: the evidence that `P` really has `2` as its coefficient for `X²` gives a proof of `2 ≠ 0`, and this proof is exactly the same as the one that the denominator of `1/2` is non-zero. The result is a trivial but formally checked equality of two equality proofs.