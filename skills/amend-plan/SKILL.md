---
name: amend-plan
description: Amend an approved feature plan when execution evidence requires a local deviation, phase split, design change, or blocked-phase resolution.
---

# Amend Plan

Change the smallest owning part of an approved plan, preserve its history, and
return an exact safe resume action. Approval makes a plan amendable, not
immutable.

## Inputs

| Input | Required | Description |
| --- | --- | --- |
| Feature folder | Yes | Folder containing the overall plan and Agent's log. |
| Agent's log | Yes | `execution-progress.html`. |
| Current phase | Yes | Phase number, outline, and spec when one exists. |
| Evidence | Yes | Live repository fact, review finding, or user decision that triggered the amendment. |

Read the Agent's log first, then the affected plan sections and live repository
paths. Do not reread or rewrite unaffected phase specs.

Follow the amendment and subphase artifact rules in
`../design-plan/references/artifact-requirements.md`.

## Classification

Classify by which approved invariant changes:

| Class | Trigger | Approval and action |
| --- | --- | --- |
| **Clarification** | A recorded fact is stale, such as a moved path or renamed helper, while the approved design remains true. | Correct the Agent's log and continue. |
| **Local adaptation** | An implementation choice not recorded as an approved decision changes while the phase outcome, acceptance criteria, public contracts, validation, and boundary remain true. Examples include internal naming, private structure, helper choice, file layout, or an unprescribed test seam. | Record the adaptation and continue without a new approval gate. |
| **Phase split** | The design remains true, but the current phase must be divided, reordered, or shed work. Existing acceptance criteria are redistributed rather than changed. | Present the split, criterion allocation, dependencies, and recommendation for explicit approval. |
| **Design amendment** | A recorded decision, public contract, validation requirement, acceptance criterion, or phase boundary changes meaning while the feature objective and overall decomposition remain valid. | Present the evidence, affected decision, options, and recommendation. Use focused `grilling` when more than one human-owned decision remains. Obtain explicit approval. |
| **Re-plan** | The feature objective, problem framing, overall architecture, or decomposition as a whole is invalid. | Record the evidence and exact question, mark the phase blocked, and tell the user to invoke `design-plan` for the feature folder. |

Effort and file count do not determine the class. The affected approved
invariant does.

If focused `grilling` is required for a design amendment but unavailable, stop
and tell the user to make it available.

## Amendment rules

1. Create a stable amendment id and append one entry using the schema in the
   artifact requirements, including the concrete change. For a clarification or
   local adaptation record `approval: not required` and the governing class.
   Before asking about a phase split or design amendment, record
   `approval: pending`, mark the phase blocked, and save the exact question and
   resume action. Update the entry to approved or rejected after the user
   responds and record the approver.
2. Clarifications and local adaptations update the Agent's log. When the stale
   fact is present in a plan, correct that fact there and link the amendment
   without reopening the design decision.
3. For a phase split, apply the numbering, container, execution-record
   inheritance, and acceptance-criterion ownership rules in the artifact
   requirements after approval. Update the overall plan's phase outline with
   the child outcomes, boundaries, dependencies, and criterion allocation, and
   link that section to the amendment id.
4. A design amendment changes only the owning decision or phase section. Mark
   retained earlier text **Superseded**, add the approved replacement and
   evidence, and link it to the amendment id.
5. Create a new child phase spec only when its implementation detail cannot be
   carried by the amended parent spec or phase outline.
6. Update phase and spec status, blockers, prerequisites, and current position
   in the Agent's log. A blocked phase must link to its amendment id.
7. Do not use a drafting sub-agent or regenerate a complete plan for a
   clarification, local adaptation, phase split, or focused design amendment.

## Resume

After an approved split or design amendment, clear the linked blocker, restore
the phase to `in progress` or `not started` as appropriate, and return control
to the calling workflow in the same session.

After rejection, keep the phase blocked, record the user's reason, and set the
exact next action to prepare a revised proposal or invoke `design-plan` when
the rejected direction exposes a feature-level change.

The amendment is complete when every changed plan section links to the amendment
id, every affected acceptance criterion has one owning child or an explicitly
recorded shared owner set, the Agent's log records the applicable approval state
and current state, and the exact next action is executable.
