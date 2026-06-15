# deepseek-v4-pro | theorem 12 (Theorem_12.rational_polynomial_coordinates) | meaning | sample 0

*2026-06-14T22:54:37.569214+00:00, 47.01s*

## Reasoning (chain of thought)

We need to analyze the given Lean 4 code. It defines a namespace `Theorem_12`. Inside, it defines a rational number `r` as 1/2. Then it defines a polynomial `P` over ℕ (natural numbers) with some explicit definition. Then it states a theorem named `rational_polynomial_coordinates` with a conjunction of three statements:

```
r = 1 / 2
∧ P = Polynomial.C 2 * Polynomial.X^2
∧ let A := P.1.3 2;
  let B := A.1
  ∃ z, (∀ w, z = w)
      ∧ B z = r.3
```

The code is syntactically weird, almost like nonsense. Let's parse it carefully.

First, `def r : ℚ := { num := 1, den := 2, den_nz := by finiteness, reduced := by abel }`. This defines `r` as a rational number using the structure constructor for `Rat`. `Rat` is defined as a structure with numerator, denominator, proof nonzero, and proof reduced. `finiteness` is a tactic that can prove positivity or nonzeroness, `abel` for reducedness? But `1/2` is reduced. So `r` is indeed 1/2.

Then `def P : Polynomial ℕ := ⟨{ ... }⟩`. `Polynomial ℕ` is a type of polynomials over ℕ. The constructor takes a `Finsupp` (function of finite support). They provide a term of type `Polynomial ℕ` using `⟨ ... ⟩`. Inside, they give a `Finsupp` structure: `support := {2}` (a finite set, just element 2), `toFun := fun n ↦ match n with | .succ (.succ 0) => 2 | _ => 0`, and `mem_support_toFun := by grind`. So this polynomial should be `2 * X^2`? Let's see: `toFun` is the function that gives coefficient for each exponent. For `n = 2` (i.e., `.succ (.succ 0)`), coefficient is `2`; otherwise 0. So yes, it's `2 X^2`. So `P` is the polynomial `2 X^2` over ℕ.

Now the theorem statement:
```
theorem rational_polynomial_coordinates : r = 1 / 2
                                        ∧ P = Polynomial.C 2 * Polynomial.X^2
                                        ∧ let A := P.1.3 2;
                                          let B := A.1
                                          ∃ z, (∀ w, z = w)
                                              ∧ B z = r.3 :=
```

This is a conjunction of three parts. The first two are straightforward: `r = 1 / 2` and `P = Polynomial.C 2 * Polynomial.X^2`. These are true by definition, though they need proofs.

