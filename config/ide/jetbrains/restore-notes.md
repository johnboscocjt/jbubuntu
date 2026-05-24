# JetBrains IDE Restore Notes

Installed IDEs from source machine (`config/ide/jetbrains/installed-ides.json`):

- IntelliJ IDEA (IC 2025.1, Ultimate 2024.3)
- PhpStorm (2024.3, 2025.1, 2025.2, 2026.1)
- PyCharm CE (2024.3, 2025.1)
- Rider (2024.3, 2025.1)

## Install methods

| Method | Command / notes |
|--------|-----------------|
| Snap | `sudo snap install phpstorm --classic`, `pycharm-community --classic` |
| Toolbox | JetBrains Toolbox → install to `~/.local/share/JetBrains/Toolbox/apps/` |
| Manual | Download tarball from jetbrains.com |

Listed in `data/snap-apps.txt`: `phpstorm`, `pycharm-community`

## Settings Sync (recommended)

1. Install IDE
2. Launch → **Log in to JetBrains Account**
3. Enable **Settings Sync** on old machine first (if still available)
4. On new machine: same account → sync pulls settings, keymaps, plugins

## Manual export / import

On old machine:

**File → Manage IDE Settings → Export Settings**

Select: keymaps, editor, code style, live templates, plugins (plugin list only)

On new machine:

**File → Manage IDE Settings → Import Settings**

## Snap config paths

```
~/snap/phpstorm/current/.PhpStorm*
~/snap/pycharm-community/current/.PyCharmCE*
```

Versioned config may include `2024.3`, `2025.1`, etc.

## Plugins

After import or Settings Sync, verify Laravel/PHP plugins (PhpStorm):

- Laravel, Blade, PHP Annotations, .env files support

Re-authenticate AI Assistant / Grazie if used.

## Licenses

JetBrains licenses and activation tokens are **not** in this repo. Sign in with JetBrains account or enter license key manually.

## Coexistence with VS Code / Cursor

`.gitconfig` uses `code --wait` as editor. Override per-project in JetBrains or change global git editor if preferred.

## Related

- [../../docs/ide-setup.md](../../docs/ide-setup.md)
- [../../docs/dev-environment-and-credentials.md](../../docs/dev-environment-and-credentials.md)
