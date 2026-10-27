---
name: code-review
description: Use when reviewing a local change or a PR snapshot.
---

# Code Review

Review one change against its intent, read-only. Follow
`references/review-contract.md`.

## Inputs

- Base and head revisions; head defaults to `HEAD`. Keep both fixed for the
  run.
- Originating intent: user request, issue, approved plan, or PR description.
- Validation evidence already produced, when available.
- Mode: `Deep` by default, or `Follow-up` with the previously reviewed head and
  the open findings.

Skip generated files, binaries, lock files, and build output unless the intent
requires them.

## Dispatch

Use `model-selection` for each reviewer. Reviewers are `general-purpose`
agents that review directly with read-only tools; they do not invoke skills or
launch agents. Give each the review contract, its role file, the revisions,
intent, and validation evidence, plus the `test-quality` references when tests
changed.

| Mode | Reviewers |
| --- | --- |
| Deep, cohesive change (docs, agent instructions, config, test-only, or where separate lenses would read the same evidence) | One: `combined-reviewer.md` |
| Deep, production behavior with distinct contracts or call paths | Three in parallel: `code-quality-reviewer.md`, `specification-fidelity-reviewer.md`, `skeptical-risk-reviewer.md` |
| Follow-up | One: `follow-up-reviewer.md`. If the delta meets a Deep invalidation condition, return `deep review required` instead. |

Classify by the behavior the change controls, not file extension.

When the repository has its own review skill, also run it in parallel; see
`references/repository-review.md`.

## Findings

Each finding has a severity (`blocker` or `material-improvement`), location,
issue, concrete impact, suggested fix, and evidence. Each design decision names
the affected approved behavior, the question for the user, and the evidence.

Findings must be caused by the change, reachable, evidence-backed, and within
the intent. Omit preferences, speculation, validation duplication, praise, and
pre-existing issues. Follow-up returns blockers and design decisions only, plus
a status for every open finding.

## Synthesize

Verify each finding against the source. Drop false positives and duplicate
root causes, keeping every contributing lens. Assign stable IDs (`CR-1`, ...).

```markdown
## Code Review

**Mode:** Deep | Follow-up
**Revisions:** `<base>..<head>`
**Signal:** <n> blocker(s), <n> material improvement(s)

### Open findings
<Follow-up only: ID, status, and evidence.>

### Blockers
| ID | Location | Problem | Impact | Suggested fix | Lens |
| --- | --- | --- | --- | --- | --- |

### Material improvements
<Deep only, or "None.">

### Design decisions needed
<Questions and evidence, or "None.">

### Clean areas
<Deep only; a few evidence-backed observations, or "None worth calling out.">

### Scope
<Validation evidence used, exclusions, and repository-review status.>
```

Do not modify code, post comments, or run validation.
