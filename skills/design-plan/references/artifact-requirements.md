# Artifact Requirements

The feature folder is the complete planning and continuation boundary. It must
not depend on the original conversation.

## Proportional planning

Choose the smallest mode that preserves the decisions and continuation context:

| Mode | Use when | Human-facing artifacts |
| --- | --- | --- |
| **Brief** | One small phase with few decisions, such as configuration, tests, documentation, a narrow fix, or a small refactor. | One concise overall plan. Put phase implementation detail in the same file. |
| **Standard** | A normal feature with multiple decisions or phases. | One concise overall plan and a detailed spec for the current phase only. |
| **Deep** | High-risk architecture, migration, concurrency, security, or an explicit teaching request. | A teaching-focused overall plan and detailed current-phase spec. |

Brief and Standard plans use Markdown unless diagrams or substantial navigation
make HTML useful. Deep plans normally use HTML. The user may override the mode
or format. Record the selected mode and format in the Agent's log.

Write for the engineer who participated in the design and owns the repository.
Explain reasoning, rejected alternatives, and constraints that cannot be
recovered from the code. Cite facts the reader can look up instead of
reproducing them. A path and focused claim are normally enough; add line ranges
when stable and quote code only when its exact text makes the decision clearer.

## Audience boundary

Human-facing plan documents contain only what the user must understand, decide,
defend, or approve:

- the problem and observable outcome;
- the resulting architecture or approach;
- material decisions, meaningful alternatives, and reasons;
- phase outcomes, boundaries, dependencies, acceptance criteria, and
  verification; and
- open questions that require a human decision.

`execution-progress.html` is the **Agent's log**. It contains operational and
historical detail: evidence citations, approvals, phase and spec status,
amendments, superseded decisions, discoveries, changed paths, validation,
commits, pull requests, blockers, and the exact next action. It is not a second
human plan and is not intended to be read end to end.

The plan is the source of truth for the current approved design. The Agent's log
is the source of truth for execution state and for how the design changed.
Cross-link them instead of copying current decisions into both.

## Overall plan: `index.<format>`

Cover only the areas that carry information for this change:

1. **Problem and outcome** — what is changing, why it matters, important
   boundaries, and what will be observable when it works.
2. **Resulting design** — the important ownership, interfaces, objects, and
   interactions at the level needed to understand the change.
3. **Decisions** — each decision the user may need to defend or revisit,
   including the meaningful alternative that lost and why.
4. **Phase outline** — every phase's outcome, boundary, dependencies,
   acceptance criteria, verification, and why the split is useful.

Merge or omit sections when the design is small. Every heading must exist
because the reader needs that decision. Later phases may retain explicit
unknowns that do not block the overall direction or current phase.

## Current phase spec: `phase-<number>-<name>.<format>`

A separate phase spec exists only when its implementation detail would overload
the overall plan. It covers:

1. the phase's observable outcome, boundary, prerequisites, and acceptance
   criteria;
2. the current and proposed system slice needed to implement safely;
3. decisions that belong specifically to this phase; and
4. expected changes, dependency order, and verification.

The current phase spec must be sufficient for a fresh implementation agent when
read with the overall plan and Agent's log. It does not need to reteach
cross-cutting material already linked from the overall plan.

Label quoted repository code as **Current code**, proposed sketches as
**Proposed code**, and retained earlier decisions as **Superseded**. Snippets
are explanatory evidence, never frozen source truth.

## Agent's log: `execution-progress.html`

Include:

1. Schema version `2`, feature title, absolute repository path, target branch,
   planning mode, spec format, pull-request strategy, validation expectations,
   and links to plans and task artifacts.
2. A phase table with stable number, name, kind (`executable`, `container`, or
   `superseded`), phase status, spec status, assigned agent when known, and most
   recent update. Container and superseded spec status is `not applicable`.
3. A current-position section with the active or next phase, exact next action,
   prerequisites, and current blocker or amendment when present.
4. Durable per-phase records for changed paths, validation, discoveries,
   amendments, commits, pull requests, and completion evidence.
5. A handoff section with precise safe-continuation instructions and
   outstanding approvals.
6. A pull-request register that retains every PR's phase, identifier, URL,
   creation time, state, and merge status.
7. One amendment log with amendment id, timestamp, phase, classification,
   trigger, evidence, change, approval state, affected plan sections, and exact
   next action. Approval state is `not required`, `pending`, `approved`, or
   `rejected`. Record `not required` for clarifications and local adaptations;
   record the user approver for approved or rejected phase splits and design
   amendments.

Phase status is `not started`, `in progress`, `blocked`, `review`, or `complete`.
Spec status is `outline only`, `drafted`, or `approved`. A phase may be
implemented only with an approved spec, including a Brief plan whose inline
phase detail serves as that spec.

Phase numbers never change. Splitting phase `N` creates `N.1`, `N.2`, and so on.
The parent becomes a non-executable container and is ignored when choosing work.
Compute its displayed status in this order: `complete` when all children are
complete; otherwise `blocked` when any child is blocked; otherwise `review`
when any child is in review; otherwise `in progress` when any child is in
progress or complete; otherwise `not started`. Redistribute each acceptance
criterion to exactly one child unless the plan explicitly identifies a shared
criterion.

When splitting an active phase, designate one active child and move the
parent's complete execution record to it, including starting SHA, changed paths,
commits, validation, amendments, pull-request register entries, and exact next
action. Re-key existing pull-request entries to the designated child while
preserving their history. The immutable review fixed point does not change. A
phase with an existing pull request may be split only after the user explicitly
approves how that pull request and its commits map to the children.

Every blocked phase records a blocker kind:

- an **amendment blocker** links to an amendment entry with the decision needed
  and exact resume action; or
- an **operational blocker** records the failure, evidence, exact resume
  condition, and owner without pretending the plan changed.

An amendment blocker resumes after its amendment records an approved resolution.
An operational blocker resumes after its recorded condition is satisfied. Do
not erase completed phase, blocker, or amendment history.

The initial next action is always to invoke `continue-plan` and inspect the live
repository before implementation. Update the Agent's log before dispatch, after
results, and whenever state or resume instructions change.

## Optional task artifact

Offer a task artifact only after phase boundaries are approved. Ask which
provider to use and obtain explicit permission before creating it.

Keep it concise:

- state the observable outcome and phase list;
- link the feature folder or accessible design artifacts;
- record relevant dependencies and acceptance criteria; and
- avoid copying the full design.
