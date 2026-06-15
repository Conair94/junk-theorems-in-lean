# deepseek-v4-pro | theorem 13 (Theorem_13.a_eq_b_eq_c) | meaning | sample 2

*2026-06-14T22:55:57.515434+00:00, 36.08s*

## Reasoning (chain of thought)

We need to parse this Lean code and understand what it's doing. It defines a bunch of terms in a namespace `Theorem_13`. The code seems to be a joke or a trick: it proves that some elements are equal, but the definitions are deliberately obfuscated using `QR`, a setoid, quotient types, etc. Let's analyze.

First, the import statements: it imports various mathlib files, but many are likely not used significantly.

The code defines:

```
def QR := ∀ a b : ℕ, Odd a → Odd b →
  jacobiSym (↑a) b = (-1) ^ (a / 2 * (b / 2)) * jacobiSym (↑b) a
```

`QR` is a proposition: For all natural numbers a and b, if a is odd and b is odd, then the Jacobi symbol (ja↑ a) b equals (-1)^(a/2 * (b/2)) * Jacobi symbol (↑b) a. This is essentially the statement of quadratic reciprocity for the Jacobi symbol, but with a and b natural numbers? The usual quadratic reciprocity for Jacobi symbols states: For odd coprime integers m, n, (m/n) * (n/m) = (-1)^{((m-1)/2)*((n-1)/2)}. However, here it's with a/2, not (a-1)/2. So `a/2` is natural division. This is not the correct statement; maybe it's a distorted version. The Jacobi symbol in mathlib might be defined for integers? Actually, `jacobiSym` from `NumberTheory.LegendreSymbol.JacobiSymbol` likely takes two integers or natural numbers? The code uses `jacobiSym (↑a) b` implying `a` is coerced to something, maybe `ℤ`? So the statement might be a variant of quadratic reciprocity. But importantly, the `QR` is a proposition, possibly true? Or false? The code doesn't assert it's true; it just defines it.

Then it has:

```
instance QR_setoid : Setoid QR where
  r := (· = ·)
  iseqv := by constructor; all_goals simp
```

This defines a setoid on the type `QR` (the type of that proposition, i.e., the type of all proofs of `QR`). `Setoid` is an equivalence relation on a type; here it uses equality as the relation, which is always an equivalence relation. So `QR_setoid` is just the trivial setoid on `QR`.

Then:

```
def QR_mod_eq := Quotient QR_setoid
```

This defines `QR_mod_eq` as the quotient of `QR` by equality. That's just isomorphic to `QR` itself, since the equivalence is equality. So `QR_mod_eq` is essentially the type of all proofs of `QR`, but with equality promoting to equivalence classes. Since the relation is equality, the quotient is just the original type, but with a wrapper. It's a type with one element per proof of `QR`.

Then:

```
def r : QR_mod_eq :=
  Quot.mk (· = ·) (by unfold QR; grind [jacobiSym.quadratic_reciprocity])
```

