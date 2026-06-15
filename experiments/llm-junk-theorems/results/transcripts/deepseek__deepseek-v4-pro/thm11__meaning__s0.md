# deepseek-v4-pro | theorem 11 (unique_proofs) | meaning | sample 0

*2026-06-14T22:53:27.529581+00:00, 47.8s*

## Reasoning (chain of thought)

We need to analyze the given Lean 4 code. It defines two definitions: QR and BCT. Then it proves a theorem named "unique_proofs". The statement of unique_proofs is:

∃ p : QR, ∃ q : ¬¬BCT, (∀ r : QR, p = r) ∧ (∀ r : ¬¬BCT, q = r) ∧ ⟨QR, p⟩ = (⟨¬¬BCT, q⟩ : Σ' A : Prop, A) ∧ Function.Bijective q.

We need to understand what QR, BCT are and what the theorem is proving. Let's first look at the definitions:

def QR := ∀ a b : ℕ, Odd a → Odd b →
  jacobiSym (↑a) b = (-1) ^ (a / 2 * (b / 2)) * jacobiSym (↑b) a

So QR is a proposition: For all natural numbers a and b, if a is odd and b is odd, then the Jacobi symbol (a on b) equals (-1)^(a/2 * b/2) times the Jacobi symbol (b on a). This is essentially the law of quadratic reciprocity for Jacobi symbols, stated for odd positive integers (natural numbers). Actually, the classical quadratic reciprocity law: (a|b)*(b|a) = (-1)^{((a-1)/2)*((b-1)/2)}. Here they have a/2 * (b/2), which is different from (a-1)/2 * (b-1)/2. For odd a, a/2 is integer division? In Lean, a / 2 is natural division, which for odd a gives (a-1)/2. Indeed, if a is odd, a = 2k+1, then a/2 = k (natural division truncates), and (a-1)/2 = k. So a/2 equals (a-1)/2. Similarly b/2 equals (b-1)/2. So (-1)^(a/2 * (b/2)) = (-1)^{((a-1)/2)*((b-1)/2)}. So this is exactly the classic statement. The Jacobi symbol is defined for integers, but a and b are ℕ, and they use ↑a to cast to ℤ. So QR is the quadratic reciprocity law for odd natural numbers using Jacobi symbols.

Next, BCT is:

def BCT := ∀ {X : Type} [inst : UniformSpace X]
  [CompleteSpace X] [(uniformity X).IsCountablyGenerated]
  {f : ℕ → Set X}, (∀ (n : ℕ), IsOpen (f n)) →
  (∀ (n : ℕ), Dense (f n)) → Dense (⋂ (n : ℕ), f n)

This is the Baire category theorem for complete metric spaces? Actually, it's stated for uniform spaces with countably generated uniformity, which includes complete metric spaces (since metric spaces have countably generated uniformity). The statement: If X is a complete uniform space with countably generated uniformity, and (f n) is a sequence of open dense subsets of X, then the intersection of all f n is dense. This is exactly the Baire category theorem (for such spaces). So BCT is the proposition that the Baire category theorem holds.

Now the theorem unique_proofs asserts: ∃ p : QR, ∃ q : ¬¬BCT, (∀ r : QR, p = r) ∧ (∀ r : ¬¬BCT, q = r) ∧ ⟨QR,p⟩ = (⟨¬¬BCT,q⟩ : Σ' A : Prop, A) ∧ Function.Bijective q.

First, note that QR is a proposition (Prop). So p : QR means p is a proof of QR. Similarly, ¬¬BCT is the double negation of BCT, which is also a Prop. q : ¬¬BCT is a proof of ¬¬BCT. The theorem claims there exists a proof p of QR and a proof q of ¬¬BCT such that:

1. For all r : QR, p = r. This says that any proof of QR equals p. In other words, p is the unique proof of QR (proof irrelevance). Since in Prop, all proofs are definitionally equal? Actually, Lean has proof irrelevance: any two proofs of a Prop are equal (by Prop extensionality). So (∀ r: QR, p = r) is always true for any p. But we'll see why it's stated.

2. (∀ r : ¬¬BCT, q = r): Similarly, q is the unique proof of ¬¬BCT. Again, proof irrelevance.

3. ⟨QR, p⟩ = (⟨¬¬BCT, q⟩ : Σ' A : Prop, A). Here Σ' is the Sigma type (dependent pair) where the first component is a Prop A and the second is a proof of A? Actually, Σ' A : Prop, A is the type of pairs ⟨A, h⟩ where A : Prop and h : A. So ⟨QR, p⟩ is a pair with first component QR and second component p (of type QR). The right-hand side is ⟨¬¬BCT, q⟩, but its type is also Σ' A : Prop, A because q : ¬¬BCT. The equality here is between two elements of that sigma type. So the theorem asserts that the pair (QR, p) equals the pair (¬¬BCT, q). Since the first components are QR and ¬¬BCT, equality would imply that QR = ¬¬BCT as Props (because sigma equality requires first components equal). But they are different statements. However, the equality is in the sigma type, not necessarily implying QR = ¬¬BCT as types? In Lean, for ⟨A, h⟩ = ⟨B, k⟩ in Σ' A : Prop, A, we have A = B and h == k (heterogeneous equality). Actually, equality is heterogenous: because the type of the second component depends on the first. So equality in sigma type means that there is an identification between the first components, and the second components are equal under that identification. This would imply that QR and ¬¬BCT are equal as propositions. But is it possible to prove that QR = ¬¬BCT? In classical logic, any two true propositions are logically equivalent, but they are not definitionally equal. In Lean, Prop has no quotient; propositions are equal if they are definitionally equal? Actually, propositional equality in Prop is based on definitional equality and can be proven via propext from classical logic: if two propositions are equivalent, then they are equal (by propositional extensionality). But the theorem is proving an equality of sigma pairs, which would require a proof that QR = ¬¬BCT, and then p and q are equal modulo that equality. That seems impossible because QR and ¬¬BCT are not logically equivalent necessarily? QR is quadratic reciprocity, which is a true theorem (provable). BCT is the Baire category theorem, which is also a true theorem in classical mathematics (assuming choice). So both QR and BCT are true. Then ¬¬BCT is also true (trivially). So both QR and ¬¬BCT are true propositions. By propositional extensionality, any two true propositions are equal. So in classical logic, QR = ¬¬BCT is true. The theorem seems to be saying: there exists a proof p of QR and a proof q of ¬¬BCT such that p is the unique proof of QR, q is the unique proof of ¬¬BCT, and the pair (QR, p) equals (¬¬BCT, q), and furthermore q is bijective as a function? Wait, q : ¬¬BCT is a proof, but Function.Bijective q? That doesn't make sense: q is a term of type ¬¬BCT (a Prop), not a function. Function.Bijective expects a function. But q is not a function; q is a proof of a proposition. However, Function.Bijective can be applied to any type? The type of q is ¬¬BCT, which is (¬BCT → False). That's a function type! So q is a term of type ¬¬BCT, i.e., ( (BCT → False) → False ). That is a function that takes a function from BCT to False and returns False. So q is indeed a function. So q : ¬¬BCT is a function of type (¬BCT) → False. So Function.Bijective q would mean that q is a bijective function from its domain to its codomain. But q's type is (¬BCT) → False. So it's a function from the type ¬BCT (which is the type of proofs that BCT leads to a contradiction) to False. The domain is ¬BCT, which is (BCT → False). The codomain is False. For a function from A to False to be bijective, both injective and surjective. Since False is a type with no elements (unless we have a contradiction), a function to False can only be defined if the domain is also empty; otherwise, we can't have a function that is surjective onto False because False has no elements unless the domain has elements that map to something? Wait, False is an empty type in the sense that there are no terms of type False. But in classical logic, False is an empty type, indeed there is no constructor. So to have a function A → False be surjective means that for every element b : False, there exists a : A such that f a = b. But there are no elements of False, so this condition is vacuously true. Surjectivity of a function to an empty type is always true because there's nothing to hit. Injectivity: if f a1 = f a2, then a1 = a2. For f : A → False, f a1 = f a2 is of type False, so from a hypothesis of type False we can deduce anything, including a1 = a2. So any function to False is automatically injective. Therefore any function to False is bijective! So Function.Bijective q would hold for any q of type ¬¬BCT. So that part is trivial. But maybe there's a subtlety: Function.Bijective expects a function, and q is indeed a function (from ¬BCT to False). So it works.

Thus, the theorem's key content is the equality of the sigma types, which implies QR = ¬¬BCT. Since QR and BCT are both true (they are classical theorems), it's consistent that they are equal as propositions under propositional extensionality. However, the proof given in the code must construct explicit p and q and prove the equality. Let's inspect the proof:

use (by unfold QR; grind [jacobiSym.quadratic_reciprocity])
use (by apply not_not_intro; unfold BCT; intros; apply BaireSpace.baire_property; all_goals assumption)
repeat' constructor
· simp only [implies_true]
· simp only [not_not, implies_true]
· grind
· simp [Function.Injective]
· simp [Function.Surjective]

The first "use" provides p. It says: p is a proof of QR. It does this by unfold QR; then grind with jacobiSym.quadratic_reciprocity. It seems that jacobiSym.quadratic_reciprocity is a lemma in Mathlib that states quadratic reciprocity for Jacobi symbols. So p is a proof of QR.

The second "use" provides q. It says: apply not_not_intro; that is, to prove ¬¬BCT, we assume ¬BCT and derive a contradiction. Then we unfold BCT, intros, and apply BaireSpace.baire_property. BaireSpace.baire_property is likely a lemma that states the Baire category theorem for complete metric spaces (or uniform spaces). So the proof of BCT is BaireSpace.baire_property. Then we get a proof of BCT, and using not_not_intro we get ¬¬BCT. So q is a proof of ¬¬BCT. So q is basically the double-negation of the BCT proof.

Then we have repeat' constructor. The goal after the two "use" is a big conjunction of five things: (∀ r : QR, p = r) ∧ (∀ r : ¬¬BCT, q = r) ∧ ⟨QR, p⟩ = (⟨¬¬BCT, q⟩ : Σ' A : Prop, A) ∧ Function.Bijective q. The tactic repeat' constructor splits the conjunction. Then we get four goals (or five?). The code shows:

· simp only [implies_true]
· simp only [not_not, implies_true]
· grind
· simp [Function.Injective]
· simp [Function.Surjective]

So there are five subgoals. The first goal: ∀ r : QR, p = r. They use simp only [implies_true]. That might be a bit weird. How does simp prove that? Actually, p = r for any r : QR is true by proof irrelevance (which is built into Lean's Prop? In Prop, there is an axiom `proof_irrel` maybe. `simp` might not know that. `implies_true` is a lemma: `(a → True) ↔ True`. That doesn't apply. Let's test mentally: `simp only [implies_true]` would rewrite `∀ r : QR, p = r` as `∀ r : QR, True`? Not sure. Actually `implies_true` is `(a → True) ↔ True`. But `p = r` is an equality in Prop, which is always `True` by proof irrelevance? In Lean, by `propext`, any two proofs of a proposition are equal, but that's not definitional. There's a lemma `proof_irrel` in `Mathlib`? The standard `Prop` in Lean has proof irrelevance as a definitional reduction? I think Lean's core has definitional proof irrelevance for `Prop`? Actually, in `Prop`, all elements are definitionally equal? No, not definitionally. There is an axiom `proofIrrel` in `Lean`? In Lean 4, `Prop` has definitional proof irrelevance? I'm not entirely sure. But the standard library has `proof_irrel` as a theorem: `theorem proof_irrel {a : Prop} (p q : a) : p = q := ...`. So `simp` with `proof_irrel` would work. But they used `simp only [implies_true]`. Maybe they meant `simp` will close the goal because `∀ r, p = r` reduces to something trivial? Let's examine: `simp only [implies_true]` rewrites `a → True` to `True`. But the goal is `∀ r : QR, p = r`, which is a forall of an equality. `simp` might rewrite `p = r` to `True` if it knows `p` and `r` are proofs? `simp` doesn't have that lemma. I think the code might be a joke or a trick: It's asserting that all these things hold trivially because `QR` is true and `¬¬BCT` is true, but the equality might rely on `propext`. Let's try to understand what `grind` does on the third subgoal: `⟨QR, p⟩ = (⟨¬¬BCT, q⟩ : Σ' A : Prop, A)`. `grind` is a tactic that can handle equalities of sigma types maybe using proof irrelevance and propositional extensionality. `grind` is from `Mathlib.Tactic`? It might be a tactic that simplifies things with `propext` and `proof_irrel`. So `grind` could easily prove this equality because both QR and ¬¬BCT are true, thus they are equal via `propext`, and then the second components are proofs of the same proposition after rewriting, so they are equal by `proof_irrel`. So `grind` can handle it.

Then the last two subgoals: `Function.Injective q` and `Function.Surjective q`. They use `simp` with `Function.Injective` and `Function.Surjective`. As argued earlier, these are trivially true for any function to `False`. So `simp` with those lemmas likely can show that any function to `False` is injective and surjective. For injectivity: `Function.Injective f` is `∀ {a b}, f a = f b → a = b`. If `f a = f b` is of type `False`, then `a = b` can be derived by `False.elim`. So `simp` might know a lemma that `False.elim` or that `f a = f b` is impossible. `simp` with `Function.Injective` might unfold `Injective` and then use `False.elim`. Similarly for `Surjective` onto `False`, it's vacuously true because `∀ b : False, ∃ a, f a = b` holds since there is no `b`. So `simp` can handle.

Thus, the whole theorem is essentially a triviality: it says there exists a proof of QR and a proof of ¬¬BCT that are unique, that the pairs are equal, and that the proof of ¬¬BCT is bijective (as a function). But this is a humorous theorem: it's exploiting the fact that any two true propositions are equal via `propext`, and that `q` being a function to `False` is automatically bijective. So the theorem is a tongue-in-cheek "unique proofs" of two unrelated true statements, showing they can be identified. It's a joke about the univalence-like principle `propext` and proof irrelevance.

However, the user asks: "What does this Lean 4 code mean, and what theorem is it proving? State the mathematical content of the main theorem in plain language."

We need to answer in plain language. The theorem "unique_proofs" states: There exists a proof of the Quadratic Reciprocity Law (for Jacobi symbols) and a proof of the double negation of the Baire Category Theorem such that:

- Any proof of Quadratic Reciprocity equals the given proof (i.e., there is at most one proof of Quadratic Reciprocity).
- Any proof of the double negation of the Baire Category Theorem equals the given proof (i.e., there is at most one proof of that statement).
- The pair (the statement Quadratic Reciprocity, its proof) is equal to the pair (the statement "not not Baire Category Theorem", its proof).
- The proof of "not not Baire Category Theorem" is a bijective function.

The mathematical content of the main theorem is essentially a consequence of propositional extensionality and proof irrelevance in the type theory of Lean. Since both Quadratic Reciprocity and the Baire Category Theorem are true statements, they are equivalent propositions, and by propositional extensionality they are equal as types. Hence, their proof-carrying type pairs are equal. Additionally, the proof of "not not BCT" is a function from "not BCT" to false, and any such function is trivially bijective because false has no elements.

But the theorem is a humorous way to show that in Lean, all true propositions are identified and all proofs are identical. It does not convey any deep mathematical result; it's a logical curiosity.

Thus, in plain language: The code defines two mathematical statements: QR (the law of quadratic reciprocity for Jacobi symbols) and BCT (the Baire category theorem for complete uniform spaces). It then proves a theorem that there exist proofs of QR and the double negation of BCT such that: (1) each proof is unique among all proofs of its statement; (2) the two statements, when paired with their respective proofs, are equal as dependent pairs; and (3) the proof of the double negation of BCT, viewed as a function, is bijective. This theorem illustrates that in Lean's logic with propositional extensionality and proof irrelevance, any two true propositions become identical, and any function to False is automatically a bijection. There is no substantial mathematical content beyond these logical principles.

## Response

The Lean code defines two propositions:

- `QR` is the statement of quadratic reciprocity for odd natural numbers via the Jacobi symbol: for all odd `a, b : ℕ`,  
  `jacobiSym (a : ℤ) b = (-1)^(a/2 * (b/2)) * jacobiSym (b : ℤ) a`.

- `BCT` is the Baire category theorem: any countable intersection of open dense sets in a complete uniform space with countably generated uniformity is dense.

The theorem `unique_proofs` then asserts:

> There exist a proof `p` of `QR` and a proof `q` of `¬¬BCT` (the double negation of `BCT`) such that:
> - `p` is the *only* proof of `QR` (i.e., all proofs of `QR` are equal).
> - `q` is the *only* proof of `¬¬BCT`.
> - The dependent pair `⟨QR, p⟩` (the statement `QR` together with its proof) is equal to the dependent pair `⟨¬¬BCT, q⟩`.
> - The proof `q`, viewed as a function `(¬BCT) → False`, is bijective.

**Mathematical content in plain language:**  
This is a humorous theorem that exploits the logical principles of the underlying type theory. Both `QR` and `BCT` are true classical theorems, so `QR` and `¬¬BCT` are both true propositions. By **propositional extensionality** (any two logically equivalent propositions are equal) and **proof irrelevance** (all proofs of a proposition are identical), the two statements become indistinguishable as types, and their proofs can be made to coincide. Moreover, a function into `False` (the empty type) is trivially bijective, because there is no element to hit and any contradictory hypothesis yields everything. Thus, the theorem is a playful demonstration that in Lean’s logic, any two true statements can be formally identified, and any function into `False` is a bijection. It does not convey any deep mathematical result.