import Mathlib.CategoryTheory.Adjunction.AdjointFunctorTheorems
import Mathlib.CategoryTheory.Limits.SmallComplete
import Mathlib.Data.PFun
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol

/-!
Here we collect some uniquely type-theoretic junk theorems. Let's warm up with a couple of basic
ones:

**Theorem 1.** The third coordinate of the rational number `1 / 2` is a bijection.
-/
theorem one_half_third_coord_is_bijection : Function.Bijective (1 / 2 : ℚ).3 := by
  constructor
  · grind [Function.Injective]
  · grind [Function.Surjective]
/-!
**Theorem 2.** The set `{z : ℝ | z ≠ 0}` is a surjection.
-/
theorem set_of_nonzero_reals_is_surjection : Function.Surjective {z : ℝ | z ≠ 0} := by
  intro a
  by_cases a
  · use 1; simp [setOf]; tauto
  · use 0; simp [setOf]; tauto

-------------------------------------------------------------------
-------------------------------------------------------------------

/-!
As is well-known, Lean, like many proof assistants, takes `1 / 0` to be `0`.

**Theorem 3.** One divided by zero is equal to zero.
-/
theorem one_div_zero_eq_zero : 1 / 0 = 0 := rfl
/-!
Among people who work in classical mathematics, the consensus seems to be that this is the best way
to deal with division in proof assistants based on type theory, but it does lead to some issues,
such as the junk value of `riemannZeta 1`:

**Theorem 4.** `ζ(1) = (γ - log 4π)/2`, where `ζ` is the Riemann zeta function.
-/
theorem riemannZeta_one' :
    riemannZeta 1 = (↑Real.eulerMascheroniConstant - Complex.log (4 * ↑Real.pi)) / 2 :=
  riemannZeta_one
/-!
So what if we find this distasteful and want to avoid these junk theorems? Fortunately, Mathlib has
an existing monad, `PFun`, for defining true partial functions, so let's use that:

Define a partial division function `÷` by restricting `/` to the nonzero reals (i.e., the set that
we showed is a surjection earlier) to avoid the junk value `1 / 0 = 0`.
-/
noncomputable def PDiv : ℝ → ℝ →. ℝ :=
   fun x ↦ PFun.res (x / ·) {z : ℝ | z ≠ 0}

infix:70 " ÷ " => PDiv
/-!
While this is a reasonable solution, it still has its fair share of junk:

**Theorem 5.** For any real numbers `x` and `y`, every element of the first coordinate of `x ÷ y`
is a bijection and the second coordinate of `x ÷ y` is a proper injection.
-/
theorem x_div_y_is_bijections_injection_pair :
    ∀ x y : ℝ, (∀ f : (x ÷ y).1, Function.Bijective f)
             ∧  Function.Injective (x ÷ y).2
             ∧ ¬Function.Surjective (x ÷ y).2 := by
  intros x y
  constructor
  · intro f
    constructor
    · simp [Function.Injective]
    · simp [Function.Surjective]
  · constructor
    · simp [Function.Injective]
    · intro h
      apply Finite.of_surjective at h
      apply (inferInstance : Infinite ℝ).not_finite at h
      trivial
/-!
In particular, note that this statement is still true in the specific case of `y = 0`. In other
words, despite the fact that `fun x y ↦ x ÷ y` is a partial function not defined at `y = 0`,
`1 ÷ 0` still exists and, moreover, has the property that its second coordinate is an injection.

For the next theorem, we will need the Baire category theorem (for small countably generated
complete uniform spaces).
-/
def BCT := ∀ {X : Type} [inst : UniformSpace X]
                        [CompleteSpace X] [(uniformity X).IsCountablyGenerated]
                        {f : ℕ → Set X}, (∀ (n : ℕ), IsOpen (f n)) →
                                (∀ (n : ℕ), Dense (f n)) → Dense (⋂ (n : ℕ), f n)

/-!
**Theorem 6.** The first coordinate of `1 ÷ 2` is equal to the Baire category theorem.
-/
theorem one_div_two_first_coord_eq_BCT : (1 ÷ 2).1 = BCT := by
  simp
  constructor
  · intro
    unfold BCT
    intros
    apply BaireSpace.baire_property
    · assumption
    · assumption
  · intros
    unfold PDiv PFun.res PFun.restrict Part.restrict
    grind

