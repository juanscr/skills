# Work Items

Use native `az boards work-item` commands. Always pass the privately resolved
organization and pass the project when the command supports it.

## Read

```text
az boards work-item show --id <id> --org <organization> --expand relations --only-show-errors -o json
```

Read the item before updating it. Preserve fields and relations the user did
not ask to change.

## Create

At minimum, obtain the work-item type and title:

```text
az boards work-item create --type <type> --title <title> --description <description> --org <organization> --project <project> --only-show-errors -o json
```

Use dedicated options for area, iteration, assignment, description, and
discussion. Use `--fields "Field.ReferenceName=value"` only for fields without
a dedicated option. Do not guess custom field names, allowed values, or work
item types; inspect project configuration or ask the user.

When creating a planning artifact, keep it concise. Include the observable
outcome, acceptance criteria, phase boundaries or children, and an accessible
link to the approved spec. Do not copy the entire HTML plan into the work item.

## Update

```text
az boards work-item update --id <id> --title <new-title> --description <new-description> --state <new-state> --discussion <comment> --fields "Field.ReferenceName=value" --org <organization> --project <project> --only-show-errors -o json
```

Include only requested options. Omit every unchanged example option.

After updating, read the work item and verify the exact changed fields. Do not
treat a successful command exit as proof that a custom rule accepted the
desired state.

## Add child work items

For each approved child:

1. Create the child and capture its returned ID and URL.
2. Add the relation from the parent:

   ```text
   az boards work-item relation add --id <parent-id> --relation-type child --target-id <child-id> --org <organization> --only-show-errors -o json
   ```

3. Read the parent with relations expanded and confirm the child relation.
4. Read the child and report both IDs and URLs.

Do not create every phase as a child automatically. `design-plan` must have
recorded the user's decision to create provider task artifacts.

If child creation succeeds but relation creation fails, do not delete the
child. Report the unlinked child and ask whether to retry, keep it, or delete
it.

Use `az boards work-item relation list-type` when the process uses a relation
name other than `child`. Never guess relation identifiers.

## Destructive and bulk operations

Require confirmation before:

- deleting a work item;
- removing a relation;
- changing multiple work items in one request;
- transitioning parent and children together; or
- replacing descriptions or acceptance criteria in bulk.

Show the affected IDs and intended changes before executing.
