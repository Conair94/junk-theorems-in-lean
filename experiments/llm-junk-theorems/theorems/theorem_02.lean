import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic

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
