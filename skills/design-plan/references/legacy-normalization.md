# Legacy Agent-Log Normalization

Apply this only to an `execution-progress.html` with no schema version that
structurally matches the previous workflow:

- it has the legacy phase table with one status column;
- its content has no draft-spec state because the previous workflow created the
  Agent's log only after phase-spec approval; and
- it has no partial `kind`, spec-status, or amendment-log structure.

Normalize it once:

1. Record schema version `2` and planning mode `Deep (legacy)`.
2. Infer spec format from linked file extensions.
3. Set every existing phase kind to `executable`.
4. Treat every existing linked phase spec as `approved`; the previous workflow
   created the Agent's log only after all linked specs were approved.
5. Treat a phase with no linked spec as `outline only`.
6. Add an amendment log. Preserve legacy per-phase decisions, approved
   deviations, and blockers as authoritative history; convert them to legacy
   amendment entries when their evidence and approval can be identified.
7. Preserve every phase status, starting SHA, changed path, validation result,
   commit, pull request, and exact next action.

Persist the normalization without a new approval gate.

If a log has a partial version-2 structure, a linked draft whose approval cannot
be established, or does not satisfy the legacy invariants above, record a
recovery blocker and ask the user to resolve the ambiguous state. Do not infer
approval from the existence of a linked file.
