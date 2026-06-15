# gpt-5.5 | theorem 14 (Theorem_14.overflow) | compiles | sample 1

*2026-06-14T23:38:48.553931+00:00, 273.31s*

## Response

The file is accepted by Lean on the usual current Mathlib/Lean setup.

The key point is the interaction between the axiom

```lean
axiom Fin_eq_IntFin_2147483649 : Fin 2147483649 = IntFin 2147483649
```

and `native_decide`.

Logically, `cast Fin_eq_IntFin_2147483649 2147483648` transports a value of type `Fin 2147483649` to the subtype `IntFin 2147483649`. In kernel reduction this cast is not definitionally reducible, since the equality proof is an axiom.

However, `native_decide` evaluates using Lean’s native runtime, where proof arguments and casts are erased. Thus the runtime representation of the `Fin` value is reinterpreted as the runtime representation of an `IntFin` value. The stored `Nat` value `2147483648` is then viewed as an `Int`, yielding `-2147483648` in the native representation. Therefore this line is accepted:

```lean
have h2 : (cast Fin_eq_IntFin_2147483649 2147483648).1 = -2147483648 :=
  by native_decide
```

After rewriting the subtype proof `h` using `h2`, Lean obtains a contradiction from a proof of a false integer inequality such as `0 ≤ -2147483648`, and `tauto` closes the goal `0 = 1`.

So despite proving an absurd theorem, the file is accepted because of the axiom plus native evaluation behavior.

VERDICT: COMPILES