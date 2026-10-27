# Review Contract

All review modes are independent, read-only analysis of a pinned change. The
implementation workflow and CI own validation.

## Execution boundaries

Built-in reviewers marked `CODE_REVIEW_LEAF: true` perform their assigned role
directly with read-only tools and return findings to the parent orchestrator.
They do not invoke skills or delegate review work.

The repository-review orchestrator marked `REPOSITORY_REVIEW_BRANCH: true`
invokes the exact repository skill verified by the parent and follows that
skill's child-agent or thread instructions. This is the only nested-dispatch
exception. Its descendants inherit the pinned snapshot, selected mode, and
read-only limits in this contract; leaf markers apply only to built-in
reviewers, not to this branch. It returns results to the parent rather than
re-entering the parent's review orchestration.

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
to assess architecture and risk. Follow-up mode stays directly coupled to
changed behavior and open findings. No mode performs a general codebase
audit.

## Modes

Reviewer counts below describe the built-in branch. The repository skill owns
its additional topology within the same mode's scope.

### Deep

Independent full review of the completed phase or pull request. Depth means
following every material contract and risk, not always launching three agents.
Use one combined reviewer when separate lenses would inspect substantially the
same evidence. Use independent code-quality, specification-fidelity, and
skeptical-risk reviewers when production behavior gives those lenses distinct
work. Report blockers, material improvements, and genuine design decisions.

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
