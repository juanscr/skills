---
name: design-plan
description: Create an approved design baseline and first executable phase, then coordinate child execution. Use only when the user explicitly invokes design-plan.
---

Create the smallest design package that lets the user defend the direction and
lets a fresh agent begin the current phase safely. Planning establishes an
amendable baseline, not a prediction of every implementation detail.

## Inputs

| Input | Required | Default |
| --- | --- | --- |
| Task description | Yes | None |
| Existing feature folder | No | None |
| Planning mode | No | Standard |
| Spec format | No | HTML; Markdown for Brief mode |
| Spec root | No | `~/Documents/coding-specs` |

Store specs at:

`<spec-root>/<repository-name>/<kebab-case-feature-name>/`

Allow the user to override the planning mode, format, and spec root, including
choosing a directory inside the repository.

The format choice applies to human-facing plans. The Agent's log is always
`execution-progress.json`. Before revising an existing feature, migrate a
legacy log through `references/legacy-normalization.md`.

When revising an existing feature, use its folder. Preserve its Agent's log,
completed phase history, amendment entries, and pull-request register. Mark
replaced design text as superseded instead of erasing why it changed.

## Required skills

Use `grilling` only when a human-owned decision is unresolved. If a required
skill for the selected path is unavailable, stop and tell the user to make it
available.

## Non-negotiable rules

1. Facts are the agent's responsibility. Decisions belong to the user.
2. Ground design claims in repository evidence or a recorded user decision.
3. The live repository is source truth. Plan snippets only explain decisions.
4. Use plain English and the smallest artifact that carries the decision.
5. Approval is an affirmative user statement naming the artifact or decision.
   It remains valid until an amendment changes what was approved.
6. Resolve every unknown that blocks the overall direction or current phase.
   Record later-phase unknowns instead of guessing or resolving them early.
7. Keep repository implementation in phase workers. Start execution only after
   the overall plan and current phase are approved and the Agent's log exists.

Read and follow:

- [Artifact requirements](references/artifact-requirements.md)
- [HTML standard](references/html-standard.md) when producing HTML

## 1. Establish the decision horizon

Search the live repository for the evidence needed to understand the task.
Separate facts from decisions. Use `grilling` only for the frontier of decisions
that must be settled to approve the overall direction or current phase.

Choose Brief, Standard, or Deep using the artifact requirements. State the
recommended mode, format, and expected artifacts before drafting; let the user
override them.

Create the feature folder once the repository and feature name are known, or
reuse the supplied existing feature folder.
Obtain explicit approval of the shared understanding when the overall direction
and current decision horizon have no unresolved blocking decisions.

## 2. Create and approve the overall plan

Create `index.<format>`. It defines the current approved architecture and gives
every phase an observable outcome, boundary, dependencies, acceptance criteria,
and verification. Later phases remain outlines until they become current.

Choose coherent, reviewable behavior slices. Avoid infrastructure-only slices
unless independently useful. Explain why each dependency and phase boundary
exists, while allowing a phase to split later when execution produces evidence.

Draft and present every planning mode with the coordinator so repository
evidence, decisions, and document context remain continuous. When an HTML
diagram earns its place, use only the bounded SVG delegation defined by the
HTML standard.

The coordinator owns factual accuracy and software design. Resolve specific gaps
through repository research or focused `grilling`; do not expand the decision
horizon merely because a later phase contains uncertainty.

Present the overall plan for explicit approval. After phase boundaries are
approved, optionally offer a concise GitHub issue or Azure DevOps work item.
Ask for the provider and explicit permission before creating one.

## 3. Create and approve the current phase

For Brief mode, the overall plan may contain sufficient implementation detail
and serve as the approved phase spec. Otherwise create
`phase-<number>-<kebab-case-name>.<format>` for the first phase only.

Reread the relevant live paths immediately before drafting. The phase spec must
settle the outcome, boundary, public contracts, acceptance criteria, and
verification needed to implement safely. It may leave internal implementation
choices to execution.

Present the phase for explicit approval. Offer to draft later phases now only
when the user wants that work or their contracts must be settled to make the
current phase safe.

Before the Agent's log exists, incorporate new evidence into the affected draft,
mark approved text superseded when needed, and obtain approval for the changed
decision. Once the Agent's log exists, later evidence is handled through
`amend-plan`. Do not regenerate the whole package unless the feature objective
or overall decomposition is invalid.

## 4. Set execution defaults

Execution proceeds one phase at a time. Use one pull request per phase unless
the user chooses another strategy.

Before creating the Agent's log, obtain and record:

- target branch;
- required validation;
- pull-request strategy; and
- any external task artifact links.

Worker dispatch, implementation method, and review configuration belong to
their owning execution and review skills; they are not planning blockers.

## 5. Create the Agent's log

For a new feature folder, create `execution-progress.json` using the Agent's log
requirements. Initialize every phase as `not started`. Mark the first phase spec
`approved`; mark later phase specs `outline only` unless separately drafted and
approved.

For an existing feature folder, update its Agent's log in place. Reconcile
phases by stable identity, preserve every existing phase and spec status plus
execution history, initialize only newly introduced phases, and require
approval for every changed current-phase spec.

Resolve and link the pending re-plan amendment, clear its blocker after the
redesigned baseline is approved, mark removed phases as `superseded`
non-executable history, select a valid current phase, and retain every earlier
phase, amendment, commit, and pull-request record.

Set `current.action` to execute or draft the selected phase as its spec status
requires. The feature folder must be sufficient for a new agent without the
original conversation.

## 6. Continue as coordinator

Remain the feature coordinator. Invoke `continue-plan` with the absolute
feature-folder path and the explicit action **implement the approved current
phase**. A folder-only handoff requests status, not execution.

`execute-phase` owns worker dispatch and result collection. Keep coordination
in this session; pause for required decisions, publication permission, and the
user's merge report. When every phase is complete, end coordination.

When the user wants to replace the coordinator or clear its context, invoke
`plan-handoff` instead of starting another coordinator alongside this one.
