# Cursor IDE Extensions

39 extensions installed in Cursor, grouped by purpose. Cursor is the **primary AI IDE** for Laravel/PHP work on this workstation.

**Manifest:** [`config/ide/cursor/extensions.txt`](../../config/ide/cursor/extensions.txt) · **Settings:** [`config/ide/cursor/settings.json`](../../config/ide/cursor/settings.json) · **Keybindings:** [`config/ide/cursor/keybindings.json`](../../config/ide/cursor/keybindings.json)

---

## Laravel, PHP & Blade

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Laravel** | `laravel.vscode-laravel` | Marketplace | Official Laravel extension | Artisan, routes, env, Blade integration | Run Artisan commands, go to routes/controllers |
| **Laravel Extra Intellisense** | `amiralizadeh9480.laravel-extra-intellisense` | Marketplace | Enhanced Laravel autocomplete | Facades, config keys, validation rules | Autocomplete `config()`, `route()` names |
| **Laravel Goto View** | `codingyu.laravel-goto-view` | Marketplace | Jump to Blade views | Navigate view() calls | Ctrl+click view name → open `.blade.php` |
| **Laravel Goto Components** | `naoray.laravel-goto-components` | Marketplace | Jump to Blade components | Component class/tag navigation | Open `<x-*>` component definitions |
| **Laravel 5 Snippets** | `onecentlin.laravel5-snippets` | Marketplace | Laravel code snippets | Faster boilerplate | Snippet shortcuts for routes, controllers |
| **Laravel Blade** | `onecentlin.laravel-blade` | Marketplace | Blade syntax support | `.blade.php` highlighting | Edit templates with correct syntax |
| **Laravel Blade Wrapper** | `ihunte.laravel-blade-wrapper` | Marketplace | Wrap selection in Blade directives | Quick `@if`, `@foreach` wrapping | Wrap HTML block in Blade logic |
| **Blade Formatter** | `shufo.vscode-blade-formatter` | Marketplace | Opinionated Blade formatter | Consistent Blade/HTML indentation | Format-on-save for views |
| **Laravel Pint** | `open-southeners.laravel-pint` | Marketplace | Laravel Pint integration | PHP code style fixer | Format PHP to Laravel standards |
| **Livewire Support** | `doonfrs.livewire-support` | Marketplace | Livewire component tooling | Livewire class/view navigation | Edit Livewire components with IntelliSense |
| **Intelephense** | `bmewburn.vscode-intelephense-client` | Marketplace | PHP language server | Autocomplete, go-to-definition for PHP | Navigate Laravel classes, fix undefined types |
| **PHP Tools (DevSense)** | `devsense.phptools-vscode` | Marketplace | Full PHP IDE features | Refactoring, debugging integration | Rename symbols, code lenses |
| **IntelliPHP (DevSense)** | `devsense.intelli-php-vscode` | Marketplace | AI-assisted PHP completions | Smarter PHP suggestions | Inline completion in PHP files |
| **Composer (DevSense)** | `devsense.composer-php-vscode` | Marketplace | Composer.json integration | Dependency intel in editor | View package versions in composer.json |
| **PHP Profiler (DevSense)** | `devsense.profiler-php-vscode` | Marketplace | PHP performance profiling | Profile requests from IDE | Identify slow PHP functions |
| **Composer (ikappas)** | `ikappas.composer` | Marketplace | Composer script runner | Run composer scripts from sidebar | `composer dump-autoload`, require packages |
| **PHP Namespace Resolver** | `mehedidracula.php-namespace-resolver` | Marketplace | Import/fix PHP namespaces | Auto-import classes | Alt+insert import, sort uses |
| **PHP Debug** | `xdebug.php-debug` | Marketplace | Xdebug debugger | Breakpoints in PHP | Debug Laravel requests with Xdebug 3 |
| **PHP Debug (legacy)** | `felixfbecker.php-debug` | Marketplace | Alternate PHP debug adapter | Fallback debug support | Use if primary debug adapter conflicts |

---

