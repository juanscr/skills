---
name: handoff
description: Use only when user says handoff.
argument-hint: "What will the next session be used for?"
---

Write a handoff document summarising the current conversation so a fresh agent
can continue the work. Save to the temporary directory of the user's OS - not
the current workspace.

Include a "suggested skills" section in the document, naming which skills the
next agent should call the Skill tool for.

Do not duplicate content already captured in other artifacts (specs, plans,
ADRs, issues, commits, diffs). Reference them by path or URL instead.

Redact any sensitive information, such as API keys, passwords, or personally
identifiable information.

If the user passed arguments, treat them as a description of what the next
session will focus on and tailor the doc accordingly.

## Active plan

When this session coordinates a plan (a feature folder with
`execution-progress.json`), the log is the handoff document; write no separate
file. The handoff request authorizes checkpoint commits and normal pushes to
the recorded source branches, not PRs or merges.

1. Ask active workers to pause at a safe point and collect their state. If a
   worker cannot be paused or its state is unknown, report it and stop.
2. Save to the log anything needed to continue: pending questions, worker state,
   uncommitted work, review state, discoveries, failed approaches, and the exact
   next action. Reference evidence instead of copying it. Keep the feature
   folder outside disposable worktrees.
3. Commit in-scope work in each worktree, excluding secrets and planning
   artifacts, and push each recorded source branch. Never force-push. Verify each
   remote branch matches its local HEAD.
4. Append a `handoffs` entry with the timestamp, reason, and each worktree's
   remote URL (without credentials), branch, and SHA. Set coordinator status to
   `handoff-ready`.
5. Return only
   `/continue-plan for "<absolute-feature-folder-path>"; resume the recorded action.`
   and stop working on the feature.

If committing, pushing, or verifying fails, record the failure and recovery
step in the log and do not return the command.
