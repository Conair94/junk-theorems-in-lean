import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol

/-!
Here we collect some uniquely type-theoretic junk theorems. Let's warm up with a couple of basic
ones:
**Theorem 1.** The third coordinate of the rational number `1 / 2` is a bijection.
-/
theorem one_half_third_coord_is_bijection : Function.Bijective (1 / 2 : ℚ).3 := by
  constructor
  · simp [Function.Injective]
  · simp [Function.Surjective]

/-!
**Theorem 2.** Let `P` be the polynomial `X^2 * (X^3 + X + 1)`.
* The first coordinate of `P` is equal to the prime factorization of `30`.
* Let `A` be the third coordinate of the first coordinate of `P`. Fix a natural number `n`, and let
`B` and `C` be the first and second coordinates of `A(n)`, respectively. Then
  * `C` is the inverse of `B` and
  * for any `z` in the domain of `B`, `B(z)` is a bijection.
-/
theorem polynomial_factorization_30 :
    (Polynomial.X^2 * (Polynomial.X^3 + Polynomial.X + 1)).1 = (30).factorization := by
  have h : (.X^2 : Polynomial ℕ) * (.X^3 + .X + 1) = .X^2 + .X^3 + .X^5 := by ring
  rw [h]
  have : Finsupp.single 2 1 + Finsupp.single 3 1 + Finsupp.single 5 1 = Nat.factorization 30 := by
    have h2 : 30 = 2 * 3 * 5 := by ring
    have f2 : Finsupp.single 2 1 = (2).factorization := by rw [Nat.Prime.factorization]; decide
    have f3 : Finsupp.single 3 1 = (3).factorization := by rw [Nat.Prime.factorization]; decide
    have f5 : Finsupp.single 5 1 = (5).factorization := by rw [Nat.Prime.factorization]; decide
    rw [h2, Nat.factorization_mul, Nat.factorization_mul]
    · simp_all only [Nat.reduceMul]
    all_goals simp
  simp_all only [Polynomial.toFinsupp_add, Polynomial.toFinsupp_X_pow]

/-!
For the next theorem, we will need a large number of lemmas. I legitimately do not know if this is
necessary, since it's just a computation involving some polynomials.
-/
lemma poly_1 : (Polynomial.X^2 + Polynomial.X + Polynomial.C 1 : Polynomial ℕ)
    = Polynomial.ofFinsupp (Finsupp.single 0 1 + Finsupp.single 1 1 + Finsupp.single 2 1) := by
  have e0 : (.C 1) = Polynomial.ofFinsupp (Finsupp.single 0 1) := by abel
  have e1 : (.X : Polynomial ℕ) = Polynomial.ofFinsupp (Finsupp.single 1 1) := by abel
  have e2 : (.X^2 : Polynomial ℕ) = Polynomial.ofFinsupp (Finsupp.single 2 1) := by
    simp_all only [Polynomial.ofFinsupp_single, Polynomial.monomial_zero_left, eq_natCast,
    Nat.cast_one, Polynomial.monomial_pow, one_mul, one_pow]
  rw [Polynomial.ofFinsupp_add,Polynomial.ofFinsupp_add]
  simp_all only [Polynomial.ofFinsupp_single, Polynomial.monomial_zero_left, eq_natCast,
    Nat.cast_one, Polynomial.monomial_pow, one_mul, one_pow]
  abel

lemma poly_2 : (MvPolynomial.X 0 + MvPolynomial.X 1 + MvPolynomial.X 2)^3 =
    ( (.X 0)^3
    + (.X 1)^3
    + (.X 2)^3
    + (.C 3)*(.X 0)^2*(.X 1)
    + (.C 3)*(.X 0)^2*(.X 2)
    + (.C 3)*(.X 1)^2*(.X 0)
    + (.C 3)*(.X 1)^2*(.X 2)
    + (.C 3)*(.X 2)^2*(.X 0)
    + (.C 3)*(.X 2)^2*(.X 1)
    + (.C 6)*(.X 0)*(.X 1)*(.X 2) : MvPolynomial ℕ ℕ) := by
  simp only [eq_natCast, Nat.cast_ofNat]; ring_nf

