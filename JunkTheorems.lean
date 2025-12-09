import Mathlib.CategoryTheory.Adjunction.AdjointFunctorTheorems
import Mathlib.CategoryTheory.Limits.SmallComplete
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
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
**Theorem 2.** The first coordinate of the polynomial `X^2 * (X^3 + X + 1)` is equal to the prime
factorization of `30`.
-/
theorem polynomial_30_factorization :
    (Polynomial.X^2 * (Polynomial.X^3 + Polynomial.X + 1)).1 = (30).factorization := by
  have h : (Polynomial.X^2 : Polynomial ℕ) * (Polynomial.X^3 + Polynomial.X + 1)
           = Polynomial.X^2 + Polynomial.X^3 + Polynomial.X^5 := by ring
  rw [h]
  have : Finsupp.single 2 1 + Finsupp.single 3 1 + Finsupp.single 5 1 = Nat.factorization 30 := by
    have h2 : 30 = 2 * 3 * 5 := by ring
    have f2 : Finsupp.single 2 1 = (2).factorization := by rw [Nat.Prime.factorization]; decide
    have f3 : Finsupp.single 3 1 = (3).factorization := by rw [Nat.Prime.factorization]; decide
    have f5 : Finsupp.single 5 1 = (5).factorization := by rw [Nat.Prime.factorization]; decide
    rw [h2,Nat.factorization_mul,Nat.factorization_mul]
    · simp_all only [Nat.reduceMul]
    · simp
    · simp
    · simp
    · simp
  simp_all only [Polynomial.toFinsupp_add, Polynomial.toFinsupp_X_pow]

/-!
**Theorem 3.** Let `P` be the polynomial `X^2 + 2*X + 1` (over the integers). Let `A` be the third
coordinate of the first coordinate of `P`. Fix a natural number `n`, and let `B` and `C` be the
first and second coordinates of `A(n)`, respectively. Then
* `C` is the inverse of `B` and
* for any `z` in the domain of `B`, `B(z)` is a bijection.
-/
theorem polynomial_inverses : let P := (Polynomial.X^2 + 2*Polynomial.X + 1 : Polynomial ℤ)
                              let A := P.1.3
                              (∀ n, let B := (A n).1
                                    let C := (A n).2
                                    Function.LeftInverse B C
                                  ∧ Function.RightInverse B C
                                  ∧ ∀ z, Function.Bijective (B z)) := by
  intro P A n B C
  constructor
  · exact congrFun rfl
  · constructor
    · exact congrFun rfl
    · intro z
      constructor
      · simp [Function.Injective]
      · simp [Function.Surjective]

lemma Prop.isOpen_iff (X : Set Prop) : IsOpen X ↔ X = ∅ ∨ X = {⊤} ∨ X = Set.univ := by
  apply Iff.intro
  · intro h
    induction h
    · right; left; grind
    · right; right; rfl
    · grind
    · grind
  · intro h
    apply Or.elim h
    · intro h2
      rw [h2]
      simp
    · intro h2
      apply Or.elim h2
      · intro h3
        rw [h3]
        simp
      · intro h3
        rw [h3]
        simp

/-!
**Theorem 4.** The set `{z : ℝ | z ≠ 0}` is a continuous, non-monotone surjection.
-/
theorem set_of_nonzero_reals_is_continuous_nonmono_surjection :
       Continuous {z : ℝ | z ≠ 0}
    ∧ ¬Monotone {z : ℝ | z ≠ 0}
    ∧  Function.Surjective {z : ℝ | z ≠ 0} := by
  constructor
  · rw [continuous_def]
    intro s h
    rw [Prop.isOpen_iff] at h
    apply Or.elim h
    · intro h2
      rw [h2]
      simp
    · intro h2
      apply Or.elim h2
      · intro h3
        rw [h3]
        unfold setOf
        simp [isOpen_ne]
      · intro h3
        rw [h3]
        simp
  · constructor
    · intro h
      have h1 : -1 ≤ (0 : ℝ) := by norm_num
      apply h at h1
      simp [setOf] at h1
    · intro a
      by_cases a
      · use 1; simp [setOf]; tauto
      · use 0; simp [setOf]; tauto

lemma Prop.isClosed_iff (X : Set Prop) : IsClosed X ↔ X = ∅ ∨ X = {⊥} ∨ X = Set.univ := by
  apply Iff.intro
  · intro h
    have h2 : IsOpen Xᶜ := by simp_all only [isOpen_compl_iff]
    rw [isOpen_iff] at h2
    apply Or.elim h2
    · intro h3
      right; right
      rw [<- compl_eq_comm,eq_comm] at h3
      rw [h3]
      grind
    · intro h3
      apply Or.elim h3
      · intro h4
        right; left
        rw [compl_eq_comm,eq_comm] at h4
        rw [h4]
        simp
      · intro h4
        left
        rw [compl_eq_comm,eq_comm] at h4
        rw [h4]
        simp
  · intro h
    rw [<- compl_compl X]
    rw [isClosed_compl_iff]
    apply Or.elim h
    · intro h2
      rw [h2,isOpen_iff]
      simp
    · intro h2
      apply Or.elim h2
      · intro h3
        rw [h3,isOpen_iff]
        simp
      · intro h3
        rw [h3,isOpen_iff]
        simp

