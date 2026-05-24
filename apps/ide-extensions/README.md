# IDE Extensions Overview

VS Code, Cursor, and Windsurf extension lists exported from this workstation, grouped by purpose for restore and reference.

**Extension manifests:**
- VS Code: [`config/ide/vscode/extensions.txt`](../../config/ide/vscode/extensions.txt) (81 extensions)
- Cursor: [`config/ide/cursor/extensions.txt`](../../config/ide/cursor/extensions.txt) (39 extensions)
- Windsurf: [`config/ide/windsurf/extensions.txt`](../../config/ide/windsurf/extensions.txt) (2 extensions)

**Settings & keybindings:** [`config/ide/`](../../config/ide/)

---

## Summary by editor

| Editor | Extensions | Primary focus | Detail guide |
|--------|------------|---------------|--------------|
| **VS Code** | 81 | Full-stack Laravel + React + API testing + docs | [vscode.md](vscode.md) |
| **Cursor** | 39 | Laravel/PHP/Tailwind (streamlined for AI IDE) | [cursor.md](cursor.md) |
| **Windsurf** | 2 | Markdown preview + live reload | [windsurf.md](windsurf.md) |

---

## Shared stack (Laravel / PHP / Tailwind)

Both VS Code and Cursor share a core Laravel development stack:

| Purpose | VS Code | Cursor |
|---------|---------|--------|
| Laravel official | `laravel.vscode-laravel` | ✓ |
| PHP intelligence | Intelephense + DevSense suite | ✓ |
| Blade formatting | `shufo.vscode-blade-formatter` | ✓ |
| Laravel Pint | `open-southeners.laravel-pint` | ✓ |
| Tailwind CSS | `bradlc.vscode-tailwindcss` | ✓ + Tailwind Docs, Tailwind Fold |
| Prettier | `esbenp.prettier-vscode` | ✓ |
| Error Lens | `usernamehw.errorlens` | ✓ |
| PHP Debug | `xdebug.php-debug` | ✓ |
| Material icons | `pkief.material-icon-theme` | ✓ + Product Icons |

Cursor omits React Native, Thunder Client, Copilot Chat, and many VS Code-only utilities — it is tuned for PHP/Laravel daily driver use.

---

## Restore commands

```bash
# VS Code
xargs -a config/ide/vscode/extensions.txt -I {} code --install-extension {}

# Cursor
xargs -a config/ide/cursor/extensions.txt -I {} cursor --install-extension {}

# Windsurf (if CLI available)
xargs -a config/ide/windsurf/extensions.txt -I {} windsurf --install-extension {}
```

After bulk install, copy settings and keybindings from `config/ide/<editor>/`.

---

## Extension groups (cross-editor)

| Group | VS Code count (approx) | Cursor | Used for |
|-------|------------------------|--------|----------|
| Laravel / PHP / Blade | ~35 | ~25 | Backend, Artisan, Blade views, Livewire |
| Frontend / CSS / Tailwind | ~15 | ~10 | HTML, Bootstrap, Alpine, Tailwind |
| React / JavaScript / TS | ~15 | ~2 | SPA, React Native, snippets |
| Formatting / lint / quality | ~10 | ~6 | Prettier, Pint, Error Lens, spell check |
| API / dev servers | ~4 | ~1 | Thunder Client, Postman, Live Server, Five Server |
| Database | ~2 | — | DevDB, Supabase |
| Markdown / docs | ~4 | — | Mermaid, markdownlint |
| Git / GitHub / AI | ~2 | — | Copilot Chat, GitHub theme |
| Icons / themes | ~2 | ~3 | Material icons, Voltage (Cursor) |
| Utilities | ~10 | ~5 | DotENV, path/npm intellisense, auto-import |

See per-editor guides for full tables with **Name | Package | Source | What it is | Used for | Typical tasks**.

---

## Related

- [development/README.md](../development/README.md) — IDE applications themselves
- [dev-environment-and-credentials/README.md](../dev-environment-and-credentials/README.md) — PHP, Composer, Xdebug setup
