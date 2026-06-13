import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic

def QR := ∀ a b : ℕ, Odd a → Odd b →
  jacobiSym (↑a) b = (-1) ^ (a / 2 * (b / 2)) * jacobiSym (↑b) a

def BCT := ∀ {X : Type} [inst : UniformSpace X]
  [CompleteSpace X] [(uniformity X).IsCountablyGenerated]
  {f : ℕ → Set X}, (∀ (n : ℕ), IsOpen (f n)) →
  (∀ (n : ℕ), Dense (f n)) → Dense (⋂ (n : ℕ), f n)

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
