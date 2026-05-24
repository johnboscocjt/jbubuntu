# Shortcuts and Keybindings

Master reference for GNOME, terminal, launcher, and IDE keyboard shortcuts.

## GNOME custom shortcuts (Super+A/V/J/G/F)

From `config/shortcuts/gnome-custom-keybindings.dconf`:

| Binding | Name | Command |
|---------|------|---------|
| **Super+A** | ulauncher | `ulauncher-toggle` |
| **Super+V** | Clipboard Popup | `~/clip_popup.sh` |
| **Ctrl+Alt+T** | kitty | `kitty` |
| **Super+F** | frog screenshot | `flatpak run com.github.tenderowl.frog` |
| **Super+J** | jshortcuts | `~/bin/jshortcuts gui` |
| **Super+G** | GitHub Desktop | `flatpak run io.github.shiftey.Desktop` |

Also configured:

| Binding | Action |
|---------|--------|
| **Super+S** | Settings / Control Center |
| **Super+E** | Home folder (Nemo) |
| **Super+Z** | Screenshot UI (`show-screenshot-ui`) |

Apply with:

```bash
./scripts/apply-gnome-config.sh
```

Or manually: **Settings → Keyboard → View and Customize Shortcuts → Custom Shortcuts**

## jshortcuts

Personal shortcut database: `config/shortcuts/jshortcuts.json`

Launch GUI: **Super+J** or `jshortcuts gui`

Documented entries include navigation (Super+D desktop, snap keys), terminal copy/paste, browser tabs, Super+Z screenshot.

Install jshortcuts to `~/bin/jshortcuts` (from your `myjshortcuts` repo).

## Ulauncher web search keywords

From `config/shortcuts/ulauncher-shortcuts.json`:

| Keyword | Target |
|---------|--------|
| `g` | Google Search |
| `so` | Stack Overflow |
| `wiki` | Wikipedia |

Restore: copy JSON into Ulauncher preferences or re-import via Ulauncher settings UI.

## Window management (Tiling Assistant + GNOME defaults)

| Keys | Action |
|------|--------|
| Super + Left/Right | Snap to half screen |
| Super + Up | Maximize |
| Super + D | Show/hide desktop |

Tiling Assistant adds snap assist beyond default 2-column tiling (see extension dconf).

## IDE keybindings

| IDE | Repo path | User path |
|-----|-----------|-----------|
| VS Code | `config/ide/vscode/keybindings.json` | `~/.config/Code/User/` |
| Cursor | `config/ide/cursor/keybindings.json` | `~/.config/Cursor/User/` |
| Exports | `config/shortcuts/ide/*-keybindings.json` | Reference copies |

Notable Cursor/VS Code binding (from jshortcuts): **Ctrl+`** → integrated terminal.

## Restore all shortcuts

```bash
# GNOME + shell
./scripts/apply-gnome-config.sh

# IDE — copy keybindings.json files (see docs/ide-setup.md)

# Ulauncher — import config/shortcuts/ulauncher-shortcuts.json manually

# jshortcuts — ensure ~/bin/jshortcuts exists and Super+J is set
```

Full restore guide: [config/shortcuts/RESTORE.md](../config/shortcuts/RESTORE.md)

## Clip popup dependency

Super+V runs `/home/jbtechnix/clip_popup.sh` — copy this script to the same path on the new machine or update the dconf command after restore.

## Related docs

- [gnome-desktop.md](gnome-desktop.md)
- [shell-and-terminals.md](shell-and-terminals.md)
- [obsidian-and-github-desktop.md](obsidian-and-github-desktop.md)
