# gpt-5.5 | theorem 14 (Theorem_14.overflow) | meaning | sample 2

*2026-06-14T23:41:56.815914+00:00, 42.64s*

## Response

This Lean file defines a namespace `Theorem_14` and then proves a theorem named

```lean
Theorem_14.overflow : 0 = 1
```

In plain mathematical language, the main theorem says:

> **Zero equals one.**

That is, it proves an absurd contradiction. In ordinary mathematics this is false, so the file is demonstrating inconsistency arising from the added axiom and the way the cast/native computation is being used.

What the code does:

```lean
def IntFin (k : ℕ) := { x : ℤ // 0 ≤ x ∧ x < k }
```

This defines `IntFin k` to be the subtype of integers `x` satisfying `0 ≤ x < k`. So `IntFin 5` would be the integers `0, 1, 2, 3, 4`, represented as integers with proofs of the bounds.

```lean
axiom Fin_eq_IntFin_2147483649 :
  Fin 2147483649 = IntFin 2147483649
```

This postulates as an axiom that the Lean type `Fin 2147483649` is equal as a type to `IntFin 2147483649`.

Mathematically, these types are naturally equivalent: both have `2147483649` elements. But in Lean, equality of types is much stronger than mere bijection/equivalence, especially because it allows `cast` to reinterpret values across that equality.

The theorem is:

```lean
theorem overflow : 0 = 1 := by
  let h := (cast Fin_eq_IntFin_2147483649 2147483648).2
  have h2 : (cast Fin_eq_IntFin_2147483649 2147483648).1 = -2147483648 :=
    by native_decide
  rw [h2] at h
  tauto
```

It casts the element `2147483648 : Fin 2147483649` into the type `IntFin 2147483649`. Since an element of `IntFin 2147483649` carries a proof that its underlying integer is nonnegative and less than `2147483649`, the term

```lean
(cast Fin_eq_IntFin_2147483649 2147483648).2
```

is a proof that its integer value lies in that range.

But then the code proves using `native_decide` that the underlying integer value is actually

```lean
-2147483648
```

So after rewriting, it obtains a proof of something like

```lean
0 ≤ -2147483648 ∧ -2147483648 < 2147483649
```

The first conjunct is false. From that contradiction, `tauto` proves anything, in particular `0 = 1`.

So the mathematical content of the theorem is simply:

> Assuming the axiom `Fin 2147483649 = IntFin 2147483649`, Lean derives a contradiction, namely `0 = 1`.

This is not a valid theorem of ordinary mathematics. It is an inconsistency-producing example, exploiting an unsafe/false type equality axiom together with native computation/casting behavior.