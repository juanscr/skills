---
name: model-selection
description: Select the model, reasoning effort, and context tier when delegating work to a child agent or child worktree.
---

Honor an explicit model choice for the current task. Otherwise select by the
delegated work, not its file extension or the review mode's name:

| Work | Model ID | Reasoning | Context tier |
| --- | --- | --- | --- |
| Most implementation and ordinary code review | `gpt-6-sol` | `high` | `long_context` |
| Bounded, low-risk execution or simple review with settled requirements | `gpt-6-luna` | `xhigh` | `long_context` |
| Research, orchestration, complex design, skeptical or high-risk review | `gpt-6-astra` | `high` | `long_context` |
| Visual implementation or visual-only review of HTML, CSS, SVG, or other presentation artifacts from settled requirements | `claude-opus-5.5` | `medium` | Runtime default |

Risk and complexity take precedence over apparent simplicity. Use Astra for a
skeptical-risk reviewer even when the diff is small. A Light or Verify review
uses Luna only when its actual scope meets the low-risk criterion.

The Claude exception is presentation work, not all frontend work. Keep
architecture, application behavior, data flow, and unresolved design decisions
with GPT; give visual workers the settled content and constraints.

Apply the selected settings to the child dispatch. Selecting a model does not
change the current coordinator's model. If the model or a requested setting is
unavailable, report the limitation and ask before substituting.