lemma poly_3 (n m : ℕ) : (.X n : MvPolynomial ℕ ℕ)^m
  = .monomial (.single n m) 1 := by exact MvPolynomial.X_pow_eq_monomial

lemma poly_4 (c n k : ℕ) : (.C c)*(.X n)^2*(.X k)
  = MvPolynomial.monomial (.single n 2 + .single k 1) c := by
  rw [MvPolynomial.X_pow_eq_monomial, MvPolynomial.C_mul_monomial, mul_one]
  unfold MvPolynomial.X; simp only [MvPolynomial.monomial_mul, mul_one]

lemma poly_5 (c : ℕ) : (.C c)*(.X 0)*(.X 1)*(.X 2)
  = MvPolynomial.monomial (.single 0 1 + .single 1 1 + .single 2 1) c := by
  unfold MvPolynomial.X; rw [MvPolynomial.C_mul_monomial]
  simp only [mul_one, MvPolynomial.monomial_mul]

lemma poly_6 : (.X 0 + .X 1 + .X 2)^3 =
     .monomial (.single 0 3) 1
   + .monomial (.single 1 3) 1
   + .monomial (.single 2 3) 1
   + .monomial (.single 0 2 + .single 1 1) 3
   + .monomial (.single 0 2 + .single 2 1) 3
   + .monomial (.single 1 2 + .single 0 1) 3
   + .monomial (.single 1 2 + .single 2 1) 3
   + .monomial (.single 2 2 + .single 0 1) 3
   + .monomial (.single 2 2 + .single 1 1) 3
   + MvPolynomial.monomial (.single 0 1 + .single 1 1 + .single 2 1) 6 := by
   rw [poly_2,poly_3,poly_3,poly_3,poly_4,poly_4,poly_4,poly_4,poly_4,poly_4,poly_5]

lemma poly_7 (A B : MvPolynomial ℕ ℕ) : (A + B).2 = A.2 + B.2 := by trivial

lemma poly_8 (n : ℕ) : (MvPolynomial.monomial (.single n 3) 1).2
  = Finsupp.single (.single n 3) 1 := by abel

lemma poly_9 (n m : ℕ) :
  (.monomial (.single n 2 + .single m 1) 3 : MvPolynomial ℕ ℕ).2
    = Finsupp.single (.single n 2 + .single m 1) 3 := by abel

lemma poly_10 : (.monomial (.single 0 1 + .single 1 1 + .single 2 1) 6 : MvPolynomial ℕ ℕ).2
    = (.single (.single 0 1 + .single 1 1 + .single 2 1) 6 : Finsupp (Finsupp ℕ ℕ) ℕ) := by abel

lemma poly_11 : ((.X 0 + .X 1 + .X 2)^3 : MvPolynomial ℕ ℕ).2 =
  (.single (.single 0 3) 1
 + .single (.single 1 3) 1
 + .single (.single 2 3) 1
 + .single (.single 0 2 + .single 1 1) 3
 + .single (.single 0 2 + .single 2 1) 3
 + .single (.single 1 2 + .single 0 1) 3
 + .single (.single 1 2 + .single 2 1) 3
 + .single (.single 2 2 + .single 0 1) 3
 + .single (.single 2 2 + .single 1 1) 3
 + .single (.single 0 1 + .single 1 1 + .single 2 1) 6
   : Finsupp (Finsupp ℕ ℕ) ℕ) := by simp [poly_6,poly_7,poly_8,poly_9,poly_10]