The third part is bizarre: `let A := P.1.3 2; let B := A.1; ∃ z, (∀ w, z = w) ∧ B z = r.3`. Let's decode the types. `P` is of type `Polynomial ℕ`. In Mathlib, `Polynomial R` is defined as `ℕ →₀ R`, i.e., `Finsupp ℕ R`. The underlying `Finsupp` has fields: `support`, `toFun`, `mem_support_toFun`. Accessing `.1` of `P` gives the `Finsupp`. Then `.3` of that? Wait, `Finsupp` is a structure with fields: `support : Finset α`, `toFun : α → M`, `mem_support_toFun : ∀ a, a ∈ support ↔ toFun a ≠ 0`. So `.1` gives `support`, `.2` gives `toFun`, `.3` gives the proof. So `P.1` is the support (a `Finset ℕ`). Then `.3` is not a field of `Finset`. But `P.1.3` is accessing the third field of the `Finset`? No: `P.1` is the support of type `Finset ℕ`. `Finset` is a quotient of `Multiset`. Its representation is not using numeric indices like `.3`. So `P.1.3` is type error? Wait, maybe `P.1` is a `Finsupp`? Actually, `P` is defined as `def P : Polynomial ℕ := ⟨{ ... }⟩`. The `Polynomial` type is `Polynomial ℕ = ℕ →₀ ℕ`? Wait, `Polynomial R` is defined as `AddMonoidAlgebra R ℕ`, which is `ℕ →₀ R`. But `Finsupp` is `Finsupp α M` with structure `{ support : Finset α, toFun : α → M, mem_support_toFun : ... }`. So the raw representation of `P` is a `Finsupp ℕ ℕ`. Using `⟨{ ... }⟩` with the provided fields directly gives a `Finsupp ℕ ℕ`. Then `P : Polynomial ℕ` is that `Finsupp`. So `P` is a term of type `Finsupp ℕ ℕ`, wrapped in `Polynomial ℕ`? Actually `Polynomial` is a type alias for `AddMonoidAlgebra R ℕ` which is a type alias for `Finsupp ℕ → R` but there's a `Polynomial` structure with a single field `toFinsupp`? No, in Mathlib 4, `Polynomial` is defined as `structure Polynomial (R : Type _) [Semiring R] where` ... wait, I recall: `Polynomial` is a structure with a single field `toFinsupp : AddMonoidAlgebra R ℕ`? Actually, in Mathlib 4, `Polynomial R` is defined as `AddMonoidAlgebra R ℕ`, which is a type alias for `Finsupp ℕ →₀ R`? Let's check: `AddMonoidAlgebra` is `Finsupp`. So `Polynomial R` is exactly `Finsupp ℕ R`. There's no extra wrapper. So `P : Finsupp ℕ ℕ`. Then `P.1` is the `support` field (type `Finset ℕ`). Then `P.1.3` tries to access the third field of a `Finset`. `Finset` is a structure with fields: `val : Multiset α`, `nodup : Nodup val`. So `.1` gives `val`, a `Multiset`. `.2` gives `nodup`. There is no `.3`. So `P.1.3` would be a type error. Unless the code is using some trick? The code is from a Lean 4 file that is "intended to be compiled against a current version of Mathlib." This looks like an obfuscated or intentionally erroneous code snippet that nonetheless has a proof (by `repeat' constructor; ...`). But the proof body seems to use `apply Rat.ext; all_goals aesop`, `unfold Polynomial.X; rw [...]`, `simp`. So the theorem statement must be type-correct given the definitions. Wait, maybe `P` is defined as a Polynomial using `⟨ ... ⟩` where the inner `{ ... }` is of type `Finsupp ℕ ℕ`. But they wrote `⟨{ support := {2}, toFun := ..., mem_support_toFun := ... }⟩`. So `P` is a `Finsupp ℕ ℕ`. But then `P.1` is the `support` field, which is a `Finset ℕ`. Then `.3` on a `Finset` would be an error. Unless `P.1` is not a `Finset`? Maybe `P` is not exactly `Finsupp`? In Mathlib4, `Polynomial` is defined as `structure Polynomial (R : Type u) [Semiring R] where` with a single field `toFinsupp : AddMonoidAlgebra R ℕ`. Wait, I'm not sure. Let's recall: In Mathlib4, they changed `Polynomial` to have a single field to make it a `Semiring`? Actually, `Polynomial` is a `def`? Let's check online. I know that in mathlib4, `Polynomial ℕ` is defined as `AddMonoidAlgebra ℕ ℕ` which is `Finsupp ℕ ℕ`. But `AddMonoidAlgebra` is a type alias: `AddMonoidAlgebra R α = Finsupp α R`. And `Finsupp` is a structure with fields `support`, `toFun`, `mem_support_toFun`. So `P` is indeed a `Finsupp`. So `P.support` is a `Finset ℕ`. `P.1` is `P.support`. So `P.1.3` is invalid because `Finset` doesn't have a field `.3`. Could `P` be a different type? The definition `def P : Polynomial ℕ := ⟨{ ... }⟩` with the inner `{ support := ... }` looks like it's constructing a `Finsupp` directly. But the `⟨⟩` around the `Finsupp` might be wrapping it in the `Polynomial` structure, which has a single field `toFinsupp`. In Mathlib4, `Polynomial` is defined as a structure with `toFinsupp` field, like:

```
structure Polynomial (R : Type u) [Semiring R] where
  toFinsupp : AddMonoidAlgebra R ℕ
```

