# IDE Setup

Restore VS Code, Cursor, Windsurf, and JetBrains IDEs from `config/ide/`.

## VS Code

| Asset | Repo path | Restore to |
|-------|-----------|------------|
| Extensions | `config/ide/vscode/extensions.txt` | `code --install-extension <id>` |
| Settings | `config/ide/vscode/settings.json` | `~/.config/Code/User/settings.json` |
| Keybindings | `config/ide/vscode/keybindings.json` | `~/.config/Code/User/keybindings.json` |

### Bulk install extensions

```bash
while read -r ext; do
  [[ -z "$ext" || "$ext" =~ ^# ]] && continue
  code --install-extension "$ext"
done < config/ide/vscode/extensions.txt
```

Install VS Code from APT (`data/apt-packages.txt`) or [official .deb](https://code.visualstudio.com/).

## Cursor

| Asset | Repo path | Restore to |
|-------|-----------|------------|
| Extensions | `config/ide/cursor/extensions.txt` (~35) | `cursor --install-extension <id>` |
| Settings | `config/ide/cursor/settings.json` | `~/.config/Cursor/User/settings.json` |
| Keybindings | `config/ide/cursor/keybindings.json` | `~/.config/Cursor/User/keybindings.json` |

Cursor is installed via APT from `downloads.cursor.com` (see `data/apt-third-party.sh`).

```bash
while read -r ext; do
  [[ -z "$ext" || "$ext" =~ ^# ]] && continue
  cursor --install-extension "$ext"
done < config/ide/cursor/extensions.txt
```

IDE-specific keybinding exports also live in `config/shortcuts/ide/`.

## Windsurf

| Asset | Repo path | Restore to |
|-------|-----------|------------|
| Extensions | `config/ide/windsurf/extensions.txt` | Windsurf extension CLI |
| Settings | `config/ide/windsurf/settings.json` | `~/.config/Windsurf/User/settings.json` |

Windsurf uses a VS Code–compatible layout; copy settings into the Windsurf config directory after first launch.

## JetBrains

Installed IDEs (from `config/ide/jetbrains/installed-ides.json`):

- IntelliJ IDEA (Community + Ultimate builds)
- PhpStorm (2024.3 – 2026.1)
- PyCharm CE (2024.3, 2025.1)
- Rider (2024.3, 2025.1)

JetBrains IDEs are typically installed via **Snap** (`phpstorm`, `pycharm-community`) or Toolbox.

### Restore settings

See [config/ide/jetbrains/restore-notes.md](../config/ide/jetbrains/restore-notes.md) for:

- JetBrains Settings Sync (recommended)
- Manual export/import via **File → Manage IDE Settings**
- Snap config paths: `~/snap/phpstorm/current/.PhpStorm*`

Licenses and account tokens are **not** in this repo.

## Git integration

`.gitconfig` sets `core.editor = code --wait` and diff tool to VS Code. After restore:

```bash
cp config/dev-environment/git/.gitconfig ~/.gitconfig
```

## Extension highlights

Common groups across VS Code / Cursor:

- **Laravel/PHP:** Intelephense, Blade formatter, Laravel Pint, PHP Debug
- **Frontend:** Tailwind CSS IntelliSense, Emmet, Auto Rename Tag
- **Formatting:** Prettier, Error Lens, EditorConfig
- **Git:** GitHub Copilot / Copilot Chat (re-authenticate on new machine)
- **Icons:** Material Icon Theme

## Restore checklist

1. Install each IDE (APT / Snap / manual)
2. Copy `settings.json` and `keybindings.json` per IDE
3. Run extension install loops from `extensions.txt`
4. JetBrains: sign in to Settings Sync or import ZIP
5. Verify `git config --global --list` and `gh auth status`

## Related docs

- [dev-environment-and-credentials.md](dev-environment-and-credentials.md)
- [shortcuts-and-keybindings.md](shortcuts-and-keybindings.md)