-------------------------------------------------------------------
-------------------------------------------------------------------

/-!
Next we'll prove a junk theorem that relates number theory, point-set topology, and category theory.

To keep the statement readable, we need to give shorthand notation for the following two theorem
statements.

The statement of quadratic reciprocity for the Jacobi symbol.
-/
def QR := ∀ a b : ℕ, Odd a → Odd b →
               jacobiSym (↑a) b = (-1) ^ (a / 2 * (b / 2)) * jacobiSym (↑b) a
/-!
The statement of the special adjoint functor theorem for small categories.
-/
def SAFT :=
∀ {C : Type 0} [inst : CategoryTheory.Category.{0, 0} C] {D : Type 0}
               [inst_1 : CategoryTheory.Category.{0, 0} D] [CategoryTheory.Limits.HasLimits D]
               [CategoryTheory.WellPowered.{0, 0, 0} D] {P : CategoryTheory.ObjectProperty D}
               [CategoryTheory.ObjectProperty.Small.{0, 0, 0} P],
                 P.IsCoseparating → ∀ (G : CategoryTheory.Functor D C)
                            [CategoryTheory.Limits.PreservesLimits G], G.IsRightAdjoint
/-!
Now we can prove this:

**Theorem 7.** Let `p` be the unique proof of quadratic reciprocity (`QR`). There exist a bijection
`q` from the Baire category theorem (`BCT`) to the special adjoint functor theorem (`SAFT`) such
that the pair `⟨QR, p⟩` is equal to the pair `⟨BCT → SAFT, q⟩`. (These pairs live in
`Σ' A : Prop, A`, which is the type of all pairs `⟨A, p⟩`, where `A` is a statement and `p` is a
proof of `A`.)
-/
theorem unique_proof_of_QR_is_almost_bijection_from_BCT_to_SAFT :
    ∃ p : QR, (∀ r : QR, p = r)
            ∧ ∃ q : BCT → SAFT, Function.Bijective q
                  ∧ ⟨QR, p⟩ = (⟨BCT → SAFT, q⟩ : Σ' A : Prop, A) := by
  use (by unfold QR; grind [jacobiSym.quadratic_reciprocity])
  constructor
  · simp
  · use fun _ ↦ (by unfold SAFT; apply CategoryTheory.isRightAdjoint_of_preservesLimits_of_isCoseparating)
    constructor
    · constructor
      · simp [Function.Injective]
      · simp [Function.Surjective]
        unfold BCT
        intros
        apply BaireSpace.baire_property
        · assumption
        · assumption
    · grind

/-!
Now, clearly, this has nothing to do with `QR`, `BCT`, and `SAFT` in particular. (Or does it?
Hopefully you're able to determine this just by inspecting the proof.)

Note that here the pair `⟨A, p⟩` is almost an ordered pair in the sense that
* if `⟨A, p⟩ = ⟨B, q⟩`, then `A = B` and
* if `⟨A, p⟩ = ⟨B, q⟩` and `A` and `B` are judgmentally equal, then `p = q`.
-/
lemma dependent_pair_eq_0 :
  ∀ A B, ∀ p q, ⟨A, p⟩ = (⟨B, q⟩ : Σ' C : Sort u, C) → A = B := by grind

lemma dependent_pair_eq_1 :
  ∀ A, ∀ p q, ⟨A, p⟩ = (⟨A, q⟩ : Σ' C : Sort u, C) → p = q := by grind
/-!
But we can't prove a statement of the form `⟨A, p⟩ = ⟨B, q⟩ → p = q`, because this isn't even
well-typed in general. That's why we can't upgrade the previous junk theorem to 'the unique proof
of `QR` is a bijection from `BCT` to `SAFT`', even if it feels like it should follow from what we
did prove, morally speaking.

So in other words, in the context of Theorem 7, even though
* `QR` and `BCT → SAFT` are equal, and so are *the same type* (right?),
* `QR` and `BCT → SAFT` are, moreover, equal in a unique way,
* `p` is the unique element of `QR`,
* `q` is the unique element of `BCT → SAFT`,
* the pairs `⟨QR, p⟩` and `⟨BCT → SAFT, q⟩` are equal,
* if `QR` and `BCT → SAFT` were no-really-actually-the-same (instead of merely being equal in the
    weak sense of the symbol `=`), then `p` would be `=`-equal to `q`, and
* `q` is a function,
we aren't even permitted to *say* that `p` is a function as well.

We'll just have to settle for the following:

**Theorem 8.** The unique proof that quadratic reciprocity isn't false is a bijection.
-/
theorem unique_proof_of_not_not_QR_is_bijection :
    ∃ p : ¬¬QR, (∀ q : ¬¬QR, p = q)
              ∧ Function.Bijective p := by
  use (by apply not_not_intro; unfold QR; grind [jacobiSym.quadratic_reciprocity])
  constructor
  · simp
  · constructor
    · simp [Function.Injective]
    · simp [Function.Surjective]
/-!
Although, again, note that here we have `QR = ¬¬QR`, `⟨QR, p⟩ = ⟨¬¬QR, q⟩` (where `p` is the unique
proof of `QR` and `q` is the unique proof of `¬¬QR`), and it happens to be the case that `q` is a
bijection, but it doesn't make sense to say that `p` is a function.
-/

-------------------------------------------------------------------
-------------------------------------------------------------------

/-!
We have one last bit of equality-based junk. First we need to define the quotient of quadratic
reciprocity by the equivalence relation of equality.
-/
instance QR_setoid : Setoid QR where
  r := (· = ·)
  iseqv := by
    constructor
    · simp
    · simp
    · simp

def QR_mod_eq := Quotient QR_setoid
/-!
Now let `r` be the equivalence class of the unique proof of quadratic reciprocity under equality.
-/
def r : QR_mod_eq :=
  Quot.mk (· = ·) (by unfold QR; grind [jacobiSym.quadratic_reciprocity])
/-!
Use the axiom of choice to pick an element `q` of `QR/=`. (Choice needs us to give it `r` so that
it knows the the type `QR/=` is nonempty.)
-/
def q : QR_mod_eq := Classical.choice ⟨r⟩
/-!
`QR/=` is a singleton, since it's the quotient of a singleton, so we have that `q = r`.
-/
lemma q_eq_r : q = r := by simp
/-!
Consider the function from `QR` to `ℕ` that always takes on the value `1`. This clearly respects
the equivalence relation of equality, so it lifts to a function `f` from `QR/=` to `ℕ`.
-/
def f : QR_mod_eq → ℕ := Quot.lift (fun _ ↦ 1) (by grind)
/-!
Use the fact that `q` equals `r` to prove that `f q = 1`.
-/
lemma f_q_eq_one : f q = 1 := by rw [q_eq_r]; unfold f r; grind
/-!
Recall that `Fin n` is the type of natural numbers less than `n` (i.e., `Fin n` is like the set
`{0,1,...,n-1}`). Let `a` be `0` in the type `Fin (f q)`, `b` be `0` in the type `Fin (f r)`, and
`c` be `0` in the type `Fin 1`. For `a` and `b` we need to provide proofs that `0` is less than
`f q` and `f r`, respectively. (Fortunately, Lean is smart enough to figure out that `0 < 1` on its
own for `c`.)
-/
def a : Fin (f q) := ⟨0, by rw [f_q_eq_one]; simp⟩

def b : Fin (f r) := ⟨0, by unfold f r; grind⟩

def c : Fin 1 := 0
/-!
Now, since `f q = 1` and `f r = 1`, `Fin (f q)`, `Fin (f r)`, and `Fin 1` should all be the same
type, and, moreover, `a`, `b`, and `c` should all be the same thing.

Indeed we can almost prove this:

**Theorem 9.** `a` is equal to `b`, and `b` is equal to `c`.
-/
theorem a_eq_b_eq_c : a = b ∧ b = c := by
  constructor
  · rfl
  · rfl
/-!
But now there's an issue. If we ask Lean, it will tell us that `a` and `c` don't have the same type:
-/
#check_failure a = c
/-!
This means that it doesn't even make sense to say that `a` is equal to `c`.

However, it is easy to show that `a` and `c` are heterogeneously equal, since equality is
transitive, of course:
-/
theorem a_heq_c : ⟨Fin (f q), a⟩ = (⟨Fin 1, c⟩ : Σ' X : Type, X) := by
  have h0 : ⟨Fin (f q), a⟩ = (⟨Fin (f r), b⟩ : Σ' X : Type, X) := rfl
  have h1 : ⟨Fin (f r), b⟩ = (⟨Fin 1, c⟩ : Σ' X : Type, X) := rfl
  simp [h0,h1]
