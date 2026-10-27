---
name: continue-plan
description: Use when continue plan is invoked.
---

# Continue Plan

Act as the feature coordinator: restore the current position and route the
requested action. The coordinator is the only writer of the plan and the
Agent's log.

## Input

An absolute feature folder, or a feature name to find under
`~/Documents/coding-specs`. A match must contain `execution-progress.json` or a
legacy `execution-progress.html`. Ask when several match; when none match, the
feature needs `design-plan`.

## Load

1. Read `execution-progress.json` following
   `../design-plan/references/artifact-requirements.md`. For a legacy log, apply
   `../design-plan/references/legacy-normalization.md` first.
2. Read the plan for the goal, design, decisions, and phases.
3. Pick the current phase: the one `in progress`, `review`, or `blocked`;
   otherwise the next `not started` phase whose dependencies are complete. Read
   its phase notes when present.

The live repository remains source truth for code.

## Take over after a handoff

When the coordinator is `handoff-ready` or another coordinator may still be
active, confirm nothing else is writing before claiming ownership. Restore the
work from the recorded checkpoint branches and update paths in the log. A
missing checkpoint is a blocker, not permission to restart from the target
branch. A handoff transfers coordination, not approval.

Then set `coordinator` to yourself, `active`, keeping handoff history.

## Route

With no action given, report the feature, current phase and status, blocker or
next action, PR, and one recommended next step. Wait.

**Resume the recorded action** means follow `current.action` within its
recorded approval. A pending decision, publication approval, or merge report is
still a stop.

- Phase work (implement, review, publish, PR feedback): invoke `execute-phase`.
- Plan changes or a decision on a pending amendment: invoke `amend-plan`, then
  `execute-phase` when it allows.
- A satisfied blocker condition: verify it, clear the blocker, and continue.
- A user report that the PR merged: mark the phase `complete`, select the next
  phase, and set the next action. Never assume a merge.
- A context question: answer from the artifacts and repository.
- Handoff or clearing the session: invoke `handoff`.

While a phase is blocked, the user may authorize a later phase that does not
depend on it; record it as current. When every phase is complete, set the
coordinator `complete` and report.
