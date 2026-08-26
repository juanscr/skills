---
name: design-plan
description: Create an approved, teaching-focused design package for a complex software change before AI implementation. Use only when the user explicitly invokes design-plan.
disable-model-invocation: true
---

Create a design package that gives the user enough understanding to explain and
defend a software design before AI writes code. The result is not an
implementation checklist. It is a self-contained teaching and continuation
artifact grounded in the live repository.

## Companion skills

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

Store specs at:

`<spec-root>/<repository-name>/<kebab-case-feature-name>/`

Allow the user to override the spec root, including choosing a directory inside
the repository.

## Non-negotiable rules

1. Facts are the agent's responsibility. Decisions belong to the user.
2. Ground material design claims in repository evidence or a recorded user
   decision.
3. A snippet in a spec teaches a decision; it is never the source of truth.
4. Use plain English. Define a term before relying on it.
5. Make each explanation decision-complete, not artifact-complete. Include all
   evidence needed to understand one decision, but only the part of each
   artifact that contributes to it.
6. Approval is explicit. Silence, continued conversation, and document creation
   are not approval.
7. Do not implement code or invoke `execute-phase` in this skill.

Read and follow:

- [Artifact requirements](references/artifact-requirements.md)
- [HTML standard](references/html-standard.md)

## Workflow

### 1. Understand and plan the task

This is a planning task. Search the live repository for the code and evidence
needed for the task. Use `grilling` when a decision needs to be made from that
evidence. If it is needed but unavailable, stop and tell the user to make that
skill available.

Create the feature folder once the repository and feature name are known.
Before drafting the overall plan, confirm the design has no material undecided
branches and obtain the user's explicit approval of the shared understanding.

### 2. Create and approve the overall plan

Create `index.html` using the artifact and HTML references. Every feature,
including a single-phase feature, gets an overview and at least one phase spec.

Choose coherent, reviewable behavior slices. Each phase must have an observable
outcome, acceptance criteria, and verification. Avoid infrastructure-only
slices unless they are independently useful. Explain every dependency and why
the phase should not be merged with or split from adjacent phases.

Delegate the design and writing of `index.html` to a Claude Opus sub-agent. Give
it the approved design, repository evidence and source references, phase
outline, and the artifact and HTML requirements. The sub-agent owns the
teaching structure and presentation, not the software design. It must return
specific questions instead of guessing when the supplied information is
incomplete. Resolve those gaps through repository research or `grilling`, then
resume the same sub-agent.

The main agent remains responsible for factual accuracy, repository grounding,
and presenting the result for user approval.

For approval, the user reviews the document and asks questions around it. This
is done until the user explicitly approves.

After phase boundaries are approved, ask whether the user wants a task artifact
such as a GitHub issue or Azure DevOps work item. Ask for the provider and
explicit permission before creating it. Keep it concise, link the design
package, and do not duplicate the full plan.

### 3. Create and approve each phase

Create `phase-<number>-<kebab-case-name>.html` one phase at a time. Each phase
must stand alone for a future implementation agent with no conversation
history, while teaching the user how that part of the system works.

Delegate its design and writing to a Claude Opus sub-agent. Give it the approved
overall design, phase outcome and boundaries, relevant repository evidence and
source references, and the artifact and HTML requirements. It must return
specific questions instead of guessing when information is incomplete. Resolve
those gaps through repository research or `grilling`, then resume the same
sub-agent.

The main agent remains responsible for factual accuracy, repository grounding,
and presenting each phase for explicit user approval before moving to the next.

Before drafting a phase, reread its relevant live paths. If repository drift
invalidates an approved interface or decision, stop, explain the impact, use
`grilling`, and obtain approval for the revised design. Update the affected
design-time decision and revision logs.

### 4. Set execution defaults

Execution proceeds one phase at a time. Use one pull request per phase unless
the user proposes a different pull-request strategy.

Before creating the continuation record, obtain and record:

- target branch;
- required validation;
- any external task artifact links.

### 5. Create the continuation record

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

### 6. End the design session

Do not begin implementation. Recommend a fresh session and give one concrete
instruction containing the absolute feature-folder path:

`/continue-plan for <absolute-feature-folder-path>.`
