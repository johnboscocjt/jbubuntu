# Python and Language Runtimes

Install, locate, and remove Node, Python, Go, Deno, PHP, and related tooling.

## Manifest location

`config/dev-environment/runtimes/`:

| File | Contents |
|------|----------|
| `nvm-versions.txt` | Installed Node versions |
| `node-default.txt` | Default Node version |
| `deno-version.txt` | Deno version |
| `go-version.txt` | Go version |
| `php-version.txt` | PHP CLI version |
| `python-version.txt` | System Python version |
| `pipx-packages.txt` | pipx-isolated CLI tools |

PATH helper: `config/dev-environment/env-paths.sh`

## Node.js (NVM)

**Not APT** — managed by NVM in `~/.nvm/`

```bash
# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Install versions from manifest
source ~/.nvm/nvm.sh
nvm install v24.15.0
nvm alias default v24.15.0

# npm global packages
npm list -g --depth=0
npm uninstall -g package
```

**Find:** `which node`, `nvm which`, `~/.nvm/versions/node/`

## Deno

```bash
curl -fsSL https://deno.land/install.sh | sh
deno upgrade --version 2.6.8
```

**Path:** `~/.deno/bin/deno`

## Go

```bash
sudo apt install golang-go   # or specific version from go.dev
go install github.com/user/tool@latest   # → ~/go/bin/
```

**Find:** `go version`, `~/go/bin/`

## PHP + Composer

```bash
sudo apt install php-cli php-fpm composer
composer global require vendor/package
```

**Global bin:** `~/.config/composer/vendor/bin` (in PATH via env-paths.sh)

## Python

System Python from APT; project venvs are local.

```bash
python3 --version
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### pip (user install)

```bash
pip install --user package
# → ~/.local/lib/python3.x/site-packages/
```

### pipx (isolated CLIs)

```bash
pipx install pyqt5
pipx list
pipx uninstall pyqt5
```

From manifest:

```bash
while read -r pkg; do pipx install "$pkg"; done < config/dev-environment/runtimes/pipx-packages.txt
```

### pipenv / poetry

```bash
pipenv install
poetry install
```

Documented in project repos — not globally manifest.

## Rust / cargo

If installed:

```bash
cargo install ripgrep
# → ~/.cargo/bin/
```

## Ruby / gem

```bash
gem install jekyll --user-install
```

## Remove runtime cleanly

| Runtime | Remove |
|---------|--------|
| NVM Node | `nvm uninstall v24.15.0` |
| Deno | `rm -rf ~/.deno` |
| Go tools | `rm ~/go/bin/tool` |
| pipx | `pipx uninstall pkg` |
| pip user | `pip uninstall pkg` |
| Composer global | `composer global remove pkg` |
| venv | `rm -rf .venv` |

## Version pinning on restore

Match manifests before running project work:

```bash
source config/dev-environment/env-paths.sh
node -v    # expect v24.15.0
deno --version
go version
php -v
python3 --version
```

## Related

- [../dev-environment-and-credentials.md](../dev-environment-and-credentials.md)
- [../shell-and-terminals.md](../shell-and-terminals.md)