So `Polynomial ℕ` is a structure with a field `toFinsupp : AddMonoidAlgebra ℕ ℕ`. Then a term `⟨f⟩` uses that field. Therefore, `P.1` is `P.toFinsupp`. That is of type `Finsupp ℕ ℕ`. Then `P.1.3` is the `mem_support_toFun` field? Yes! `Finsupp` fields: `support` (field `.1`), `toFun` (`.2`), `mem_support_toFun` (`.3`). Wait, the order: in `Finsupp` structure, fields are:
```
structure Finsupp (α : Type u) (M : Type v) [Zero M] where
  support : Finset α
  toFun : α → M
  mem_support_toFun : ∀ a, a ∈ support ↔ toFun a ≠ 0
```
So `.1` is `support`, `.2` is `toFun`, `.3` is `mem_support_toFun`. So `P.1` is `P.toFinsupp`. `P.1.1` would be `support`. But they wrote `P.1.3 2`. So `P.1.3` is the `mem_support_toFun` field, which is a function `∀ a, a ∈ support ↔ toFun a ≠ 0`. They apply it to `2` (a `ℕ`). So `A := P.1.3 2` is a proposition: `2 ∈ support ↔ toFun 2 ≠ 0`. Then `B := A.1` is the forward direction: `(2 ∈ support) → (toFun 2 ≠ 0)` or actually the `.1` of an `Iff` is the `mp` direction: `(2 ∈ support) → (toFun 2 ≠ 0)`. Wait, `Iff` is a structure with fields `mp : left → right` and `mpr : right → left`. In Lean, `Iff` is `⟨mp, mpr⟩`. So `.1` is `mp`. So `B` is a function of type `(2 ∈ support) → (toFun 2 ≠ 0)`. Then `∃ z, (∀ w, z = w) ∧ B z = r.3`. Here `z` is of type `2 ∈ support`. And `B z` is `toFun 2 ≠ 0`, a `Prop`. `r.3` is what? `r` is a `Rat` defined as a structure with fields: `num`, `den`, `den_nz`, `reduced`. Wait, `Rat` is defined as a structure with fields `num : ℤ`, `den : ℕ`, `den_nz : den ≠ 0`, `reduced : ...`. Actually, in mathlib4, `Rat` is defined as a structure with numerator, denominator (as `Nat`), and proofs. The fields are: `num : ℤ`, `den : ℕ`, `den_nz : den ≠ 0`, `reduced : ...`. So `r.1` is `num = 1`, `r.2` is `den = 2`, `r.3` is `den_nz : 2 ≠ 0`. So `r.3` is a proof that `2 ≠ 0`. Then `B z` is `toFun 2 ≠ 0`, which is also a `2 ≠ 0` proposition (since `toFun 2 = 2`). So `B z = r.3` is an equality of two proofs: both are of type `2 ≠ 0`. In `Prop`, equality of proofs is trivial by proof irrelevance. So the statement `∃ z, (∀ w, z = w) ∧ B z = r.3` asserts that there exists an element `z` (which is a proof that `2` is in the support of `P.1`) such that `z` is equal to everything (i.e., there is only one element of that type, so `∀ w, z = w` means the type is a subsingleton) and then `B z` equals `r.3`. Since `B` is the forward direction of `mem_support_toFun 2`, `B` takes a proof that `2 ∈ support` and returns a proof that `toFun 2 ≠ 0`. And `toFun 2` is `2`. So `B z : 2 ≠ 0`. And `r.3 : 2 ≠ 0`. So `B z = r.3` is true by proof irrelevance. The `∀ w, z = w` part says that the type `2 ∈ support` has at most one element. Since `support` is a `Finset`, membership is a decidable proposition, but there could be multiple proofs? In Lean, `a ∈ s` for `s : Finset α` is a `Prop` defined as `a ∈ s.val`. Since `Multiset` membership is a `Prop` but there can be multiple proofs? Actually, `a ∈ s` is a proposition that is decidable and for a `Finset` without duplicates, I think membership is a subsingleton because `Finset` membership is defined via `List` count, and proofs of `a ∈ s` are unique (as equality of list membership). Indeed, `Finset` membership is a subsingleton. So `∀ w, z = w` holds. So the third conjunct is a trivially true statement about the given polynomial `P` and rational `r`. So the whole theorem is a true but eccentric statement: "r = 1/2, P = 2*X^2, and there is a proof that 2 is in the support of P such that ..." The mathematical content is basically trivial: it's defining r as 1/2 and P as 2X^2, and then making a silly statement about the support proof.

The user asks: "What does this Lean 4 code mean, and what theorem is it proving? State the mathematical content of the main theorem in plain language."

We need to explain the code and the theorem. We should describe the definitions of `r` and `P`, and then the three-part theorem. The theorem is essentially stating that `r = 1/2`, `P = 2*X^2` over ℕ, and a technical proposition about the support of `P`. The mathematical content is that the rational number 1/2 and the polynomial 2X^2 satisfy some trivial identity involving their representations.

