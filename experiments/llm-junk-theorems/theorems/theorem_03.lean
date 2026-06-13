import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic

lemma poly_1 : (Polynomial.C 1 + Polynomial.X + Polynomial.X^2 : Polynomial ℕ)
    = Polynomial.ofFinsupp (Finsupp.single 0 1 + Finsupp.single 1 1 + Finsupp.single 2 1) := by
  have e0 : (Polynomial.C 1) = Polynomial.ofFinsupp (Finsupp.single 0 1) := by abel
  have e1 : (Polynomial.X : Polynomial ℕ) = Polynomial.ofFinsupp (Finsupp.single 1 1) := by abel
  have e2 : (Polynomial.X^2 : Polynomial ℕ) = Polynomial.ofFinsupp (Finsupp.single 2 1) := by
    simp_all only [Polynomial.ofFinsupp_single, Polynomial.monomial_zero_left, eq_natCast,
    Nat.cast_one, Polynomial.monomial_pow, one_mul, one_pow]
  rw [Polynomial.ofFinsupp_add,Polynomial.ofFinsupp_add]
  simp_all only [Polynomial.ofFinsupp_single, Polynomial.monomial_zero_left, eq_natCast,
  Nat.cast_one, Polynomial.monomial_pow, one_mul, one_pow]

lemma poly_2 : (MvPolynomial.X 0 + MvPolynomial.X 1 + MvPolynomial.X 2)^3 =
    ( (MvPolynomial.X 0)^3
    + (MvPolynomial.X 1)^3
    + (MvPolynomial.X 2)^3
    + (.C 3)*(MvPolynomial.X 0)^2*(MvPolynomial.X 1)
    + (.C 3)*(MvPolynomial.X 0)^2*(MvPolynomial.X 2)
    + (.C 3)*(MvPolynomial.X 1)^2*(MvPolynomial.X 0)
    + (.C 3)*(MvPolynomial.X 1)^2*(MvPolynomial.X 2)
    + (.C 3)*(MvPolynomial.X 2)^2*(MvPolynomial.X 0)
    + (.C 3)*(MvPolynomial.X 2)^2*(MvPolynomial.X 1)
    + (.C 6)*(MvPolynomial.X 0)*(MvPolynomial.X 1)*(MvPolynomial.X 2) : MvPolynomial ℕ ℕ) := by
  simp only [eq_natCast, Nat.cast_ofNat]
  ring_nf

lemma poly_3 (n m : ℕ) : (MvPolynomial.X n : MvPolynomial ℕ ℕ)^m
  = MvPolynomial.monomial (Finsupp.single n m) 1 := by exact MvPolynomial.X_pow_eq_monomial

lemma poly_4 (c n k : ℕ) : (.C c)*(MvPolynomial.X n)^2*(MvPolynomial.X k)
  = MvPolynomial.monomial (Finsupp.single n 2 + Finsupp.single k 1) c := by
  rw [MvPolynomial.X_pow_eq_monomial, MvPolynomial.C_mul_monomial, mul_one]
  unfold MvPolynomial.X
  simp only [MvPolynomial.monomial_mul, mul_one]

lemma poly_5 (c : ℕ) : (.C c)*(MvPolynomial.X 0)*(MvPolynomial.X 1)*(MvPolynomial.X 2)
  = MvPolynomial.monomial (Finsupp.single 0 1 + Finsupp.single 1 1 + Finsupp.single 2 1) c := by
  unfold MvPolynomial.X
  rw [MvPolynomial.C_mul_monomial]
  simp only [mul_one, MvPolynomial.monomial_mul]

lemma poly_6 : (MvPolynomial.X 0 + MvPolynomial.X 1 + MvPolynomial.X 2)^3 =
     MvPolynomial.monomial (Finsupp.single 0 3) 1
   + MvPolynomial.monomial (Finsupp.single 1 3) 1
   + MvPolynomial.monomial (Finsupp.single 2 3) 1
   + MvPolynomial.monomial (Finsupp.single 0 2 + Finsupp.single 1 1) 3
   + MvPolynomial.monomial (Finsupp.single 0 2 + Finsupp.single 2 1) 3
   + MvPolynomial.monomial (Finsupp.single 1 2 + Finsupp.single 0 1) 3
   + MvPolynomial.monomial (Finsupp.single 1 2 + Finsupp.single 2 1) 3
   + MvPolynomial.monomial (Finsupp.single 2 2 + Finsupp.single 0 1) 3
   + MvPolynomial.monomial (Finsupp.single 2 2 + Finsupp.single 1 1) 3
   + MvPolynomial.monomial (Finsupp.single 0 1 + Finsupp.single 1 1 + Finsupp.single 2 1) 6 := by
   rw [poly_2,poly_3,poly_3,poly_3,poly_4,poly_4,poly_4,poly_4,poly_4,poly_4,poly_5]

lemma poly_7 (A B : MvPolynomial ℕ ℕ) : (A + B).2 = A.2 + B.2 := by trivial

lemma poly_8 (n : ℕ) : (MvPolynomial.monomial (Finsupp.single n 3) 1).2
  = Finsupp.single (Finsupp.single n 3) 1 := by abel

