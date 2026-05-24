# Obsidian and GitHub Desktop

## Obsidian

Obsidian is installed manually under `/opt/Obsidian` (see `installs/opt-manifest.txt`).

### Vault registry

`config/obsidian/obsidian.json` lists registered vaults (paths use `$HOME` templates):

| Vault ID | Path (template) |
|----------|-----------------|
| `d48364d7…` | `$HOME/Documents/mydocs/.../PrinciplesOfSystemSecurityVault` |
| `7dbf4354…` | `$HOME/Documents/mydocs/.../MobileComputingVault` |
| `118e18b4…` | `$HOME/Documents/mydocs/.../AIcourseVault` |

### Restore vault registry

1. Clone or copy your vault folders to the new machine
2. Edit paths in `obsidian.json` if your `$HOME` layout differs
3. Copy to Obsidian config:

```bash
mkdir -p ~/.config/obsidian
cp config/obsidian/obsidian.json ~/.config/obsidian/obsidian.json
```

4. Launch Obsidian — vaults appear in the sidebar
5. Re-enable community plugins and themes (not backed up in this repo)
6. Sync: use Obsidian Sync, git, or Syncthing per vault

### What is not backed up

- Vault note content (only registry paths)
- Plugin binaries and plugin data
- Obsidian account / Sync credentials

## GitHub Desktop

| Item | Value |
|------|-------|
| Flatpak ID | `io.github.shiftey.Desktop` |
| Launch | `flatpak run io.github.shiftey.Desktop` |
| Shortcut | **Super+G** (see custom keybindings) |

Listed in `data/flatpak-apps.txt`.

### Install

```bash
flatpak install flathub io.github.shiftey.Desktop
```

### Flatpak auth restore

Authentication **must be re-done** on every new machine. Tokens are stored in the Flatpak sandbox, not in this repo.

See [config/github-desktop/README-restore.md](../config/github-desktop/README-restore.md) for step-by-step auth.

Quick steps:

1. Install Flatpak app
2. Launch GitHub Desktop
3. **File → Options → Accounts → Sign in**
4. Complete browser OAuth flow
5. Verify clone/push to a test repo

### Flatpak paths

| Data | Path |
|------|------|
| Config | `~/.var/app/io.github.shiftey.Desktop/config/` |
| Data | `~/.var/app/io.github.shiftey.Desktop/data/` |

To reset auth: remove the app data directory and sign in again (you will lose local UI state).

```bash
flatpak uninstall --delete-data io.github.shiftey.Desktop
flatpak install flathub io.github.shiftey.Desktop
```

## Related shortcuts

| Keys | Action |
|------|--------|
| Super+G | GitHub Desktop |
| Super+J | jshortcuts GUI |

See [shortcuts-and-keybindings.md](shortcuts-and-keybindings.md).
