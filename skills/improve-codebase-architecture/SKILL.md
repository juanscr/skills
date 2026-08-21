---
name: improve-codebase-architecture
description: Scan a codebase for deepening opportunities and save each candidate as an architecture-improvement spec. Use only when the user explicitly invokes improve-codebase-architecture.
disable-model-invocation: true
---

# Improve Codebase Architecture

Surface architectural friction and propose **deepening opportunities**: refactors
that turn shallow modules into deep ones. The aim is testability and
AI-navigability.

Use the architectural vocabulary from `codebase-design` when it is available:
**module**, **interface**, **depth**, **seam**, **adapter**, **leverage**, and
**locality**. Use those terms consistently in every candidate.

## Inputs

| Input | Required | Default |
| --- | --- | --- |
| Scope or pain point | No | Recently changed code |
| Spec root | No | `~/Documents/coding-specs` |

Store architecture-improvement specs at:

`<spec-root>/<repository-name>/architecture-improvements/<kebab-case-candidate-name>/`

Each candidate gets its own folder so it can be independently selected for
future planning. Do not write review artifacts into the repository.

## Process

### 1. Explore

**Scope before you scan: YAGNI.** Deepening a module pays off by making future
changes to it easier, so put extra weight on parts of the codebase that have
recently changed:

- If the user named a direction (a module, subsystem, or pain point), use it
  and skip the inference below.
- Otherwise, inspect a useful stretch of recent commit history with
  `git log --oneline` to find hot spots. Let repeatedly changed paths guide the
  scan. If no hot spot emerges, widen the scope.

Read relevant ADRs before proposing a candidate so the report does not
re-litigate settled decisions without evidence of real friction.

Explore organically and record where the code creates friction:

- Does understanding one concept require bouncing between many small modules?
- Is a module **shallow**, with an interface nearly as complex as its
  implementation?
- Were pure functions extracted only for testability while real bugs hide in
  how they are called (poor **locality**)?
- Do tightly coupled modules leak across their seams?
- Is code untested or difficult to test through its current interface?

Apply the **deletion test** to each suspected shallow module: would deleting it
concentrate complexity behind a smaller interface, rather than merely move the
complexity? Only candidates for which complexity concentrates belong in the
report.

### 2. Present candidates and create reusable specs

Write a self-contained HTML review to the OS temp directory. Resolve the temp
directory from `$TMPDIR`, falling back to `/tmp` (or `%TEMP%` on Windows), and
name it `<tmpdir>/architecture-review-<timestamp>.html`. Open it for the user
and state its absolute path.

Use [HTML report guidance](HTML-REPORT.md) for the review. Each candidate must
include:

- involved files and modules;
- the observed friction;
- a plain-English deepening proposal;
- benefits stated in terms of locality, leverage, and testing;
- a side-by-side before/after visualisation; and
- a `Strong`, `Worth exploring`, or `Speculative` recommendation badge.

End the review with the top recommendation and why it ranks first. If a
candidate conflicts with an ADR, surface it only when evidence shows enough
friction to justify reopening that decision, and label the conflict clearly.

For every candidate, create its own folder under the architecture-improvements
spec root and write `index.html`. The candidate spec is self-contained and
must include:

1. purpose, observed friction, scope, non-goals, and recommendation strength;
2. relevant current architecture with live-code evidence, including paths and
   line ranges;
3. the deletion-test result;
4. the candidate deepening, its likely seam, and expected gains in locality,
   leverage, and testability;
5. before/after diagrams and the files expected to change;
6. ADR evidence or conflicts, when applicable;
7. uncertainties, assumptions, and questions that need design decisions; and
8. a handoff section stating that this is a discovery spec, not an approved
   implementation plan.

The review only summarizes and links to the candidate specs. Do not propose
concrete interfaces or implement code.

### 3. Hand off a selected candidate to planning

After the review and candidate specs are complete, ask the user which candidate
they want to pursue. When they select one, stop this skill and direct them to
start a planning session using that candidate spec:

`/design-plan using <absolute-path-to-selected-candidate-spec>\index.html`

`design-plan` owns repository-grounded design decisions, approval, phase
planning, and implementation handoff. The architecture-improvement spec is
input evidence for that process; it does not replace the resulting design
package.
