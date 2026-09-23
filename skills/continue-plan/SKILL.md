---
name: continue-plan
description: Restore feature coordination when the user asks to continue a plan or design-plan hands off an approved phase.
---

# Continue Plan

Act as the feature coordinator. Restore the current position and route the
requested action; a `design-plan` handoff supplies an explicit implementation
action. A fresh session resumes the coordinator role, not a new execution tree.

The coordinator is the sole writer of shared plan artifacts and the Agent's
log. Phase workers return results and amendment evidence through `execute-phase`.

## Required skills

- `amend-plan`
- `execute-phase`

If a required skill is unavailable, stop and tell the user to make it
available. `design-plan` is an explicit-user-request re-plan destination, not a
dependency for ordinary continuation.

## Input

Accept either:

- an absolute feature-spec folder path; or
- a feature name to find under `~/Documents/coding-specs`.

Prefer an explicit folder path. When searching by name, require the folder to
contain `execution-progress.json` or a legacy `execution-progress.html`. If
multiple folders match, ask the user to choose. If none match, state that the
feature needs a `design-plan` handoff.

## Load order

1. Load `execution-progress.json` first, using the Agent's log requirements in
   `../design-plan/references/artifact-requirements.md`. If only a legacy log
   exists or the schema is not `3`, apply
   `../design-plan/references/legacy-normalization.md` before routing.
   Load metadata, coordinator, current position, and the selected phase record;
   retrieve historical records only when relevant.
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

For a coordinator replacement, reconcile the recorded owner and workers before
claiming ownership. A `handoff-ready` checkpoint transfers coordination, not
new approval. If the previous coordinator or a worker may still be writing,
settle ownership before dispatch or shared-artifact edits.

## Resume behavior

When neither the user nor a `design-plan` handoff supplied an action, report the
feature, current phase and status, blocker or exact next action, relevant pull
request, and one recommended next action. Wait for confirmation or redirection.

**Resume the recorded action** means reconcile live state, claim coordination,
and follow `current.action` within its recorded approval scope. A pending
decision, publication approval, or merge report remains a stop, not permission
to proceed. Set `coordinator` to the new owner, `active`, and the current
timestamp while preserving handoff history.

When an action was supplied, restore context and route only that action:

- implementation, iteration, validation, code review, publication, phase
  drafting, phase-spec review, explicit approval or rejection of a draft, or
  pull-request feedback: invoke `execute-phase` with the feature folder,
  current phase outline or spec, Agent's log, supplied action, and recorded
  approval scope;
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
  without dispatching implementation;
- a request to replace the coordinator or clear the session: invoke
  `plan-handoff` and stop after its checkpoint.

Keep control in the coordinator when invoking these workflows; `execute-phase`
delegates bounded work rather than launching another coordinator. If every
phase is complete, set coordinator status to `complete` and report completion
without dispatching a worker.

A current `in progress` or `review` phase retains priority. An amendment blocker
resumes when its linked amendment records an approved resolution. An operational
blocker resumes when its recorded resume condition is satisfied. The user may
authorize an independent later phase only when the dependency graph shows that
it does not depend on the blocked phase. Record that phase as the active
exception in current position before dispatch; `execute-phase` treats that
explicit designation as current for the action.

Never treat a pull request as merged without the user's report.