Here they attempt to define an element `r` of `QR_mod_eq` by taking a proof of `QR` and applying the quotient constructor. The proof is provided by `by unfold QR; grind [jacobiSym.quadratic_reciprocity]`. `grind` is a tactic? Probably it's a term that is meant to be a proof. `jacobiSym.quadratic_reciprocity` is a lemma in mathlib: that's the quadratic reciprocity for Jacobi symbols. But `jacobiSym.quadratic_reciprocity` is about integers, and the statement might be exactly `QR`? Let's inspect what the lemma says. The typical lemma in `Mathlib/NumberTheory/LegendreSymbol/JacobiSymbol` is `quadratic_reciprocity` with type `(a / b) * (b / a) = (-1)^(((a-1)/2)*((b-1)/2))` for odd coprime integers a, b. But the `QR` statement uses `a/2` and `b/2`, not `(a-1)/2`. So they are different. The `QR` as written is likely false: e.g., take a=1, b=1: LHS jacobiSym(1,1)=1; RHS (-1)^(0*0)*1=1. a=3, b=5: a/2 = 1, b/2 = 2, exponent = 2, (-1)^2 = 1; RHS = 1*jacobiSym(5,3). jacobiSym(5,3) = (5 mod 3) = jacobiSym(2,3). 2 is not odd? Jacobi symbol requires odd denominator, 3 is odd, so (2/3) = -1? Let's compute: Legendre symbol (2/3) = -1. So jacobiSym(2,3) = -1. So RHS = -1. LHS: jacobiSym(3,5) = (3/5)=? 3 mod 5 = 3, 3 is quadratic residue mod 5? 3^2=9≡4; 4^2=16≡1; so 3 is not a square mod 5, so (3/5)=-1. So LHS = -1, RHS = -1. So it might be actually true? Let's test: a=3, b=7: a/2=1, b/2=3, exponent=3 -> (-1)^3=-1. LHS jacobiSym(3,7) = (3/7) =? 3^2=9≡2; 3^3=27≡6; 3^4=81≡4; 3^5=12≡5; 3^6=15≡1. Wait, by Euler's criterion, 3^{(7-1)/2}=3^3=27≡6≡-1 mod 7, so (3/7) = -1. So LHS = -1. RHS = (-1)*jacobiSym(7,3). jacobiSym(7,3) = (7 mod 3) = (1/3) = 1. So RHS = -1*1 = -1. Works. a=1, b=any odd: a/2=0, exponent=0, LHS=1, RHS=1*jacobiSym(b,1)=1*1=1. a=5, b=3: a/2=2, b/2=1, exponent=2 -> 1. LHS jacobiSym(5,3)=(2/3)=-1. RHS=1*jacobiSym(3,5)=(3/5)=-1. Works. So the formula appears to hold? Let's think: Quadratic reciprocity for Jacobi symbols: For odd coprime a,b: (a/b) * (b/a) = (-1)^{((a-1)/2)*((b-1)/2)}. The given formula is (a/b) = (-1)^{(a/2)*(b/2)} * (b/a). Is it equivalent? Multiply both sides by (b/a): (a/b)*(b/a) = (-1)^{(a/2)*(b/2)}. So they claim that ((a-1)/2)*((b-1)/2) ≡ (a/2)*(b/2) modulo 2? Since (-1)^k depends only on k mod 2. So we need to check if ((a-1)/2)*((b-1)/2) ≡ (a/2)*(b/2) mod 2 for all odd a,b. Compute: Let a = 2m+1, then (a-1)/2 = m, a/2 = m (since integer division floors; 2m+1/2 = m). So for odd a, a/2 = (a-1)/2 exactly. So the two expressions are identical! Because if a is odd, a = 2k+1, a/2 (natural division) = k, and (a-1)/2 = k. So they are equal. Wait, the division used here: `a / 2` in `ℕ` is natural division (floor division). For a odd, a/2 = (a-1)/2 exactly. So indeed (a/2)*(b/2) = ((a-1)/2)*((b-1)/2). Thus the exponent is the same. So `QR` is actually exactly the quadratic reciprocity statement for Jacobi symbols, but with the condition that a and b are odd natural numbers. However, note that Jacobi symbol is defined for integers, and the condition for the reciprocity theorem is that a and b are odd and positive? Actually, `quadratic_reciprocity` in mathlib requires that a and b are odd integers (maybe nonzero) and coprime? The lemma `jacobiSym.quadratic_reciprocity` likely states: for a b : ℤ, with a % 2 = 1, b % 2 = 1, and a.gcd b = 1, we have (a/b)*(b/a) = (-1)^((a-1)/2*(b-1)/2). Using `↑a` coerces ℕ to ℤ. The condition `Odd a` in ℕ means a is odd natural number. But the lemma may also require coprimality? Jacobi symbol can be defined for non-coprime but it's zero if they share a factor. However, quadratic reciprocity for Jacobi symbol usually requires positive odd integers that are coprime, or else the formula involves terms of 0. The lemma might incorporate that. Anyway, the given `QR` is a true statement; it's the quadratic reciprocity for Jacobi symbols for odd natural numbers (but they didn't include coprime condition, but Jacobi symbol is 0 if not coprime, and the formula might still hold with 0? Let's test: a=3, b=9: both odd. a/2=1, b/2=4, exponent 4 -> 1. LHS jacobiSym(3,9) = 0 because 3 divides 9? Jacobi symbol (a/n) requires n odd positive, and if gcd(a,n)≠1, then (a/n)=0. So LHS=0. RHS = 1 * jacobiSym(9,3). jacobiSym(9,3) = (9 mod 3) = (0/3) = 0. So RHS=0. Works. So indeed the formula holds even without coprime condition; it's consistent. So `QR` is a true theorem, which is the quadratic reciprocity for Jacobi symbols for odd natural numbers. But is it exactly `jacobiSym.quadratic_reciprocity`? The lemma may be exactly that but with a and b as ℤ. So `by unfold QR; grind [jacobiSym.quadratic_reciprocity]` should indeed provide a proof. So `r` is a term of `QR_mod_eq` corresponding to that proof.

Next:

```
def q : QR_mod_eq := Classical.choice ⟨r⟩
```

