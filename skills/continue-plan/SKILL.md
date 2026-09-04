---
name: continue-plan
description: Restore the current context of an existing feature plan and route the user's requested next action. Use only when the user explicitly asks to continue or resume a plan.
disable-model-invocation: true
---

# Continue Plan

Restore enough context to continue an existing feature safely. Load the current
position, recommend the next action, and act only on the user's requested or
confirmed action.

## Required skills

- `amend-plan`
- `execute-phase`

If a required skill is unavailable, stop and tell the user to make it
available. `design-plan` is a user-invoked re-plan destination, not a dependency
for ordinary continuation.

## Input

Accept either:

- an absolute feature-spec folder path; or
- a feature name to find under `~/Documents/coding-specs`.

Prefer an explicit folder path. When searching by name, require the folder to
contain `execution-progress.html`. If multiple folders match, ask the user to
choose. If none match, state that the feature needs a `design-plan` handoff.

## Load order

1. Read `execution-progress.html` first. It is the Agent's log and source of
   truth for workflow state, approvals, amendments, pull requests, blockers,
   and the exact next action.
   For a log without schema version `2`, read and apply
   `../design-plan/references/legacy-normalization.md` before routing.
2. Read the linked overall plan for the feature goal, current approved design,
   decisions, and phase boundaries.
3. Identify the current phase:
   - ignore phase rows marked as containers or superseded;
   - use an executable `in progress`, `review`, or `blocked` phase when one
     exists;
   - otherwise use the next eligible `not started` phase named by current
     position;
   - if every phase is complete, do not load a phase spec.
4. Read the current phase spec when its spec status is `drafted` or `approved`.
   When it is `outline only`, read its outline from the overall plan and note
   that `execute-phase` will draft it before implementation.

Do not eagerly read later phase specs. The plans explain approved decisions;
the live repository remains source truth for code.

## Resume behavior

When the user did not request an action, report the feature, current phase and
status, blocker or exact next action, relevant pull request, and one recommended
next action. Wait for confirmation or redirection.

When the user included an action, restore context and route only that action:

- implementation, iteration, validation, phase drafting, phase-spec review,
  explicit approval or rejection of a draft, or pull-request feedback: invoke
  `execute-phase` with the feature folder, current phase outline or spec,
  Agent's log, and the user's exact requested action;
- new execution evidence, a phase split, a focused design change, or a decision
  resolving an amendment blocker: invoke `amend-plan`, update current position,
  and resume `execute-phase` when the amendment permits it;
- a satisfied operational blocker: verify its recorded resume condition, clear
  the blocker without creating an amendment, and invoke `execute-phase`;
- a feature-level change to the objective, architecture, or decomposition:
  invoke `amend-plan` so it records and blocks the re-plan, then tell the user
  to invoke `design-plan` with this existing feature folder and the decision to
  revisit;
- a user report that the current pull request merged: update that phase to
  `complete`, preserve its history and pull-request record, select the next
  eligible phase, recompute every ancestor container status using the artifact
  requirements, and set the exact next action according to spec status;
- a context question: answer from the loaded artifacts and live repository
  without dispatching implementation.

A current `in progress` or `review` phase retains priority. An amendment blocker
resumes when its linked amendment records an approved resolution. An operational
blocker resumes when its recorded resume condition is satisfied. The user may
authorize an independent later phase only when the dependency graph shows that
it does not depend on the blocked phase. Record that phase as the active
exception in current position before dispatch; `execute-phase` treats that
explicit designation as current for the action.

Never treat a pull request as merged without the user's report.

## Safety

Before changing code or progress:

- confirm the recorded repository exists;
- inspect its live branch and worktree;
- compare them with the Agent's log; and
- surface stale or conflicting handoff information through `amend-plan` instead
  of inventing a replacement.

Use every execution value that the Agent's log records. Implementation method,
sub-agent use, and review configuration remain decisions of their owning
skills; missing values for them are not planning blockers.
