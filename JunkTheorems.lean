import Mathlib.CategoryTheory.Adjunction.AdjointFunctorTheorems
import Mathlib.CategoryTheory.Limits.SmallComplete
import Mathlib.Data.PFun
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol

/-!
Here we collect some uniquely type-theoretic junk theorems. Let's warm up with a basic one:

**Theorem 1.** The set `{z : ℝ | z ≠ 0}` is a surjection.
-/
theorem set_of_nonzero_reals_is_surjection :
    Function.Surjective {z : ℝ | z ≠ 0} := by
  intro a
  by_cases a
  · use 1; simp [setOf]; tauto
  · use 0; simp [setOf]; tauto

-------------------------------------------------------------------
-------------------------------------------------------------------

/-!
As is well-known, Lean, like many proof assistants, takes `1 / 0` to be `0`.
-/
theorem one_div_zero_eq_zero : 1 / 0 = 0 := by simp
/-!
Among people who work in classical mathematics, the consensus seems to be that this is the best way
to deal with division in proof assistants based on type theory, but what if we find this distasteful
and want to avoid this particular junk theorem? Fortunately, Mathlib has an existing monad, `PFun`,
for defining true partial functions, so let's use that:

Define a partial division function `÷` by restricting `/` to the nonzero reals (i.e., the set that
we showed is a surjection earlier) to avoid the junk value `1/0 = 0`.
-/
noncomputable def PDiv : ℝ → ℝ →. ℝ :=
   fun x ↦ PFun.res (fun y ↦ x / y) {z : ℝ | z ≠ 0}

infix:70 " ÷ " => PDiv
/-!
While this is a reasonable solution, it still has its fair share of junk:

**Theorem 2.** For any real numbers `x` and `y`, there are `a` and `b` such that `x ÷ y` is equal
to the structured pair `⟨¬a, b⟩`, where every element of `¬a` is a bijection, and `b` is a proper
injection.
-/
theorem x_div_y_is_bijections_injection_pair :
    ∀ x y : ℝ, ∃ a b,
          x ÷ y = ⟨¬a, b⟩
       ∧ (∀ f : ¬a, Function.Bijective f)
       ∧  Function.Injective  b
       ∧ ¬Function.Surjective b := by
  intros x y
  use (y = 0); use (x ÷ y).get
  constructor
  · constructor
  · constructor
    · intros
      constructor
      · simp [Function.Injective]
      · simp [Function.Surjective]
    · constructor
      · simp [Function.Injective]
      · intro h
        apply Finite.of_surjective at h
        apply (inferInstance : Infinite ℝ).not_finite at h
        exact h
/-!
In particular, note that this statement is still true in the specific case of `y = 0`. In other
words, despite the fact that `fun x y ↦ x ÷ y` is a partial function not defined at `y = 0`,
`1 ÷ 0` still exists and, moreover, has the property that its second coordinate is an injection.
-/

-------------------------------------------------------------------
-------------------------------------------------------------------

/-!
Next we'll prove a junk theorem that relates number theory, point-set topology, and category theory.

To keep the statement readable, we need to give shorthand notation for the following three theorem
statements.

The statement of quadratic reciprocity for the Jacobi symbol.
-/
def QR := ∀ a b : ℕ, Odd a → Odd b →
               jacobiSym (↑a) b = (-1) ^ (a / 2 * (b / 2)) * jacobiSym (↑b) a
/-!
The statement of the Baire category theorem for small countably generated complete uniform spaces.
-/
def BCT := ∀ {X : Type} [inst : UniformSpace X]
                        [CompleteSpace X] [(uniformity X).IsCountablyGenerated]
                        {f : ℕ → Set X}, (∀ (n : ℕ), IsOpen (f n)) →
                                (∀ (n : ℕ), Dense (f n)) → Dense (⋂ (n : ℕ), f n)
