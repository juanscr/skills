---
name: continue-plan
description: Restore the current context of an existing feature plan and route the user's requested next action. Use only when the user explicitly asks to continue or resume a plan.
disable-model-invocation: true
---

# Continue Plan

Restore enough context to continue an existing feature safely. This skill does
not execute a phase, review a pull request, or decide what the user wants to do.
It loads the handoff, reports the current position, and waits when no action was
requested.

## Input

Accept either:

- an absolute feature-spec folder path; or
- a feature name to find under `~/Documents/coding-specs`.

Prefer an explicit folder path. When searching by name, require the folder to
contain `execution-progress.html`. If multiple folders match, ask the user to
choose. If none match, state that the feature needs a completed `design-plan`
handoff.

## Load order

1. Read `execution-progress.html` first. It is the source of truth for workflow
   state, completed work, approvals, pull requests, blockers, and the exact next
   action.
2. Read the overall plan linked by the progress file to restore the feature's
   goal, architecture, decisions, and phase boundaries.
3. Identify the current phase from the progress file:
   - use the `in progress`, `review`, or `blocked` phase when one exists;
   - otherwise use the next eligible `not started` phase named by the
     current-position section;
   - if every phase is complete, do not load a phase spec.
4. Read only that phase's HTML spec.

Do not eagerly read every phase. When a reported merge closes the current phase
and makes another phase current, update the progress state first, then read the
new current phase spec.

The specs explain approved decisions, but the live repository remains the
source of truth for code. Do not trust planning-time snippets as current code.

## Resume behavior

If the user did not request an action:

1. Briefly report the feature, current phase and status, blocker or exact next
   action, and relevant pull request.
2. Wait for the user to say what they want to do.

Do not infer that the user wants to implement, address review feedback, merge,
start the next phase, or redesign anything.

If the user included an action, restore context first and then route only that
action:

- implementation, iteration, validation, or pull-request feedback for the
  current phase: invoke `execute-phase` with the feature folder, current phase
  spec, progress file, and the user's requested action;
- a material design change: invoke `design-plan` with the feature folder and
  the decision that must be revisited;
- a user report that the current pull request merged: update that phase to
  `complete`, preserve its history and pull-request record, select the next
  eligible phase, update the exact next action, and read the new phase spec;
- a context question: answer from the loaded artifacts and live repository as
  needed without dispatching implementation.

Never substitute a later phase while the current phase is `in progress`,
`review`, or `blocked`. Never treat a pull request as merged without the user's
report.

## Safety

Before any action that changes code or progress:

- confirm the recorded repository exists;
- inspect its live branch and worktree;
- compare them with the progress record; and
- surface missing, stale, or conflicting handoff information instead of
  inventing it.

Do not create a replacement plan. Do not select a new model or execution
strategy; use the approved values in the progress file and current phase spec.
