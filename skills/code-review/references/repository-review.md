# Parallel Repository Review

Use this branch when the target repository supplies its own review skill.
The parent verifies the entrypoint; a separate `general-purpose` agent invokes
it and owns any child reviewers or threads prescribed by that skill.

## Verify the entrypoint

1. Follow repository guidance that identifies a review skill. Otherwise inspect
   repo-local skill locations such as `.github/skills`, `.claude/skills`, and
   `.agents/skills` for a review entrypoint. Search within the target repository,
   not personal or globally installed skills.
2. Read the candidate's `SKILL.md`, frontmatter, and referenced dispatch
   instructions. Confirm its purpose is code review and that its resolved
   source belongs to the target repository. Record its name, absolute source
   path, and the repository guidance or discovery evidence selecting it.
3. Select the repository's documented entrypoint when it composes several
   reviewers. If several independent skills remain equally applicable, ask
   which to use before dispatch. A skill that is this parent orchestrator, or
   merely routes back to it, is not an independent repository review.
4. Verify that the child can invoke the selected source unambiguously. For a
   name collision such as `code-review`, use a supported path-qualified
   invocation or explicit loading of that exact `SKILL.md` and its references.
   Name-only invocation is allowed only when skill resolution is verified to
   select that source. An unresolved collision blocks the repository branch;
   never substitute the personal skill.
5. Confirm that the workflow can honor the shared snapshot, read-only limits,
   and selected mode. Keep any repository-prescribed child-agent or thread
   topology that fits those limits. If mandatory steps require modifications,
   validation execution, publishing, or broader review than the selected mode
   permits, report the incompatibility instead of silently changing the skill
   or mode.

Verification is complete only when one repository entrypoint, its exact
invocation, and its compatible delegation instructions are established.
Discovery and skill loading do not change the pinned code-review snapshot.

## Dispatch the repository branch

Launch one outer `general-purpose` agent alongside the built-in reviewers,
using the parent's `model-selection` choice for orchestration work. Supply:

- `REPOSITORY_REVIEW_BRANCH: true`, without `CODE_REVIEW_LEAF`;
- the verified skill name, absolute source path, exact invocation, and
  discovery evidence;
- the absolute path to `review-contract.md`, repository guidance, and the
  requirement to keep those review limits through every descendant;
- the repository root, resolved base and head SHAs, complete commits,
  changed-file list, diff or prepared snapshot, and exact read-only commands;
- originating intent, validation evidence, exclusions, and selected mode;
- for Follow-up, the previous reviewed head, the delta, and open finding IDs
  with evidence and expected resolutions; and
- the parent's mode-specific finding or verification output contract.

Tell the outer agent to invoke the verified repository skill, follow its
workflow, and itself spawn the child agents or threads it requires. The parent
does not replace those reviewers with its own leaf roles. The outer agent
verifies the loaded skill's source before executing it and returns a blocked
result if resolution selects another skill. It carries the branch marker
through descendants to prevent re-entry into the personal orchestrator.

Every descendant reviews the supplied immutable SHAs, not a newly resolved
`HEAD`, worktree diff, or different merge base. Consume supplied validation
evidence rather than running gates. Keep the mode's scope: Deep reviews the
complete change, and Follow-up checks open findings and reports only blockers
and design decisions from the delta. A repository skill
need not use these mode names, but must honor their boundaries.

Request the selected source path, reviewed SHAs, completion status, any
limitations, and evidence-backed results. Preserve native finding IDs and
severities as provenance alongside the parent's output contract. The branch
returns results only; the parent owns final verification and synthesis.

## Completion and synthesis

Await the repository branch and its prescribed child work before synthesizing.
Check its reported source and SHAs against the verified entrypoint and pinned
snapshot. Mismatched, failed, unavailable, or incompatible execution is an
incomplete repository review, not a clean result. Report that limitation in
Scope alongside available built-in findings; never claim full review completion.
When no independent repository skill exists, record that fact without treating
the built-in review as incomplete.

For both modes, verify and deduplicate repository findings with built-in
findings under the parent's finding contract. Preserve repository provenance
in the Lens field. Native severity labels alone do not establish a blocker.

For Follow-up, retain the parent's stable finding IDs, reconcile statuses from
both branches against source evidence, and keep disagreements unresolved until
the evidence settles them. A required repository branch that did not complete
prevents `all open blockers resolved`; return `verification incomplete` with
the branch limitation instead.
