# VS Code IDE Extensions

81 extensions installed in Visual Studio Code, grouped by purpose. VS Code is the **full-featured fallback IDE** with React Native, API clients, database tools, and GitHub Copilot.

**Manifest:** [`config/ide/vscode/extensions.txt`](../../config/ide/vscode/extensions.txt) · **Settings:** [`config/ide/vscode/settings.json`](../../config/ide/vscode/settings.json) · **Keybindings:** [`config/ide/vscode/keybindings.json`](../../config/ide/vscode/keybindings.json)

---

## Laravel, PHP & Blade

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Laravel Extension Pack** | `onecentlin.laravel-extension-pack` | Marketplace | Meta-pack of Laravel extensions | One-shot Laravel setup | Install core Laravel tooling bundle |
| **Laravel** | `laravel.vscode-laravel` | Marketplace | Official Laravel extension | Artisan, routes, env, Blade | Run `php artisan` from command palette |
| **Laravel Extra Intellisense** | `amiralizadeh9480.laravel-extra-intellisense` | Marketplace | Enhanced Laravel autocomplete | Facades, config, validation rules | Complete `Route::`, `config()` keys |
| **Laravel Artisan** | `ryannaddy.laravel-artisan` | Marketplace | Artisan command runner | Execute Artisan without terminal | `migrate`, `make:model` from VS Code |
| **Laravel Goto View** | `codingyu.laravel-goto-view` | Marketplace | Jump to Blade views | Navigate `view()` references | Open matching `.blade.php` |
| **Laravel Goto Components** | `naoray.laravel-goto-components` | Marketplace | Jump to Blade components | Component tag → class/file | Navigate `<x-layout>` definitions |
| **Laravel Jump Controller** | `pgl.laravel-jump-controller` | Marketplace | Route → controller navigation | Follow route definitions | Jump from route list to controller method |
| **Laravel Create View** | `glitchbl.laravel-create-view` | Marketplace | Scaffold Blade views | Quick view file creation | Create view from controller return |
| **Laravel 5 Snippets** | `onecentlin.laravel5-snippets` | Marketplace | Laravel snippets | Boilerplate shortcuts | Snippet expansion for MVC pieces |
| **Laravel Blade** | `onecentlin.laravel-blade` | Marketplace | Blade language basics | Syntax for `.blade.php` | Highlight `@section`, `@yield` |
| **Laravel Blade Wrapper** | `ihunte.laravel-blade-wrapper` | Marketplace | Wrap in Blade directives | `@if`, `@foreach` wrapping | Wrap selected HTML in Blade |
| **Blade Formatter** | `shufo.vscode-blade-formatter` | Marketplace | Blade/HTML formatter | Consistent view formatting | Format-on-save for Blade files |
| **Laravel Pint** | `open-southeners.laravel-pint` | Marketplace | Laravel Pint runner | PHP style fixer | Fix PSR-12/Laravel style on save |
| **Format HTML in PHP** | `rifi2k.format-html-in-php` | Marketplace | Format HTML embedded in PHP | Mixed PHP/HTML files | Clean legacy PHP templates |
| **Livewire Docs** | `austenc.livewire-docs` | Marketplace | Livewire documentation inline | Livewire API reference | Hover help for Livewire directives |
| **Livewire for VS Code** | `cierra.livewire-vscode` | Marketplace | Livewire tooling | Component discovery | Navigate Livewire classes/views |
| **Livewire Goto Updated** | `lennardv.livewire-goto-updated` | Marketplace | Updated Livewire navigation | Jump to Livewire components | Open component from tag |
| **TALL Stack** | `entexa.tall-stack` | Marketplace | TALL stack snippets/helpers | Tailwind/Alpine/Laravel/Livewire | Scaffold TALL stack patterns |
| **Intelephense** | `bmewburn.vscode-intelephense-client` | Marketplace | PHP language server | Autocomplete, indexing | Navigate Laravel codebase |
| **PHP Intelephense (zobo)** | `zobo.php-intellisense` | Marketplace | Alternate PHP IntelliSense | Backup/complement Intelephense | PHP completions where needed |
| **PHP Tools** | `devsense.phptools-vscode` | Marketplace | DevSense PHP IDE suite | Refactoring, debugging | Rename class, code lenses |
| **IntelliPHP** | `devsense.intelli-php-vscode` | Marketplace | AI PHP completions | Smart inline suggestions | Faster PHP typing |
| **Composer (DevSense)** | `devsense.composer-php-vscode` | Marketplace | Composer.json intel | Dependency insight | Version hints in composer.json |
| **PHP Profiler** | `devsense.profiler-php-vscode` | Marketplace | PHP profiling | Performance analysis | Profile slow endpoints |
| **PHP CS Fixer** | `junstyle.php-cs-fixer` | Marketplace | PHP CS Fixer integration | Code style (pre-Pint alternative) | Fix coding standards |
| **phpfmt** | `kokororin.vscode-phpfmt` | Marketplace | PHP formatter | Format PHP files | Alternative PHP formatting |
| **PHP Namespace Resolver** | `mehedidracula.php-namespace-resolver` | Marketplace | Import PHP namespaces | Auto-import classes | Sort `use` statements |
| **PHP DocBlocker** | `neilbrayfield.php-docblocker` | Marketplace | Generate docblocks | PHPDoc for methods | Type `/**` + Enter on function |
| **PHP Debug** | `xdebug.php-debug` | Marketplace | Xdebug 3 debugger | Breakpoints, step debugging | Debug Laravel with Xdebug |
| **PHP Debug Pack** | `xdebug.php-pack` | Marketplace | PHP debug extension bundle | Debug + related tools | Complete PHP debug setup |
| **PHP Server** | `brapifra.phpserver` | Marketplace | Built-in PHP server | Quick `php -S` launcher | Serve folder without Artisan |

