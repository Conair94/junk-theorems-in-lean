# deepseek-v4-pro | theorem 5 (Riemann_hypothesis_in_closure_of_not_not) | compiles | sample 2

*2026-06-14T22:47:27.299896+00:00, 45.87s*

## Reasoning (chain of thought)

We are asked: Does this Lean 4 code compile? We need to reason and then give VERDICT: COMPILES or DOES NOT COMPILE.

Let's examine the code.

First, imports:
```lean4
import Mathlib.Algebra.Category.Grp.Basic
import Mathlib.Algebra.Ring.BooleanRing
import Mathlib.Data.Nat.PSub
import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.List.Basic
```
These are random imports. They likely include a lot of things but maybe not necessary. The code uses `RiemannHypothesis` but where is that defined? I don't see it defined in this file, and none of the imports seem to contain that theorem/proposition. Mathlib might have something like `RiemannHypothesis`? Let's check: `Mathlib.NumberTheory.Harmonic.ZetaAsymp` could contain something about Riemann Hypothesis? Actually, I don't think `RiemannHypothesis` is defined in Mathlib as a Prop. There is no `RiemannHypothesis` in current Mathlib (as of now). Even if there were, the code would need to have it available. The code references `RiemannHypothesis` in the final theorem. It's not defined, so that would cause an error.

Also, the code uses `grind` tactic. Is `grind` a tactic in Lean 4? I think `grind` is a tactic from `Mathlib`? Actually, `grind` might be a tactic in development or not in standard mathlib? There's `grind` tactic? I'm not sure. In Lean 4, `grind` is a tactic for `Nat` and `Int` inequalities? I think `grind` is a tactic from `Mathlib` that solves certain goals. I'm not certain it's present. The code uses `grind` in several places. It might not be recognized, causing error.

Next, the lemmas:

`Prop.isOpen_iff` uses `IsOpen X` for `X : Set Prop`. `IsOpen` is from topology? The file imports `Algebra.Category.Grp.Basic`, which might not bring topology. But `IsOpen` is a typeclass from `Topology`. They haven't imported `Mathlib.Topology.Basic`. Without the topology import, `IsOpen` might not be defined. However, `Set` might have a topology? There is a topology on `Prop`? Maybe there's a topology defined on `Prop` in some mathlib file? Actually, `Prop` has a topology as a discrete space? In `Mathlib` there is an instance of `TopologicalSpace Prop`? Possibly from `Mathlib.Topology.Instances.Prop`? But not imported here. So `IsOpen` would be unknown. Indeed, the code uses `IsOpen` and `IsClosed` on `Set Prop`. That likely requires a topology instance. Unless `Set` has a topology by default? No. So `IsOpen` is an error.

Also, `aesop` tactic used. It's present in Mathlib? Yes, `Aesop` is available.

The final theorem:
```lean4
theorem Riemann_hypothesis_in_closure_of_not_not : RiemannHypothesis ∈ closure (¬¬ ·) := by
  have h3 : (¬¬ ·) = ({⊤} : Set Prop) := by
    unfold Not singleton Set.instSingletonSet Set.singleton; aesop
  rw [h3,Prop.closure_singleton_true_univ]; simp
```

