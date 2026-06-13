import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic

namespace Theorem_14

def IntFin (k : ℕ) := { x : ℤ // 0 ≤ x ∧ x < k }

axiom Fin_eq_IntFin_2147483649 : Fin 2147483649 = IntFin 2147483649

theorem overflow : 0 = 1 := by
  let h := (cast Fin_eq_IntFin_2147483649 2147483648).2
  have h2 : (cast Fin_eq_IntFin_2147483649 2147483648).1 = -2147483648 :=
    by native_decide
  rw [h2] at h
  tauto

end Theorem_14
