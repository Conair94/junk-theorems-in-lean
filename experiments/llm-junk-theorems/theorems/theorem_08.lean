import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic

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
