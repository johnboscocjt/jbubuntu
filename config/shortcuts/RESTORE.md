# Keyboard Shortcuts Restore

Apply all GNOME, launcher, and IDE keybindings from the jbubuntu repo.

## GNOME custom + shell shortcuts

**Files:**

- `config/shortcuts/gnome-custom-keybindings.dconf` — Super+A/V/J/G/F, Ctrl+Alt+T
- `config/shortcuts/gnome-shell-keybindings.dconf` — Super+Z screenshot
- `config/dconf/media-keys.dconf` — duplicate media-keys block

**Apply all at once:**

```bash
chmod +x scripts/apply-gnome-config.sh
./scripts/apply-gnome-config.sh
```

**Apply shortcuts only:**

```bash
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < config/shortcuts/gnome-custom-keybindings.dconf
dconf load /org/gnome/shell/keybindings/ < config/shortcuts/gnome-shell-keybindings.dconf
```

## Shortcut reference

| Keys | Action |
|------|--------|
| Super+A | Ulauncher toggle |
| Super+V | Clipboard popup (`~/clip_popup.sh`) |
| Ctrl+Alt+T | Kitty terminal |
| Super+F | Frog screenshot (Flatpak) |
| Super+J | jshortcuts GUI |
| Super+G | GitHub Desktop |
| Super+Z | GNOME screenshot UI |
| Super+S | Settings |
| Super+E | Home folder |

Full table: [../../docs/shortcuts-and-keybindings.md](../../docs/shortcuts-and-keybindings.md)

## Dependencies to install first

| Shortcut | Requires |
|----------|----------|
| Super+A | `ulauncher` (APT) |
| Super+V | `~/clip_popup.sh` — copy manually |
| Ctrl+Alt+T | `kitty` |
| Super+F | `flatpak install flathub com.github.tenderowl.frog` |
| Super+J | `~/bin/jshortcuts` |
| Super+G | GitHub Desktop Flatpak |

## jshortcuts

Database: `config/shortcuts/jshortcuts.json`

Install binary to `~/bin/jshortcuts` and ensure Super+J binding matches dconf.

## Ulauncher web keywords

Import `config/shortcuts/ulauncher-shortcuts.json` via Ulauncher preferences (Google `g`, Stack Overflow `so`, Wikipedia `wiki`).

## IDE keybindings

Copy to user config after IDE first launch:

```bash
mkdir -p ~/.config/Code/User ~/.config/Cursor/User
cp config/ide/vscode/keybindings.json ~/.config/Code/User/
cp config/ide/cursor/keybindings.json ~/.config/Cursor/User/
```

Reference exports: `config/shortcuts/ide/`

## Export current shortcuts (backup)

```bash
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > gnome-media-keys.dconf
dconf dump /org/gnome/shell/keybindings/ > gnome-shell-keybindings.dconf
```

## Troubleshooting

- **Shortcut does nothing:** Check app installed; run command from terminal manually
- **Conflict:** Settings → Keyboard — search binding key
- **Wayland:** Some xdotool shortcuts won't work; use native GNOME bindings

## Related

- [../../docs/gnome-desktop.md](../../docs/gnome-desktop.md)
- [../../docs/ide-setup.md](../../docs/ide-setup.md)
