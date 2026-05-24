# Windsurf IDE Extensions

Minimal extension set for Windsurf on this workstation (2 extensions).

**Manifest:** [`config/ide/windsurf/extensions.txt`](../../config/ide/windsurf/extensions.txt) · **Settings:** [`config/ide/windsurf/settings.json`](../../config/ide/windsurf/settings.json)

Windsurf is used as a secondary AI IDE; most Laravel/PHP tooling lives in Cursor and VS Code. These extensions cover markdown preview and local runtimes.

---

## All extensions

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Markdown Inline Preview** | `markdown-inline-preview.markdown-inline-preview` | Open VSX / Marketplace | Renders Markdown inline while editing | Preview README and docs without split pane | Write `README.md`, see formatted headings live |
| **Live Server** | `ritwickdey.liveserver` | Marketplace | Local dev server with live reload | Quick HTML/static preview in browser | Right-click `index.html` → Open with Live Server |

---

## Restore

```bash
xargs -a config/ide/windsurf/extensions.txt -I {} windsurf --install-extension {}
cp config/ide/windsurf/settings.json ~/.config/Windsurf/User/settings.json
```

If the Windsurf CLI is unavailable, install manually from the Extensions panel using the package IDs above.

---

## When to use Windsurf vs Cursor/VS Code

| Task | Recommended editor |
|------|-------------------|
| Laravel / PHP / Blade / Xdebug | Cursor or VS Code (full extension stack) |
| AI agent coding on full repo | Cursor (primary) |
| Quick markdown editing with preview | Windsurf |
| Static HTML prototype with live reload | Windsurf or VS Code Live Server |

See [cursor.md](cursor.md) and [vscode.md](vscode.md) for the full development extension sets.