- `RiemannHypothesis` is a proposition, as a term of type `Prop`. But `closure` is on `Set Prop`? Actually `closure` expects a set of `α` in a topological space. Here `(¬¬ ·)` is an expression `Not (Not (·))`? It's `¬¬ ·`, a lambda that takes `P : Prop` and returns `¬¬ P`. But the notation `(¬¬ ·)` might be ambiguous. It could be interpreted as `fun x => ¬¬ x`. That's a `Set Prop` (a `Set Prop` is `Prop → Prop`). So `closure (¬¬ ·)` is the closure of that set. The statement `RiemannHypothesis ∈ closure (¬¬ ·)` means `RiemannHypothesis` is in the closure of the set of propositions `P` such that `¬¬ P` (which is all propositions, because `¬¬ P` is true for all `P` in classical logic? Actually, `¬¬ P` is `¬ (¬ P)`. For any `P`, `¬¬ P` holds if we have classical logic? No, `¬¬ P` is equivalent to `P` in classical logic, but as a proposition `¬¬ P` is not necessarily `True`. In Prop, `¬¬ P` is `P → False → False` which is equivalent to `P` only if we have `∀ P, ¬¬ P → P`. In constructive logic, `¬¬ P` does not imply `P`. But if we consider `Set Prop`, the set `(¬¬ ·)` is the set of propositions `P` for which `¬¬ P` holds, i.e., all `P` where `¬¬ P` is true. In classical logic, `¬¬ P` is true for all `P`? Actually `¬¬ P` is a proposition that is true exactly when `P` is not false, i.e., `P` is true. So the set is exactly `{P : Prop // P}`? Wait, `Set Prop` is `Prop → Prop`; the element `(¬¬ ·)` is a function `Prop → Prop`. So `a ∈ s` for `s : Set Prop` means `s a` is `True`? Actually `Set α` is `α → Prop`. So `x ∈ s` means `s x` (a proposition). So `(¬¬ ·)` applied to `P` is `¬¬ P`. So the set `(¬¬ ·)` is `λ P => ¬¬ P`. Its closure in the topology on `Prop` (if such exists) is something. Then they are trying to show `RiemannHypothesis` is in that closure. That seems like a joke: Riemann Hypothesis is in the closure of the set of propositions not not P. Usually such a theorem is trivially true because closure of that set might be the whole space. They show `(¬¬ ·) = ({⊤} : Set Prop)`. Is that true? `{⊤}` is the singleton set containing `True`? `⊤` in `Prop` is `True` (since `Prop` is a `CompleteSemilatticeSup` with `⊤ = True`). So `({⊤} : Set Prop)` is the set `{True}`. So `(¬¬ ·)` is being claimed equal to `{True}`. That would mean that `¬¬ P` is true for exactly those `P` that are equal to `True`. That's false: `¬¬ False` is `¬¬ False = False → False` which is `True` (since `False → False` is `True`). Indeed `¬¬ False` is `True`. So `¬¬ False` holds. Thus `(¬¬ ·)` includes `False` as well? Let's check: for any `P`, `¬¬ P` is `(P → False) → False`. If `P` is `False`, then `¬¬ False` is `(False → False) → False`? Actually `¬ P` is `P → False`. So `¬¬ P` is `(P → False) → False`. If `P = False`, then `¬¬ False` = `(False → False) → False`? Wait, `P → False` where `P = False` is `False → False`, which is true. Then `¬¬ False` = `(False → False) → False`? No, `¬¬ P` = `¬ (¬ P)`. `¬ P` is `P → False`. So `¬¬ P` = `(P → False) → False`. For `P = False`, `¬ P` = `False → False` which is `True` (type `True`). Then `¬¬ P` = `True → False`? Actually `¬ (¬ False)` = `¬ True`. `True` is `True` the proposition. `¬ True` is `True → False`, which is `False`. Wait, careful: `¬ P` is `P → False`. So `¬ True` is `True → False` = `False`. `¬ False` is `False → False` = `True`. So `¬¬ False` = `¬ (¬ False)` = `¬ True` = `False`. So `¬¬ False` = `False`. That's consistent: `¬¬ False` is `False`? Let's double-check: `¬¬ False` is `¬ (¬ False)`. `¬ False` is `True`. Then `¬ True` is `False`. So `¬¬ False` is `False`. So `(¬¬ ·) False` = `False`. So `(¬¬ ·)` is not `True` for all `P`. For `P = False`, `¬¬ P` is `False`, so `False` is not in the set. For `P = True`, `¬¬ True` = `¬ (¬ True)` = `¬ False` = `True`. So `True` is in. For any other `P`, `¬¬ P` is not necessarily `True`. So `(¬¬ ·)` is the set of `P` such that `¬¬ P` is true. In classical logic with LEM, `¬¬ P ↔ P`. So `(¬¬ ·)` would be exactly the set of true propositions? Wait, `P` is a proposition, `(¬¬ ·) P` is the proposition `¬¬ P`. So the set `(¬¬ ·)` is `λ P => ¬¬ P`. The statement `P ∈ (¬¬ ·)` is `¬¬ P`. So the set is the extension of the predicate `¬¬`. So it contains all `P` that satisfy `¬¬ P`. That includes `True` (since `¬¬ True` is true), but does not include `False` because `¬¬ False` is false. So `(¬¬ ·)` = `{P | ¬¬ P}`. Is that equal to `{⊤}` i.e. `{True}`? No, because for any `P` that is true, `¬¬ P` is true. But in Prop, there are many distinct true propositions, like `True`, `1=1`, etc. They are all equal by proof irrelevance? Actually, `Prop` has proof irrelevance, so all true propositions are equal? In `Prop`, there is `propext` which makes equivalent propositions equal. So if `P` is true, then `P` is equivalent to `True`, so by `propext`, `P = True`. So all true propositions are equal to `True`! Because `True` is the terminal object in `Prop`. So `P = True` for any true `P`. So the set `{P | ¬¬ P}` is the set of all true propositions, which under propositional extensionality is just `{True}`. Indeed, in Lean, if we have `propext`, all true propositions are equal to `True`. So `¬¬ P` holds iff `P` is true (in classical logic, `¬¬ P ↔ P`). But here we don't assume classical logic? Lean's `Prop` has `propext` and `em` (by default, `open Classical` is not imported but `em` is an axiom in Lean's core? Actually, Lean's core logic is constructive, but `Classical.choice` gives classical logic. The mathlib library often uses classical logic. The standard environment includes `Classical`? By default, Lean's kernel is constructive, but mathlib often works in classical logic with `open Classical` or `em` as an axiom. However, `Prop` equality uses `propext` which says equivalent propositions are equal. So `¬¬ P ↔ P` is not an axiom unless we assume LEM. But we have `by_contra` and `Classical.em` available as a global axiom. In mathlib, `Classical.em` is often used. In any case, the lemma `h3 : (¬¬ ·) = ({⊤} : Set Prop)` uses `aesop` and `unfold Not singleton Set.instSingletonSet Set.singleton`. It might be true in classical logic because `¬¬ P` is equivalent to `P`, and `⊤` is `True`. So the set `fun P => ¬¬ P` is equal to `fun P => P`? But `P` is not `True` unless `P` is true. The set `{⊤}` is `fun P => P = ⊤` (since `Set.singleton a` is `fun x => x = a`). So `({⊤} : Set Prop)` is `fun P => P = ⊤`. Is `fun P => ¬¬ P` equal to `fun P => P = ⊤`? In the presence of `propext` and LEM, yes, because `¬¬ P` holds iff `P` is true iff `P = True`. But is `P` equal to `True` if `P` is true? By `propext`, if `P` is true, `P ↔ True`, so `P = True`. So if `P` is true, `¬¬ P` is true, and `P = True`. So the two sets coincide. So the lemma might be provable. The `unfold` part: `Not` is `¬`, `singleton` is `Set.singleton`. The goal would be `(fun P => ¬¬ P) = (fun P => P = True)`. `aesop` might handle it using `propext`. So that might succeed.

But then `closure_singleton_true_univ` says closure of `{⊤}` is `Set.univ`. That is based on `Prop.isOpen_iff` and `Prop.isClosed_iff`. Those lemmas define the topology on `Prop` as having open sets only `∅`, `{⊤}`, and `Set.univ` (maybe also `{⊥}`?). Actually `isOpen_iff` says `IsOpen X ↔ X = ∅ ∨ X = {⊤} ∨ X = Set.univ`. So the topology is the one where only these three sets are open. Is that a valid topology? It must contain `∅` and `Set.univ` (which it does), and be closed under arbitrary unions and finite intersections. The set `{⊤}` being open would give a peculiar topology (the particular point topology). Does this topology satisfy the axioms? Possibly. However, is `IsOpen` defined on `Set Prop`? For `IsOpen` to be a proposition, we need a `TopologicalSpace` instance on `Prop`. But we have no instance imported. That's likely an error. `IsOpen` is a function that depends on the `TopologicalSpace` instance. The `simp` lemmas might use `isOpen_univ` etc. But without an instance, `IsOpen X` would be an error: `failed to synthesize instance TopologicalSpace Prop`. So the file would not compile.

Furthermore, the `closure_singleton_true_univ` uses `closure`, which is from topology as well.

So the code is full of topology references that are not defined. The imports do not include any topology file. So `IsOpen`, `IsClosed`, `closure` are not available. Hence compile error.

Also `RiemannHypothesis` is undefined. Could it be defined in one of the imports? Let's check the imports one by one:

- `Algebra.Category.Grp.Basic` - about category of groups, not likely.
- `Algebra.Ring.BooleanRing` - Boolean rings, unlikely.
- `Data.Nat.PSub` - maybe partial subtraction? unlikely.
- `NumberTheory.Harmonic.ZetaAsymp` - asymptotic of zeta, maybe there is a statement of Riemann Hypothesis? In Mathlib, there is `RiemannHypothesis` defined as a proposition? I recall that Mathlib has `RiemannHypothesis` as a statement about the zeta function? Yes! I think `Mathlib.NumberTheory.ZetaFunction` or something defines `RiemannHypothesis` as a proposition. Actually, there is a file `NumberTheory/ZetaFunction.lean` and `NumberTheory/Harmonic/ZetaAsymp.lean`. The import `NumberTheory.Harmonic.ZetaAsymp` might indeed contain the definition `RiemannHypothesis`? Let's recall: in Mathlib4, there is `RiemannHypothesis : Prop` defined in `NumberTheory/ZetaFunction.lean` or possibly `NumberTheory/Harmonic/ZetaAsymp`? I'm pretty sure `RiemannHypothesis` exists as a statement that all non-trivial zeros have real part 1/2. The import `NumberTheory.Harmonic.ZetaAsymp` might be about asymptotic harmonic numbers, not zeta function. But there is `NumberTheory.ZetaFunction`. The import `NumberTheory.Harmonic.ZetaAsymp` may not have `RiemannHypothesis`. However, maybe `ZetaAsymp` imports `ZetaFunction`? Possibly. Let's check mental map: Mathlib4 has `NumberTheory/ZetaFunction.lean` which defines `riemannZeta`, `RiemannHypothesis`. `NumberTheory/Harmonic/ZetaAsymp.lean` might be about asymptotics of harmonic numbers and zeta. If it imports `NumberTheory.ZetaFunction`, then `RiemannHypothesis` would be available. That's plausible. The import `NumberTheory.Harmonic.ZetaAsymp` might bring in `RiemannHypothesis`. So maybe `RiemannHypothesis` is defined. I'm not 100% sure but it's plausible.

But the bigger issue is topology. `IsOpen` and `closure` need `TopologicalSpace Prop`. There is a topology on `Prop` defined in mathlib? There is `Mathlib.Topology.Instances.Prop` which gives a topology on `Prop`. Is that imported? None of the imports seem to be about topology. `Algebra.Category.Grp.Basic` might import `Topology` because group categories? No, `Algebra.Category.Grp.Basic` is about the category of groups, which does not require topology. It might import `Topology` for topological groups, but `Grp` is the category of groups with no topology. So probably not. `Algebra.Ring.BooleanRing` might import `Topology`? Not necessarily. So no topology instance for `Prop` is available. So `IsOpen` on `Set Prop` fails.

Thus the code does not compile.

But we need to be certain. Let's also check the `grind` tactic. `grind` is not a built-in tactic; it might be from `Mathlib.Tactic`? I recall there's a `grind` tactic for `Nat` arithmetic in `Mathlib/Tactic.lean`. Is it imported by default? No. The code uses `grind` without importing `Mathlib.Tactic`. In Mathlib4, `grind` might be a tactic from `Mathlib.Tactic.Grind`? I think `grind` exists as a tactic for solving `Nat` and `Int` equations/inequalities. It is not imported by default. The file doesn't import `Mathlib.Tactic`. So `grind` would be unknown. That's another error.

`aesop` is imported? No explicit import. But `aesop` is a tactic available in `Mathlib` after `import Aesop`? Typically you need `import Aesop` to use `aesop`. In many mathlib files, `aesop` is used and they have `open scoped` or import. Here, no import. So `aesop` could be unknown. That's another error.

Also, the `unfold` line uses `singleton`, `Set.instSingletonSet`, `Set.singleton`. Unfolding these may not be necessary. But `aesop` might still work if it's present.

But the fundamental error is lack of topology instance and missing `RiemannHypothesis`.

Therefore, the code will not compile.

Now, we should output exactly "VERDICT: DOES NOT COMPILE" or "VERDICT: COMPILES". Based on the analysis, it does not compile.

Reasoning: The code uses topological concepts (`IsOpen`, `IsClosed`, `closure`) on `Set Prop` without importing any topology library that provides a `TopologicalSpace Prop` instance. This will cause errors like `failed to synthesize instance TopologicalSpace Prop`. Also uses `grind` tactic without import. And possibly `RiemannHypothesis` undefined. So DOES NOT COMPILE.

Make sure: Could it be that `Set Prop` has a default topology? For any type, `Set α` has a topology if `α` has a topology? No, `Set Prop` is a type `Set Prop`. The topology would be on `Prop` itself. The `closure` is on `Set Prop`? Actually, `closure (¬¬ ·)` takes the closure of a set in `Prop`? The notation `closure` applied to a set of `Prop` is the closure in the topological space `Prop`. So we need a topology on `Prop`. By default, there is no topology. So definitely error.

Thus VERDICT: DOES NOT COMPILE.

## Response

This Lean 4 code does not compile. The main issues are:

1. **Missing topology instance**: The lemmas `Prop.isOpen_iff`, `Prop.isClosed_iff`, and `Prop.closure_singleton_true_univ` use `IsOpen`, `IsClosed`, `closure`, etc., which require a `TopologicalSpace Prop` instance. The file imports no topology module that would provide such an instance, so these terms are not recognized and typeclass synthesis fails.

2. **Undefined tactic `grind`**: The tactic `grind` is used but is not imported. It is not part of the standard Lean 4 environment; an explicit import (e.g., `import Mathlib.Tactic`) would be required.

3. **Potential missing definition of `RiemannHypothesis`**: While `RiemannHypothesis` might be defined in `NumberTheory.Harmonic.ZetaAsymp`, that import is unlikely to bring it (it usually lives in `NumberTheory.ZetaFunction`). In any case, the other errors already prevent compilation.

Because of these errors, Lean will reject the file.

VERDICT: DOES NOT COMPILE