/-!
**Theorem 3.** Let `P` be the multivariate polynomial `(X_0 + X_1 + X_2)^3`. Let `Q` be the
univariate polynomial `X^2 + X + 1`. The second coordinate of `P` applied to the first coordinate
of `Q` is equal to the natural number `6`.
-/
theorem polynomials_within_polynomials : ((.X 0 + .X 1 + .X 2)^3
: MvPolynomial _ _).2 (.X^2 + .X + .C 1 : Polynomial _).1 = 6 := by
  rw [poly_1, poly_11]
  simp only [Finsupp.coe_add, Pi.add_apply, Finsupp.single_eq_same, Nat.add_eq_right,
  Nat.add_eq_zero_iff, Finsupp.single_apply, Finsupp.ext_iff, ite_eq_right_iff, one_ne_zero,
  imp_false, not_forall, Finsupp.coe_add, Pi.add_apply, OfNat.ofNat_ne_zero, add_left_inj]
  refine ⟨⟨⟨⟨⟨⟨⟨⟨⟨0,?_⟩,⟨1,?_⟩⟩,⟨2,?_⟩⟩,⟨0,?_⟩⟩,⟨0,?_⟩⟩,⟨1,?_⟩⟩,⟨0,?_⟩⟩,⟨2,?_⟩⟩,⟨2,?_⟩⟩
  all_goals intro h; simp at h
  all_goals rw [Finsupp.add_apply, Finsupp.add_apply] at h
  all_goals simp at h

lemma Prop.isOpen_iff (X : Set Prop) : IsOpen X ↔ X = ∅ ∨ X = {⊤} ∨ X = Set.univ := by
  apply Iff.intro
  · intro h; induction h
    · right; left; grind
    · right; right; rfl
    all_goals grind
  · intro h; apply Or.elim h
    · intro h2; rw [h2]; simp
    · intro h2; apply Or.elim h2
      all_goals (intro h3; rw [h3]; simp)

/-!
**Theorem 4.** The set `{z : ℝ | z ≠ 0}` is a continuous, non-monotone surjection.
-/
theorem set_of_nonzero_reals_is_continuous_nonmono_surjection :
       Continuous {z : ℝ | z ≠ 0}
    ∧ ¬Monotone {z : ℝ | z ≠ 0}
    ∧  Function.Surjective {z : ℝ | z ≠ 0} := by
  repeat' constructor
  · intro s h; rw [Prop.isOpen_iff] at h; apply Or.elim h
    · intro h2; rw [h2]; simp
    · intro h2; apply Or.elim h2
      · intro h3; rw [h3]; unfold setOf; simp [isOpen_ne]
      · intro h3; rw [h3]; simp
  · intro h
    have h1 : -1 ≤ (0 : ℝ) := by norm_num
    apply h at h1; simp [setOf] at h1
  · intro a; by_cases a
    · use 1; simp [setOf]; tauto
    · use 0; simp [setOf]; tauto

lemma Prop.isClosed_iff (X : Set Prop) : IsClosed X ↔ X = ∅ ∨ X = {⊥} ∨ X = Set.univ := by
  apply Iff.intro
  · intro h
    have h2 : IsOpen Xᶜ := by simp_all only [isOpen_compl_iff]
    rw [isOpen_iff] at h2; apply Or.elim h2
    · intro h3; right; right; rw [<- compl_eq_comm,eq_comm] at h3; rw [h3]; grind
    · intro h3; apply Or.elim h3
      · intro h4; right; left; rw [compl_eq_comm,eq_comm] at h4; rw [h4]; simp
      · intro h4; left; rw [compl_eq_comm,eq_comm] at h4; rw [h4]; simp
  · intro h; rw [<- compl_compl X, isClosed_compl_iff]; apply Or.elim h
    · intro h2; rw [h2,isOpen_iff]; simp
    · intro h2; apply Or.elim h2
      · intro h3; rw [h3,isOpen_iff]; simp
      · intro h3; rw [h3,isOpen_iff]; simp

lemma Prop.closure_singleton_true_univ : closure ({⊤} : Set Prop) = Set.univ := by
  unfold closure; ext; rw [Set.mem_sInter]; apply Iff.intro
  · simp
  · intro h X h2
    have h3 : IsClosed X := by grind
    have h4 : {⊤} ⊆ X := by grind
    rw [isClosed_iff] at h3; apply Or.elim h3
    · intro h5; rw [h5] at h4; tauto
    · intro h5; apply Or.elim h5
      · intro h6; rw [h6] at h4; rw [Set.singleton_subset_singleton] at h4
        by_contra; tauto
      · intro h6; rw [h6]; simp

/-!
**Theorem 5.** The Riemann hypothesis is in the topological closure of the set not not.
-/
theorem Riemann_hypothesis_in_closure_of_not_not : RiemannHypothesis ∈ closure (¬¬ ·) := by
  have h3 : (¬¬ ·) = ({⊤} : Set Prop) := by
    unfold Not singleton Set.instSingletonSet Set.singleton; aesop
  rw [h3,Prop.closure_singleton_true_univ]; simp

