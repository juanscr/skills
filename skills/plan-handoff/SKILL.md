---
name: plan-handoff
description: Checkpoint a feature plan when the user wants to replace its coordinator or clear the session. Use only for an explicit plan handoff or coordinator replacement.
---

# Plan Handoff

Transfer feature coordination through the existing Agent's log, not a second
handoff document. Accept the current feature folder or an explicit absolute
path; ask when the active feature is ambiguous.

## 1. Reach a safe checkpoint

Load `execution-progress.json` and the current phase. For a legacy log, apply
`../design-plan/references/legacy-normalization.md` before proceeding.
Follow the log contract in
`../design-plan/references/artifact-requirements.md`.

Ask active workers to finish their current bounded operation or pause safely,
then collect their results and inspect the actual worktrees. Account for
running commands as well as agents: clearing a session must not abandon an
unrecorded writer. Do not force a commit, publish, or discard uncommitted work
merely to hand off.

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

Append a `handoffs` entry with the outgoing coordinator, timestamp, reason, and
remaining context. Set coordinator status to `handoff-ready`. Parse the saved
JSON and confirm the next agent can locate the active worktree, required
artifacts, outstanding decisions, and next action without this conversation.

## 3. Release coordination

Return only this command, substituting the absolute feature-folder path:

`/continue-plan for "<absolute-feature-folder-path>"; resume the recorded action.`

Then stop dispatching work and modifying the feature. The new session claims
coordination through `continue-plan`; the checkpoint grants no new approval.
