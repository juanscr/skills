---
name: plan-handoff
description: Commit and push a recoverable feature checkpoint before replacing its coordinator or clearing the session. Use only for an explicit plan handoff or coordinator replacement.
---

# Plan Handoff

Transfer feature coordination through the existing Agent's log, not a second
handoff document. Accept the current feature folder or an explicit absolute
path; ask when the active feature is ambiguous.

An explicit handoff authorizes checkpoint commits and pushes of in-scope work
to the recorded source branches, not PR creation, merge, or bypassing review.
An explicit restriction on committing or pushing remains a handoff blocker.

## 1. Reach a safe checkpoint

Load `execution-progress.json` and the current phase. For a legacy log, apply
`../design-plan/references/legacy-normalization.md` before proceeding.
Follow the log contract in
`../design-plan/references/artifact-requirements.md`.

Ask active workers to finish their current bounded operation or pause safely,
then collect their results and inspect the actual worktrees. Account for
running commands as well as agents: clearing a session must not abandon an
unrecorded writer. Preserve incomplete work as such rather than finishing the
phase merely to hand off.

If a worker cannot be safely paused or its state is unknown, report the blocker
and withhold the ready-to-clear signal until it is resolved.

## 2. Persist the continuation state

Reconcile the log with live work and the conversation. Save all continuation-
relevant facts not already recorded:

- phase/spec status, decisions, approval scope, and pending questions;
- worker identity and paused/completed status, worktree, branch, HEAD,
  uncommitted paths, and interrupted operations;
- validation evidence, commits, PR state, review anchors, retained findings,
  and review rounds already used; and
- discoveries, failed approaches worth avoiding, blockers, and exact recovery
  or next action.

Reference existing evidence instead of copying plans, diffs, or the transcript.
Preserve unknowns and pending permissions as such. Set `current.action` to the
exact safe continuation, including any approval wait.

Commit all in-scope repository changes, including new files, in each relevant
worktree and push each recorded source branch to its verified remote. Preserve
unrelated changes; exclude secrets and private planning artifacts. Ask when the
destination is missing or ambiguous. Use normal pushes, never force-push.

Verify no in-scope changes remain uncommitted and each remote branch matches its
checkpoint HEAD, for example with `git ls-remote`. Refresh worker HEADs, commits,
and changed paths in the log. Local commits and stashes alone are insufficient.
If committing, pushing, or verification is blocked, record the failure and exact
recovery action; withhold `handoff-ready` and the continuation command.

Keep the feature folder and required local-only evidence outside disposable
worktrees, updating references if moved. Record unfinished validation and review
without treating the checkpoint push as approval or phase completion.

Append a `handoffs` entry with the outgoing coordinator, timestamp, reason, and
remaining context, plus each worktree's checkpoint remote URL (without
credentials), branch, and verified SHA. Only after every checkpoint is verified,
set coordinator status to `handoff-ready`. Parse the saved JSON and confirm a
fresh worktree can recover the code and locate required artifacts, outstanding
decisions, and the next action without this conversation or the old worktrees.

## 3. Release coordination

Return only this command, substituting the absolute feature-folder path:

`/continue-plan for "<absolute-feature-folder-path>"; resume the recorded action.`

Then stop dispatching work and modifying the feature. The new session claims
coordination through `continue-plan`; the checkpoint grants no new approval.
