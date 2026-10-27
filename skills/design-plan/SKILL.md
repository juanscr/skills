---
name: design-plan
description: Use only when the user explicitly invokes design-plan.
---

Guide the user to an approved design they understand and can defend, then
coordinate its execution. The user owns outcomes and decisions; the agent owns
facts and implementation details.

## Inputs

| Input | Required | Default |
| --- | --- | --- |
| Task description | Yes | None |
| Existing feature folder | No | None |
| Spec root | No | `~/Documents/coding-specs` |

Store specs at `<spec-root>/<repository-name>/<kebab-case-feature-name>/`.
Plans are HTML unless the user asks for another format.

When revising an existing feature, use its folder and preserve its Agent's log
history. Migrate a legacy log through `references/legacy-normalization.md`
first. Mark replaced design text **Superseded** instead of erasing why it
changed.

Read and follow:

- [Artifact requirements](references/artifact-requirements.md)
- [HTML standard](references/html-standard.md) when producing HTML

## Rules

1. Look facts up yourself; ask the user only for decisions.
2. Ground design claims in repository evidence or a recorded user decision.
   The live repository is source truth.
3. Keep the plan at the level of outcomes, behavior, boundaries, and decisions.
   Leave implementation detail to execution.
4. Start simple and go deeper wherever the user asks. Do not pre-teach.
5. Approval is an affirmative user statement naming the artifact or decision.

## 1. Understand the problem

Research the live repository. Use `grilling` for the decisions the user must
make before the direction can be approved. Create the feature folder once the
repository and feature name are known.

## 2. Write and approve the plan

Create `index.<format>` following the artifact requirements. Split the work
into coherent, reviewable behavior slices; avoid infrastructure-only phases
unless independently useful. Later phases may keep unknowns that do not block
the first.

When the user asks about something, answer it and fold the answer into the
plan when it belongs there. Present the plan for explicit approval.

After approval, optionally offer a concise GitHub issue or Azure DevOps work
item. Ask for the provider and permission before creating one.

## 3. Create the Agent's log

Infer the target branch and required validation from the repository; ask only
when unclear. Default to one pull request per phase.

Create `execution-progress.json` following the artifact requirements, with
every phase `not started`. For an existing feature folder, update the log in
place: reconcile phases by ID, keep all history, mark removed phases
`superseded`, and resolve the pending re-plan amendment.

## 4. Continue as coordinator

Invoke `continue-plan` with the absolute feature-folder path and the action
**implement the current phase**. A folder-only handoff requests status, not
execution.

Remain the coordinator. Pause for user decisions, publication approval, and
merge reports. To replace the coordinator or clear the session, invoke
`handoff`.
