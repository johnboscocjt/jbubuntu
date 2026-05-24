# Development

IDEs, editors, API clients, containers, version control, and build tooling for software development on this workstation.

**Related config:** [`config/ide/`](../../config/ide/) · **Install manifests:** [`data/apt-packages.txt`](../../data/apt-packages.txt), [`data/snap-apps.txt`](../../data/snap-apps.txt)

---

## AI & modern IDEs

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Cursor** | `cursor` | APT ([Cursor repo](../../data/apt-third-party.sh)) | AI-native code editor forked from VS Code | Primary Laravel/PHP development with AI-assisted coding | Edit `.php`/`.blade.php`, agent workflows, PHP debugging, format-on-save |
| **Windsurf** | `windsurf` | APT | AI IDE by Codeium (VS Code fork) | Secondary AI coding environment | Same stack as VS Code with Windsurf-specific AI features |
| **VS Code** | `code` | APT ([Microsoft repo](../../data/apt-third-party.sh)) | Microsoft's extensible code editor | General editing, extension testing, non-AI fallback IDE | Open repos, run Live Server, Thunder Client API tests |
| **Antigravity** | `antigravity` | APT | Lightweight editor/utility (Python easter-egg package) | Humor / minimal use | Rarely used; installed as part of dev tooling |
| **OpenCode** | `open-code` | APT | Open-source AI coding assistant CLI/IDE hybrid | Experimental AI workflows | Quick AI-assisted edits outside main IDEs |

---

## Classic IDEs & editors

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **PhpStorm** | `phpstorm` | Snap | JetBrains PHP IDE | Deep PHP/Laravel refactoring when Snap version is preferred | Navigate large codebases, run PHPUnit, database tools |
| **PyCharm Community** | `pycharm-community` | Snap | JetBrains Python IDE | Python scripts, Django projects | Debug Python, manage virtualenvs, run `python3-django` apps |
| **IntelliJ IDEA** | `IdeaIC2025.1`, `IntelliJIdea2024.3` | JetBrains Toolbox / manual | JetBrains Java/Kotlin IDE | JVM projects, Rider companion | Build Java/Kotlin apps, Gradle/Maven projects |
| **Rider** | `Rider2024.3`, `Rider2025.1` | JetBrains Toolbox / manual | JetBrains .NET IDE | C# / Unity / .NET development | Open `.csproj`, debug .NET apps |
| **Sublime Text** | `sublime-text` | APT + `/opt/sublime_text` | Fast minimalist text editor | Quick file edits, large log files | Open single files, regex search/replace, scratch notes |
| **Neovim** | `neovim` | APT | Modal terminal editor | Remote/server editing, quick terminal edits | Edit configs over SSH, `:wq` workflow |
| **Vim (GTK)** | `vim-gtk3` | APT | GUI-capable Vim | Fallback editor when GUI~ is available | Edit files with mouse support |
| **Micro** | `io.github.zyedidia.micro` | Flatpak | Terminal editor with Ctrl+S/Ctrl+Q bindings | Friendly nano alternative in terminal | Quick config edits with mouse and menus |
| **Packet Tracer** | `packettracer` | APT + `/opt/pt` | Cisco network simulation (licensed) | Networking coursework and lab topology design | Build LAN/WLAN topologies, simulate routing |

---

## API clients & testing

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Bruno** | `/opt/Bruno` | Manual `/opt/` | Open-source API client (Postmanually alternative) | REST/GraphQL testing for Laravel backends | Save collections, send auth headers, test endpoints |
| **Postman** | `/opt/Postman` | Manual `/opt/` | Full-featured API platform | Complex API workflows, team collections | Import OpenAPI specs, environment variables |
| **Thunder Client** | VS Code extension | Marketplace | Lightweight REST client inside VS Code | Quick API calls without leaving the editor | Test Laravel routes from VS Code sidebar |
| **Postman for VS Code** | VS Code extension | Marketplace | Postman integration in VS Code | Sync Postman collections in-editor | Run saved requests alongside code |

See also: [ide-extensions/vscode.md](../ide-extensions/vscode.md) for API-related extensions.

---

## Containers & virtualization

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Docker Desktop** | `docker-desktop` | APT `.deb` + `/opt/docker-desktop` | GUI + engine for containers | Local dev databases, Laravel Sail, microservices | `docker compose up`, pull images, manage volumes |
| **QEMU** | `qemu-system-x86` | APT | x86 system emulator | VM testing, cross-arch builds | Boot test ISOs, emulate other OS environments |

---

## Version control

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Git** | `git` | APT | Distributed version control | All project source management | `commit`, `push`, `pull`, branch workflows |
| **GitHub CLI** | `gh` | APT | Official GitHub command-line tool | PRs, issues, HTTPS git credentials | `gh pr checkout`, `gh auth login`, create repos |
| **GitKraken** | `gitkraken` | Snap | GUI git client | Visual history, merge conflict resolution | Browse commit graph, resolve merges |
| **GitHub Desktop** | `io.github.shiftey.Desktop` | Flatpak | Simple GitHub-focused GUI | Quick clone/push for GitHub repos | Clone `johnboscocjt/*` repos, stage/commit |

**Related config:** [`config/dev-environment/git/.gitconfig`](../../config/dev-environment/git/.gitconfig), [`config/dev-environment/gh/config.yml`](../../config/dev-environment/gh/config.yml)

---

## Runtimes (CLI — see also dev-environment category)

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Node.js** | `nodejs` | APT (system) + NVM | JavaScript runtime | npm scripts, frontend tooling | `npm run dev`, install global CLIs |
| **Go** | `golang-go` | APT | Go compiler and toolchain | CLI tools via `go install` | Build Go binaries to `~/go/bin` |
| **Python 3** | `python3-all`, `python3-pip`, `python3-venv` | APT | System Python 3.12+ | Scripts, pipx tools, Django | Run `python3`, create venvs |
| **PHP** | `php` | APT | PHP CLI interpreter | Laravel Artisan, Composer, global tools | `php artisan`, `composer install` |

Full runtime restore details: [dev-environment-and-credentials/README.md](../dev-environment-and-credentials/README.md)

---

## Build tools & compilers

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **build-essential** | `build-essential` | APT | Meta-package: gcc, g++, make, libc-dev | Compiling C/C++ extensions, native npm modules | `make`, compile PHP extensions, build from source |
| **GCC** | `gcc`, `gcc-12` | APT | GNU C compiler | Native compilation | Build kernel modules, compile C projects |
| **Clang** | `clang` | APT | LLVM C/C++ compiler | Alternative compiler, some projects prefer clang | `clang` builds, LLVM tooling |
| **CMake** | `cmake` | APT | Cross-platform build system generator | C/C++ projects using CMakeLists.txt | `cmake .. && make` |
| **Make** | `make` | APT | Build automation | Makefile-driven projects | Run project Makefiles |
| **pkg-config** | `pkg-config` | APT | Library dependency resolver | Finding compile flags for libraries | `pkg-config --libs libssl` |

---

## IDE extensions

Extension lists are maintained separately and restored from [`config/ide/`](../../config/ide/):

| Editor | Count | Guide |
|--------|-------|-------|
| VS Code | 81 | [ide-extensions/vscode.md](../ide-extensions/vscode.md) |
| Cursor | 39 | [ide-extensions/cursor.md](../ide-extensions/cursor.md) |
| Windsurf | 2 | [ide-extensions/windsurf.md](../ide-extensions/windsurf.md) |
