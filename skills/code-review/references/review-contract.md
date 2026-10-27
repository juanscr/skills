# Review Contract

Every review is independent, read-only analysis of a fixed change. The
implementation workflow and CI own validation.

## Do not become CI

Use supplied validation results and provider checks as evidence. Do not run
formatters, linters, builds, tests, restores, code generation, or deployments.
Report missing or contradictory validation evidence only when it creates a
concrete release risk.

## Context traversal

Start from a changed contract or concrete suspected defect. Trace only the
callers, callees, state owners, tests, and configuration needed to prove or
disprove it. Stop when behavior and impact are established.

Deep mode may follow cross-module ownership and lifecycle paths broadly enough
to assess architecture and risk. Follow-up mode stays directly coupled to
changed behavior and open findings. No mode performs a general codebase
audit.

## Modes

### Deep

Independent full review of the complete change. Depth means following every
material contract and risk, not always launching three agents. Report
blockers, material improvements, and genuine design decisions.

### Follow-up

One reviewer after fixes to a Deep-reviewed change. Give every open finding a
status: `resolved`, `unresolved`, `regressed`, or
`superseded by approved amendment`. Review the delta in the context of the
final diff and report only:

- reachable correctness or compatibility blockers;
- violated acceptance criteria or public contracts;
- concrete security, privacy, or data-integrity blockers;
- changed tests that create false confidence; and
- evidence requiring a human-owned design decision.

Do not report optional refactors, naming preferences, comment polish, generic
abstraction opportunities, or speculative maintainability improvements, and do
not reopen the full review.

## Review invalidation

A recorded Deep review remains valid across fixes that preserve its approved
architecture, behavior, and risk boundaries; review those fixes with Follow-up.

Run a new Deep review only when later changes invalidate the earlier review by:

- adding behavior unrelated to open findings;
- changing an approved outcome, acceptance criterion, or design decision;
- changing a public API, schema, migration, serialization, or cross-process
  contract;
- introducing or materially changing authorization, privacy, persistence,
  concurrency, cancellation, retry, resource-lifecycle, or shutdown behavior;
- performing a broad redesign or refactor; or
- substantially expanding the reviewed subsystem.

The fact that `HEAD` changed does not invalidate a review by itself.
