# Artifact Requirements

The feature folder is the complete planning and continuation boundary. It must
not depend on the original conversation.

## Overall plan: `index.html`

Include:

1. **Purpose and observable outcome** — motivation, users, behavior, success
   evidence, non-goals, and constraints.
2. **Current architecture and concepts** — a plain-English walkthrough of the
   relevant system. Define each material concept, owner, lifecycle, and
   relationship.
3. **Current behavior and evidence** — focused live-code snippets with source
   paths and line ranges. Include definitions and call sites needed to explain
   flow or ownership.
4. **Proposed architecture** — components, control and data flow, ownership,
   state, and boundaries.
5. **Design decisions** — the selected design, evidence, user approval, and
   consequences.
6. **Alternatives and trade-offs** — serious alternatives, strengths, costs,
   and why they were not selected.
7. **Phase plan** — coherent outcomes, boundaries, dependencies, acceptance
   criteria, and the reason for each boundary.
8. **Cross-cutting behavior** — errors, security, compatibility, performance,
   rollout, migration, cleanup, and observability where applicable.
9. **Verification strategy** — how feature-level behavior will be proved.
10. **Decision log** — design-time decisions, rationale, evidence, approval,
    and affected phases.
11. **Revision log** — design-time document changes, reason, approval, and
    affected sections or phases.
12. **Understanding approval** — clarifications produced by comprehension
    grilling and the user's explicit approval. Do not include quiz transcripts.

## Phase spec: `phase-<number>-<name>.html`

Include these sections in order:

1. **Phase goal and boundaries** — user-visible outcome, changes, non-goals,
   prerequisites, acceptance criteria, and place in the completed feature.
2. **Architecture and concepts** — phase-specific architecture in plain
   English. Define each object's role, owner, lifecycle, and relationships.
3. **Current design** — focused current snippets and call sites with paths and
   line ranges. Explain current control flow, data flow, and ownership.
4. **Proposed code structure** — for every changed or new class, struct,
   interface, module, function, method, endpoint, event, or schema, state its:
   path; responsibility; signature or public API; inputs and outputs; mutable
   state; invariants; dependencies; callers; errors; and lifecycle. Add concise
   proposed code sketches for non-trivial behavior.
5. **Interaction design** — happy, alternate, and failure paths step by step.
   Use interaction diagrams when two or more components collaborate and
   relationship diagrams when three or more structures have material
   relationships.
6. **State, data, and ownership** — creation, reads, updates, disposal, valid
   transitions, validation, persistence, serialization, retry, rollback,
   cleanup, and migration where applicable.
7. **Implementation walkthrough** — ordered file-level changes. Name exact
   structures and methods, dependency order, and behavior enabled by each step.
8. **Behavioral decisions and assumptions** — evidence or approval for every
   assumption; boundaries, invalid input, errors, security, performance, and
   compatibility.
9. **Verification design** — map every acceptance criterion and important
   branch to a test. State level, setup, stimulus, expected observable result,
   and why the test proves the interaction.
10. **Decision and revision logs** — phase-specific design history.
11. **Understanding approval** — clarifications and explicit user approval.

Clearly label quoted repository code as **Current code** and design sketches as
**Proposed code**. Snippets are explanatory evidence, not a frozen source of
truth. Never invent omitted code.

## Continuation record: `execution-progress.html`

Include:

1. Feature title, absolute repository path, expected target branch, spec format,
   execution cadence, pull-request strategy, validation expectations, and links
   to all specs and optional task artifacts.
2. A phase table with number, name, status (`not started`, `in progress`,
   `review`, `blocked`, or `complete`), selected model, assigned agent when
   known, and most recent update.
3. A current-position section with the active or next phase, exact next action,
   and prerequisites.
4. Durable per-phase records for completed work, changed paths, validation,
   decisions, deviations, blockers, commits, and pull requests.
5. A handoff section with precise safe-continuation instructions and outstanding
   approvals.
6. A pull-request register that retains every PR's phase, identifier, URL,
   creation time, state, and merge status.

The initial next action is always to invoke `continue-plan` and inspect the live
repository before implementation. The continuation record points to design
artifacts; it does not copy the repository or claim that planning-time snippets
remain current.

During execution, update this file before dispatch, after results, and whenever
status or resume instructions change. A phase remains `review` until the user
reports its PR merged. Do not erase completed phase history.

## Optional task artifact

Offer a task artifact only after phase boundaries are approved. Ask which
provider to use and obtain explicit permission before creating it.

Keep the task concise:

- state the observable outcome and phase list;
- link the feature folder or accessible design artifacts;
- record relevant dependencies and acceptance criteria; and
- avoid copying the full design.

