# Shell and Terminals

This document covers the default shell stack, terminal emulators, and CLI tooling restored from `dotfiles/` and `config/dev-environment/`.

## Default terminal: Kitty

Kitty is the preferred terminal, launched via **Ctrl+Alt+T** (custom GNOME shortcut).

| Item | Location |
|------|----------|
| Config | `dotfiles/kitty/kitty.conf` → `~/.config/kitty/kitty.conf` |
| Install | `sudo apt install kitty` or from `data/apt-packages.txt` |

Other terminals on the system: GNOME Terminal (default Ubuntu), Ghostty (Snap), Warp (`/opt/warpdotdev`), Terminator.

## Shell: zsh + Oh My Zsh

| Component | Details |
|-----------|---------|
| Default shell | `zsh` (set with `chsh -s $(which zsh)`) |
| OMZ path | `$HOME/.oh-my-zsh` |
| Config source | `dotfiles/zsh/.zshrc` |
| Theme | Empty (`ZSH_THEME=""`) — Starship handles the prompt |
| Plugins | `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting` |

### Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Copy the repo `.zshrc`:

```bash
cp ~/jbubuntu/dotfiles/zsh/.zshrc ~/.zshrc
```

Install plugins:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### zsh-autocomplete

Loaded from `$HOME/zsh-autocomplete/zsh-autocomplete.plugin.zsh` (installed separately).

## Starship prompt

Starship replaces Powerlevel10k. Init line in `.zshrc`:

```bash
eval "$(starship init zsh)"
```

| Item | Location |
|------|----------|
| Config | `dotfiles/starship.toml` → `~/.config/starship.toml` |
| Install | `curl -sS https://starship.rs/install.sh \| sh` or `sudo apt install starship` |

## Atuin (shell history)

Searchable, sync-capable history replacing plain `.zsh_history`.

| Item | Location |
|------|----------|
| Config template | `config/dev-environment/atuin/config.toml.template` |
| Init | `eval "$(atuin init zsh)"` in `.zshrc` |
| Install | `bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)` |

After install, copy the template and optionally run `atuin login` for cloud sync.

## fastfetch (startup banner)

Runs on every shell login:

```bash
fastfetch -c ~/.config/fastfetch/sample_2.jsonc
```

| Item | Location |
|------|----------|
| Config | `dotfiles/fastfetch/sample_2.jsonc` |
| Install | `sudo apt install fastfetch` |

## NVM and Node.js

| Item | Value |
|------|-------|
| Active version | `v24.15.0` (see `config/dev-environment/runtimes/nvm-versions.txt`) |
| Default | `v24.15.0` (`node-default.txt`) |
| NVM dir | `$HOME/.nvm` |

### Install NVM

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.nvm/nvm.sh
nvm install v24.15.0
nvm alias default v24.15.0
```

Or source `config/dev-environment/env-paths.sh` which loads NVM automatically.

## Deno

| Item | Value |
|------|-------|
| Version | `2.6.8` (`config/dev-environment/runtimes/deno-version.txt`) |
| Install dir | `$HOME/.deno` |

```bash
curl -fsSL https://deno.land/install.sh | sh
```

## Modern CLI aliases

From `dotfiles/cli-tools/shell-aliases.zsh` — source from `.zshrc` or copy aliases:

| Alias | Replaces | Package (Ubuntu) |
|-------|----------|------------------|
| `ls` → `lsd` | GNU ls | `lsd` |
| `cat` → `batcat` | cat | `bat` (binary is `batcat` on Ubuntu) |

Add to `.zshrc`:

```bash
source ~/jbubuntu/dotfiles/cli-tools/shell-aliases.zsh
```

## PATH consolidation

`config/dev-environment/env-paths.sh` exports all runtime paths. Add to `.zshrc`:

```bash
source ~/jbubuntu/config/dev-environment/env-paths.sh
```

Includes: `$HOME/.local/bin`, `$HOME/bin`, Atuin, Deno, Go (`$GOPATH/bin`), Composer vendor bin, NVM.

## Default browser

Set in `.zshrc`:

```bash
export BROWSER="flatpak run app.zen_browser.zen"
```

## Restore checklist

1. Install zsh, kitty, starship, fastfetch, lsd, bat
2. Install Oh My Zsh + plugins
3. Copy `dotfiles/zsh/.zshrc`, starship.toml, fastfetch config, kitty.conf
4. Install Atuin, NVM, Deno; run versions from `config/dev-environment/runtimes/`
5. Source `env-paths.sh` or merge PATH lines into `.zshrc`
6. Set kitty shortcut: run `scripts/apply-gnome-config.sh` or set Ctrl+Alt+T manually

## Related docs

- [dev-environment-and-credentials.md](dev-environment-and-credentials.md)
- [shortcuts-and-keybindings.md](shortcuts-and-keybindings.md)
- [installation-and-removal/python-and-runtimes.md](installation-and-removal/python-and-runtimes.md)
