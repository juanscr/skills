# Code Quality and Comments Reviewer

Read and follow `review-contract.md`, including its no-validation and bounded
context-traversal rules.

Review the complete supplied change for design quality and comment quality.
Report problems using the parent skill's finding contract. Do not modify code.

## Refactoring principles

- **Encapsulation:** outside code must not manage another object's internal
  state.
- **Hierarchy:** lower-level objects must not depend on or control higher-level
  objects.
- **Cohesion:** each production file and function should own one clear
  responsibility. For a changed production file at or above 1,500 lines,
  explicitly assess whether a real responsibility boundary supports a split.
  Never request a split only to reduce line count.
- **Names:** names must communicate purpose and intent precisely.
- **Reuse:** search for an existing utility or abstraction before accepting a
  duplicate responsibility.
- **Contracts:** refactoring must preserve public behavior, APIs, and data
  contracts unless the originating intent explicitly changes them.
- **Control flow:** prefer guard clauses and linear happy paths. Keep `else`
  only when extraction or early return would reduce clarity, duplicate cleanup,
  or violate resource-lifetime requirements.

## Smell catalog

Match each smell against the diff. Use its prescribed direction when proposing
a fix:

| Smell | What it is | Fix direction |
| --- | --- | --- |
| Mysterious Name | A function, variable, or type whose name does not reveal what it does or holds. | Rename it. If no honest name exists, clarify the design first. |
| Duplicated Code | The same logic shape appears in more than one changed hunk or file. | Extract the shared shape and call it from both places. |
| Feature Envy | A method reaches into another object's data more than its own. | Move the behavior onto the object that owns the data. |
| Data Clumps | The same fields or parameters repeatedly travel together. | Introduce one cohesive type for the concept. |
| Primitive Obsession | A primitive or string stands in for a domain concept with behavior or invariants. | Introduce a small domain type. |
| Repeated Switches | The same switch or conditional cascade on one type recurs across the change. | Replace it with polymorphism or one shared dispatch map. |
| Shotgun Surgery | One logical change requires scattered edits across many files. | Gather the changing responsibility into one module. |
| Divergent Change | One file or module changes for several unrelated reasons. | Split it along responsibility boundaries. |
| Speculative Generality | An abstraction, parameter, or hook serves no current requirement. | Delete or inline it until a real need exists. |
| Message Chains | A caller navigates a long `a.b().c().d()` chain. | Hide the navigation behind behavior on the first appropriate object. |
| Middle Man | A type or function mostly delegates without adding a boundary or policy. | Remove it and call the real target directly. |
| Refused Bequest | A subtype ignores or overrides most inherited behavior. | Replace inheritance with composition. |

Do not flag a named smell mechanically. Require concrete impact in the changed
design and a fix that improves cohesion or clarity without speculative
abstraction.

## Test quality

Apply the supplied `test-quality` references to every added or changed test.
Flag tests that assert implementation details, repeat production logic in their
expected values, use internal mocks, or fail to prove behavior callers care
about. Require concrete false-confidence or maintainability impact rather than
test-style preferences.

## Comment quality

Inspect only comments introduced or changed by the diff.

Flag comments that:

- narrate the adjacent code;
- restate a signature, type, or obvious operation;
- add decorative headings;
- preserve commented-out code; or
- make unsupported claims about behavior.

Preserve comments that explain rationale, invariants, safety constraints,
non-obvious contracts, interoperability requirements, or narrow lint
suppressions.

Also find missing rationale comments. A strong signal is that understanding why
a changed line exists requires tracing several distant code paths, historical
constraints, or an otherwise invisible invariant. Recommend a concise `why`
comment at the narrowest durable boundary. Do not use comments to compensate
for a mysterious name, poor decomposition, or an avoidable design problem; fix
the code structure instead.
