---
name: amend-plan
description: Use when amending a plan spec.
---

# Amend Plan

Change the smallest part of an approved plan that the evidence affects, keep
its history, and return an exact next action. The coordinator runs this skill;
workers return evidence to it.

Read the Agent's log, then only the affected plan sections and repository
paths.

## Who decides

Does the change alter something the user approved: a phase outcome, an
acceptance criterion, a public contract, a recorded decision, required
validation, or the overall breakdown?

- **No: the agent decides.** This covers stale facts, implementation choices,
  and splitting or reordering phases while keeping every acceptance criterion.
  Record it, continue, and mention it in the next report to the user.
- **Yes: the user decides.** Record the amendment as pending, block the phase,
  and present the evidence, the affected decision, options, and a
  recommendation. Use `grilling` when more than one decision is open.

If the feature's objective or overall design no longer holds, record the
evidence and tell the user to invoke `design-plan` with this feature folder.

Size and effort do not decide who owns the change; what it changes does.

## Apply

1. Append an amendment entry to the Agent's log.
2. Update only the owning plan section. Mark replaced text **Superseded**, add
   the replacement, and link the amendment ID.
3. For a split, follow the split rules in
   `../design-plan/references/artifact-requirements.md`, update the plan's
   phase list, and move the parent's execution state to the child that
   continues it. The review fixed point does not change. Ask before splitting a
   phase that already has a pull request.
4. Update phase status, blockers, and `current` in the log.

## Resume

After approval, clear the blocker and return control to the caller. After
rejection, keep the phase blocked, record the reason, and set the next action
to a revised proposal or `design-plan`.