---

## Livewire, Alpine & TALL frontend (in Blade)

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Alpine.js IntelliSense** | `adrianwilczynski.alpine-js-intellisense` | Marketplace | Alpine autocomplete | `x-data`, `@click` in Blade | Complete Alpine directives |
| **Alpine IntelliSense** | `pcbowers.alpine-intellisense` | Marketplace | Alternate Alpine support | Alpine in HTML/Blade | Directive completions |
| **Alpine.js Syntax Highlight** | `sperovita.alpinejs-syntax-highlight` | Marketplace | Alpine syntax colors | Readable Alpine in views | Highlight `x-show`, `x-bind` |
| **Tailwind CSS IntelliSense** | `bradlc.vscode-tailwindcss` | Marketplace | Tailwind class completion | Blade/HTML class attrs | Autocomplete utilities, `@apply` |
| **Bootstrap 5** | `anbuselvanrocky.bootstrap5-vscode` | Marketplace | Bootstrap 5 snippets/classes | Bootstrap-based admin UIs | Snippet `b5-` prefixes |
| **Bootstrap 4** | `thekalinga.bootstrap4-vscode` | Marketplace | Bootstrap 4 support | Legacy Bootstrap projects | BS4 class completion |
| **HTML CSS Support** | `ecmel.vscode-html-css` | Marketplace | Class/id completion | Link HTML to CSS | Autocomplete from stylesheets |
| **CSS Peek** | `pranaygp.vscode-css-peek` | Marketplace | Peek CSS definitions | Jump to CSS from class name | F12 on class name → CSS file |
| **CSS Formatter** | `aeschli.vscode-css-formatter` | Marketplace | CSS formatting | Clean stylesheets | Format `.css` on save |

---

## React, JavaScript & TypeScript

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **ES7+ React Snippets** | `dsznajder.es7-react-js-snippets` | Marketplace | React snippet pack | `rafce`, hook snippets | Scaffold React components |
| **Simple React Snippets** | `burkeholland.simple-react-snippets` | Marketplace | Minimal React snippets | Quick JSX boilerplate | Create functional components |
| **React Snippets (xabikos)** | `xabikos.reactsnippets` | Marketplace | React code snippets | Alternate snippet set | Expand React patterns |
| **React TypeScript** | `infeng.vscode-react-typescript` | Marketplace | React + TS support | Typed React projects | TSX IntelliSense |
| **React Native Tools** | `msjsdiag.vscode-react-native` | Marketplace | React Native debugger/tools | Mobile RN projects | Debug RN, run on emulator |
| **React Native Snippets** | `jundat95.react-native-snippet` | Marketplace | RN snippet pack | Mobile component boilerplate | Snippet RN screens |
| **React Native Redux** | `equimper.react-native-react-redux` | Marketplace | RN + Redux snippets | State management patterns | Redux boilerplate in RN |
| **JavaScript Snippets** | `xabikos.javascriptsnippets` | Marketplace | General JS snippets | Vanilla JS helpers | Common JS patterns |
| **JavaScript Snippet Pack** | `akamud.vscode-javascript-snippet-pack` | Marketplace | Extra JS snippets | ES6+ shortcuts | Arrow functions, promises |
| **Language Babel** | `mgmcdermott.vscode-language-babel` | Marketplace | JSX/Flow syntax | Modern JS in VS Code | Parse JSX outside `.jsx` |
| **TypeScript Nightly** | `ms-vscode.vscode-typescript-next` | Marketplace | Bleeding-edge TS | Latest TS features | Preview TS 5.x features |
| **JS Debug Nightly** | `ms-vscode.js-debug-nightly` | Marketplace | Modern JS debugger | Debug Node/browser JS | Breakpoints in Vite bundles |
| **Auto Import** | `steoates.autoimport` | Marketplace | Auto-import JS modules | ES module imports | Import on symbol use |
| **Auto Import (nucllear)** | `nucllear.vscode-extension-auto-import` | Marketplace | Alternate auto-import | TS/JS import suggestions | Add missing imports |
| **npm Intellisense** | `christian-kohler.npm-intellisense` | Marketplace | npm package autocomplete | `import from 'pkg'` | Complete package names in imports |
| **Path Intellisense** | `christian-kohler.path-intellisense` | Marketplace | File path autocomplete | Relative import paths | `./components/` completion |

