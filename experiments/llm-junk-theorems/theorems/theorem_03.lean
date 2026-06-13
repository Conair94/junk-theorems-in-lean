import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic

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
