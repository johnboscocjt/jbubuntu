# Terminals & Shell

Terminal emulators, shell, prompt, history, and launcher integration.

**Dotfiles:** [`dotfiles/zsh/.zshrc`](../../dotfiles/zsh/.zshrc) · [`dotfiles/cli-tools/shell-aliases.zsh`](../../dotfiles/cli-tools/shell-aliases.zsh) · **Shortcuts:** [`config/shortcuts/`](../../config/shortcuts/)

---

## Terminal emulators

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Kitty** | `kitty` | APT | GPU-accelerated terminal | **Primary terminal** (via shortcuts) | Tabs, ligatures, fast scrollback |
| **Ghostty** | `ghostty` | Snap | Modern terminal by Mitchell Hashimoto | Alternative terminal with native UI | Split panes, GPU rendering |
| **Warp** | `warp-terminal` + `/opt/warpdotdev` | APT ([Warp repo](../../data/apt-third-party.sh)) | Rust-based terminal with blocks | AI-assisted command history, modern UX | Run commands in blocks, share sessions |
| **Terminator** | `terminator` | APT | GTK terminal with split panes | Grid layouts for monitoring | Horizontal/vertical splits |
| **GNOME Terminal** | (default) | Ubuntu | Default GNOME terminal | Fallback when others unavailable | Basic shell sessions |

---

## Shell & framework

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Zsh** | `zsh` | APT | Extended Bourne shell | **Default login shell** | Tab completion, globbing, scripting |
| **Oh My Zsh** | `~/.oh-my-zsh` | Git clone | Zsh configuration framework | Plugins, themes directory, conventions | Manage plugins in `.zshrc` |
| **zsh-autosuggestions** | `zsh-autosuggestions` | APT + OMZ | Fish-like command suggestions | Gray inline suggestions from history | Accept suggestion with → |
| **zsh-syntax-highlighting** | `zsh-syntax-highlighting` | APT + OMZ | Command syntax coloring | Red/green valid/invalid commands | Visual feedback while typing |

**OMZ plugins enabled:** `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`

**Theme:** Empty (`ZSH_THEME=""`) — Starship replaces Powerlevel10k (p10k disabled in `.zshrc`).

---

## Prompt & startup banner

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Starship** | `/usr/local/bin/starship` | curl/install script | Minimal cross-shell prompt | Gruvbox-style fast prompt | Shows git branch, duration, directory |
| **fastfetch** | `fastfetch` | APT | System info on terminal open | OS/kernel/packages banner | Runs at shell startup |
| **neofetch** | `neofetch` | APT | ASCII art system info | Alternative splash screen | Screenshots, quick system ID |

**Config:** [`dotfiles/starship.toml`](../../dotfiles/starship.toml) · [`dotfiles/cli-tools/fastfetch/sample_2.jsonc`](../../dotfiles/cli-tools/fastfetch/sample_2.jsonc)

---

## Shell history & search

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Atuin** | `~/.atuin/bin/atuin` | curl installer | Syncable searchable shell history | Replace plain `.zsh_history` | `Ctrl+R` search, sync across machines |

**Init:** `eval "$(atuin init zsh)"` in `.zshrc`

**Config template:** [`config/dev-environment/atuin/config.toml.template`](../../config/dev-environment/atuin/config.toml.template)

---

## Clipboard & Wayland helpers

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **wl-clipboard** | `wl-clipboard` | APT | Wayland clipboard CLI | Copy/paste in Wayland sessions | `wl-copy`, `wl-paste` |
| **xclip** | `xclip` | APT | X11 clipboard CLI | Legacy X11 clipboard | Pipe output to clipboard |
| **wl-clipboard popup** | custom script | `~/bin` | Clipboard history popup | `Super+V` clipboard manager | Recall previous copies |

---

## Application launcher

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Ulauncher** | `ulauncher` | APT | Keyboard-driven app launcher | **`Super+A`** fuzzy app search | Launch apps, run custom shortcuts |

**Shortcuts config:** [`config/shortcuts/ulauncher-shortcuts.json`](../../config/shortcuts/ulauncher-shortcuts.json)

---

## Keyboard shortcuts (shell-related)

| Shortcut | Action |
|----------|--------|
| `Super+A` | Ulauncher |
| `Super+V` | Clipboard history popup |
| `Super+E` | Open Home folder (Nemo) |
| `Ctrl+R` | Atuin history search (when Atuin active) |

Full keybinding exports: [`config/shortcuts/gnome-custom-keybindings.dconf`](../../config/shortcuts/gnome-custom-keybindings.dconf), [`config/shortcuts/jshortcuts.json`](../../config/shortcuts/jshortcuts.json)

---

## PATH & runtime integration

Shell startup loads paths for NVM, Deno, Go, Composer, and local bins — see [dev-environment-and-credentials/README.md](../dev-environment-and-credentials/README.md).

```bash
export PATH="$HOME/.local/bin:$PATH"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
# NVM, Deno sourced from .zshrc
```

---

## Modern CLI aliases

Shell aliases map classic commands to modern replacements — documented in [modern-cli-tools/README.md](../modern-cli-tools/README.md):

```bash
alias ls='lsd'
alias cat='batcat'
```

Sourced from [`dotfiles/cli-tools/shell-aliases.zsh`](../../dotfiles/cli-tools/shell-aliases.zsh).