---

## HTML, XML & markup utilities

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **HTML Snippets** | `abusaidm.html-snippets` | Marketplace | HTML snippet pack | Faster HTML authoring | Expand HTML5 structures |
| **HTML5 Boilerplate** | `sidthesloth.html5-boilerplate` | Marketplace | HTML5 boilerplate snippets | Starter HTML docs | `html:5` snippet |
| **HTML Preview** | `george-alisson.html-preview-vscode` | Marketplace | Preview HTML in editor | Static HTML preview | Preview without browser |
| **Auto Close Tag** | `formulahendry.auto-close-tag` | Marketplace | Auto-close tags | HTML/XML editing | Close `<div>` automatically |
| **Auto Complete Tag** | `formulahendry.auto-complete-tag` | Marketplace | Tag name completion | HTML tag suggestions | Complete tag names |
| **Auto Rename Tag** | `formulahendry.auto-rename-tag` | Marketplace | Rename paired tags | Sync open/close tags | Rename `<section>` both ends |
| **XML Tools** | `dotjoshjohnson.xml` | Marketplace | XML formatting/tools | Config XML, SVG | Format XML files |

---

## Formatting, lint & code quality

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Prettier** | `esbenp.prettier-vscode` | Marketplace | Opinionated formatter | JS/CSS/JSON/Markdown | Format-on-save |
| **EditorConfig** | `editorconfig.editorconfig` | Marketplace | EditorConfig support | Consistent indent across editors | Honor `.editorconfig` |
| **Error Lens** | `usernamehw.errorlens` | Marketplace | Inline diagnostics | See errors in-place | Fix without Problems panel |
| **Code Spell Checker** | `streetsidesoftware.code-spell-checker` | Marketplace | Spell check in code | Typos in strings/comments | Underline misspellings |
| **DotENV** | `mikestead.dotenv` | Marketplace | `.env` highlighting | Laravel environment files | Syntax color `.env` keys |

---

## API testing & dev servers

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Thunder Client** | `rangav.vscode-thunder-client` | Marketplace | Lightweight REST client | API testing in sidebar | Test Laravel API routes |
| **Postman for VS Code** | `postman.postman-for-vscode` | Marketplace | Postman in VS Code | Sync Postman collections | Run saved Postman requests |
| **Live Server** | `ritwickdey.liveserver` | Marketplace | Live reload static server | HTML/CSS/JS preview | Open with Live Server |
| **Five Server** | (Cursor only) | — | — | Use Live Server in VS Code | — |

---

## Database & backend services

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **DevDB** | `damms005.devdb` | Marketplace | In-editor DB browser | Query local databases | SELECT from MariaDB/Postgres |
| **Supabase** | `supabase.vscode-supabase-extension` | Marketplace | Supabase project integration | Supabase-backed projects | Manage Supabase schema, SQL |

---

## Markdown & documentation

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Markdown Mermaid** | `bierner.markdown-mermaid` | Marketplace | Mermaid in Markdown preview | Diagrams in README | Render ` ```mermaid ` blocks |
| **Mermaid Chart** | `mermaidchart.vscode-mermaid-chart` | Marketplace | Mermaid Chart integration | Advanced diagram authoring | Edit diagrams with Mermaid Chart |
| **Markdown Preview GitHub Styles** | `bierner.markdown-preview-github-styles` | Marketplace | GitHub-flavored MD preview | README preview matching GitHub | Preview docs before push |
| **markdownlint** | `davidanson.vscode-markdownlint` | Marketplace | Markdown lint rules | Consistent documentation style | Fix MD heading/list issues |

---

## Git, GitHub & AI

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **GitHub Copilot Chat** | `github.copilot-chat` | Marketplace | AI pair programming chat | Code explanations, generation | Ask about codebase in chat |
| **GitHub VS Code Theme** | `github.github-vscode-theme` | Marketplace | GitHub-inspired theme | Familiar GitHub color scheme | Dark/light GitHub theme |

---

## Icons & misc utilities

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Material Icon Theme** | `pkief.material-icon-theme` | Marketplace | File type icons | Visual file identification | Icons for `.blade.php`, `.env` |
| **Emoji** | `perkovec.emoji` | Marketplace | Emoji picker in editor | Insert emoji in docs/commits | `:rocket:` completion |

---

## Restore

```bash
xargs -a config/ide/vscode/extensions.txt -I {} code --install-extension {}
cp config/ide/vscode/settings.json ~/.config/Code/User/settings.json
cp config/ide/vscode/keybindings.json ~/.config/Code/User/keybindings.json
```

Configure Xdebug 3 in `php.ini` and add a `launch.json` for Laravel debugging.

---

## vs Cursor

VS Code includes **42 additional extensions** beyond Cursor — mainly React Native, API clients (Thunder Client, Postman), Copilot Chat, DevDB, Supabase, markdown tooling, and extra snippet packs. See [cursor.md](cursor.md) for the streamlined Cursor set.
