# deepseek-v4-pro | theorem 5 (Riemann_hypothesis_in_closure_of_not_not) | meaning | sample 2

*2026-06-14T22:47:52.223069+00:00, 23.77s*

## Reasoning (chain of thought)

We are asked: "What does this Lean 4 code mean, and what theorem is it proving? State the mathematical content of the main theorem in plain language."

First, understand the code. It's a Lean file with several imports, then three lemmas and a theorem.

Let's inspect the lemmas:

1. `Prop.isOpen_iff (X : Set Prop) : IsOpen X ↔ X = ∅ ∨ X = {⊤} ∨ X = Set.univ`. This states that a set of propositions is open (in some topology on Prop) iff it is empty, or the singleton containing `True` (since `⊤` is the top element, i.e., `True`), or the whole set. So it's describing the topology on the type `Prop`, which is presumably the Sierpinski topology or something analogous? Actually, Prop with the order is a Boolean algebra, but the standard topology used in such contexts? In `Mathlib`, `Prop` is given a topology where the open sets are exactly ∅, {True}, and univ? That seems plausible because Prop is a two-element type (classically) with values `True` and `False`. The open sets could be the Scott topology or something. Indeed, `IsOpen` on `Prop` likely corresponds to the upward closed sets? But the lemma says open sets are exactly those three. Let's verify: In a two-element type, the discrete topology would have all four subsets open, but here it's only three: missing {⊥} (the singleton containing False). So the topology is the one where {False} is not open, but {True} is open. This is the Sierpinski space on a two-point set where one point is open. The lemma asserts that the only open sets are empty, {True}, univ. This is the characteristic of the Sierpinski topology on Prop.

2. `Prop.isClosed_iff (X : Set Prop) : IsClosed X ↔ X = ∅ ∨ X = {⊥} ∨ X = Set.univ`. Closed sets are complements of open sets, so they should be exactly empty, {False}, univ. Indeed, the lemma states that closed sets are ∅, {⊥} (False), or univ. That matches.

3. `Prop.closure_singleton_true_univ : closure ({⊤} : Set Prop) = Set.univ`. The closure of the singleton containing True is the whole set. Since the only closed sets containing {True} are univ (because closed sets are ∅, {⊥}, univ; {⊥} doesn't contain ⊤, and ∅ doesn't). So the smallest closed set containing {True} is univ. So true.

Now the main theorem:

`theorem Riemann_hypothesis_in_closure_of_not_not : RiemannHypothesis ∈ closure (¬¬ ·) := by
  have h3 : (¬¬ ·) = ({⊤} : Set Prop) := by
    unfold Not singleton Set.instSingletonSet Set.singleton; aesop
  rw [h3,Prop.closure_singleton_true_univ]; simp` 

Let's parse: `RiemannHypothesis` is presumably a proposition (the statement of the Riemann Hypothesis). In Mathlib, there is likely a definition `RiemannHypothesis : Prop`. Indeed, `import Mathlib.NumberTheory.Harmonic.ZetaAsymp` might define it? Actually, `RiemannHypothesis` is defined somewhere as a Prop. Then `(¬¬ ·)` is a set of propositions? Wait: `(¬¬ ·)` is a lambda expression? `·` is a placeholder, so `(¬¬ ·)` means `fun x => ¬¬ x`. In Lean, that's a function from Prop to Prop, but the theorem says `RiemannHypothesis ∈ closure (¬¬ ·)`. `closure` expects a set? Actually, `closure` is from topology, and it takes a set (i.e., `Set α`). But `(¬¬ ·)` is a function, not a Set Prop? Wait, `closure` in a topological space `α` takes a `Set α` and returns `Set α`. Here, `closure` is applied to `(¬¬ ·)`. If `(¬¬ ·)` is of type `Set Prop`, then it would be a set of propositions. How can a lambda be a set? In Lean, there's a notation where `(¬¬ ·)` can be used as a set via `Set.mem`? Actually, Lean has the `Set` type defined as `α → Prop`. So `Set Prop` is `Prop → Prop`. So `closure` expects a `Set Prop`, i.e., a function `Prop → Prop`. Then `(¬¬ ·)` as a lambda of type `Prop → Prop` can be interpreted as a set: the set of propositions `x` such that `¬¬ x` holds. Indeed, `(¬¬ ·)` is the set `{x : Prop | ¬¬ x}`. So `closure (¬¬ ·)` means the topological closure of the set of propositions `x` for which `¬¬ x` is true. Since `¬¬ x` is true for all `x`? In classical logic, `¬¬ x` is equivalent to `x`, so the set `¬¬ ·` is actually the entire `Set.univ`? Wait: `¬¬ x` is `¬(¬x)`. For any proposition `x`, `¬¬ x` holds if and only if `x` is true (classically). So the set of `x` such that `¬¬ x` is exactly the set of true propositions? No, `¬¬ x` is a proposition itself; for `x : Prop`, `¬¬ x` is true (i.e., has a proof) exactly when `x` is true? No, `¬¬ x` being true means `¬¬ x` is provable, which in classical logic is equivalent to `x` being provable. But as a set, `(¬¬ ·)` is the set of `x` for which the proposition `¬¬ x` holds. Since `¬¬ x` is a Prop, its truth value can be `True` or `False`. The set of `x` such that `¬¬ x` is true? In Prop, there are only two elements: `True` and `False`. For `x = True`, `¬¬ True` is `True`. For `x = False`, `¬¬ False` is `False`? Actually `¬¬ False` is `¬True` which is `False`. So only `True` satisfies `¬¬ x`. So the set `(¬¬ ·)` is precisely `{True}`. Indeed, the lemma `h3` proves that: `(¬¬ ·) = ({⊤} : Set Prop)`. So the set of propositions `x` such that `¬¬ x` holds is exactly the singleton containing `True`. Then `closure` of that set is `Set.univ` by the previous lemma. So `RiemannHypothesis ∈ closure (¬¬ ·)` becomes `RiemannHypothesis ∈ Set.univ`, which is true for any proposition, because `Set.univ` contains everything. The proof is trivial: rewrite `(¬¬ ·)` to `{⊤}`, then use `Prop.closure_singleton_true_univ` to get that the closure is univ, then `simp` shows that `RiemannHypothesis ∈ Set.univ`. So the theorem is indeed provable, and it's a trivial consequence of the topology.

