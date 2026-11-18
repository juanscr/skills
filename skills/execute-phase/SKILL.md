---
name: execute-phase
description: Use when continue-plan routes a phase action.
---

# Execute Phase

Deliver one phase of an approved plan. The coordinator owns the plan, Agent's
log, review, and publication. Workers own spec tests, implementation,
validation, fixes, and local commits.

Stop at a validated, reviewed local branch unless the user asked to publish or
hand off.

## Durable artifact boundary

Never mention phases in repository-facing artifacts (code, tests, docs, commit
messages, PR titles and descriptions). Describe observable behavior in product
and domain language instead. Check the full diff and provider text before
committing or publishing.

## Workers

Follow `acceptance-test-driven-development`. Use two distinct child workers.
They may communicate directly, but edit and validate sequentially on one
worktree, never at once:

- **Spec executor**: runs `spec-executor` on the phase's spec items.
- **Implementer**: makes every spec test pass. Receives only the approved spec
  and its criteria, acceptance tests and mapping, repository, branch, and
  validation commands. No implementation plan or solution sketches.
  Decides how to implement and may add its own tests,
  following `test-quality`.

The implementer never modifies spec tests (tests added or changed by a recorded
spec commit). When it believes a spec test is wrong, it pauses affected work
and exchanges evidence with the spec executor. Resolve test defects and
implementation assumptions without user input while preserving the approved
contract. Relay messages if direct worker communication is unavailable.

Prefer a child worktree; otherwise use child agents in the verified source
worktree. Use `model-selection` before each dispatch. Reuse a recorded worker
for its own role when still available, and record each assignment in the log
before dispatch. Inspect each worker's diff before accepting its result. Workers
pause and return evidence when a change would alter something the user
approved.

## 1. Restore state

Read the Agent's log, then the phase in the plan and its notes. Reconcile the
log with the live repository and the workers' worktree. Preserve unrelated
changes and ask only when they overlap the phase. On resume, continue from the
recorded action and reuse still-valid validation and review evidence.

When evidence changes the plan, invoke `amend-plan`. Continue unless it returns
a user decision.

## 2. Write the spec

When starting a phase, record HEAD as its immutable review fixed point and set
the phase `in progress`. When resuming, reuse the recorded fixed point; if it is
missing, record a blocker instead of deriving a new one.

If the phase has no spec items, invoke `amend-plan` to add them.

Dispatch the spec executor. Record its commit and mapping. Then run
`code-review` in `Spec` mode on that commit. The spec executor fixes blockers in
a new recorded spec commit; allow two rounds, then block the phase. Spec items
that cannot be tested as written go to `amend-plan`.

## 3. Implement

Dispatch the implementer with the spec-only handoff above and record its
result: all spec tests and validation pass.

When the implementer disputes a spec test, let the workers resolve it from
evidence. The spec executor owns corrections; record each new spec commit and
mapping and run a new spec check before implementation resumes. The
coordinator settles disagreements within the approved contract without asking
the user. Only a needed change to an approved requirement or decision goes to
`amend-plan` for user input.

## 4. Review

Run one Deep `code-review` of the phase, from the fixed point to HEAD, with the
plan, spec commits, and validation evidence. Record the review head and
findings.

The implementer fixes blockers and proportionate material improvements, adding
regression tests where useful, in new local commits. Record out-of-scope
improvements as follow-ups. Then run a `Follow-up` review, or a new Deep review
when the delta meets the review contract's invalidation rules. Allow two
follow-up rounds; if blockers remain, block the phase with the evidence and what
would unblock it.

The phase is ready to publish when it has a recorded Deep review and no open
blockers.

## 5. Publish

Report the branch, commits, validation, review signal, and follow-ups. Stop
until the user explicitly asks to publish. Then:

1. If the branch changed since review, revalidate and review the delta.
2. Get the description from `pr-description` and check the artifact boundary.
3. Push only the recorded source branch and create the PR against the target.
   Use `azure-devops-workflow` for Azure DevOps.
4. Set the phase to `review` and record the PR.

Only `continue-plan` marks a phase complete, after the user reports the merge.

## PR feedback

Retrieve active feedback. Route changes to approved outcomes or spec items
through `amend-plan`, then have the spec executor update the spec. Have the
implementer fix the rest, review the delta, and wait for approval before
pushing.

## Handoff

To replace the coordinator or clear the session, invoke `handoff`.
