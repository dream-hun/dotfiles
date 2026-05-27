---
name: test-shell
description: Smoke-test a shell script or alias file on the current system — syntax check, shellcheck analysis, and advice on any errors found.
disable-model-invocation: true
---

Test the shell file specified by $ARGUMENTS.

Steps:
1. Read the file to understand what it does
2. Run a syntax check without executing: `bash -n "$ARGUMENTS"` (or `zsh -n` for .zsh files)
3. If shellcheck is available (`command -v shellcheck`), run `shellcheck "$ARGUMENTS"` and capture output
4. Report all errors and warnings with plain-English explanations of what each one means
5. For each error, show the corrected code
6. If the file defines aliases or functions, show how to load and verify them:
   - Source the file: `source "$ARGUMENTS"`
   - List loaded functions: `declare -f <function-name>`
   - Test an alias: `alias <alias-name>`

Note: if shellcheck is not installed, suggest installing it:
- Ubuntu/Debian: `sudo apt install shellcheck`
- The syntax check via `bash -n` still works without it and catches fatal errors.

The user is still learning — explain each error clearly before showing the fix.
