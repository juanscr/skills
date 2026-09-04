---
name: execute-phase
description: Execute one approved feature phase with a proportionate implementation method, adapt through amend-plan when evidence changes the plan, review the complete phase diff, and wait for approval before publishing.
---

# Execute Phase

Execute one current phase. The main agent owns implementation, tests,
validation, review fixes, state, and handoff. Use sub-agents only when
independent work benefits from parallel or isolated context.

The initial endpoint is a validated, reviewed local branch with committed
changes. Stop there unless the user explicitly requested publication.

## Required skills

- `amend-plan`
- `code-review`

Use `test-quality` whenever tests change. Use `tdd` only for substantial feature
work with multiple observable behaviors. If a required skill is unavailable,
stop and tell the user to make it available.

## Inputs

| Input | Required | Description |
| --- | --- | --- |
| Feature folder | Yes | Folder containing the approved plan artifacts. |
| Current phase | Yes | Approved spec, Brief inline spec, or outline-only phase. |
| Agent's log | Yes | `execution-progress.html`. |
| Requested action | Yes | Draft/implement/resume, address feedback, or publish. |

Use recorded repository, branch, target, validation, and pull-request values.
Implementation method and sub-agent use are execution decisions.

## 0. Restore and validate state

Read the Agent's log first, then the current phase material. Read the overall
plan only for linked cross-cutting decisions.

For a log without schema version `2`, read and apply
`../design-plan/references/legacy-normalization.md` before routing.

Before changing anything:

1. Confirm the phase is current or explicitly designated as the active
   independent exception, executable rather than a split-phase container, and
   has spec status `outline only`, `drafted`, or `approved`.
2. An amendment-blocked phase is eligible when its linked amendment records an
   approved resolution. An operationally blocked phase is eligible when its
   recorded resume condition is satisfied. A `review` phase is eligible only
   for feedback or publication, not new implementation.
3. Inspect the live repository, branch, HEAD, remotes, and worktree.
4. Compare live state with the Agent's log. Planning snippets are not source
   truth.
5. Identify unrelated worktree changes, determine whether they overlap this
   phase, and preserve them. Ask the user only when overlap or ownership makes
   proceeding unsafe.
6. Confirm the approved source branch. Ask when none is recorded or active.

When live evidence changes the plan, invoke `amend-plan`. Continue immediately
after a clarification, local adaptation, or approved focused amendment. Stop
only when `amend-plan` returns a human decision or re-plan.

## 1. Prepare the current phase

When spec status is `outline only`, draft the current phase from:

- the approved phase outline;
- the validated live repository;
- completed-phase results and amendments; and
- the recorded planning mode and format.

Keep the draft proportional and settle only what the current phase needs. Write
the file, link it from the Agent's log, and set spec status to `drafted` before
presenting it for approval. If the session stops, the next run presents this
existing draft instead of recreating it.

When spec status is `drafted`, present the existing draft and its unresolved
questions. On explicit approval, set spec status to `approved`; stop unless the
user also requested implementation. On rejection, preserve the draft, record
the reason and exact revision action, keep it non-executable, and revise it only
as requested before presenting it again. Do not implement an unapproved draft.

For implementation, confirm prerequisites and required approvals. When
transitioning from `not started`, record the current SHA as the immutable
`code-review` fixed point. When resuming `in progress`, require and reuse its
existing fixed point; if it is missing or invalid, record an operational
blocker instead of deriving a new one. Then set or retain `in progress` with
branch, timestamp, and exact next action.

## 2. Implement the phase

Use TDD only for substantial feature behavior. Implement refactoring, CI or
build configuration, test-only work, documentation, narrow fixes, and other
straightforward changes directly. For mixed work, use TDD only for the
substantial behavior.

Read relevant live code and implement the approved outcome. Follow
`test-quality` for changed tests. Run targeted validation while working and the
recorded final validation when complete.

Local implementation choices are available to the agent while the approved
outcome, acceptance criteria, public contracts, validation, and phase boundary
remain true. Record meaningful local adaptations through `amend-plan`; do not
turn ordinary implementation choices into approval gates.

