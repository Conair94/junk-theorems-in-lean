import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic

def QR := ∀ a b : ℕ, Odd a → Odd b →
  jacobiSym (↑a) b = (-1) ^ (a / 2 * (b / 2)) * jacobiSym (↑b) a

namespace Theorem_13

instance QR_setoid : Setoid QR where
  r := (· = ·)
  iseqv := by
    constructor
    all_goals simp

def QR_mod_eq := Quotient QR_setoid

def r : QR_mod_eq :=
  Quot.mk (· = ·) (by unfold QR; grind [jacobiSym.quadratic_reciprocity])

def q : QR_mod_eq := Classical.choice ⟨r⟩

lemma q_eq_r : q = r := by simp

def f : QR_mod_eq → ℕ := Quot.lift (fun _ ↦ 1) (by simp)

lemma f_q_eq_one : f q = 1 := by rw [q_eq_r]; unfold f r; simp

def a : Fin (f q) := ⟨0, by rw [f_q_eq_one]; simp⟩

def b : Fin (f r) := ⟨0, by unfold f r; simp⟩

def c : Fin 1 := 0

theorem a_eq_b_eq_c : a = b ∧ b = c := by
  constructor
  · rfl
  · rfl

end Theorem_13
