# Progress Log Migration

Before planning, execution, amendment, or handoff, use
`execution-progress.json` with schema version `3`, following
`artifact-requirements.md`. Migration changes storage, not approvals or phase
state; it needs no new design approval.

## Select the source

- A valid version-3 JSON log is canonical, even when legacy HTML remains.
- If JSON exists but is malformed, incomplete, or has an unsupported version,
  stop and report the recovery blocker. Do not hide it by falling back to HTML.
- If JSON is absent, read `execution-progress.html`. Version-2 HTML can be
  mapped directly. Normalize an unversioned log only under the rules below.
  Other versions or unrecognized layouts are recovery blockers.
- If neither exists, report missing execution state rather than reconstructing
  approvals or a review fixed point from the current checkout.

Only the coordinator migrates. Settle any other active writer before creating
the replacement log.

## Unversioned HTML

The supported legacy shape has one phase-status column, no draft-spec state,
and no partial kind, spec-status, or amendment-log structure. That workflow
created its log only after phase-spec approval.

For this shape, preserve phase numbers and statuses, use kind `executable`,
mark linked phase specs `approved`, and mark phases without specs `outline only`.
Use planning mode `Deep (legacy)` and infer human-spec format from linked files.
Convert recorded deviations to amendments only where their evidence and
approval are established.

For a partial structure or ambiguous approval, preserve the source and ask for
the missing decision. A linked file alone proves no approval outside the
recognized legacy shape.

## Write and verify once

1. Map the source into the version-3 fields. Preserve every phase, approval,
   amendment, PR, review finding and disposition, review-round count, commit,
   validation result, blocker, starting SHA, worker assignment, and next action.
   Retain useful unmatched narrative as discoveries or handoff context.
2. Write a candidate JSON file and parse it. Compare record IDs, states,
   approvals, and review anchors with the source; verify referenced paths.
   Missing historical values stay unknown, not inferred from current HEAD.
3. After a successful comparison, make it `execution-progress.json`. Keep the
   original HTML unchanged as an archive and record it in `legacySource`.
   Update progress-log links in the feature's plan artifacts to point to JSON.
4. Resume from JSON only. Never update or merge the archived HTML afterward.

On conversion failure, keep the original intact, report the exact blocker, and
do not begin the requested workflow.