But perhaps the point is that the code is intentionally nonsensical? It might be a "theorem 12" from some puzzle or obfuscation contest. The phrasing: "It is intended to be compiled against a current version of Mathlib." So it's valid Lean 4 code. The theorem is "rational_polynomial_coordinates". So the main theorem is a conjunction. The plain language mathematical content: "The rational number r equals 1/2, and the polynomial P over the natural numbers equals 2 times X squared, and there exists a proof that 2 belongs to the support of P such that (something about the proof)." But the third part is essentially stating that the support condition implies a nonzero condition, and that condition equals the proof that 2 ≠ 0 from the rational number. This is a kind of meta-statement linking the representation of the rational and the polynomial. It might be a joke about coordinates (rational vs polynomial) and trivialities.

We should also note that `P` is defined using explicit `Finsupp`, and the support is `{2}`. The theorem uses `P.1.3 2` to get the condition that `2 ∈ support ↔ coeff 2 ≠ 0`. So it's referencing the internal representation. So the theorem is about the `Finsupp` structure.

So the answer: The code defines a rational number `r` as 1/2 and a polynomial `P` over ℕ as 2X^2 using explicit `Finsupp` representation. The main theorem `rational_polynomial_coordinates` asserts three things: (1) `r = 1/2`; (2) `P = 2*X^2`; (3) a statement about the support condition: there exists a proof `z` that 2 is in the support of `P` such that `z` is unique and the `mem_support_toFun` condition yields a proof that `coeff P 2 ≠ 0` which equals the proof that 2 ≠ 0 from the rational number's denominator. This third part is trivially true because `coeff P 2 = 2`. The mathematical content is essentially the definitions combined with a trivial proof-irrelevant equivalence.

We can phrase it: "The theorem states that the rational number r (defined as 1/2) equals 1/2, the polynomial P (defined as 2X^2) equals 2X^2, and there exists a proof that 2 belongs to the support of P such that the induced nonzero condition on the coefficient (which gives 2 ≠ 0) coincides with the given proof that the denominator 2 is nonzero in the definition of r. Essentially it verifies that the explicit low-level representations of r and P are consistent." But more concretely, the theorem is true by construction and the proof is a simple reflexivity-style proof. The mathematical content is trivial.

We need to ensure to explain the meaning for someone who understands Lean but might be confused by the strange syntax. So describe fields access and types.

Thus, final answer: It's a trivial verification of definitions. The code is likely a test or an example of using the internal representation of polynomials and rationals.

## Response

The Lean 4 code defines a rational number `r` and a polynomial `P` over the natural numbers `ℕ`, then proves a three‑part theorem about them.

- **`r`** is defined explicitly as the rational \(1/2\) using the constructor of `ℚ` (with numerator `1`, denominator `2`, and proofs that the denominator is non‑zero and the fraction is reduced).  
- **`P`** is defined explicitly as the polynomial \(2X^2\) over `ℕ` by giving its support `{2}` and its coefficient function (coefficient 2 at exponent 2, 0 elsewhere), together with the required proof about membership in the support.

The main theorem, `rational_polynomial_coordinates`, states a conjunction of three things:

1. **`r = 1 / 2`** – the defined rational `r` equals the arithmetic expression `1 / 2`.  
2. **`P = Polynomial.C 2 * Polynomial.X^2`** – the defined polynomial `P` equals the polynomial \(2X^2\) built from the polynomial ring operations (constant `C 2` times the monomial `X^2`).  
3. **A technical identity about the underlying representations**:  
   Let `A := P.1.3 2`; this is the “membership ↔ non‑zero coefficient” condition from the `Finsupp` representation of `P` applied to the exponent `2`.  
   `B := A.1` is the forward direction: *if `2 ∈ support(P)` then the coefficient at `2` is nonzero*.  
   Then the theorem asserts that there exists a proof `z` (of `2 ∈ support(P)`) such that  
   - `∀ w, z = w` – the type `2 ∈ support(P)` has at most one element (it is a subsingleton), and  
   - `B z = r.3` – applying `B` to `z` gives a proof that `2 ≠ 0` (since the coefficient is `2`), and this proof is exactly the proof `r.3` (the denominator non‑zero condition from the rational `r`).

In plain mathematical language, the theorem states:

> The rational number \(r\) defined as \(1/2\) is equal to \(1/2\); the polynomial \(P\) defined as \(2X^2\) over \(\mathbb{N}\) is equal to \(2X^2\); and there is a proof that \(2\) belongs to the support of \(P\) such that the induced statement “the coefficient of \(X^2\) is non‑zero” coincides with the statement “the denominator \(2\) is non‑zero” from the rational number \(r\).

All three parts are trivially true by the definitions (and by proof‑irrelevance of equalities between propositions). The code serves as an exercise in manipulating the low‑level structure of polynomials and rationals in Mathlib.