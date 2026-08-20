---
name: execute-phase
description: Execute one approved feature phase with a TDD sub-agent, review and fix the complete phase diff, then wait for approval before pushing and opening a pull request.
---

# Execute Phase

Execute exactly one approved phase. A dedicated implementation sub-agent owns
the TDD work and review fixes. This skill orchestrates state, review, and
handoff; it does not implement the phase in the main conversation.
The main agent must not write production code or tests for the phase.

The initial endpoint is a validated, reviewed local branch with committed
changes. Stop there and wait for the user to approve publishing the pull
request.

## Required skills

- `tdd`
- `code-review`

If either skill is unavailable, stop and tell the user to make it available.

## Inputs

| Input | Required | Description |
| --- | --- | --- |
| Feature folder | Yes | Folder containing the approved plan artifacts. |
| Phase spec | Yes | Current approved phase HTML file. |
| Execution progress | Yes | `execution-progress.html` for the feature. |
| Requested action | Yes | Implement/resume, address feedback, or publish the reviewed phase. |

Use the repository, branch strategy, target branch, validation, execution
model, and pull-request strategy recorded in the approved artifacts. Do not
select substitutes.

## 1. Restore and validate state

Read the execution progress first, then the complete current phase spec. Read
the overall plan only when the phase links to a cross-cutting decision that is
not explained locally.

Before changing anything:

1. Confirm the requested phase is the current `not started` or `in progress`
   phase. Do not execute a `blocked`, `review`, or later dependent phase.
2. Confirm prerequisites and required approvals are complete.
3. Inspect the live repository, branch, HEAD, remotes, and worktree.
4. Compare live state with the execution record. Planning-time snippets are not
   source truth.
5. Refuse unrelated or unexplained worktree changes. Preserve recorded phase
   work when resuming.
6. Record the phase starting SHA as the immutable `code-review` fixed point.
7. Confirm the approved source branch. If none is recorded or active, ask the
   user instead of inventing a branch or changing branches silently.

If live code materially contradicts an approved design decision, mark the phase
`blocked`, record the conflict and exact next action, and return to
`design-plan`.

Before dispatch, set the phase to `in progress` and record the agent, starting
SHA, branch, timestamp, and exact next action in `execution-progress.html`.

## 2. Implement through a TDD sub-agent

Launch one implementation sub-agent using the phase's recorded model. Give it:

- the absolute repository path and current branch;
- the phase spec and execution-progress paths;
- the phase starting SHA;
- repository guidance;
- the absolute path to the `tdd` skill and its references;
- approved validation commands; and
- any recorded resume action or relevant pull-request feedback.

Require the agent to:

1. Read the phase spec and live relevant code.
2. Map acceptance criteria to approved public seams.
3. Execute one red -> green vertical slice at a time.
4. Run targeted validation during the loop and final validation once after all
   slices.
5. Implement only the current phase.
6. Stop on a material design conflict rather than choosing new behavior.
7. Commit the completed TDD implementation locally without pushing.
8. Return red/green evidence, changed paths, validation, commit SHA, and any
   deviation or blocker.

The main agent must verify the commit exists, the worktree is clean, and the
reported validation corresponds to the phase. Update execution progress with
the result.

## 3. Review the complete phase

Invoke `code-review` with:

- fixed point: the recorded phase starting SHA;
- review head: current local HEAD;
- originating intent: the approved phase spec;
- repository: the live repository; and
- the complete phase commit list and diff.

Do not replace the fixed point after review fixes. Every review covers the
complete phase change from its original starting SHA.

If review returns a material design decision, mark the phase `blocked`, record
the decision needed, and wait for the user. Do not let the implementation agent
resolve it implicitly.

## 4. Fix findings

Send all retained blockers and material improvements to the same implementation
sub-agent. Require it to reread the cited live code and:

- fix each finding within the approved phase;
- use a red -> green cycle when a fix changes or adds behavior;
- preserve or add behavior-focused regression coverage;
- run targeted and final validation; and
- create a new local commit without amending or pushing.

Verify the returned commit, clean worktree, and validation. Record the fixes and
commit in execution progress.

Run `code-review` again over the full starting-SHA-to-HEAD diff. Repeat the
fix-and-review loop until no blocker or material improvement remains. If the
same root issue survives two fix attempts, or reviewers produce a design
conflict, mark the phase `blocked` and ask the user rather than looping
indefinitely.

## 5. Wait for publish approval

When TDD, final validation, and the final code review are clean:

1. Keep the phase `in progress`; a phase enters `review` only after its pull
   request exists.
2. Record all local commit SHAs, changed paths, validation, final review result,
   and any approved deviation.
3. Set the exact next action to `Await user approval to push and create the pull
   request`.
4. Report the local branch, commit range, validation, and review signal.
5. Stop.

Do not push, open a pull request, or post provider content until the user
explicitly asks to publish.

## 6. Publish the pull request

On an explicit publish action:

1. Reload execution progress and inspect the live branch, HEAD, worktree, and
   final review record.
2. If HEAD changed or the worktree is not clean, rerun required validation and
   `code-review`; do not publish stale approval.
3. Invoke `pr-description` with the target branch, originating intent, complete
   reviewed diff, commit list, validation, and linked artifacts. Use its output
   unchanged as the PR description.
4. Push only the recorded source branch.
5. Create the pull request against the recorded target branch using the
   provider's approved companion skill or integration. Invoke
   `azure-devops-workflow` for Azure DevOps.
6. Build the title from the observable outcome. Never expose internal planning
   vocabulary in the title or description.
7. Update the phase to `review` and record the PR URL, creation time, commits,
   and exact next action in `execution-progress.html`.
8. Preserve all earlier pull-request register entries.
9. Stop and wait for review feedback or the user's merge report.

Never mark the phase `complete`. `continue-plan` does that only after the user
reports that the pull request merged.

## Pull-request feedback

When the requested action is to address feedback on an existing phase PR:

1. Retrieve the current approved feedback through the provider integration.
2. Give only that feedback and the current phase context to an implementation
   sub-agent.
3. Use TDD for behavior changes, run validation, commit locally, and run
   `code-review` over the complete phase diff.
4. Wait for explicit approval before pushing the follow-up commits.
