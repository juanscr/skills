---
name: tdd
description: Implement an approved phase spec through behavior-focused red-green cycles. Use as the implementation method inside execute-phase.
---

# Test-Driven Development

Implement one approved phase spec through repeated red -> green vertical
slices. The phase spec defines the required behavior, acceptance criteria, public
seams, and verification. The live repository defines the current code. Follow
explicit repository guidance, but return a material conflict with the approved
phase spec for user decision.

Read:

- [Good and bad tests](references/tests.md)
- [Mocking](references/mocking.md)

## Input

| Input | Required | Description |
| --- | --- | --- |
| Phase spec | Yes | The approved phase HTML spec. |
| Repository | Yes | The live repository to change. |
| Validation | Yes | Existing targeted and final validation commands recorded for the phase. |

## Preconditions

Before writing a test:

1. Read the entire phase spec and its acceptance criteria.
2. Read the live implementation, relevant tests, and repository guidance.
3. Map each acceptance criterion to an observable behavior and public seam.
4. Confirm that the phase spec settles the interface and test seam.

Do not ask the user to reconfirm seams already approved in the phase spec. If a
required seam is absent, ambiguous, or contradicted by live code, stop and
return the exact design gap. Do not invent a new interface.

## What a good test is

Tests verify behavior through public interfaces, not implementation details. A
test should read like a capability in the phase spec and survive an internal
refactor.

Expected values must come from an independent source of truth: an approved
example, a known literal, a protocol contract, or another fact outside the code
under test.

## Rules of the loop

Work one vertical slice at a time. Do not write all tests before implementation.

### Red

1. Select the smallest unimplemented behavior that advances one acceptance
   criterion.
2. Add one focused test at its approved public seam.
3. Run the narrowest existing test command that includes it.
4. Confirm it fails for the expected missing behavior. A test that passes,
   crashes for an unrelated reason, or cannot distinguish the intended
   behavior is not a valid red state.

### Green

1. Add only enough production code to make that test pass.
2. Do not anticipate later slices or add speculative hooks.
3. Run the same focused test and confirm it passes.
4. Run directly coupled tests when the change can affect existing behavior.

Repeat red -> green until every phase acceptance criterion and material branch
has observable coverage.

Do not perform broad design refactoring during the loop. `code-review` owns the
post-implementation refactoring assessment. Small cleanup needed to keep the
current slice coherent is allowed only when behavior remains covered.

## Test boundaries

Mock only system boundaries such as external services, time, randomness, and
sometimes databases or filesystems. Prefer real controlled dependencies when
practical.

Do not mock internal collaborators, private methods, or code owned by the same
module merely to make a test easy. If a public behavior is difficult to test
without internal mocks, report the design pressure rather than coupling the
test to implementation.

## Completion

Before returning:

1. Run every targeted test added or changed during the cycles.
2. Run the phase's recorded final validation once.
3. Map passing tests back to every acceptance criterion.
4. Report the red and green evidence for each slice, changed paths, validation
   results, and any deviation or unresolved design conflict.

The phase is not complete merely because tests pass. It must implement the
approved observable behavior without unapproved scope.
