# Context and CLI

## Resolve context

Never hard-code an organization, project, repository, identity, or credential
in this public skill.

Resolve organization, project, and repository from explicit inputs or the
artifact URL first, then the current repository's Azure DevOps Git remote.
Inspect remotes with `git remote -v`; support HTTPS and SSH URLs and decode
escaped project/repository names. Use only a remote matching the requested
artifact; ask if multiple candidates remain.

Private configuration is optional fallback for unresolved values, not a
prerequisite. If needed, select the first existing source:

1. the path in `COPILOT_AZURE_DEVOPS_CONFIG`;
2. `~\.copilot\azure-devops.json`; or
3. `resources\config.local.json` in this skill's folder, which is gitignored.

The public shape is in
[`resources/config.example.json`](../resources/config.example.json).

When consulting a file, require valid JSON and a non-empty absolute `http` or
`https` `organization` URI; `project` and `repository` are optional defaults.
Apply defaults only within the resolved organization/project. Report a malformed
selected source and stop. If no file exists, ask only for values still required
by the operation; never require creating a configuration file.

Read the JSON with a parser. Do not source it as a script, print the complete
file, commit it, copy it into logs, or add tokens to it.

## CLI preflight

Before the first operation:

1. Confirm `az` is installed.
2. Confirm the `azure-devops` extension is installed:

   ```text
   az extension show --name azure-devops
   ```

3. Confirm Azure CLI authentication is active. If not, ask the user to run the
   appropriate `az login` flow. Never request or handle a token directly.
4. Resolve context as above; skip configuration files when inputs or the remote
   suffice. For a legacy remote such as
   `https://<account>.visualstudio.com/<collection>/<project>/_git/<repository>`,
   preserve `https://<account>.visualstudio.com/<collection>/` as the
   organization, with `<project>` as project and `<repository>` as repository.

Run `az repos` commands from the resolved repository root. This gives the
extension the Git remote it needs when `--detect true` is required. Pass `--org`
and, when supported by that exact subcommand, `--project` explicitly from the
resolved values. Check `az <command> --help` before a provider command:
Azure DevOps extension subcommands do not all accept the same flags. Use
`--only-show-errors -o json` for machine-readable operations. Do not call
`az devops configure --defaults`; keep resolved context local to this operation.

If an `az repos` operation run from an Azure DevOps worktree rejects a validated
organization from its Git remote before making a mutation, retry it once from
that worktree with `--detect true` instead of `--org`. Verify the resulting
artifact after a successful retry. Do not retry an operation whose failure may
have created or modified an artifact.

Use native `az boards` and `az repos` commands first. When the extension lacks
an operation, use `az devops invoke` with a named `--area` and `--resource`.
This keeps authentication inside Azure CLI and avoids a hard-coded resource
GUID.

Write request bodies for `az devops invoke` to the operating system's temporary
directory, pass them with `--in-file`, and delete them after the command.
Never put mutation bodies or retrieved private data in the target repository.
