---
name: linux-compat
description: Check a file, alias, or shell snippet for macOS vs Linux compatibility and suggest Linux-native alternatives with full explanations.
---

When invoked, examine the specified file, alias block, or shell snippet ($ARGUMENTS) for macOS-specific commands and tools. Explain what each one does and provide the Linux equivalent.

Check for:
- `brew` commands → suggest `apt`, `snap`, `nix`, or `mise` alternatives
- macOS-only commands: `defaults`, `osascript`, `open`, `pbcopy`, `pbpaste`, `mdfind`, `launchctl`, `say`, `caffeinate`, `sw_vers`, `system_profiler`
- macOS-specific paths: `/usr/local/Cellar`, `~/Library/`, `/Applications`, `/System/`
- Herd (macOS-only PHP tool) → suggest `phpenv`, `mise`, `asdf`, or Docker
- iTerm2 / Terminal.app references → suggest kitty, alacritty, gnome-terminal, wezterm
- `defaults write` macOS system prefs → suggest `gsettings`, `dconf`, or `/etc/environment`
- macOS-specific env vars or Apple Silicon assumptions

For each incompatibility:
1. Explain what the original command/tool does
2. Explain why it won't work on Linux
3. Provide the exact Linux replacement command/syntax
4. Note if there's no direct equivalent and describe the closest Linux approach

The user is still learning — be thorough and explain concepts rather than just swapping syntax.
