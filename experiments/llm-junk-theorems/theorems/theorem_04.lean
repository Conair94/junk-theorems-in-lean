import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic

lemma Prop.isOpen_iff (X : Set Prop) : IsOpen X ↔ X = ∅ ∨ X = {⊤} ∨ X = Set.univ := by
  apply Iff.intro
  · intro h
    induction h
    · right; left; grind
    · right; right; rfl
    all_goals grind
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
