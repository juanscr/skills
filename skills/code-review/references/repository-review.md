# Repository Review

Use this when the target repository has its own code-review skill, named in
repository guidance or found in a repo-local skill folder such as
`.github/skills`.

- Confirm it is a review skill from the target repository, not this skill or a
  personal skill with the same name. Load it by path when names collide. Ask
  when several qualify.
- Launch one `general-purpose` agent that runs it, including any child
  reviewers it prescribes, on the same revisions and mode. It stays read-only
  and does not run validation.
- Merge its findings with the built-in ones, using the repository skill as the
  lens. Its severity labels alone do not make a finding a blocker.
- If it fails or cannot honor these limits, report the review as incomplete,
  not clean.
