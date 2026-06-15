# deepseek-chat | theorem 8 (Exists_GrpCat_nonmeasurable) | meaning | sample 0

*2026-06-14T22:58:06.671939+00:00, 5.02s*

## Response

This Lean file attempts to prove a statement about measurability in the category of groups. The main result is the theorem at the bottom:

```lean4
theorem Exists_GrpCat_nonmeasurable : ¬MeasurableSet (@Exists GrpCat) := ...
```

**Mathematical content in plain language**  

The theorem says: **The quantifier `∃` (existential quantification), considered as a predicate on predicates of groups, is not a measurable set in the standard product σ‑algebra on the function space `(GrpCat → Prop)`.**

In more concrete terms:  
- Let `GrpCat` be the class (or, formally, the type) of all groups.  
- Consider the set of all properties (i.e., functions from groups to propositions) for which there exists at least one group satisfying the property. This set is often called the “existential quantifier” as a set of predicates.  
- Equip the set of all such predicates `(GrpCat → Prop)` with the product σ‑algebra (the usual measurable space structure on a product of copies of `Prop`).  
- The theorem says that this set of properties (the set of predicates that are non‑empty) is **not measurable** in that product σ‑algebra.

In other words, the existential quantifier is a non‑measurable subset of the power set of the universe of groups.

The proof uses a lemma that any measurable subset of `(Set A)`, when `A` is uncountable, must be “determined by a countable set” (the `countable_set_measure_support` lemma). Because the class of all groups is uncountable (proved by `GrpCat_Uncountable`), the set of non‑empty predicates is not determined by any countable set of groups, hence cannot be measurable. The argument is a standard “uncountability implies a certain set is not in the product σ‑algebra” argument.