When evidence crosses an approved invariant, invoke `amend-plan` and follow its
classification. Otherwise complete the phase, commit locally without pushing,
and update the Agent's log with changed paths, validation, commits, and
amendments.

## 3. Review the complete phase

After initial implementation and final validation, run exactly one Deep
`code-review` over the complete phase diff:

- mode: `Deep`;
- fixed point: recorded phase starting SHA;
- review head: current local HEAD;
- originating intent: current approved plan plus amendments;
- repository: live repository;
- complete phase commit list and diff; and
- validation commands, results, and exclusions already produced by this
  workflow.

The reviewers consume validation evidence and do not run formatters, builds,
tests, linters, restoration, or other CI gates.

Keep the fixed point unchanged. Record the Deep-review head, stable finding IDs,
retained findings, validation evidence, and review result in the Agent's log.
Route genuine design ambiguity through `amend-plan`; do not resolve it silently.

## 4. Fix findings

Fix every blocker and every proportionate material improvement that protects
the approved phase outcome. Add useful regression coverage, run targeted and
final validation, and create a new local commit without amending or pushing.

Record a material improvement as follow-up instead of expanding the phase when
it is outside the approved boundary or disproportionate to the concrete impact.
Include the finding, rationale, and recommended owner in the Agent's log.

After fixes, classify the delta since the recorded Deep-review head using the
shared `code-review` invalidation rules:

- use `Verify` when changes are confined to retained findings;
- use `Light` when fixes add bounded directly coupled implementation while
  preserving the approved design and risk boundaries; or
- run a new `Deep` review only when the delta invalidates the recorded Deep
  review.

Verify mode receives the retained finding IDs, expected resolutions, resolution
commits, original fixed point, Deep-review head, current head, and validation
evidence. It verifies those findings and directly coupled blockers only.

Light mode uses one combined reviewer and reports blockers or design decisions
only. A changed `HEAD` by itself never requires another Deep review.

After each fix round, classify the new delta again rather than defaulting to
Verify. Allow at most two follow-up review rounds after the initial Deep review.
Every blocker from the latest Deep, Light, or Verify result gates publication.
If a blocker survives two fix attempts or blockers remain after the review
budget without changing the approved plan, mark the phase blocked with kind
`operational`, its evidence, owner, and exact resume condition.

Publish readiness requires a recorded Deep review, zero open blockers, and
every retained blocker verified resolved or superseded by an approved
amendment.

## 5. Wait for publish approval

When implementation, validation, and final review are publishable:

1. Keep the phase `in progress`; it enters `review` only after a pull request
   exists.
2. Record commits, changed paths, validation, final review signal, amendments,
   and deferred follow-ups.
3. Set the exact next action to await publication.
4. Report the local branch, commit range, validation, review signal, and any
   follow-ups.
5. Stop unless the user explicitly requested publication in this action.

Do not push, open a pull request, or post provider content without explicit
publication permission.

## 6. Publish the pull request

On an explicit publish action:

1. Reload the Agent's log and inspect branch, HEAD, and worktree.
2. If reviewed state changed, rerun required validation and classify the delta
   using the Verify, Light, and Deep invalidation rules in section 4.
3. Invoke `pr-description` with the target, approved intent and amendments,
   reviewed diff, commits, validation, and linked artifacts. Use its output
   unchanged.
4. Push only the recorded source branch.
5. Create the pull request against the recorded target using the provider's
   approved integration. Invoke `azure-devops-workflow` for Azure DevOps.
6. Build the title from the observable outcome, not planning vocabulary.
7. Set the phase to `review` and record the PR URL, creation time, commits, and
   exact next action.
8. Preserve every earlier pull-request entry and wait for feedback or the
   user's merge report.

Only `continue-plan` marks a phase complete after the user reports the pull
request merged.

## Pull-request feedback

For feedback on an existing phase pull request:

1. Retrieve the current approved feedback through the provider integration.
2. Address only feedback within the current approved phase and amendments.
3. Route changed design requirements through `amend-plan`.
4. Follow `test-quality`, run validation, commit locally, and classify the
   feedback delta using the Verify, Light, and Deep invalidation rules in
   section 4.
5. Wait for explicit approval before pushing follow-up commits.
