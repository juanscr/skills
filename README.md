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
| `/design-plan` | Start a complex feature: research the repository, settle decisions with you, and approve a plan you understand. |
| `/continue-plan` | Resume a planned feature from its execution-progress file and decide what to do with the current phase. |
| `/code-review` | Review a local change against a fixed Git revision and its originating issue or spec. |
| `/pr-review` | Review a GitHub or Azure DevOps PR, inspect findings, and approve which comments may be posted. |
| `/address-pr-comments` | Classify active GitHub or Azure DevOps PR feedback, approve the response plan, then implement, push, and reply. |
| `/improve-codebase-architecture` | Identify deepening opportunities and save each as a reusable architecture-improvement spec. |
| `/handoff` | Hand the session to a fresh agent. With an active plan, it checkpoints and pushes the work and returns the `/continue-plan` command. |

## Expected flow

1. Invoke `/design-plan` in the target repository. Ask about anything you
   don't understand, then approve the plan: problem, design, decisions, and
   phase outcomes. Implementation details stay with the agent.
2. The same agent coordinates the feature through `continue-plan` and
   `execute-phase`: a worker implements and commits locally, `code-review`
   reviews it, and `execution-progress.json` records state.
3. Tell the agent to publish. It writes the PR with `pr-description`, pushes,
   and records the PR.
4. Use `/continue-plan` for PR feedback or to report a merge; it moves to the
   next phase. A folder alone requests status and a recommendation.

Plans are baselines, not frozen predictions. The agent records its own
adaptations and phase splits; `amend-plan` asks you only when an approved
outcome, acceptance criterion, contract, or decision would change. Plans are
HTML by default. Legacy HTML logs are migrated before work begins.

## Miscellaneous

- `/grilling` stress-tests a plan, decision, or idea through decision-frontier
  questions.
- `amend-plan` is invoked by planning and execution skills when evidence
  changes the plan.
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
- `model-selection` owns model, reasoning, and context choices for delegated
  implementation, research, review, and visual work.

## Credits

`grilling`, `wait-what`, and `improve-codebase-architecture` are copied from,
and `handoff`, `tdd`, and `test-quality` are adapted from,
[mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills).
They are used under the MIT License. See
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
