# deepseek-chat | theorem 14 (Theorem_14.overflow) | meaning | sample 0

*2026-06-14T22:59:11.721398+00:00, 8.35s*

## Response

This Lean 4 code is a deliberately crafted "proof" of a contradiction \[0 = 1\]. It exploits the fact that `Fin 2147483649` has exactly `2147483649` elements, while `IntFin 2147483649` is defined as  

```lean4
{ x : ℤ // 0 ≤ x ∧ x < k }
```  
with `k = 2147483649`.  

The set `{ x : ℤ // 0 ≤ x ∧ x < 2147483649 }` has `2147483649` elements (the integers 0 through `2147483648` inclusive), so the two types do have the same cardinality.  

However, they are not *definitionally* equal. The line  

```lean4
axiom Fin_eq_IntFin_2147483649 : Fin 2147483649 = IntFin 2147483649
```  

simply assumes as an axiom that the two types are **equal** (as types). In Lean's type theory, a type equality `A = B` means that `A` and `B` can be treated as identical in all contexts. In particular, if `A = B`, then any element of `A` can be cast to an element of `B` and every property of `A` transfers to `B`.

---

### What the "proof" does

1. `(cast ... 2147483648)` takes the element `2147483648` of `Fin 2147483649` and, using the (false) axiom, treats it as an element of `IntFin 2147483649`.

2. For an element of `IntFin 2147483649`, its second component is a proof that its first component `x` satisfies `0 ≤ x ∧ x < 2147483649`.  

3. The `native_decide` tactic then *computes* that the first component of that cast element is `-2147483648`. Note that `2147483648` in `ℤ` is `-2147483648` as an `Int32` (a signed 32‑bit integer overflow). `native_decide` uses machine integer arithmetic, which wraps around modulo `2^32`. So `2147483648` as a `ℤ` constant is actually `-2147483648` in `ℤ` because `ℤ` has an `Int` representation in the kernel.

4. Replacing the first component with `-2147483648` in the constraint `0 ≤ x` gives `0 ≤ -2147483648`, which is false (since `-2147483648` is negative).  

5. `tauto` then deduces a contradiction: from the false assumption we conclude `0 = 1`.

---

### Mathematical content

In plain language:  

> Assuming that the finite type `Fin n` (with `n` elements) is equal to the subset of ℤ consisting of the integers from 0 to `n-1` leads, via machine-integer overflows in the `native_decide` tactic, to a contradiction that proves `0 = 1`.

The "theorem" `overflow : 0 = 1` is nonsense; the code is essentially a demonstration of what can go wrong when you add false axioms and rely on `native_decide`’s behavior with large integers near the 32‑bit boundary. Obviously, `0 ≠ 1` in any reasonable system, so the "proof" is invalid and highlights subtle dangers in combining inconsistent axioms with `native_decide`.