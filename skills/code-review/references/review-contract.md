# Review Contract

All review modes are independent, read-only analysis of a pinned change. The
implementation workflow and CI own validation.

## Do not become CI

Consume supplied validation commands, results, and provider check status as
evidence. Do not run:

- formatters or commands that modify files;
- linters, builds, tests, benchmarks, or coverage;
- package restore, dependency installation, or code generation; or
- deployment or external-service checks.

Use read-only source navigation, search, `git diff`, and `git log` as needed.
When existing validation evidence is missing or contradictory, report that fact
only when it creates a concrete release risk. Do not fill the gap by running the
gate yourself.

## Context traversal

Start from a changed contract or concrete suspected defect. Trace only the
callers, callees, state owners, tests, and configuration needed to prove or
disprove it. Stop when behavior and impact are established.

Deep mode may follow cross-module ownership and lifecycle paths broadly enough
to assess architecture and risk. Light and Verify modes stay directly coupled
to changed behavior or retained findings. No mode performs a general codebase
audit.

## Modes

### Deep

Independent full review of the completed phase or pull request. Depth means
following every material contract and risk, not always launching three agents.
Use one combined reviewer when separate lenses would inspect substantially the
same evidence. Use independent code-quality, specification-fidelity, and
skeptical-risk reviewers when production behavior gives those lenses distinct
work. Report blockers, material improvements, and genuine design decisions.

### Light

One combined review for bounded expansion after a Deep review. The approved
behavior and risk profile remain unchanged, but fixes added enough directly
coupled code that finding-only verification is insufficient. Report only:

- reachable correctness or compatibility blockers;
- violated acceptance criteria or public contracts;
- concrete security, privacy, or data-integrity blockers;
- changed tests that create false confidence; and
- evidence requiring a human-owned design decision.

Do not report optional refactors, naming preferences, comment polish, generic
abstraction opportunities, or speculative maintainability improvements.

### Verify

Confirm disposition of retained findings after fixes. Review the resolution
delta and enough of the final full diff to ensure each affected contract still
holds. Return a status for every supplied finding:

- `resolved`;
- `unresolved`;
- `regressed`; or
- `superseded by approved amendment`.

Report a new issue only when the fix directly introduced a blocker in the same
behavior or contract. Do not reopen the full review or search for unrelated
improvements.

## Review invalidation

A recorded Deep review remains valid across fixes that stay within its findings
and approved contract.

Run Light when fixes expand directly coupled implementation beyond the retained
findings but preserve architecture, behavior, and risk boundaries.

Run a new Deep review only when later changes invalidate the earlier review by:

- adding behavior unrelated to retained findings;
- changing an approved outcome, acceptance criterion, or design decision;
- changing a public API, schema, migration, serialization, or cross-process
  contract;
- introducing or materially changing authorization, privacy, persistence,
  concurrency, cancellation, retry, resource-lifecycle, or shutdown behavior;
- performing a broad redesign or refactor; or
- substantially expanding the reviewed subsystem.

The fact that `HEAD` changed does not invalidate a review by itself.
