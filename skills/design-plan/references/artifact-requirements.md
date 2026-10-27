# Artifact Requirements

The feature folder must let a fresh agent continue without the original
conversation.

## Plan: `index.<format>`

Write for the user, who owns the design but not the implementation. Include
only what the user must understand, decide, defend, or approve:

1. **Problem and outcome**: what changes, why it matters, its boundaries, and
   what is observable when it works.
2. **Design**: the important ownership, interfaces, and interactions, at the
   level needed to understand the change.
3. **Decisions**: each decision the user may need to defend, with the
   alternative that lost and why.
4. **Phases**: each phase's outcome, boundary, dependencies, and acceptance
   criteria stated as observable behavior, and why the split is useful.

Merge or omit sections when the design is small. Leave out file lists, code
sketches, and work order unless the user asks for them or a decision depends on
them. Cite facts by path instead of reproducing them. Label repository code
**Current code**, sketches **Proposed code**, and replaced decisions
**Superseded**.

The plan is the source of truth for the approved design. The Agent's log is the
source of truth for execution state and how the design changed. Cross-link
them instead of copying.

## Phase notes (optional)

The coordinator may write `phase-<id>-<name>.md` when a worker needs more than
the plan: relevant current code, approach, order, and verification. Phase notes
are agent-owned working material, not an approval gate, and may change freely
within the approved plan.

## Agent's log: `execution-progress.json`

Use valid JSON with `schemaVersion: 3` and concise values. Only the coordinator
writes it. Update it before dispatch, after results, and whenever the next
action changes. It contains at least:

| Key | Contents |
| --- | --- |
| `schemaVersion` | `3` |
| `feature`, `repository`, `plan` | Title, absolute repository path, and plan path. |
| `targetBranch`, `validation`, `prStrategy` | Target branch, required validation commands, and PR strategy. |
| `coordinator` | `id`, `status` (`active`, `handoff-ready`, or `complete`), and `updatedAt`. |
| `current` | `phase`, the exact next `action`, and any pending question for the user. |
| `phases` | Keyed by stable ID (`"1"`, `"1.1"`): `name`, `status`, notes path when present, and execution state as it exists: source branch, starting SHA (the review fixed point), worker and worktree, commits, validation, review state (Deep-review head, open findings, rounds used), PR, and blocker. |
| `amendments` | Each plan change: ID, trigger, evidence, change, who decided, and when. |

Add anything else needed to resume, in whatever shape is clearest. Never record
an interrupted or unverified result as successful. Read the current phase
first; query history only when needed.

Phase status is `not started`, `in progress`, `blocked`, `review`, `complete`,
or `superseded`. A blocked phase records why and the exact resume condition.

Phase IDs never change. Splitting phase `N` creates `N.1`, `N.2`, and so on and
marks `N` superseded. Each acceptance criterion moves to exactly one child
unless the plan marks it shared.

## Optional task artifact

Keep it concise: the observable outcome, the phase list, a link to the feature
folder, and relevant dependencies. Do not copy the design.
