# Work Items

Use `az boards work-item` commands. Preserve fields and relations the user did
not ask to change.

- Do not guess work-item types, custom field names, allowed values, or relation
  names. Inspect the project configuration (for example
  `az boards work-item relation list-type`) or ask.
- Use dedicated options where they exist and `--fields` only for the rest.
- A planning work item holds the observable outcome, acceptance criteria, phase
  list, and a link to the plan. Do not copy the plan into it.
- Create child items only when the user decided to. Add each with
  `az boards work-item relation add --relation-type child` from the parent. If
  the relation fails, keep the child and ask whether to retry, keep, or delete
  it.