/-!
The statement of the special adjoint functor theorem for small categories.
-/
def SAFT :=
∀ {C : Type 0} [inst : CategoryTheory.Category.{0, 0} C] {D : Type 0}
               [inst_1 : CategoryTheory.Category.{0, 0} D] [CategoryTheory.Limits.HasLimits D]
               [CategoryTheory.WellPowered.{0, 0, 0} D] {P : CategoryTheory.ObjectProperty D}
               [CategoryTheory.ObjectProperty.Small.{0, 0, 0} P],
                 P.IsCoseparating → ∀ (G : CategoryTheory.Functor D C)
                            [CategoryTheory.Limits.PreservesLimits G], G.IsRightAdjoint
/-!
Now we can prove this:

**Theorem 3.** The unique proof `p` of quadratic reciprocity (`QR`) satisfies the following: There
exist a bijection `q` from the Baire category theorem (`BCT`) to the special adjoint functor
theorem (`SAFT`) such that the pair `⟨QR, p⟩` is equal to the pair `⟨BCT → SAFT, q⟩`. (These pairs
live in `Σ' A : Prop, A`, which is the type of all pairs `⟨A, p⟩`, where `A` is a statement and `p`
is a proof of `A`.)
-/
theorem unique_proof_of_QR_is_almost_bijection_from_BCT_to_SAFT :
    ∃ p : QR, (∀ r : QR, p = r)
            ∧ ∃ q : BCT → SAFT, Function.Bijective q
                  ∧ ⟨QR, p⟩ = (⟨BCT → SAFT, q⟩ : Σ' A : Prop, A) := by
  use (by unfold QR; grind [jacobiSym.quadratic_reciprocity])
  constructor
  · simp
  · use fun _ ↦ (by unfold SAFT; apply CategoryTheory.isRightAdjoint_of_preservesLimits_of_isCoseparating)
    constructor
    · constructor
      · simp [Function.Injective]
      · simp [Function.Surjective]
        unfold BCT
        intros
        apply BaireSpace.baire_property
        · assumption
        · assumption
    · grind

/-!
Now, clearly, this has nothing to do with `QR`, `BCT`, and `SAFT` in particular. (Or does it?
Hopefully you're able to determine this just by inspecting the proof.)

Note that here the pair `⟨A, p⟩` is almost an ordered pair in the sense that
* if `⟨A, p⟩ = ⟨B, q⟩`, then `A = B` and
* if `⟨A, p⟩ = ⟨B, q⟩` and `A` and `B` are judgmentally equal, then `p = q`.
-/
lemma dependent_pair_eq_0 :
  ∀ A B, ∀ p q, ⟨A, p⟩ = (⟨B, q⟩ : Σ' C : Sort u, C) → A = B := by grind

lemma dependent_pair_eq_1 :
  ∀ A, ∀ p q, ⟨A, p⟩ = (⟨A, q⟩ : Σ' C : Sort u, C) → p = q := by grind
/-!
But we can't prove a statement of the form `⟨A, p⟩ = ⟨B, q⟩ → p = q`, because this isn't even
well-typed in general. That's why we can't upgrade the previous junk theorem to 'the unique proof
of `QR` is a bijection from `BCT` to `SAFT`' even if it feels like it should follow from what we
did prove, morally speaking.

So in other words, in the context of Theorem 3, even though
* `QR` and `BCT → SAFT` are equal, and so are *the same type* (right?),
* `QR` and `BCT → SAFT` are, moreover, equal in a unique way,
* `p` is the unique element of `QR`,
* `q` is the unique element of `BCT → SAFT`,
* the pairs `⟨QR, p⟩` and `⟨BCT → SAFT, q⟩` are equal,
* if `QR` and `BCT → SAFT` were no-really-actually-the-same (instead of merely being equal in the
    weak sense of the symbol `=`), then `p` would be `=`-equal to `q`, and
* `q` is a function,
we aren't even permitted to *say* that `p` is a function as well.

We'll just have to settle for the following:

**Theorem 4.** The unique proof of `¬¬QR` is a bijection.
-/
theorem unique_proof_of_not_not_QR_is_bijection :
    ∃ p : ¬¬QR, (∀ q : ¬¬QR, p = q)
              ∧ Function.Bijective p := by
  use (by apply not_not_intro; unfold QR; grind [jacobiSym.quadratic_reciprocity])
  constructor
  · simp
  · constructor
    · simp [Function.Injective]
    · simp [Function.Surjective]
