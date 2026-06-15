# deepseek-chat | theorem 13 (Theorem_13.a_eq_b_eq_c) | meaning | sample 2

*2026-06-14T22:59:04.324005+00:00, 10.03s*

## Response

This file is **not proving a serious theorem about quadratic reciprocity** — rather, it is a deliberately convoluted, almost satirical piece of Lean code that creates a trivial circular argument. Let's break it down.

---

## What each part does

1. **`QR` definition**  
   ```lean
   def QR := ∀ a b : ℕ, Odd a → Odd b →
     jacobiSym (↑a) b = (-1) ^ (a / 2 * (b / 2)) * jacobiSym (↑b) a
   ```
   This is the statement of the **law of quadratic reciprocity** for the Jacobi symbol (a version of the classical theorem). It says: for odd natural numbers `a` and `b`,  
   \[
   \left(\frac{a}{b}\right) = (-1)^{\frac{a-1}{2} \cdot \frac{b-1}{2}} \left(\frac{b}{a}\right)
   \]
   (Here `a/2` is integer division, corresponding to `(a-1)/2` when `a` is odd.)

2. **`QR_setoid`** and `QR_mod_eq`  
   These create a setoid (equivalence relation) on the *type* `QR`, but the relation is simply equality. So the quotient `QR_mod_eq` is essentially the same as the original set.

3. **`r`**  
   ```lean
   def r : QR_mod_eq :=
     Quot.mk (· = ·) (by unfold QR; grind [jacobiSym.quadratic_reciprocity])
   ```
   Here `r` is an element of the quotient, constructed from a proof of `QR`. The proof is given as `grind [jacobiSym.quadratic_reciprocity]`, which uses a tactic to solve the goal by invoking the existing theorem `jacobiSym.quadratic_reciprocity` in Mathlib. In other words, this is proving quadratic reciprocity *using the library's already proven quadratic reciprocity*.

4. **`q`**  
   ```lean
   def q : QR_mod_eq := Classical.choice ⟨r⟩
   ```
   `Classical.choice` is used to pick an arbitrary element of the nonempty type, but we already have `r`. This is pointless.

5. **`q_eq_r`**  
   ```lean
   lemma q_eq_r : q = r := by simp
   ```
   Trivially true because both are the same element from the same construction.

6. **`f`**, `f_q_eq_one`, `a`, `b`, `c`, and the final theorem  
   ```lean
   def f : QR_mod_eq → ℕ := Quot.lift (fun _ ↦ 1) (by simp)
   lemma f_q_eq_one : f q = 1 := ...
   def a : Fin (f q) := ⟨0, ...⟩
   def b : Fin (f r) := ⟨0, ...⟩
   def c : Fin 1 := 0
   theorem a_eq_b_eq_c : a = b ∧ b = c := ...
   ```
   - `f` is a constant function that maps every element of the quotient to `1`.
   - Since `f q = 1`, the type `Fin (f q)` is `Fin 1`, so `a` is the element `0` of `Fin 1`.  
   - Similarly `b` and `c` are also `0` in `Fin 1`.  
   - The final theorem just says that these three zeros are equal.

---

## Mathematical content in plain language

**This code proves nothing new.**  
It is a parody of circular reasoning:

- The main definition `QR` is a statement of quadratic reciprocity.
- The construction `r` “proves” it by appealing to the already-known theorem in Mathlib.
- Everything after that is a trivial play with trivial finite types.

The final "theorem" `a_eq_b_eq_c` amounts to:  
> **`0 = 0` and `0 = 0`**.

---

## The joke

The file pretends to be a serious development (`Theorem_13`), imports heavy number theory libraries, defines a nontrivial-sounding predicate, and then uses all that machinery only to conclude something utterly trivial. It is a demonstration that one can make a very roundabout “proof” that `0 = 0` by dressing it up in high-level concepts.

It does **not** prove quadratic reciprocity; it assumes it from Mathlib. The actual theorem `a_eq_b_eq_c` is just an identity of three zeros.