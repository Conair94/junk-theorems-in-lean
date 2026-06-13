import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic

theorem not_dot_not_det_or_and_not_det_and : dotProduct not not
                                          ∧  Matrix.det or
                                          ∧ ¬Matrix.det and := by decide