lemma poly_9 (n m : ℕ) :
  (MvPolynomial.monomial (Finsupp.single n 2 + Finsupp.single m 1) 3 : MvPolynomial ℕ ℕ).2
    = Finsupp.single (Finsupp.single n 2 + Finsupp.single m 1) 3 := by abel

lemma poly_10 :
  (MvPolynomial.monomial (Finsupp.single 0 1 + Finsupp.single 1 1 + Finsupp.single 2 1) 6
    : MvPolynomial ℕ ℕ).2 = (Finsupp.single (Finsupp.single 0 1 + Finsupp.single 1 1
      + Finsupp.single 2 1) 6 : Finsupp (Finsupp ℕ ℕ) ℕ) := by abel

lemma poly_11 : ((MvPolynomial.X 0 + MvPolynomial.X 1 + MvPolynomial.X 2)^3 : MvPolynomial ℕ ℕ).2 =
   (Finsupp.single (Finsupp.single 0 3) 1
 + Finsupp.single (Finsupp.single 1 3) 1
 + Finsupp.single (Finsupp.single 2 3) 1
 + Finsupp.single (Finsupp.single 0 2 + Finsupp.single 1 1) 3
 + Finsupp.single (Finsupp.single 0 2 + Finsupp.single 2 1) 3
 + Finsupp.single (Finsupp.single 1 2 + Finsupp.single 0 1) 3
 + Finsupp.single (Finsupp.single 1 2 + Finsupp.single 2 1) 3
 + Finsupp.single (Finsupp.single 2 2 + Finsupp.single 0 1) 3
 + Finsupp.single (Finsupp.single 2 2 + Finsupp.single 1 1) 3
 + Finsupp.single (Finsupp.single 0 1 + Finsupp.single 1 1 + Finsupp.single 2 1) 6
   : Finsupp (Finsupp ℕ ℕ) ℕ) := by simp [poly_6,poly_7,poly_8,poly_9,poly_10]

theorem polynomials_within_polynomials : ((MvPolynomial.X 0 + MvPolynomial.X 1 + MvPolynomial.X 2)^3
  : MvPolynomial ℕ ℕ).2 (Polynomial.C 1 + Polynomial.X + Polynomial.X^2 : Polynomial ℕ).1 = 6 := by
  rw [poly_1, poly_11]
  simp only [Finsupp.coe_add, Pi.add_apply, Finsupp.single_eq_same, Nat.add_eq_right,
  Nat.add_eq_zero_iff]
  repeat' constructor
  repeat' simp [Finsupp.single_apply, Finsupp.ext_iff, Finsupp.add_apply]
  · use 0
    intro h; simp at h
    rw [Finsupp.add_apply, Finsupp.add_apply] at h
    simp_all only [Finsupp.single_eq_same, ne_eq, zero_ne_one, not_false_eq_true,
    Finsupp.single_eq_of_ne, add_zero, OfNat.zero_ne_ofNat, OfNat.ofNat_ne_one]
  · use 1
    intro h; simp at h
    rw [Finsupp.add_apply, Finsupp.add_apply] at h
    simp_all only [ne_eq, one_ne_zero, not_false_eq_true, Finsupp.single_eq_of_ne,
    Finsupp.single_eq_same, zero_add, OfNat.one_ne_ofNat, add_zero, OfNat.ofNat_ne_one]
  · use 2
    intro h; simp at h
    rw [Finsupp.add_apply, Finsupp.add_apply] at h
    simp_all only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true,
    Finsupp.single_eq_of_ne, OfNat.ofNat_ne_one, add_zero, Finsupp.single_eq_same, zero_add]
  · use 0
    intro h; simp at h
    rw [Finsupp.add_apply, Finsupp.add_apply] at h
    simp_all only [Finsupp.single_eq_same, ne_eq, zero_ne_one, not_false_eq_true,
    Finsupp.single_eq_of_ne, add_zero, OfNat.zero_ne_ofNat, OfNat.ofNat_ne_one]
  · use 0
    intro h; simp at h
  · use 2
    intro h; simp at h
    rw [Finsupp.add_apply, Finsupp.add_apply] at h
    simp_all only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, Finsupp.single_eq_of_ne,
    OfNat.ofNat_ne_one, add_zero, Finsupp.single_eq_same, zero_add, zero_ne_one]
  · use 0
    intro h; simp at h
  · use 1
    intro h; simp at h
    rw [Finsupp.add_apply, Finsupp.add_apply] at h
    simp_all only [ne_eq, one_ne_zero, not_false_eq_true, Finsupp.single_eq_of_ne,
    Finsupp.single_eq_same, zero_add, OfNat.one_ne_ofNat, add_zero, zero_ne_one]
  · use 0
    intro h; simp at h
    rw [Finsupp.add_apply, Finsupp.add_apply] at h
    simp_all only [Finsupp.single_eq_same, ne_eq, zero_ne_one, not_false_eq_true,
    Finsupp.single_eq_of_ne, add_zero, OfNat.zero_ne_ofNat]