## Frontend, CSS & Tailwind

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Tailwind CSS IntelliSense** | `bradlc.vscode-tailwindcss` | Marketplace | Tailwind class completion | Blade/HTML class autocomplete | `@apply`, arbitrary values, class sorting hints |
| **Tailwind Documentation** | `alfredbirk.tailwind-documentation` | Marketplace | Inline Tailwind docs | Look up utility classes without browser | Hover docs for `flex`, `grid`, spacing |
| **Tailwind Fold** | `stivo.tailwind-fold` | Marketplace | Fold long Tailwind class lists | Readable Blade templates | Collapse `class="..."` attribute clutter |
| **Windi CSS IntelliSense** | `voorjaar.windicss-intellisense` | Marketplace | Windi CSS class support | Projects using Windi | Autocomplete Windi utilities |
| **Bootstrap IntelliSense** | `hossaini.bootstrap-intellisense` | Marketplace | Bootstrap 5 class completion | Bootstrap-based UIs | Autocomplete `btn-`, `col-` classes |
| **HTML CSS Support** | `ecmel.vscode-html-css` | Marketplace | CSS class/id completion in HTML | Link HTML to CSS definitions | Autocomplete classes from stylesheets |
| **Alpine.js Syntax Highlight** | `devdojo.alpinejs-syntax-highlight` | Marketplace | Alpine directive highlighting | `@click`, `x-data` in Blade | Edit Alpine snippets in views |
| **Auto Close Tag** | `formulahendry.auto-close-tag` | Marketplace | Auto-close HTML/XML tags | Faster markup editing | Type `<div>` → auto `</div>` |
| **Auto Rename Tag** | `formulahendry.auto-rename-tag` | Marketplace | Rename paired HTML tags | Sync open/close tag names | Rename `<div>` → updates closing tag |
| **Highlight Matching Tag** | `vincaslt.highlight-matching-tag` | Marketplace | Highlight tag pairs | Visual matching bracket/tag | Locate closing Blade/HTML tag |
| **Language Babel** | `mgmcdermott.vscode-language-babel` | Marketplace | JSX/ES6+ syntax | JavaScript in Laravel/Vite projects | Highlight JS in mixed `.blade.php` + Vite files |

---

## Formatting, lint & quality

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Prettier** | `esbenp.prettier-vscode` | Marketplace | Code formatter | JS/CSS/JSON/Markdown formatting | Format-on-save for frontend assets |
| **Error Lens** | `usernamehw.errorlens` | Marketplace | Inline error/warning display | See diagnostics in-line | Fix PHP/JS errors without Problems panel |
| **Code Spell Checker** | `streetsidesoftware.code-spell-checker` | Marketplace | Spell check in code/comments | Catch typos in strings/docs/ | Underline misspelled docblocks |

---

## Dev servers & utilities

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Five Server** | `yandeu.five-server` | Marketplace | Live reload dev server | Preview static/Laravel public assets | Auto-refresh browser on save |
| **DotENV** | `mikestead.dotenv` | Marketplace | `.env` syntax highlighting | Laravel environment files | Edit `.env` with highlighting |
| **Voltage (Tailwind UI)** | `robsontenorio.voltage` | Marketplace | Volt/Livewire UI snippets | Livewire Volt component helpers | Scaffold Volt components |

---

## Java / Maven (secondary)

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Maven for Java** | `vscjava.vscode-maven` | Marketplace | Maven project support | Java/Maven projects when opened | Run Maven goals, manage pom.xml |

---

## Icons & themes

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Material Icon Theme** | `pkief.material-icon-theme` | Marketplace | File/folder icons | Visual file type identification | Distinguish `.blade.php`, `.php`, `.vue` |
| **Material Product Icons** | `pkief.material-product-icons` | Marketplace | Product-style file icons | Alternate icon set for UI chrome | Pair with Material Icon Theme |

---

## Restore

```bash
xargs -a config/ide/cursor/extensions.txt -I {} cursor --install-extension {}
cp config/ide/cursor/settings.json ~/.config/Cursor/User/settings.json
cp config/ide/cursor/keybindings.json ~/.config/Cursor/User/keybindings.json
```

Ensure Xdebug is configured in `php.ini` and Cursor `launch.json` for PHP debugging.

---

## vs VS Code

Cursor shares ~25 extensions with VS Code but **drops** React Native, Thunder Client, Copilot Chat, DevDB, Supabase, and most snippet packs — see [vscode.md](vscode.md) for the full 81-extension set.
