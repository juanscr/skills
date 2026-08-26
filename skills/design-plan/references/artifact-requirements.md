# Artifact Requirements

The feature folder is the complete planning and continuation boundary. It must
not depend on the original conversation.

## Teaching standard

Assume the reader has no previous knowledge of the task or the relevant system.
Use plain English, introduce concepts before relying on them, and connect facts
into an explanation rather than presenting a sparse inventory.

Use the medium that teaches each idea most clearly: prose, diagrams, interface
or object sketches, focused current-code evidence, tables, or examples. Include
only the detail needed to understand and defend the design. Keep raw output and
large supporting material out of the main narrative.

## Overall plan: `index.html`

Teach the overall design through four areas:

1. **Problem and objective** — explain the problem being tackled, why it
   matters, the intended outcome, and important boundaries.
2. **Overall architecture** — explain the resulting design at a high level.
   Show the important interfaces, objects, ownership, and interactions without
   turning the overview into an implementation specification.
3. **Design decisions** — give each material decision that is not already clear
   from the architecture its own subsection. Include the relevant evidence,
   the decision, and enough reasoning to understand it. Use focused code or a
   diagram when it makes the decision clearer.
4. **Phases** — describe each phase's outcome, boundary, dependencies,
   acceptance criteria, verification, and why that phase division is useful.

Place alternatives, cross-cutting concerns, open questions, and approval
information beside the architecture or decision they affect. Do not create
empty or repetitive sections merely to satisfy a template.

## Phase spec: `phase-<number>-<name>.html`

Teach the phase through the same pattern as the overall plan, replacing its
phase summary with the detail needed to implement and verify this slice:

1. **Phase problem and objective** — explain what the phase accomplishes, why
   it exists, where it fits in the completed feature, its boundaries and
   prerequisites, and its observable outcome.
2. **Architecture deep dive** — teach the relevant slice of the current and
   proposed system in enough detail to implement safely. Explain the important
   interfaces, objects, ownership, interactions, state, and behavior without
   inventorying every symbol.
3. **Design decisions** — give each material decision that is not obvious from
   the architecture its own subsection. Include the relevant evidence, the
   decision, and enough reasoning to understand it. Use focused code or a
   diagram when it makes the decision clearer.
4. **Implementation and verification** — explain the expected code changes and
   a sensible dependency order, then state the acceptance criteria and how the
   resulting behavior will be proved.

Place alternatives, cross-cutting concerns, assumptions, open questions, and
approval information beside the part of the phase they affect. Include enough
file and symbol detail for implementation, but let the design determine what is
material rather than filling out a mandatory inventory.

Clearly label quoted repository code as **Current code** and design sketches as
**Proposed code**. Snippets are explanatory evidence, not a frozen source of
truth. Never invent omitted code.

## Continuation record: `execution-progress.html`

Include:

1. Feature title, absolute repository path, expected target branch, spec format,
   pull-request strategy, validation expectations, and links to all specs and
   optional task artifacts.
2. A phase table with number, name, status (`not started`, `in progress`,
   `review`, `blocked`, or `complete`), assigned agent when known, and most
   recent update.
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
