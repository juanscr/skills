# Pull Requests

Use `az repos pr` commands. Threads and comments have no native command; use
`az devops invoke --area git --resource pullRequestThreads` (or
`pullRequestThreadComments`) with `--api-version 7.1`.

## Create

Push the source branch first and confirm its HEAD is the approved commit. Use
the description from `pr-description`; do not write one here.

Pass a multiline description as one value per line after `--description`, not
as one multiline string. After creating, read the PR and confirm the stored
description is complete; if truncated, fix it with `az repos pr update` the
same way.

Add `--work-items` only when the context or user identifies the work item.
Enable autocomplete, squash, source-branch deletion, or work-item transitions
only when the user chose them.

## Comments

Before posting, confirm the source commit has not changed since review and
deduplicate against current threads. Line comments use file and line
coordinates from the reviewed diff.
