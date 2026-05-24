# Modern CLI Tools

Replacements and enhancements for classic Unix commands — faster, prettier, and more informative in the terminal.

**Config backup:** [`dotfiles/cli-tools/`](../../dotfiles/cli-tools/) · **Aliases:** [`dotfiles/cli-tools/shell-aliases.zsh`](../../dotfiles/cli-tools/shell-aliases.zsh)

---

## Installed modern CLI stack

| Name | Package | Source | Replaces | What it is | Used for | Typical tasks |
|------|---------|--------|----------|------------|----------|---------------|
| **lsd** | `lsd` | APT + `~/.local/bin/lsd` | `ls` | LSDeluxe — colorful `ls` with icons | Directory listings with grid layout | `lsd -la`, `lsd --tree` |
| **bat** | `bat` (`batcat` on Ubuntu) | APT | `cat` | Syntax-highlighted file viewer | Read code/logs with line numbers | `batcat file.php`, `--paging=never` |
| **fastfetch** | `fastfetch` | APT | `neofetch` | Fast system info display | Terminal splash on open | Custom JSONC config |
| **neofetch** | `neofetch` | APT | — | Classic ASCII system info | Fallback/info screenshots | `neofetch` |
| **Starship** | `starship` | `/usr/local/bin` | default PS1 | Cross-shell prompt | Minimal Gruvbox-style prompt | Git branch, cmd duration |
| **htop** | `htop` | APT | `top` | Interactive process monitor | CPU/RAM per process | Sort by MEM, kill PIDs |
| **Nala** | `nala` | APT | `apt` | Friendly APT frontend | Cleaner install/remove output | `nala install`, `nala history` |
| **jq** | `jq` | APT | manual JSON parsing | JSON processor | Filter API responses in shell | `curl ... \| jq '.data'` |
| **wl-clipboard** | `wl-clipboard` | APT | `xclip` | Wayland clipboard tools | Copy/paste in Wayland | `wl-copy`, `wl-paste` |
| **Atuin** | `atuin` | curl installer | `.zsh_history` | Searchable shell history | Cross-session command recall | `atuin search git` |

---

## Configuration files

| Tool | User config path | Repo backup |
|------|------------------|-------------|
| **lsd** | `~/.config/lsd/config.yaml` | [`dotfiles/cli-tools/lsd/config.yaml`](../../dotfiles/cli-tools/lsd/config.yaml) |
| **bat** | `~/.config/bat/config` | [`dotfiles/cli-tools/bat/config`](../../dotfiles/cli-tools/bat/config) |
| **fastfetch** | `~/.config/fastfetch/` | [`dotfiles/cli-tools/fastfetch/sample_2.jsonc`](../../dotfiles/cli-tools/fastfetch/sample_2.jsonc) |
| **Starship** | `~/.config/starship.toml` | [`dotfiles/starship.toml`](../../dotfiles/starship.toml) |
| **Atuin** | `~/.config/atuin/config.toml` | [`config/dev-environment/atuin/config.toml.template`](../../config/dev-environment/atuin/config.toml.template) |

### lsd settings (summary)

- Icons: fancy theme, auto when terminal supports
- Layout: grid view
- Sort: by name, directories first
- Colors and hyperlinks: enabled

### Shell aliases (from `shell-aliases.zsh`)

```bash
alias ls='lsd'
alias l='lsd -l'
alias la='lsd -la'
alias lt='lsd --tree'
alias cat='batcat'
alias bat='batcat'
```

---

## Optional recommended additions

Not installed by default on source PC but documented for new installs:

| Name | Package | Install | Replaces | Used for | Typical tasks |
|------|---------|---------|----------|----------|---------------|
| **fd** | `fd-find` | `sudo apt install fd-find` | `find` | Fast friendly file search | `fd config`, `fd -e php` |
| **ripgrep** | `ripgrep` | `sudo apt install ripgrep` | `grep -r` | Fast recursive code search | `rg 'function foo'` |
| **fzf** | `fzf` | `sudo apt install fzf` | manual filtering | Fuzzy finder for files/history | `Ctrl+T`, `history \| fzf` |
| **zoxide** | `zoxide` | apt or curl | `cd` | Smart directory jumping | `z project`, `zi dirname` |
| **eza** | `eza` | apt or cargo | `ls`/`lsd` alt | Modern ls with git status | `eza --git --icons` |
| **btop** | `btop` | apt | `htop` | Prettier system monitor | GPU/CPU graphs |
| **dust** | `dust` | cargo/apt | `du` | Visual disk usage tree | `dust ~/Downloads` |
| **duf** | `duf` | go install | `df` | Human-readable disk free | `duf` |
| **delta** | `git-delta` | apt/cargo | `diff` | Better git diffs | `git diff` with syntax highlighting |
| **lazygit** | `lazygit` | apt/go | git CLI | Terminal UI for git | Stage, commit, push in TUI |
| **tldr** | `tldr` | pip/npm | `man` | Simplified command examples | `tldr tar` |

---

## Overlap with other categories

Some tools appear in multiple catalogs by design:

| Tool | Also documented in |
|------|-------------------|
| Starship, fastfetch, Atuin | [terminals-and-shell/README.md](../terminals-and-shell/README.md) |
| htop, Nala | [system-and-utilities/README.md](../system-and-utilities/README.md) |
| jq, wl-clipboard | [terminals-and-shell/README.md](../terminals-and-shell/README.md) |

---

## Restore on new PC

Part of `setup.sh` `--with-shell-extras` (default on):

```bash
sudo apt install -y lsd bat fastfetch neofetch htop nala jq wl-clipboard \
  zsh-autosuggestions zsh-syntax-highlighting

mkdir -p ~/.config/lsd ~/.config/bat ~/.config/fastfetch
cp dotfiles/cli-tools/lsd/config.yaml ~/.config/lsd/
cp dotfiles/cli-tools/bat/config ~/.config/bat/
cp dotfiles/fastfetch/sample_2.jsonc ~/.config/fastfetch/
cp dotfiles/starship.toml ~/.config/starship.toml
```

Ensure `shell-aliases.zsh` is sourced from `.zshrc`.
