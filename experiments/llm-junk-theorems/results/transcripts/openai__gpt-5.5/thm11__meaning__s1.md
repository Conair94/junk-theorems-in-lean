# gpt-5.5 | theorem 11 (unique_proofs) | meaning | sample 1

*2026-06-14T23:31:59.855445+00:00, 45.51s*

## Response

This file defines two propositions, then proves a deliberately “type-theoretic” theorem about proofs of them.

### The two propositions

#### `QR`

```lean
def QR := ∀ a b : ℕ, Odd a → Odd b →
  jacobiSym (↑a) b = (-1) ^ (a / 2 * (b / 2)) * jacobiSym (↑b) a
```

`QR` is a statement of quadratic reciprocity for the Jacobi symbol.

In ordinary notation, for odd natural numbers `a` and `b`, it says roughly

\[
\left(\frac{a}{b}\right)
=
(-1)^{\lfloor a/2 \rfloor \lfloor b/2 \rfloor}
\left(\frac{b}{a}\right).
\]

For odd `a`, `a / 2` in Lean’s natural-number division is \((a-1)/2\), so this is the usual sign appearing in quadratic reciprocity.

The proof later uses Mathlib’s theorem

```lean
jacobiSym.quadratic_reciprocity
```

to prove this proposition.

#### `BCT`

```lean
def BCT := ∀ {X : Type} [inst : UniformSpace X]
  [CompleteSpace X] [(uniformity X).IsCountablyGenerated]
  {f : ℕ → Set X}, (∀ (n : ℕ), IsOpen (f n)) →
  (∀ (n : ℕ), Dense (f n)) → Dense (⋂ (n : ℕ), f n)
```

`BCT` is a version of the Baire category theorem.

It says:

> In every complete uniform space whose uniformity is countably generated, the countable intersection of open dense sets is dense.

The proof later uses Mathlib’s Baire theorem:

```lean
BaireSpace.baire_property
```

---

### The main theorem

```lean
theorem unique_proofs :
    ∃ p : QR, ∃ q : ¬¬BCT, (∀ r : QR, p = r)
                         ∧ (∀ r : ¬¬BCT, q = r)
                         ∧ ⟨QR,p⟩ = (⟨¬¬BCT,q⟩ : Σ' A : Prop, A)
                         ∧ Function.Bijective q := by
  ...
```

This theorem asserts the existence of:

* a proof `p` of `QR`;
* a proof `q` of `¬¬BCT`;

such that:

1. every proof of `QR` is equal to `p`;
2. every proof of `¬¬BCT` is equal to `q`;
3. the dependent pair consisting of the proposition `QR` together with its proof `p` is equal to the dependent pair consisting of the proposition `¬¬BCT` together with its proof `q`;
4. viewing `q : ¬¬BCT` as a function

   ```lean
   q : ¬BCT → False
   ```

   this function is bijective.

---

### Plain-language mathematical content

Ignoring the proof-irrelevance and dependent-type bookkeeping, the mathematical content is:

> Quadratic reciprocity for the Jacobi symbol is true, and the Baire category theorem for complete countably generated uniform spaces is true.

The rest of the theorem is mostly about Lean’s treatment of propositions as types.

Because Lean’s universe of propositions `Prop` is proof-irrelevant, any two proofs of the same proposition are equal. Therefore, once `QR` is proved, all proofs of `QR` are equal. Similarly, once `¬¬BCT` is proved, all proofs of `¬¬BCT` are equal.

The equality

```lean
⟨QR,p⟩ = (⟨¬¬BCT,q⟩ : Σ' A : Prop, A)
```

is also a proof-irrelevance/propositional-extensionality artifact. Since both `QR` and `¬¬BCT` are true propositions, they are logically equivalent, hence equal as propositions in Lean’s `Prop`.

Finally, `q : ¬¬BCT` is a function

\[
\neg BCT \to \mathrm{False}.
\]

Since `BCT` is true, `¬BCT` is empty, so this is essentially the unique function from the empty type to the empty type, and it is bijective.

So the theorem is not saying that quadratic reciprocity and the Baire category theorem are mathematically the same theorem. Rather, it exploits Lean’s proof irrelevance: as propositions, once both are true, their proofs are unique, and their inhabited `Prop`-sigma packages can be identified.