# Skills

Personal Copilot CLI skills for understanding, designing, implementing, and
reviewing software with AI while keeping engineering decisions human-owned.

## Install

Run from PowerShell:

```powershell
.\scripts\install.ps1
```

The script registers this repository's `skills` directory with Copilot CLI and
verifies every repository skill is available. Existing personal skills are left
unchanged.

In an active Copilot CLI session, run `/skills reload` after installation.

## Main entrypoints

| Skill | Use it when |
| --- | --- |
| `/design-plan` | Start a complex feature with repository research, decision grilling, teaching-focused HTML specs, and explicit understanding gates. |
| `/continue-plan` | Resume a planned feature from its execution-progress file and decide what to do with the current phase. |
| `/code-review` | Review a local change against a fixed Git revision and its originating issue or spec. |
| `/pr-review` | Review a GitHub or Azure DevOps PR, inspect findings, and approve which comments may be posted. |
| `/address-pr-comments` | Classify active GitHub or Azure DevOps PR feedback, approve the response plan, then implement, push, and reply. |
| `/improve-codebase-architecture` | Identify deepening opportunities and save each as a reusable architecture-improvement spec. |
| `/handoff` | Compact the current conversation into a temporary handoff document for another agent. |

## Expected flow

1. Invoke `/design-plan` in the target repository. Approve the overall design
   and each phase only after you can explain the design end to end.
2. Start a fresh session and invoke `/continue-plan` with the generated feature
   folder. Ask it to implement the current phase.
3. `execute-phase` delegates implementation with TDD reserved for substantial
   feature phases, runs `code-review`, fixes retained findings, and stops with
   reviewed local commits.
4. Tell the agent to publish. `pr-description` follows the repository template,
   then the agent pushes the approved branch, creates the PR, and records its
   URL in execution progress.
5. Use `/continue-plan` for phase feedback or to report that the PR merged.
   Continue with the next eligible phase.

Use `/code-review` independently for a local branch. Use `/pr-review <URL>` for
an existing PR; it always waits for approval before posting feedback.
Use `/address-pr-comments <URL>` when a PR already has active feedback that
needs triage, approved implementation, and provider replies.

## Miscellaneous

- `/grilling` stress-tests a plan, decision, or idea through decision-frontier
  questions.
- `/wait-what` asks the agent to re-explain its last response with more context
  and simpler language.
- `/improve-codebase-architecture` creates one candidate spec per finding under
  `~/Documents/coding-specs/<repository>/architecture-improvements/`. Select a
  candidate and use it as input to `/design-plan`.
- `pr-description` prepares every PR description from the repository template,
  intent, architecture, validation, and future direction.
- `human-voice` writes concise responses in simple English and avoids redundant
  replies when a pull-request suggestion can simply be resolved.
- `test-quality` supplies the shared rules for behavior-focused tests and
  boundary-aware mocking used by implementation and code review.
- `handoff` saves a concise, redacted continuation document outside the current
  workspace for a fresh agent.
- `writing-for-agents` guides creation of skills and other documents consumed by
  agents.

## Credits

`grilling`, `handoff`, `wait-what`, `writing-for-agents`, and
`improve-codebase-architecture` are copied from, and `tdd` and `test-quality`
are adapted from,
[mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills).
They are used under the MIT License. See
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
