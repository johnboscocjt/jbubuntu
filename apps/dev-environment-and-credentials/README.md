# Dev Environment & Credentials

Runtimes, language toolchains, version control auth, shell history sync, and secret storage — how development tools are installed and authenticated on this workstation.

**Config tree:** [`config/dev-environment/`](../../config/dev-environment/) · **Security rule:** No private keys, tokens, or keyring files are committed.

---

## JavaScript / TypeScript

| Name | Package / path | Source | What it is | Used for | Typical tasks |
|------|----------------|--------|------------|----------|---------------|
| **NVM** | `~/.nvm/` | curl install script | Node Version Manager | Install/switch Node versions | `nvm install`, `nvm use` |
| **Node.js** | v24.15.0 (default) | NVM | JavaScript runtime | npm, Vite, frontend tooling | `npm run dev`, `npx` |
| **npm** | bundled with Node | NVM | Node package manager | Project and global JS packages | `npm install`, `npm run build` |
| **Deno** | `~/.deno/` | curl install | Modern JS/TS runtime | Scripts, some web tooling | `deno run`, `deno fmt` |

**Manifests:** [`config/dev-environment/runtimes/nvm-versions.txt`](../../config/dev-environment/runtimes/nvm-versions.txt), [`node-default.txt`](../../config/dev-environment/runtimes/node-default.txt), [`deno-version.txt`](../../config/dev-environment/runtimes/deno-version.txt)

---

## PHP & Composer

| Name | Package / path | Source | What it is | Used for | Typical tasks |
|------|----------------|--------|------------|----------|---------------|
| **PHP CLI** | `php` (8.5+) | APT | PHP command-line | Laravel Artisan, scripts | `php artisan migrate` |
| **Composer** | `~/.config/composer/` | global install | PHP dependency manager | Laravel/vendor packages | `composer install`, global tools |
| **PHP-FPM** | 8.3 + 8.4 services | APT | Web PHP pools | Apache/nginx PHP processing | See databases category |

**Manifest:** [`config/dev-environment/runtimes/php-version.txt`](../../config/dev-environment/runtimes/php-version.txt)

---

## Go, Python & other runtimes

| Name | Package / path | Source | What it is | Used for | Typical tasks |
|------|----------------|--------|------------|----------|---------------|
| **Go** | `golang-go`, `~/go/bin` | APT | Go toolchain | CLI tools via `go install` | Build binaries to `$GOPATH/bin` |
| **Python 3** | system + venv | APT | Python runtime | Scripts, Django, pipx | `python3`, `pip install --user` |
| **pipx** | `~/.local/share/pipx/` | APT | Isolated Python CLIs | Global Python apps | `pipx install pyqt5` |
| **pipenv** | `pipenv` | APT | Project virtualenv manager | Python project deps | `pipenv install` |

**Manifests:** [`go-version.txt`](../../config/dev-environment/runtimes/go-version.txt), [`python-version.txt`](../../config/dev-environment/runtimes/python-version.txt), [`pipx-packages.txt`](../../config/dev-environment/runtimes/pipx-packages.txt)

---

## Git & GitHub

| Name | Package / path | Source | What it is | Used for | Typical tasks |
|------|----------------|--------|------------|----------|---------------|
| **Git** | `git`, `~/.gitconfig` | APT | Version control | All source repos | commit, push, branch, LFS |
| **GitHub CLI** | `gh`, `~/.config/gh/` | APT | GitHub API from terminal | PRs, issues, HTTPS credentials | `gh pr create`, `gh auth login` |
| **Git LFS** | (via gitconfig) | git extension | Large file storage | Binary assets in git | `git lfs track *.psd` |

**Backed up:** [`config/dev-environment/git/.gitconfig`](../../config/dev-environment/git/.gitconfig), [`config/dev-environment/gh/config.yml`](../../config/dev-environment/gh/config.yml)

**NOT backed up:** `~/.config/gh/hosts.yml` (contains auth token) — run `gh auth login` after restore.

**Credential helper (from gitconfig):**
```gitconfig
[credential "https://github.com"]
    helper = !/usr/bin/gh auth git-credential
```

---

## Shell history — Atuin

| Name | Package / path | Source | What it is | Used for | Typical tasks |
|------|----------------|--------|------------|----------|---------------|
| **Atuin** | `~/.atuin/bin/atuin` | curl installer | Encrypted/syncable shell history | Search across sessions/machines | `Ctrl+R`, `atuin sync` |

**Config template:** [`config/dev-environment/atuin/config.toml.template`](../../config/dev-environment/atuin/config.toml.template) (sync keys stripped)

**Init:** `eval "$(atuin init zsh)"` in `.zshrc`

---

## Key storage & authentication

| Name | Package / path | Source | What it is | Used for | Typical tasks |
|------|----------------|--------|------------|----------|---------------|
| **GNOME Keyring / Seahorse** | `seahorse` | APT | Encrypted password storage | App passwords, certificates | Unlock keyring at login |
| **SSH keys** | `~/.ssh/` | user-generated | Public-key authentication | Git over SSH, server login | `ssh-keygen`, `ssh-add` |
| **GPG** | `~/.gnupg/` | APT `gnupg` | OpenPGP signing/encryption | Signed commits, encrypted email | `gpg --sign`, export public key |
| **Authenticator** | Flatpak | Flathub | TOTP 2FA app | GitHub, cloud 2FA codes | Scan QR, copy tokens |

> SSH private keys and GPG secret keys are **never** committed. Restore manually or regenerate.

---

## Docker & containers

| Name | Package / path | Source | What it is | Used for | Typical tasks |
|------|----------------|--------|------------|----------|---------------|
| **Docker Desktop** | `docker-desktop`, `~/.docker/` | APT `.deb` | Container platform | Local dev stacks, databases | `docker compose up`, pull images |

**NOT backed up:** `~/.docker/` login state — re-authenticate to Docker Hub after install.

---

## PATH exports (sanitized)

From [`config/dev-environment/env-paths.sh`](../../config/dev-environment/env-paths.sh) (when present) or `.zshrc`:

```bash
export NVM_DIR="$HOME/.nvm"
export DENO_INSTALL="$HOME/.deno"
export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.atuin/bin:$DENO_INSTALL/bin:$GOPATH/bin:$HOME/.config/composer/vendor/bin:$PATH"
export BROWSER="flatpak run app.zen_browser.zen"
```

---

## Restore checklist (new PC)

1. Run `setup.sh` runtime phase or install NVM, Deno, Go, PHP, Composer manually
2. Copy `.gitconfig` → `~/.gitconfig`
3. Copy `gh/config.yml` → `~/.config/gh/config.yml`, then `gh auth login`
4. Install Atuin, copy config template, optionally `atuin login`
5. Restore SSH public keys to GitHub; copy private keys securely (USB/password manager)
6. Import GPG public key to GitHub; restore secret key from secure backup
7. Install Docker Desktop, log in to registries
8. Run `composer global install` / `pipx install` from manifests

---

## Related categories

| Topic | Guide |
|-------|-------|
| IDE-specific tooling | [development/README.md](../development/README.md) |
| Database services | [databases-and-backend/README.md](../databases-and-backend/README.md) |
| Shell & terminal | [terminals-and-shell/README.md](../terminals-and-shell/README.md) |
| Modern CLI | [modern-cli-tools/README.md](../modern-cli-tools/README.md) |
