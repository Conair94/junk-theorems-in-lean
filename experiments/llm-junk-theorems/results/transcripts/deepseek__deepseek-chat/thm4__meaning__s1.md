# deepseek-chat | theorem 4 (set_of_nonzero_reals_is_continuous_nonmono_surjection) | meaning | sample 1

*2026-06-14T22:57:30.011946+00:00, 11.16s*

## Response

This Lean 4 code defines two things:

1. **A lemma `Prop.isOpen_iff`**, which is claiming — and attempting to prove — a characterization of open sets in the topological space of propositions `Prop` (with the usual topology? No — this is nonsense in standard topology). It says: in the space of propositions, a set `X` of propositions is open if and only if it is either empty, or the singleton `{True}`, or the whole space `Set.univ`. This is mathematically suspect. In the standard topology on the two-point space `{True, False}` isomorphic to the Sierpiński space, the open sets are precisely `∅`, `{True}`, and `{True, False}` (i.e., `Set.univ`). So the lemma actually is correct *if* we assume `Prop` is the two-point space (True / False). However, `Prop` in Lean is *not* a finite type — it's the universe of all propositions, which is huge. The "topology" on `Prop` used here is presumably the one *induced* by considering `Prop` as a topological space via a certain definition of `IsOpen` that comes from the `Topology` structure, but by default in `mathlib`, `Prop` does not have a nontrivial topology.

2. **A theorem `set_of_nonzero_reals_is_continuous_nonmono_surjection`**: This states the following:
   - The subset `{z : ℝ | z ≠ 0}` of nonzero real numbers, when viewed as a subset of ℝ with the usual topology, is **continuous** (as a set, in the sense of "the indicator function is continuous"? No — the statement is ambiguous: `Continuous {z : ℝ | z ≠ 0}` is syntactically wrong because `Continuous` usually expects a function, not a set. This almost certainly means: "the topological subspace of nonzero reals is continuous"? No — that is meaningless. Most likely the author intended: considering the set itself as a function from ℝ to Prop via its characteristic function, they want to claim that the characteristic function is continuous with respect to the topology on ℝ (usual) and the topology on Prop above. That is: the map `x ↦ (x ≠ 0)` is continuous as a map ℝ → Prop, where Prop is given the topology where open sets are exactly ∅, {True}, and univ. This would mean the preimage of {True} (which is exactly ℝ \ {0}) is open, which is true. The statement then also says the set is "non‑monotone" meaning the characteristic function is not monotone: `¬ Monotone (λ x => x ≠ 0)`. Indeed, because -1 ≤ 0 but (-1 ≠ 0) is true while (0 ≠ 0) is false, violating monotonicity. And finally it is "surjective" as a function from ℝ to Prop: both True (nonzero) and False (zero) are attained. That is true: there exists a real nonzero (e.g. 1) and zero itself gives False.

But this is all highly contrived and not standard real analysis. The code “proves” these three properties *using* the lemma `Prop.isOpen_iff` (which might be true only under the misinterpretation that Prop is a two-element set). In standard mathematics, "the set of nonzero reals is continuous" is not a statement — sets aren't continuous; functions are. Here the author abuses notation and treats the set as its indicator (characteristic) function.

**Mathematical content in plain language:**

> Interpreting the set of nonzero real numbers as a function ℝ → {False, True} that sends a real number to True exactly when it is nonzero, and endowing the two‑point set {False, True} with the topology whose open sets are ∅, {True}, and {False, True} (i.e., the Sierpiński topology), then:
> - This function is continuous (since the preimage of the open set {True} is ℝ \ {0}, which is open).
> - This function is not monotone: –1 ≤ 0, but (–1 ≠ 0) is true while (0 ≠ 0) is false.
> - This function is surjective onto {True, False}: there exist reals mapping to each.

That is a trivial observation dressed up in unnecessary language. The code is essentially a joke or an example of formalizing a vacuous/silly theorem.