---
name: babysit-pr
description: Use when babysit-pr is invoked.
---

Take one of the user's pull requests to merge: keep the build green, address
reviewer feedback, and merge once approved. Do your best attempt at getting the
PR ready for merge (or merged) without user input and only request it when
absolutely necessary; you are authorized to do anything you need while in the
bounds of the pull request scope.

User is only needed when: proof of presence (PoP) and major architectural decisions
that significantly impact the spec.

## Input

| Input | Required | Default |
| --- | --- | --- |
| Pull request URL | Yes | None |
| Self-approval opt-in | No | Off |

## Wait without tokens

Never wait with agent turns. Write a polling script in the session files folder
and run it as an attached background command, then end the turn; its exit wakes
you. The script:

- polls the PR every 5 minutes with the provider CLI;
- keeps the state last reported to you in a file;
- exits with a short summary when the PR merges or closes, checks finish on the
  current head, a comment or review from someone else appears, or votes change;
- ignores your own comments and checks still running;
- exits after 72 hours without an event, or after repeated fetch failures.

Reuse the script for the rest of the run.

## Start

1. If the PR is a draft, publish it.
2. Handle the current state as an event, then start the polling script.

## On each event

Act, then restart the polling script.

1. **Checks finished:** on failure, read the logs, fix, run the repository's
   validation, and push. Rerun failures unrelated to the change (flaky tests,
   infrastructure) instead of changing code. No attempt limit.
2. **New reviewer comments:** run `address-pr-comments`. When it needs the
   user, report the question and keep babysitting; do not merge until it is
   answered.
3. **Merge** when approvals reach the repository's required count (1 if none),
   required checks pass, no reviewer requests changes, no thread is active, and
   no question is open. With the self-approval opt-in, when approvals are one
   short and the provider lets the author approve (GitHub never does), approve
   as the author, then merge. Use the repository's default or only allowed
   merge method, otherwise squash. Keep the source branch. Never bypass policy.

## Stop

Stop the polling script and report when the PR merges or closes, or when the
script times out. If the PR belongs to a plan, report the merge to
`continue-plan`.
