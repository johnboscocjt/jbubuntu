# Static sites & documentation projects

Simple projects with no backend — HTML/CSS/JS, MkDocs, VitePress, or plain GitHub Pages.

---

## Plain HTML / CSS / JS

```bash
mkdir -p ~/src/github/johnboscocjt/my-site
cd ~/src/github/johnboscocjt/my-site
# add index.html, style.css, script.js
git init && git add . && git commit -m "Initial site"
```

**Preview locally:**

```bash
# Option 1: Python built-in server
python3 -m http.server 8080
# → http://localhost:8080

# Option 2: VS Code Live Server extension (already installed)
# Right-click index.html → Open with Live Server

# Option 3: npx
npx serve .
```

---

## Vite static site

```bash
npm create vite@latest my-site -- --template vanilla
cd my-site
npm install
npm run dev
npm run build    # output in dist/
```

---

## MkDocs (Python documentation)

```bash
cd ~/src/github/johnboscocjt
python3 -m venv venv && source venv/bin/activate
pip install mkdocs mkdocs-material

mkdocs new my-docs
cd my-docs
mkdocs serve     # → http://127.0.0.1:8000
mkdocs build     # output in site/
```

---

## Deploy to GitHub Pages

1. Build static output (`dist/`, `site/`, or docs folder)
2. Push to `gh-pages` branch or use GitHub Actions

See [`docs/github/ci-cd.md`](../github/ci-cd.md) for GitHub Pages workflow example.

```bash
gh repo create johnboscocjt/my-site --public --source=. --push
# Settings → Pages → Deploy from branch gh-pages
```

---

## Obsidian vault as docs (your setup)

Your vaults are registered in [`config/obsidian/obsidian.json`](../../config/obsidian/obsidian.json).

Clone vault repo separately:

```bash
cd ~/Documents/mydocs
git clone https://github.com/johnboscocjt/AIcourseVault.git
```

Open in Obsidian → vault path points to cloned folder.

---

## Quick reference

| Type | Dev command | Build output |
|------|-------------|--------------|
| Plain HTML | `python3 -m http.server` | N/A |
| Vite | `npm run dev` | `dist/` |
| MkDocs | `mkdocs serve` | `site/` |
| Next.js static export | `npm run build` | `out/` |

No database or PHP required for these project types.