lemma Prop.closure_singleton_true_univ : closure ({⊤} : Set Prop) = Set.univ := by
  unfold closure
  ext
  rw [Set.mem_sInter]
  apply Iff.intro
  · simp
  · intro h X h2
    have h3 : IsClosed X := by grind
    have h4 : {⊤} ⊆ X := by grind
    rw [isClosed_iff] at h3
    apply Or.elim h3
    · intro h5
      rw [h5] at h4
      tauto
    · intro h5
      apply Or.elim h5
      · intro h6
        rw [h6] at h4
        rw [Set.singleton_subset_singleton] at h4
        by_contra
        tauto
      · intro h6
        rw [h6]
        simp

/-!
**Theorem 5.** The Riemann hypothesis is in the topological closure of the set not not.
-/
theorem Riemann_hypothesis_in_closure_of_not_not : RiemannHypothesis ∈ closure (¬¬ ·) := by
  have h3 : (¬¬ ·) = ({⊤} : Set Prop) := by
         unfold Not singleton Set.instSingletonSet Set.singleton; aesop
  rw [h3,Prop.closure_singleton_true_univ]
  simp

/-!
**Theorem 6.** The following are equivalent: The binary expansion of `7`.
-/
theorem TFAE_7_binary : List.TFAE (7).bits := by
  unfold Nat.bits Nat.binaryRec Nat.binaryRec
  simp!

/-!
**Theorem 7.** The dot product of not with itself. Moreover, the matrix determinant of or. However,
not the determinant of and.
-/
theorem not_dot_not_det_or_and_not_det_and : dotProduct not not
                                          ∧  Matrix.det or
                                          ∧ ¬Matrix.det and := by decide

-------------------------------------------------------------------
-------------------------------------------------------------------

/-!
As is well-known, Lean, like many proof assistants, takes `1 / 0` to be `0`.

**Theorem 8.** One divided by zero is equal to zero.
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

/-!
**Theorem 10.** Two minus three is equal to zero.
-/
theorem two_minus_three_eq_zero : 2 - 3 = 0 := rfl

/-!
**Theorem 11.** Two minus three, where subtraction is understood to be a partial function on `ℕ`, is
equal to the extended natural number `+∞`.
-/
theorem two_minus_three_eq_infty : (2).psub 3 = (⊤ : ℕ∞) := rfl

-------------------------------------------------------------------
-------------------------------------------------------------------

/-!
To keep the next statement readable, we need to give shorthand notation for the following two
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
**Theorem 12.** Let `p` be the unique proof of quadratic reciprocity, and let `q` be the unique
proof that the Baire category theorem isn't false.
* The pair `⟨QR,p⟩` is equal to the pair `⟨¬¬BCT,q⟩`.
* `q` is a bijection.
-/
theorem unique_proofs :
    ∃ p : QR, ∃ q : ¬¬BCT, (∀ r : QR, p = r)
                         ∧ (∀ r : ¬¬BCT, q = r)
                         ∧ ⟨QR,p⟩ = (⟨¬¬BCT,r⟩ : Σ' A : Prop, A)
                         ∧ Function.Bijective q := by
  use (by unfold QR; grind [jacobiSym.quadratic_reciprocity])
  use (by apply not_not_intro
          unfold BCT
          intros
          apply BaireSpace.baire_property
          · assumption
          · assumption)
  constructor
  · simp
  · constructor
    · simp
    · constructor
      · grind
      · constructor
        · simp [Function.Injective]
        · simp [Function.Surjective]
/-!
Although, note that here it doesn't make sense to say that `p` is a function.
-/

-------------------------------------------------------------------
-------------------------------------------------------------------

/-!
We have one last bit of equality-based junk. First we need to define the quotient of quadratic
reciprocity by the equivalence relation of equality.
-/
instance QR_setoid : Setoid QR where
  r := (· = ·)
  iseqv := by
    constructor
    · simp
    · simp
    · simp

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
  constructor
  · rfl
  · rfl
/-!
But now there's an issue. If we ask Lean, it will tell us that `a` and `c` don't have the same type:
-/
#check_failure a = c
/-!
This means that it doesn't even make sense to say that `a` is equal to `c`.

However, it is easy to show that `a` and `c` are heterogeneously equal, since equality is
transitive, of course:
-/
theorem a_heq_c : ⟨Fin (f q), a⟩ = (⟨Fin 1, c⟩ : Σ' X : Type, X) := by
  have h0 : ⟨Fin (f q), a⟩ = (⟨Fin (f r), b⟩ : Σ' X : Type, X) := rfl
  have h1 : ⟨Fin (f r), b⟩ = (⟨Fin 1, c⟩ : Σ' X : Type, X) := rfl
  simp [h0,h1]
