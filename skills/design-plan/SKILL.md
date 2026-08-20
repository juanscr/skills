---
name: design-plan
description: Create an approved, teaching-focused design package for a complex software change before AI implementation. Use only when the user explicitly invokes design-plan.
disable-model-invocation: true
---

# Design Plan

Create a design package that gives the user enough understanding to explain and
defend a software design before AI writes code. The result is not an
implementation checklist. It is a self-contained teaching and continuation
artifact grounded in the live repository.

## Required companion skill

Invoke `grilling` before beginning discovery. Do not imitate or silently replace
it. If `grilling` is unavailable, stop and tell the user to make that skill
available, then invoke `design-plan` again.

`continue-plan` and `execute-phase` are required after planning, not during it.
Before declaring the design package ready, confirm that the user can make those
skills available. If either is unavailable, explain the missing dependency and
leave the package unready for execution.

## Inputs

| Input | Required | Default |
| --- | --- | --- |
| Task description | Yes | None |
| Spec format | No | HTML |
| Spec root | No | `~/Documents/coding-specs` |
| Execution cadence | No | One phase at a time |

Store specs at:

`<spec-root>/<repository-name>/<kebab-case-feature-name>/`

Allow the user to override the spec root, including choosing a directory inside
the repository.

## Non-negotiable rules

1. Facts are the agent's responsibility. Decisions belong to the user.
2. Ask every currently answerable decision in a grilling round. Give a
   recommendation and rationale for each discovery question.
3. Never ask the user for repository facts that tools or research can provide.
4. Read the live repository before drafting a design and require it to be read
   again before execution. A snippet in a spec teaches a decision; it is never
   the source of truth.
5. Do not infer material product behavior, API semantics, ownership,
   persistence, concurrency, compatibility, security, or error behavior.
   Support each with repository evidence or a recorded user decision.
6. Use plain English. Define a term before relying on it.
7. Approval is explicit. Silence, continued conversation, and document creation
   are not approval.
8. Do not implement code or invoke `execute-phase` in this skill.

Read and follow:

- [Grilling protocol](references/grilling-protocol.md)
- [Artifact requirements](references/artifact-requirements.md)
- [HTML standard](references/html-standard.md)

## Workflow

### 1. Grill the intent

Before repository research, use `grilling` to establish:

- desired observable behavior;
- why the change matters;
- non-goals and boundaries;
- constraints;
- evidence of success; and
- domain terminology.

Ask about intent only. Defer implementation decisions that depend on repository
facts.

### 2. Research the live system

Locate the repository and inspect only as broadly as needed to establish:

- entry points and relevant current code paths;
- control flow and data flow;
- state ownership and lifecycle;
- public and internal contracts;
- persistence and serialization;
- alternate and failure paths;
- tests and validation commands;
- compatibility, security, and performance constraints; and
- repository conventions that constrain the design.

Use sub-agents only for substantial independent research or alternative-design
analysis. Give each one a bounded question. Reconcile their evidence and
conflicts yourself; do not paste unprocessed agent reports into a spec.

Create the feature folder once the repository and feature name are known.

### 3. Grill the grounded design

Return to `grilling`. Build a design tree from the user's intent and the
repository evidence. Ask the complete current frontier in each round. A
question whose answer depends on an unsettled question belongs to a later
round.

For each question:

- explain the evidence and uncertainty;
- provide a recommendation and rationale;
- describe material alternatives and trade-offs; and
- record the user's decision.

Continue until observable behavior, architecture, ownership, state,
interactions, failure behavior, compatibility, phase boundaries, and
verification have no material undecided branches.

Present a shared-understanding summary and require explicit approval before
drafting the overall plan.

### 4. Create and approve the overall plan

Create `index.html` using the artifact and HTML references. Every feature,
including a single-phase feature, gets an overview and at least one phase spec.

Choose coherent, reviewable behavior slices. Each phase must have an observable
outcome, acceptance criteria, and verification. Avoid infrastructure-only
slices unless they are independently useful. Explain every dependency and why
the phase should not be merged with or split from adjacent phases.

For approval, the user reviews the document and asks questions around it. This
is done until the user explicitly approves.

After phase boundaries are approved, ask whether the user wants a task artifact
such as a GitHub issue or Azure DevOps work item. Ask for the provider and
explicit permission before creating it. Keep it concise, link the design
package, and do not duplicate the full plan.

### 5. Create and approve each phase

Create `phase-<number>-<kebab-case-name>.html` one phase at a time. Each phase
must stand alone for a future implementation agent with no conversation
history, while teaching the user how that part of the system works.

Apply the same review, active-recall, revision, and explicit-approval gate used
for the overview before moving to the next phase.

Before drafting a phase, reread its relevant live paths. If repository drift
invalidates an approved interface or decision, stop, explain the impact, return
to grilling, and obtain approval for the revised design. Update the affected
design-time decision and revision logs.

### 6. Settle execution decisions

Before creating the continuation record, obtain and record:

- one-phase-at-a-time or approve-all-first execution;
- one pull request per phase or one pull request for the feature;
- phase dependency and merge gates;
- target branch;
- required validation;
- the selected GPT execution model for each phase; and
- any external task artifact links.

Use Luna for small phases and Terra for other phases. Use Sol only when a phase
requires unusually complex analysis. Do not use a non-GPT model.

### 7. Create the continuation record

After all required specs are approved, create `execution-progress.html`. The
entire feature folder must be sufficient for a new agent to continue without
the original conversation.

Initialize every phase as `not started`. Set the exact next action to invoke
`continue-plan` and reread the live code for the selected phase before any
implementation. Do not copy a frozen repository description into the progress
file.

Design-time decisions and review revisions belong in `index.html` or the
relevant phase spec. During later execution, discoveries, approved deviations,
changed paths, validation, and pull-request state belong to the active phase in
`execution-progress.html`, cross-linked to amended design sections when needed.

### 8. End the design session

Do not begin implementation. Recommend a fresh session and give one concrete
instruction containing the absolute feature-folder path:

`/continue-plan for <absolute-feature-folder-path>.`

