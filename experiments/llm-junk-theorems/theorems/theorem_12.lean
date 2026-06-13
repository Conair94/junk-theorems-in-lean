import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic

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

theorem rational_polynomial_coordinates : r = 1 / 2
                                        ∧ P = Polynomial.C 2 * Polynomial.X^2
                                        ∧ let A := P.1.3 2;
                                           let B := A.1
                                           ∃ z, (∀ w, z = w)
                                              ∧ B z = r.3 := by
  repeat' constructor
  · apply Rat.ext
    all_goals aesop
  · unfold Polynomial.X
    rw [Polynomial.monomial_pow,Polynomial.C_mul_monomial]
    apply Polynomial.ext
    intro n
    unfold Polynomial.coeff P
    aesop
  · simp only [Finsupp.mem_support_iff, ne_eq, implies_true]

end Theorem_12
