# gpt-5.5 | theorem 11 (unique_proofs) | meaning | sample 0

*2026-06-14T23:31:36.466225+00:00, 23.39s*

## Response

This file defines two propositions and proves a theorem about them.

### The propositions

```lean
def QR := ∀ a b : ℕ, Odd a → Odd b →
  jacobiSym (↑a) b = (-1) ^ (a / 2 * (b / 2)) * jacobiSym (↑b) a
```

`QR` is the statement of quadratic reciprocity for the Jacobi symbol, phrased for odd natural numbers `a` and `b`.

In plain mathematical terms:

> For all odd natural numbers `a` and `b`,
> \[
> \left(\frac{a}{b}\right)
> =
> (-1)^{\lfloor a/2 \rfloor \lfloor b/2 \rfloor}
> \left(\frac{b}{a}\right).
> \]

Here `jacobiSym` is Mathlib’s Jacobi symbol.

---

```lean
def BCT := ∀ {X : Type} [inst : UniformSpace X]
  [CompleteSpace X] [(uniformity X).IsCountablyGenerated]
  {f : ℕ → Set X}, (∀ (n : ℕ), IsOpen (f n)) →
  (∀ (n : ℕ), Dense (f n)) → Dense (⋂ (n : ℕ), f n)
```

`BCT` is a form of the Baire category theorem.

In plain mathematical terms:

> In every complete uniform space whose uniformity is countably generated, the countable intersection of open dense subsets is dense.

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

- a proof `p` of `QR`;
- a proof `q` of `¬¬BCT`;

such that:

1. every proof of `QR` is equal to `p`;
2. every proof of `¬¬BCT` is equal to `q`;
3. the dependent pair consisting of the proposition `QR` and its proof `p` is equal to the dependent pair consisting of the proposition `¬¬BCT` and its proof `q`;
4. the function `q` is bijective.

The last point may look strange, but in Lean propositions are types. The proposition `¬¬BCT` means

```lean
(BCT → False) → False
```

so a proof `q : ¬¬BCT` is literally a function

```lean
q : ¬ BCT → False
```

Since `BCT` is true, `¬ BCT` is empty, and `False` is also empty. Thus `q` is a function from the empty type to the empty type, which is bijective.

---

### Plain-language mathematical content

The theorem proves that:

> Quadratic reciprocity for the Jacobi symbol is true, and the Baire category theorem is not false. Moreover, because Lean treats propositions proof-irrelevantly, all proofs of these propositions are equal. Since both propositions are true, the proof-carrying proposition `QR` is equal, as an element of the type of true propositions, to the proof-carrying proposition `¬¬BCT`. Finally, the proof of `¬¬BCT`, viewed as a function from `¬BCT` to `False`, is a bijection between two empty types.

The mathematically substantive facts used are:

- quadratic reciprocity for the Jacobi symbol, from Mathlib;
- the Baire category theorem for complete uniform spaces with countably generated uniformity, from Mathlib.

The rest of the theorem is mostly about Lean’s logical foundations: proof irrelevance, propositions as types, and equality of true propositions via propositional extensionality.