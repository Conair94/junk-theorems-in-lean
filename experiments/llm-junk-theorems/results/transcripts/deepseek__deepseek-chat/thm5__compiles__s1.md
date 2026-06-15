# deepseek-chat | theorem 5 (Riemann_hypothesis_in_closure_of_not_not) | compiles | sample 1

*2026-06-14T22:57:39.295316+00:00, 4.72s*

## Response

The file attempts to use some nontrivial constructions, but there are several issues.

1. `IsOpen` and `IsClosed` for the type `Set Prop` refer to the standard topology on `Prop`? In Mathlib, `Prop` is not normally given a nontrivial topology; the lemmas `isOpen_iff` and `isClosed_iff` as stated would need a topological space instance for `Prop`. There is no such standard instance and the file does not open one. The lemmas therefore would not apply without an explicit topology.

2. The syntax `(¬¬ ·)` expects a binder of type `Prop → Prop`? Actually `¬¬` is a propositional operator, but using `·` as a placeholder in a set is not valid there—you can't write `(¬¬ ·)` to mean the set `{x | ¬¬ x}`; the correct syntax would be `{x : Prop | ¬¬ x}`.

3. The proof in `Prop.closure_singleton_true_univ` uses `grind` and `simp` heavily, but these rely on the topology being defined, which it is not.

4. `RiemannHypothesis` is a proposition (`Prop`), not a term of `Prop`, so `RiemannHypothesis ∈ ...` is a type error because `closure` is on sets of `Prop`, but `RiemannHypothesis` is a statement (type `Prop`), not a term of type `Prop`. Actually it *is* a term of type `Prop` (since `RiemannHypothesis : Prop`), so that part is okay. But the set constructor `(¬¬ ·)` as written is invalid.

Thus the file will not compile.

VERDICT: DOES NOT COMPILE