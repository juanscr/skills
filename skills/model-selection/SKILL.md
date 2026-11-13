---
name: model-selection
description: Use when delegating work to a child agent or child worktree.
---

Honor an explicit model choice for the current task. Otherwise select by the
delegated work, not its file extension or the review mode's name:

| Work | Model ID | Reasoning | Context tier |
| --- | --- | --- | --- |
| Research, orchestration, spec implementation or complex design | `claude-opus-5.5` | `high` | `long_context` |
| Feature implementation | `claude-sonnet-5.5` | `high` | `long_context` |
| Ordinary code review, skeptical or high-risk review | `gpt-6.1-sol` | `high` | `long_context` |
| Bounded, low-risk execution or simple review with settled requirements | `gpt-6.1-terra` | `high` | `long_context` |

Apply the selected settings to the child dispatch. If the model or a requested
setting is unavailable, report the limitation and ask before substituting.
