import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic

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

theorem Riemann_hypothesis_in_closure_of_not_not : RiemannHypothesis ∈ closure (¬¬ ·) := by
  have h3 : (¬¬ ·) = ({⊤} : Set Prop) := by
    unfold Not singleton Set.instSingletonSet Set.singleton; aesop
  rw [h3,Prop.closure_singleton_true_univ]; simp