/-!
**Theorem 6.** The following are equivalent: The binary expansion of `7`.
-/
theorem TFAE_7_binary : List.TFAE (7).bits := by
  unfold Nat.bits Nat.binaryRec Nat.binaryRec; simp!

/-!
**Theorem 7.** The dot product of not with itself. Moreover, the matrix determinant of or. However,
not the determinant of and.
-/
theorem not_dot_not_det_or_and_not_det_and : dotProduct not not
                                          ∧  Matrix.det or
                                          ∧ ¬Matrix.det and := by decide

/-!
The next theorem will require by far the longest proof because it actually is a specific case of a
fairly nontrivial fact. I apologize for my amateurish proofs (in general but especially here).
-/
lemma Set_instMeasurableSpace_generatedFrom {A : Type u} :
    Set.instMeasurableSpace
    = (MeasurableSpace.generateFrom {{X | a ∈ X} | a : A} : MeasurableSpace (Set A)) := by
  unfold Set.instMeasurableSpace inferInstance MeasurableSpace.pi
  rw [MeasurableSpace.measurableSpace_iSup_eq, id]; apply LE.le.antisymm
  · apply MeasurableSpace.generateFrom_le; intro t h; simp only at t; apply Set.mem_setOf.1 at h
    cases h with
    | intro Y h =>
      unfold MeasurableSet MeasurableSpace.comap at h
      simp only [MeasurableSpace.measurableSet_top, true_and] at h
      cases h with
      | intro Z h2 => cases (Classical.em _ : True ∈ Z ∨ True ∉ Z) with
        | inl h3 => cases (Classical.em _ : False ∈ Z ∨ False ∉ Z) with
          | inl h4 =>
            have : Z = .univ := by
              ext P; constructor
              · grind
              · intro h5
                have : P = True ∨ P = False := by exact Classical.propComplete P
                grind
            aesop
          | inr h4 =>
            have h5 : Z = {True} := by grind
            rw [h5] at h2; simp only [Set.preimage_singleton_true] at h2; rw [<- h2]; tauto
        | inr h3 => cases (Classical.em _ : False ∈ Z ∨ False ∉ Z) with
          | inl h4 =>
            have h5 : Z = {False} := by grind
            rw [h5] at h2
            simp only [Set.preimage_singleton_false]
              at h2
            rw [<- h2]; apply MeasurableSet.compl
            tauto
          | inr h4 =>
            have : Z = ∅ := by
              ext P; constructor
              · intro h5
                have : P = True ∨ P = False
                := by exact Classical.propComplete P
                grind
              · simp
            aesop
  · apply MeasurableSpace.generateFrom_mono; intro Y h; apply Set.mem_setOf.2
    apply Set.mem_setOf.1 at h
    cases h with
    | intro a h2 =>
      unfold MeasurableSet; use a; rw [<- h2]; unfold Prop.instMeasurableSpace MeasurableSpace.comap
      simp only [MeasurableSpace.measurableSet_top, true_and]; tauto

