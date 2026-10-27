# Context and CLI

## Resolve context

Never hard-code an organization, project, repository, or identity in this
public skill. Resolve them from explicit input or the artifact URL first, then
the current repository's Azure DevOps remote. Ask if several remotes match.

A legacy remote such as
`https://<account>.visualstudio.com/<collection>/<project>/_git/<repository>`
has organization `https://<account>.visualstudio.com/<collection>/`.

For values still unresolved, use the first private config that exists:

1. the path in `COPILOT_AZURE_DEVOPS_CONFIG`;
2. `~\.copilot\azure-devops.json`; or
3. `resources\config.local.json` in this skill's folder (gitignored).

The shape is in
[`resources/config.example.json`](../resources/config.example.json):
`organization` is a required absolute URL; `project` and `repository` are
optional defaults. Read it with a JSON parser and never print, commit, or add
tokens to it. If no config exists, ask only for the missing values.

## CLI usage

- Run `az repos` commands from the repository root and pass `--org` and, where
  supported, `--project`. Subcommands accept different flags; check `--help`
  when unsure.
- If an `az repos` command from a worktree rejects a valid `--org` before
  mutating anything, retry once with `--detect true` instead.
- Use `--only-show-errors -o json`. Do not run `az devops configure --defaults`.
- When no native command exists, use `az devops invoke` with a named `--area`
  and `--resource`. Write request bodies to the OS temp directory, pass them
  with `--in-file`, and delete them afterwards.
