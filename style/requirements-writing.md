# Requirements-Writing Style

**Content type:** Guidance

## Structure

A requirement document should identify its scope before listing normative
statements. Each independently verifiable obligation should have a stable
identifier or an unambiguous subordinate reference.

A requirement should include, where applicable:

- identifier and title;
- scope or applicability;
- normative statement;
- rationale;
- verification method and test references;
- dependencies or related requirements; and
- tailoring conditions.

## Normative Statements

Write requirements in the form:

```text
<responsible subject> shall <observable behavior or constraint>
<under stated conditions>.
```

A good requirement is:

- **necessary** — it expresses a real stakeholder, product, or process need;
- **atomic** — it contains one obligation or one inseparable behavioral set;
- **unambiguous** — its subject, conditions, and expected result are clear;
- **feasible** — it can be satisfied within known constraints;
- **verifiable** — objective evidence can determine whether it is satisfied;
  and
- **implementation-neutral** — it avoids prescribing a solution unless the
  solution itself is a required constraint.

Use explicit quantities, units, boundaries, and error behavior. Replace vague
terms such as *fast*, *appropriate*, *user-friendly*, *normally*, and *as
needed* with measurable criteria or a referenced definition.

Avoid combining obligations with *and* when each part could pass or fail
independently. Avoid *and/or*; enumerate the intended cases instead.

## Rationale and Implementation Records

Rationale explains why a requirement exists but does not add obligations. If
rationale contains words that must be enforced, move those statements into the
normative requirement.

An implementation record may describe the current means of satisfaction, but
it should not redefine the requirement. This distinction allows an
implementation to change without silently changing the obligation.

## Verification

Identify one or more suitable methods:

- automated or manual test;
- inspection or review;
- static analysis;
- engineering analysis; or
- demonstration.

Verification references should use stable test-case or evidence identifiers.
Passing tests does not repair an ambiguous requirement; improve the requirement
when expected behavior cannot be determined objectively.