Thus the main theorem is: "The Riemann Hypothesis is in the closure of the set of propositions that are not not true." But mathematically, this is a tautology because the closure of that set is the entire space, so any proposition is in it. So the theorem is a joke: it's a roundabout way of stating that the Riemann hypothesis is a proposition, and the topological closure of {True} is all propositions, so Riemann hypothesis is in it. So the mathematical content is essentially: "In the Sierpinski topology on the set of propositions (where open sets are ∅, {True}, univ), the closure of the singleton {True} is the whole space; hence every proposition, including the Riemann hypothesis, is in the closure of {True}." Or more precisely, the set of propositions that are not not true is exactly {True}, and its closure is everything, so the Riemann hypothesis is in that closure.

But the theorem statement: `RiemannHypothesis ∈ closure (¬¬ ·)`. That is: the Riemann Hypothesis belongs to the topological closure of the set of propositions that are double-negated. In plain language: "The Riemann Hypothesis is in the closure of the set of propositions that are not not true." Or humorously, "The Riemann Hypothesis is in the closure of {True}", so it's a true statement, but it's a triviality based on the topology.

Given the context, it's a playful "proof" that the Riemann hypothesis is "almost true" or "true in the sense of closure of the true proposition". But the actual mathematical theorem is trivial.

So I need to state the mathematical content in plain language. I'll describe that the code endows `Prop` with a topology (the Sierpinski topology) where open sets are empty, {True}, and all; then the closure of {True} is everything, so any proposition, including the Riemann Hypothesis, lies in that closure. The theorem is a formalized joke.

I'll answer accordingly.

## Response

This Lean 4 code is a playful formalization that endows the type `Prop` (classically consisting of just `True` and `False`) with a topology, and then “proves” that the Riemann Hypothesis lies in the closure of a certain set of propositions.

### What the code does

1. **Topology on `Prop`**:  
   The lemmas `Prop.isOpen_iff` and `Prop.isClosed_iff` define a topology where the only open sets are `∅`, `{True}`, and `Set.univ`. Consequently, the closed sets are `∅`, `{False}`, and `Set.univ`. This is the Sierpiński topology on the two‑element set.

2. **Closure of `{True}`**:  
   The lemma `Prop.closure_singleton_true_univ` shows that the topological closure of the singleton `{True}` is the whole set `Set.univ` (the only closed set containing `{True}` is the whole space).

3. **The set `(¬¬ ·)`**:  
   The set `{x : Prop | ¬¬ x}` is precisely the set of propositions for which double negation holds. Classically, `¬¬ x` is true exactly when `x` is true, so this set is exactly `{True}`. This is captured by the auxiliary rewriting `(¬¬ ·) = {⊤}`.

4. **Main theorem**  
   `RiemannHypothesis ∈ closure (¬¬ ·)`  
   After the rewriting, this becomes `RiemannHypothesis ∈ closure ({⊤})`, which is `RiemannHypothesis ∈ Set.univ`, which is trivially true.

### Mathematical content in plain language

The theorem states:  

> *In the Sierpiński topology on the set of classical truth values (where the open sets are ∅, {True}, and {True, False}), the topological closure of the set {True} is the entire space. Consequently, every proposition — including the Riemann Hypothesis — belongs to this closure.*

Equivalently:  

> *The Riemann Hypothesis is an element of the closure of the set of all propositions that are not not true (i.e., the set containing only True).*

In other words, the statement is a logical tautology dressed up in topological language. It is a formalized joke, not a serious mathematical result about the Riemann Hypothesis.