`Classical.choice` takes a nonempty type and returns an element. `⟨r⟩` is a proof that `QR_mod_eq` is nonempty, since `r` is an element. So `q` is an element of `QR_mod_eq` chosen using `Classical.choice`. By classical logic, this is equal to `r`? Not necessarily; `Classical.choice` picks an arbitrary element from the nonempty type. Since `QR_mod_eq` might have multiple elements (different proofs of `QR`), `q` could be any of them. But we have `lemma q_eq_r : q = r := by simp` . This lemma says `q = r`. Let's see: `simp` is used. Does `simp` know that `Classical.choice ⟨r⟩ = r`? Yes, there is a lemma `Classical.choice_eq`? Actually, `by simp` might use `Classical.choice_eq_of_subsingleton` if the type is a subsingleton. Is `QR_mod_eq` a subsingleton? The quotient by equality of a proposition is a subsingleton, because a proposition is a subsingleton (proofs are equal). In Lean, `QR` is a `Prop`, so all proofs of `QR` are equal. Therefore, the quotient type `QR_mod_eq` also has at most one element. Thus `q` must equal `r`. `simp` might know that because of `Subsingleton`. Indeed, `simp` can use `Subsingleton.elim`. So `q_eq_r` is proven.

Next:

```
def f : QR_mod_eq → ℕ := Quot.lift (fun _ ↦ 1) (by simp)
```

This defines a function `f` from `QR_mod_eq` to `ℕ` by lifting a constant function on `QR` that always returns 1. The `Quot.lift` requires a proof that the function respects the equivalence relation, which is trivial because it's constant. So `f x = 1` for any `x`. Indeed, `f` is the constant function 1. So `f q = 1` and `f r = 1`. The lemma `f_q_eq_one` shows `f q = 1` by rewriting with `q_eq_r` and then `unfold f r; simp`.

Next:

```
def a : Fin (f q) := ⟨0, by rw [f_q_eq_one]; simp⟩
```

`f q = 1`, so `Fin (f q)` is `Fin 1`. `a` is defined as 0 in `Fin 1`. The proof of `0 < 1` is easy.

```
def b : Fin (f r) := ⟨0, by unfold f r; simp⟩
```

`f r` also equals 1, but the proof uses `unfold f r; simp` to show `0 < 1`. So `b` is also 0 in `Fin 1`.

```
def c : Fin 1 := 0
```

So `c` is 0 in `Fin 1`.

Theorem:

```
theorem a_eq_b_eq_c : a = b ∧ b = c := by
  constructor; all_goals rfl
```

`rfl` works because `a`, `b`, `c` are all defined as `0` in `Fin 1`. So this is trivially true.

Now, what is the mathematical content of the main theorem? It states `a = b ∧ b = c`, where `a`, `b`, `c` are terms of `Fin 1` (all 0). So it's a trivial equality. But the names and the context are a joke about "Theorem 13" perhaps referencing some famous theorem? The file is called `Theorem_13`. It might be a parody of a complicated theorem number 13, but actually it proves something trivial using heavy machinery like Jacobi symbol, quotient, setoid, etc. The main theorem is just that 0 = 0 and 0 = 0.

The user asks: "What does this Lean 4 code mean, and what theorem is it proving? State the mathematical content of the main theorem in plain language."

So we need to explain that the code defines a type representing quadratic reciprocity for Jacobi symbols, constructs two elements of a trivial quotient type that are equal because of proof irrelevance, defines a constant function, then defines elements in `Fin 1` which are all zero, and proves they are equal. The main theorem is `a = b ∧ b = c`, i.e., all three constants of type `Fin 1` are equal (which is trivially true). In plain language: "Theorem 13" states that three particular elements of the single-element set (the natural numbers less than 1) are equal; in other words, 0 = 0 and 0 = 0.

But maybe the joke is that "Theorem 13" is actually a disguised trivial equality. We can also mention that the code is an elaborate way of stating a trivial fact.

Thus the answer: The Lean code is a comedic obfuscation: it imports heavy number theory, defines a proposition `QR` (quadratic reciprocity for Jacobi symbols), sets up a quotient, uses `Classical.choice`, defines a constant function to `ℕ`, and finally constructs three terms of `Fin 1`, then proves they are all equal. The main theorem (`a_eq_b_eq_c`) simply asserts that three specific elements of the one-element type `Fin 1` are equal—which is trivially true because there is only one value, `0`.

I'll phrase it clearly.

## Response

The Lean code is a deliberately overcomplicated joke. Under a mountain of irrelevant imports, it defines a proposition `QR` (a correct variant of quadratic reciprocity for the Jacobi symbol), uses setoids, quotients, and classical choice to construct two different-looking but equal terms, applies a constant function to them to get `1`, and finally builds three elements of the finite type `Fin 1` (natural numbers less than 1). The "main theorem" of the piece, `a_eq_b_eq_c`, is simply the trivial statement that all three of these elements are equal—in other words, that `0 = 0` and `0 = 0`. The mathematical content is the trivial equality of elements in a singleton set.