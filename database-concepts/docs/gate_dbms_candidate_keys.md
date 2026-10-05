# GATE DBMS: Candidate Keys Using Attribute Closure

## Definition: Candidate Key

A **candidate key** is a minimal set of attributes that functionally determines every attribute in a relation.

A candidate key must satisfy both conditions:

1. **Superkey:** Its attribute closure contains all attributes of the relation.
2. **Minimality:** Removing any attribute means the remaining set is no longer a superkey.

---

## Example 1

Given relation:

\[
R(A,B,C,D,E)
\]

Functional dependencies:

\[
AB \rightarrow C,\quad C \rightarrow D,\quad B \rightarrow EA
\]

### Step 1: Calculate \((AB)^+\)

Start with:

\[
(AB)^+ = \{A,B\}
\]

Apply \(AB \rightarrow C\):

\[
(AB)^+ = \{A,B,C\}
\]

Apply \(C \rightarrow D\):

\[
(AB)^+ = \{A,B,C,D\}
\]

Apply \(B \rightarrow EA\), adding \(E\) (since \(A\) is already present):

\[
(AB)^+ = \{A,B,C,D,E\}
\]

The closure contains every attribute, so **AB is a superkey**.

### Step 2: Check minimality

Check the proper subsets:

- \(A^+ = \{A\}\). No dependency adds any other attribute from \(A\) alone.
- \(B^+ = \{A,B,E\}\), using \(B \rightarrow EA\). This does not contain \(C\) or \(D\).

Neither \(A\) nor \(B\) alone is a superkey. Therefore, **AB is minimal**.

**Candidate key:**

\[
\boxed{AB}
\]

### Note on prime attributes

An attribute is **prime** if it belongs to at least one candidate key. Here, \(A\) and \(B\) are prime because they belong to candidate key \(AB\). Being prime does not mean an attribute is a candidate key by itself.

---

## Example 2

Given relation:

\[
R(A,B,C,D,E)
\]

Functional dependencies:

\[
AB \rightarrow C,\quad C \rightarrow D,\quad B \rightarrow E
\]

### Step 1: Calculate \((AB)^+\)

Start with:

\[
(AB)^+ = \{A,B\}
\]

Apply \(AB \rightarrow C\):

\[
(AB)^+ = \{A,B,C\}
\]

Apply \(C \rightarrow D\):

\[
(AB)^+ = \{A,B,C,D\}
\]

Apply \(B \rightarrow E\):

\[
(AB)^+ = \{A,B,C,D,E\}
\]

The closure contains every attribute, so **AB is a superkey**.

### Step 2: Check minimality

- \(A^+ = \{A\}\).
- \(B^+ = \{B,E\}\), using \(B \rightarrow E\).

Neither subset determines all attributes. Therefore, **AB is minimal**.

**Candidate key:**

\[
\boxed{AB}
\]

---

## Compare the two examples

| Item | Example 1 | Example 2 |
|---|---|---|
| Functional dependency involving \(B\) | \(B \rightarrow EA\) | \(B \rightarrow E\) |
| \(B^+\) | \(\{A,B,E\}\) | \(\{B,E\}\) |
| Is \(B\) alone a superkey? | No | No |
| Candidate key | \(AB\) | \(AB\) |

The closure of \(B\) differs, but \(AB\) is a candidate key in both examples.

---

## GATE Shortcut: Attributes That Never Appear on the RHS

Any attribute that **never appears on the right-hand side** of the given functional dependencies must be included in every candidate key, because these dependencies cannot derive that attribute from other attributes.

### Example 1

\[
AB \rightarrow C,\quad C \rightarrow D,\quad B \rightarrow EA
\]

RHS attributes: \(A,C,D,E\).

Attribute \(B\) never appears on the RHS, so every candidate key must contain \(B\).

### Example 2

\[
AB \rightarrow C,\quad C \rightarrow D,\quad B \rightarrow E
\]

RHS attributes: \(C,D,E\).

Attributes \(A\) and \(B\) never appear on the RHS, so every candidate key must contain both \(A\) and \(B\). Their closure gives all attributes, confirming \(AB\) as the candidate key.

### Remember

1. Start with attributes that never appear on any RHS.
2. Calculate the closure of the resulting set.
3. If the closure contains every attribute, check minimality.
4. A **superkey** determines every attribute; a **candidate key** is a minimal superkey.
