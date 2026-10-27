---
name: pr-review
description: Use when reviewing a PR URL.
---

# Pull Request Review

Review a GitHub or Azure DevOps pull request with `code-review`, present the
findings, and post only the comments the user approves.

Use `azure-devops-workflow` for Azure DevOps and the GitHub tools for GitHub.
Other providers are unsupported.

## 1. Gather context

Read the PR, its diff, checks, and existing threads, including resolved ones.
Build the intent from, in order: linked approved specs, linked issues or work
items, the PR description, and context from the user. If none explains the
intended behavior, ask the user before reviewing.

## 2. Review

Run a Deep `code-review` over the whole PR, from the target commit to the
source commit, with the intent and checks as evidence.

Then drop findings already covered by an existing thread. When a resolved
thread looks wrongly resolved, list it as a **resolved-thread reconsideration**
with the new evidence; do not reopen it.

## 3. Present and wait

```markdown
## PR Review

**Pull request:** <URL>
**Signal:** <n> blocker(s), <n> material improvement(s)

### Blockers
| ID | Location | Problem | Impact | Suggested fix |
| --- | --- | --- | --- | --- |

### Material improvements
| ID | Location | Problem | Impact | Suggested fix |
| --- | --- | --- | --- | --- |

### Design decisions needed
<Or "None.">

### Resolved-thread reconsiderations
<Or "None.">

### Clean areas
<Or "None worth calling out.">
```

Ask which findings to post, then stop. A review request is not permission to
post.

## 4. Post approved comments

If the PR head changed since the review, do not post; rerun the review. Post
one concise line comment per approved finding with the problem, impact, and
suggested fix. Use a general comment only for an approved finding that cannot
be anchored to a line. Report the links to the comments created.
