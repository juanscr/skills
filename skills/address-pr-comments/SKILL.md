---
name: address-pr-comments
description: Use when addressing pull request feedback.
---

# Address Pull-Request Comments

Turn the active feedback on one pull request into an evidence-backed action
plan, wait for explicit approval, then implement the approved plan and close
the loop with every commenter.

## Input

| Input | Required | Description |
| --- | --- | --- |
| Pull request URL | Yes | A GitHub or Azure DevOps pull-request URL. |

## 1. Identify pull request source

Extract pull request title, description and latest snapshot of code.
Extract all active feedback to the date from the pull request as well.

## 2. Capture current feedback and intent

Extract all active comments from the pull request, including the code location,
author, body, replies and ID. Identify spec of the pull request by the first of
these which is known:

1. current approved specification linked from the pull request, plan or
   repository;
2. linked issue or work item;
3. pull-request description and acceptance criteria; and
4. the observable purpose of the complete diff.

When no approved specification exists, make a best attempt from the linked
artifact, pull-request description, and diff. State the missing specification
as a confidence limit; do not block analysis solely because it is absent.

## 3. Classify every active comment

Verify each comment by classifying:

- **Material fixes:** correct, in-scope feedback with a concrete benefit to the
  pull request, including readability, security, or test quality.
- **Conflicting:** a valid concern that conflicts with the spec.
- **No-Go:** incorrect or already satisfied feedback, a repeated decision with
  no new evidence, or a suggestion without a concrete benefit.

Assess the substance rather than the commenter's wording or authority.
Deduplicate comments with the same root cause, but preserve every provider
identifier so every active comment receives its own disposition and eventual
reply.

## 4. Present the plan

Present only the conflicting ones and no-go, with a bigger focus on conflicting
ones. If all comments are in material fixes, don't require user input and go
straight to fixing. After conflicting and no-go is decided, we go to step 5. A
user-approved No-Go or Conflicting override becomes an explicit scope decision;
record that decision with the change.

## 5. Implement with the right test boundary

For each approved change, choose a proportionate method:

- Use red -> green TDD only when feedback changes substantial feature behavior
  with multiple related observable slices. Invoke `tdd`.
- Implement narrow bug fixes, CI or build changes, test-only changes,
  behavior-preserving refactors, naming changes, comments, and documentation
  directly.
- Follow `test-quality` whenever tests are added, changed, or reviewed. For a
  bug, prefer a focused behavior-level regression test when it provides useful
  evidence. If one is not feasible, record why and use the narrowest reliable
  validation instead.

Run the repository's smallest existing targeted validation throughout, then its
required final validation.

## 6. Push and close every comment

Invoke `human-voice` for each analyzed active comment. Follow its
`RESOLVE_WITHOUT_REPLY` result for a suggestion applied as written: post no
reply and resolve the thread after the pushed fix is verified. Close the
addressed threads, if possible mark Won't Fix threads that were not accepted
explaining why.

