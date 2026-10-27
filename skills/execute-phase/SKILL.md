---
name: execute-phase
description: Use when continue-plan routes a phase action.
---

# Execute Phase

Deliver one phase of an approved plan. The coordinator owns the plan, Agent's
log, review, and publication. One phase worker at a time owns implementation,
tests, validation, fixes, and local commits.

Stop at a validated, reviewed local branch unless the user asked to publish or
hand off.

## Durable artifact boundary

Never mention phases in repository-facing artifacts (code, tests, docs, commit
messages, PR titles and descriptions). Describe observable behavior in product
and domain language instead. Check the full diff and provider text before
committing or publishing.

## Worker

Prefer a child worktree; otherwise use a child agent in the verified source
worktree. Use `model-selection` before dispatch. Never run two writers on one
worktree. Reuse the recorded worker when it is still available, and record the
assignment in the log before dispatch.

Give the worker the phase outcome, acceptance criteria, notes, amendments,
branch, and validation. The worker decides how to implement. It uses `tdd` for
substantial feature behavior and `test-quality` when tests change, and pauses
to return evidence when a change would alter something the user approved.
Inspect its diff before accepting the result.

## 1. Restore state

Read the Agent's log, then the phase in the plan and its notes. Reconcile the
log with the live repository and the worker's worktree. Preserve unrelated
changes and ask only when they overlap the phase. On resume, continue from the
recorded action and reuse still-valid validation and review evidence.

When evidence changes the plan, invoke `amend-plan`. Continue unless it returns
a user decision.

## 2. Implement

When starting a phase, record HEAD as its immutable review fixed point and set
the phase `in progress`. When resuming, reuse the recorded fixed point; if it is
missing, record a blocker instead of deriving a new one.

Write phase notes when the worker needs more than the plan. Dispatch the worker
and record its result.

## 3. Review

Run one Deep `code-review` of the phase, from the fixed point to HEAD, with the
plan and validation evidence. Record the review head and findings.

The worker fixes blockers and proportionate material improvements, adding
regression tests where useful, in new local commits. Record out-of-scope
improvements as follow-ups. Then run a `Follow-up` review, or a new Deep review
when the delta meets the review contract's invalidation rules. Allow two
follow-up rounds; if blockers remain, block the phase with the evidence and what
would unblock it.

The phase is ready to publish when it has a recorded Deep review and no open
blockers.

## 4. Publish

Report the branch, commits, validation, review signal, and follow-ups. Stop
until the user explicitly asks to publish. Then:

1. If the branch changed since review, revalidate and review the delta.
2. Get the description from `pr-description` and check the artifact boundary.
3. Push only the recorded source branch and create the PR against the target.
   Use `azure-devops-workflow` for Azure DevOps.
4. Set the phase to `review` and record the PR.

Only `continue-plan` marks a phase complete, after the user reports the merge.

## PR feedback

Retrieve active feedback. Route changes to approved outcomes through
`amend-plan`, have the worker fix the rest, review the delta, and wait for
approval before pushing.

## Handoff

To replace the coordinator or clear the session, invoke `handoff`.
