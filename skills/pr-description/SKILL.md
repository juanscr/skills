---
name: pr-description
description: PR descriptions for every pull request creation or description update. Find and obey the repository PR template, then explain intent, architecture, and future direction without internal phase language or code walkthroughs.
---

# Pull Request Description

Write the description for any pull request before it is created or when its
description is updated. Return description text to the calling workflow; do not
publish or modify the PR.

## 1. Find the template

Resolve the template before drafting any description:

1. Identify the provider, repository default branch, PR target branch, and any
   explicitly selected template.
2. Enumerate template paths on the default branch, target branch, and working
   tree. Include hidden directories and paths omitted by ignore rules; a
   default file search can miss `.github`. Search case-insensitively in root,
   `.github`, `docs`, and `.azuredevops`, including template directories rather
   than only one hard-coded filename. Use Git tree listings or the provider API
   when the checkout is sparse or a branch is unavailable locally.
3. Resolve provider-specific sources and selection rules. GitHub templates are
   supplied from the default branch; check the owner's public `.github`
   repository for an applicable inherited template when the repository has
   none. Azure DevOps templates also live on the default branch; resolve the
   target-branch-specific template before the default template.
4. Read the selected template in full. Record its repository, ref, and path,
   plus why it applies. Treat a working-tree or target-branch variant as a
   candidate, not an automatic override of provider selection.

An unreadable source, failed lookup, or incomplete search is **blocked**, not
evidence that no template exists. Report what could not be checked and resolve
it before drafting. Only a completed search with no applicable template permits
the [no-template fallback](references/no-template-fallback.md); read that
reference only after recording the checked sources and their results.

When a template exists, follow it. Only omit instructional comments only when
the template says they are removable.

Do not add a competing structure. If several templates could apply and no
provider rule or request selects one, ask the user which template to use.

## 2. Write the narrative

Keep the description simple and reviewer-oriented. The topics below guide
content within the selected template's fields; they are not replacement
headings. Fit relevant intent, architecture, and validation into that structure.

### Intent

Start from the problem, desired outcome, and why the change matters. Explain the
observable behavior rather than retelling the implementation sequence.

### Change

Summarize the cohesive change at system level. Name a folder or important file
when it helps reviewers orient themselves. Prefer concepts and boundaries over
symbols, methods, line numbers, hunks, or a file-by-file walkthrough.

### Architecture

Include only decisions a reviewer needs to understand the shape of the change:

- ownership and responsibility boundaries;
- control or data-flow changes;
- contracts, persistence, lifecycle, compatibility, or migration choices; and
- the strongest trade-off that explains why this design was selected.

Explain the decision and consequence, not the code used to implement it.

### Validation

State the observed validation performed and its outcome. Use exact command names
only when the template or repository convention expects them. Never claim a
test, check, benchmark, or manual verification that did not run.

### Future direction

Describe concrete follow-up work or how this change advances the broader goal
when that context helps reviewers judge the boundary. Make clear what is
deliberately outside this PR. Do not manufacture future work to fill a section.
