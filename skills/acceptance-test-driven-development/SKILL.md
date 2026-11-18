---
name: acceptance-test-driven-development
description: Use when defining acceptance specs or driving implementation from approved acceptance tests.
---

# Acceptance Test-Driven Development

Agree on what proves success before implementing it. Use two distinct child
workers in sequence: `spec-executor` writes the failing tests; an implementer
makes them pass. The coordinator owns approval and the handoff, not either
worker's implementation.

## Define the contract

Read the request and relevant repository behavior. Ask the user for decisions,
not facts you can look up. Split the work into coherent behavior slices.

State acceptance criteria as observable outcomes. For each settled phase,
write a Spec table:

| Field | Contents |
| --- | --- |
| ID | `SPEC-<phase>.<n>` |
| Criterion | Exactly one `AC-<phase>.<n>` it proves. |
| Kind | `behavior` (observable outcome) or `structural` (the structure is the requirement: schema, public types, module boundaries). |
| Seam | Where it is verified: E2E, API, UI, schema, or public type. Prefer E2E. |
| Example | Concrete given / when / then with literal values, or the exact required structure. |

For standalone work, use one slice numbered `1`. Every criterion has at least
one spec item; every item traces to exactly one criterion. Cover meaningful
failure and boundary cases, not implementation details. Use `structural` only
when the user requires the structure itself.

Resolve ambiguous expectations with the user. Get explicit approval of the
criteria and examples before writing tests. When called by `design-plan`,
include them in the plan's approval and return control; do not start execution.

## Write the failing spec

Use `model-selection` before dispatch. Delegate to a child worker running
`spec-executor`, following `test-quality`. Give it the approved spec, acceptance
criteria, repository, branch, and validation commands. It writes tests, not
feature behavior.

Require its spec commit, spec-to-test mapping, and evidence that each test
fails because the required behavior or structure is missing. Broken setup is
not a valid failure. Report already-satisfied items instead of forcing them to
fail. Review the tests against the approved contract before implementation.

## Implement independently

Only after the spec check passes, dispatch a different child worker. Pass only
the approved spec and its criteria, the acceptance tests and mapping, and the
repository, branch, and validation commands. Do not pass an implementation
plan or solution sketches. The implementer owns the approach; the spec owns
the requirements.

The implementer follows `test-quality`, makes the tests pass, and refactors
while keeping them green. It may add focused tests but never edits the spec
tests.

## Resolve without the user

After approval, the workers may communicate directly to exchange evidence,
clarify the contract, and correct their own assumptions. The coordinator
relays messages when direct communication is unavailable. Do not ask the user
to settle test defects, harness problems, or implementation choices that leave
the approved contract unchanged.

Keep edits sequential on the shared worktree. The implementer pauses affected
work while `spec-executor` corrects a test. Record the new spec commit and
mapping, repeat the spec check, then resume implementation. A passing test
alone does not prove a correction still detects missing behavior.

Escalate only when resolution requires changing an approved outcome,
criterion, example, public contract, or decision. Return the evidence and the
exact decision needed; use `amend-plan` for an existing plan. Workers cannot
weaken the spec merely to make the implementation pass.

Require passing acceptance tests, relevant regression tests, and repository
checks. Report unproved criteria and blockers plainly.

For planned phases, `execute-phase` owns dispatch, spec checks, review, and
execution state. Follow its workflow with this worker boundary; do not start
a second execution flow.