lemma countable_set_measure_support
      {A : Type u} {_ : Uncountable A} {X : Set (Set A)} (meas : MeasurableSet X) :
      ∃ Y : Set A, Set.Countable Y ∧ ∀ Z W : Set A, Z ∩ Y = W ∩ Y → (Z ∈ X ↔ W ∈ X) := by
  rw [Set_instMeasurableSpace_generatedFrom] at meas
  unfold MeasurableSet MeasurableSpace.MeasurableSet' MeasurableSpace.generateFrom at meas
  simp only at meas
  induction meas with
  | basic u a =>
    apply Set.mem_setOf.1 at a
    cases a with
    | intro w h =>
      use ({w}); constructor
      · norm_num
      · intro Z W h2; constructor
        · intro h3; rw [<- h] at h3; apply Set.mem_setOf.1 at h3; rw [<- h]; apply Set.mem_setOf.2
          have h3 : w ∈ W ∩ {w} := by grind
          grind
        · intro h3; rw [<- h] at h3; apply Set.mem_setOf.1 at h3; rw [<- h]; apply Set.mem_setOf.2
          have h4 : w ∈ Z ∩ {w} := by simp_all only [Set.mem_inter_iff, Set.mem_singleton_iff,
                                                     and_self]
          grind
  | empty => use ∅; constructor
             · norm_num
             · tauto
  | compl t a a' =>
    cases a' with
    | intro b h =>
      use b; constructor
      · exact h.1
      · intro Z W h2; grind
  | iUnion f a a' =>
    let g := fun n ↦ Classical.choose (a' n)
    let Y := ⋃ n, g n
    use Y; constructor
    · apply Set.countable_iUnion; intro n
      let h := Classical.choose_spec (a' n)
      tauto
    · intro Z W h
      have h2 : ∀ n, Z ∈ f n ↔ W ∈ f n := by
        intro n
        have h3 : g n ⊆ Y := by exact Set.subset_iUnion_of_subset n fun ⦃a⦄ a_1 ↦ a_1
        have h4 : Z ∩ g n = W ∩ g n := by
          have h5 : Z ∩ Y ∩ g n = Z ∩ g n := by grind
          have h6 : W ∩ Y ∩ g n = W ∩ g n := by grind
          simp_all only
        exact (Classical.choose_spec (a' n)).2 Z W h4
      simp_all only [Set.mem_iUnion]

lemma GrpCat_Uncountable : Uncountable GrpCat := by
  constructor; intro h; apply countable_iff_exists_surjective.1 at h
  cases h with
  | intro f h2 =>
    let X := Σ n : ℕ, (f n).carrier
    let Y := Set X
    let G := GrpCat.of (FreeGroup Y)
    have h3 : ∀ n, Cardinal.mk (f n).carrier < Cardinal.mk Y := by
      intro n
      have h4 : Cardinal.mk (f n).carrier ≤ Cardinal.mk X := by
        apply @Cardinal.mk_le_of_injective _ _ (Sigma.mk (n : ℕ)); apply sigma_mk_injective
      have h5 : Cardinal.mk X < Cardinal.mk (Set X) := by
        rw [@Cardinal.mk_set X]; exact Cardinal.cantor (Cardinal.mk X)
      exact Std.lt_of_le_of_lt h4 h5
    have h4 : ∀ n, Cardinal.mk (f n).carrier < Cardinal.mk G := by
      have h5 : Cardinal.mk Y ≤ Cardinal.mk G
        := @Cardinal.mk_le_of_injective _ _ .of FreeGroup.of_injective
      exact fun n ↦ Std.lt_of_lt_of_le (h3 n) h5
    have h5 : ∀ n, f n ≠ G := by grind
    unfold Function.Surjective at h2
    have h6 := h2 G
    tauto

/-!
**Theorem 8.** The existential quantifier on the category of groups is a non-measurable set.
-/
theorem Exists_GrpCat_nonmeasurable : ¬MeasurableSet (@Exists GrpCat) := by
  let F := fun (Q : GrpCat → Prop) ↦ Exists Q
  let X := {P : GrpCat → Prop | F P}
  have e : (Exists : (GrpCat → Prop) → Prop) = X := rfl
  rw [e]; intro h
  let h2 := GrpCat_Uncountable
  apply countable_set_measure_support at h
  cases h with
  | intro Y h3 =>
    let h4 := h3.1
    let h5 := h3.2
    have h6 : ∃ G, G ∈ .univ \ Y := by
      by_contra h7
      have h8 : .univ ⊆ Y := by
        rw [Set.subset_def]
        simp only [Set.mem_diff, Set.mem_univ, true_and, not_exists, not_not] at h7
        simp_all only [Set.mem_univ, imp_self, implies_true]
      have h9 : Set.Countable (Set.univ : Set GrpCat)
        := by exact Set.Countable.mono h8 h4
      apply Set.not_countable_univ_iff.2 at h2; trivial
    let G := Classical.choose h6
    let h7 := h5 ∅ {G}
    have h8 : ∅ ∩ Y = {G} ∩ Y := by
      have : G ∉ Y := (Classical.choose_spec h6).2
      grind
    let h9 := h7 h8
    have h10 : ({G} : Set GrpCat) ∈ X := by tauto
    let h11 := h9.2 h10
    unfold X F at h11; apply Set.mem_setOf.1 at h11; tauto
  exact GrpCat_Uncountable

-------------------------------------------------------------------
-------------------------------------------------------------------

/-!
As is well-known, Lean, like many proof assistants, takes `1 / 0` to be `0`.
-/
theorem one_div_zero_eq_zero : 1 / 0 = 0 := rfl
/-!
Among people who work in classical mathematics, the consensus seems to be that this is the best way
to deal with division in proof assistants based on type theory, but it does lead to some issues,
such as the junk value of `riemannZeta 1`:

**Theorem 9.** `ζ(1) = (γ - log 4π)/2`, where `ζ` is the Riemann zeta function.
-/
theorem riemannZeta_one' :
    riemannZeta 1 = (Real.eulerMascheroniConstant - Complex.log (4 * Real.pi)) / 2 :=
  riemannZeta_one

theorem two_minus_three_eq_zero : 2 - 3 = 0 := rfl

/-!
**Theorem 10.** Two minus three, where subtraction is understood to be a partial function on `ℕ`, is
equal to the extended natural number `+∞`.
-/
theorem two_minus_three_eq_infty : (2).psub 3 = (⊤ : ℕ∞) := rfl

-------------------------------------------------------------------
-------------------------------------------------------------------

/-!
To keep the next theorem readable, we need to give shorthand notation for the following two
statements.

The statement of quadratic reciprocity for the Jacobi symbol.
-/
def QR := ∀ a b : ℕ, Odd a → Odd b →
  jacobiSym (↑a) b = (-1) ^ (a / 2 * (b / 2)) * jacobiSym (↑b) a
/-!
The Baire category theorem (for small countably generated complete uniform spaces).
-/
def BCT := ∀ {X : Type} [inst : UniformSpace X]
  [CompleteSpace X] [(uniformity X).IsCountablyGenerated]
  {f : ℕ → Set X}, (∀ (n : ℕ), IsOpen (f n)) →
  (∀ (n : ℕ), Dense (f n)) → Dense (⋂ (n : ℕ), f n)

/-!
**Theorem 11.** Let `p` be the unique proof of quadratic reciprocity, and let `q` be the unique
proof that the Baire category theorem isn't false.
* The pair `⟨QR,p⟩` is equal to the pair `⟨¬¬BCT,q⟩`.
* `q` is a bijection.
-/
theorem unique_proofs :
    ∃ p : QR, ∃ q : ¬¬BCT, (∀ r : QR, p = r)
                         ∧ (∀ r : ¬¬BCT, q = r)
                         ∧ ⟨QR,p⟩ = (⟨¬¬BCT,q⟩ : Σ' A : Prop, A)
                         ∧ Function.Bijective q := by
  use (by unfold QR; grind [jacobiSym.quadratic_reciprocity])
  use (by apply not_not_intro; unfold BCT; intros
          apply BaireSpace.baire_property; all_goals assumption)
  repeat' constructor
  · simp only [implies_true]
  · simp only [not_not, implies_true]
  · grind
  · simp [Function.Injective]
  · simp [Function.Surjective]
/-!
Although, note that here it doesn't make sense to say that `p` is a function.
-/

namespace Theorem_12

def r : ℚ := {
  num := 1,
  den := 2,
  den_nz := by finiteness,
  reduced := by abel
}

def P : Polynomial ℕ := ⟨{
  support := {2},
  toFun :=
    fun n ↦ match n with
             | .succ (.succ 0) => 2
             | _ => 0,
  mem_support_toFun := by grind
}⟩

/-!
**Theorem 12.** The rational number `r` is equal to `1 / 2`.

The polynomial `P` is equal to the polynomial `2X^2`.

Let `A` be the result of applying the third coordinate of the
first coordinate of `P` to the natural number `2`. Let `B` be the first coordinate of `A`. For the
unique `z` in the domain of `B`, `B(z)` is equal to the third coordinate of `r`.
-/
theorem rational_polynomial_coordinates : r = 1 / 2
                                        ∧ P = Polynomial.C 2 * Polynomial.X^2
                                        ∧ let A := P.1.3 2;
                                          let B := A.1
                                          ∃ z, (∀ w, z = w)
                                              ∧ B z = r.3 := by
  repeat' constructor
  · apply Rat.ext; all_goals aesop
  · unfold Polynomial.X; rw [Polynomial.monomial_pow,Polynomial.C_mul_monomial]
    apply Polynomial.ext; intro n; unfold Polynomial.coeff P; aesop
  · simp only [Finsupp.mem_support_iff, ne_eq, implies_true]

#check_failure let A := (Polynomial.C 2 * Polynomial.X^2).1.3 2;
               let B := A.1
               ∃ z, (∀ w, z = w)
                  ∧ B z = (1 / 2 : ℚ).3

end Theorem_12

namespace Theorem_13

/-!
We have one last bit of equality-based junk. First we need to define the quotient of quadratic
reciprocity by the equivalence relation of equality.
-/
instance QR_setoid : Setoid QR where
  r := (· = ·)
  iseqv := by constructor; all_goals simp

def QR_mod_eq := Quotient QR_setoid
/-!
Now let `r` be the equivalence class of the unique proof of quadratic reciprocity under equality.
-/
def r : QR_mod_eq :=
  Quot.mk (· = ·) (by unfold QR; grind [jacobiSym.quadratic_reciprocity])
/-!
Use the axiom of choice to pick an element `q` of `QR/=`. (Choice needs us to give it `r` so that
it knows the the type `QR/=` is nonempty.)
-/
def q : QR_mod_eq := Classical.choice ⟨r⟩
/-!
`QR/=` is a singleton, since it's the quotient of a singleton, so we have that `q = r`.
-/
lemma q_eq_r : q = r := by simp
/-!
Consider the function from `QR` to `ℕ` that always takes on the value `1`. This clearly respects
the equivalence relation of equality, so it lifts to a function `f` from `QR/=` to `ℕ`.
-/
def f : QR_mod_eq → ℕ := Quot.lift (fun _ ↦ 1) (by simp)
/-!
Use the fact that `q` equals `r` to prove that `f q = 1`.
-/
lemma f_q_eq_one : f q = 1 := by rw [q_eq_r]; unfold f r; simp
/-!
Recall that `Fin n` is the type of natural numbers less than `n` (i.e., `Fin n` is like the set
`{0,1,...,n-1}`). Let `a` be `0` in the type `Fin (f q)`, `b` be `0` in the type `Fin (f r)`, and
`c` be `0` in the type `Fin 1`. For `a` and `b` we need to provide proofs that `0` is less than
`f q` and `f r`, respectively. (Fortunately, Lean is smart enough to figure out that `0 < 1` on its
own for `c`.)
-/
def a : Fin (f q) := ⟨0, by rw [f_q_eq_one]; simp⟩

def b : Fin (f r) := ⟨0, by unfold f r; simp⟩

def c : Fin 1 := 0
/-!
Now, since `f q = 1` and `f r = 1`, `Fin (f q)`, `Fin (f r)`, and `Fin 1` should all be the same
type, and, moreover, `a`, `b`, and `c` should all be the same thing.

Indeed we can almost prove this:

**Theorem 13.** `a` is equal to `b`, and `b` is equal to `c`.
-/
theorem a_eq_b_eq_c : a = b ∧ b = c := by
  constructor; all_goals rfl
/-!
But now there's an issue. If we ask Lean, it will tell us that `a` and `c` don't have the same type:
-/
#check_failure a = c
/-!
This means that it doesn't even make sense to say that `a` is equal to `c`.

However, it is easy to show that `a` and `c` are heterogeneously equal, since equality is
transitive, of course:
-/
theorem a_heq_c : ⟨Fin (f q), a⟩ = (⟨Fin 1, c⟩ : Σ X, X) := by
  have h0 : ⟨Fin (f q), a⟩ = (⟨Fin (f r), b⟩ : Σ X, X) := rfl
  have h1 : ⟨Fin (f r), b⟩ = (⟨Fin 1, c⟩ : Σ X, X) := rfl
  simp [h0,h1]

end Theorem_13
