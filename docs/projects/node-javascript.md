# Node.js / JavaScript project setup

React, Next.js, Vue, Express, and other Node projects on your stack (NVM Node 24, optional PostgreSQL/MongoDB, Cursor/VS Code).

---

## Prerequisites (system-wide)

```bash
cd ~/jbubuntu && ./setup.sh   # installs NVM, Node, git, gh

# Verify
source ~/.nvm/nvm.sh
node -v    # v24.x from config/dev-environment/runtimes/
npm -v
```

Optional databases (if backend needs them):

```bash
sudo systemctl enable --now postgresql redis-server
# MongoDB: see config/system-services/databases/RESTORE.md
```

---

## 1. Project location

```bash
mkdir -p ~/src/github/johnboscocjt
cd ~/src/github/johnboscocjt
```

---

## 2. New project examples

### Vite + React

```bash
npm create vite@latest my-react-app -- --template react-ts
cd my-react-app
npm install
npm run dev
# → http://localhost:5173
```

### Next.js

```bash
npx create-next-app@latest my-next-app
cd my-next-app
npm run dev
# → http://localhost:3000
```

### Express API

```bash
mkdir my-api && cd my-api
npm init -y
npm install express
# create index.js, then:
node index.js
```

### Clone existing repo

```bash
git clone https://github.com/johnboscocjt/my-frontend.git
cd my-frontend
npm install          # or pnpm install / yarn
cp .env.example .env.local
npm run dev
```

---

## 3. Node version per project

```bash
cd my-project
echo "24" > .nvmrc
nvm use
# or
nvm install $(cat .nvmrc)
```

Commit `.nvmrc` so all machines use the same Node version.

---

## 4. Environment variables

| File | Committed? | Purpose |
|------|------------|---------|
| `.env.example` | Yes | Template |
| `.env.local` | No | Local secrets (Next.js) |
| `.env` | No | Vite/Express local config |

Example `.env.local` (Next.js):

```env
DATABASE_URL=postgresql://laravel:password@localhost:5432/myapp
NEXT_PUBLIC_API_URL=http://localhost:3000
```

---

## 5. With PostgreSQL backend

```bash
sudo -u postgres createdb myapp
npm install pg          # or use Prisma/Drizzle
```

Prisma example:

```bash
npm install prisma @prisma/client
npx prisma init
# edit DATABASE_URL in .env
npx prisma migrate dev
```

---

## 6. With MongoDB

```bash
# Ensure mongod is running
npm install mongodb
# or mongoose
```

Connection string in `.env`:

```env
MONGODB_URI=mongodb://127.0.0.1:27017/myapp
```

---

## 7. IDE setup

```bash
cursor .
```

Your restored extensions include:
- ES7 React Snippets, Prettier, ESLint (via VS Code defaults)
- Tailwind CSS IntelliSense
- TypeScript support

Recommended `.vscode/extensions.json` in project:

```json
{
  "recommendations": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "bradlc.vscode-tailwindcss"
  ]
}
```

---

## 8. Common scripts

| Script | Typical command |
|--------|-----------------|
| Dev server | `npm run dev` |
| Production build | `npm run build` |
| Preview build | `npm run preview` |
| Tests | `npm test` |
| Lint | `npm run lint` |

---

## 9. Full-stack: Laravel API + React frontend

**Terminal 1 — Laravel** (see [laravel.md](laravel.md)):

```bash
cd ~/src/github/johnboscocjt/my-api
php artisan serve --port=8000
```

**Terminal 2 — Frontend:**

```bash
cd ~/src/github/johnboscocjt/my-frontend
echo "VITE_API_URL=http://127.0.0.1:8000" > .env.local
npm run dev
```

Configure Laravel CORS in `config/cors.php` for `http://localhost:5173`.

---

## Quick reference

```bash
git clone <repo>
cd <repo>
nvm use
npm install
cp .env.example .env.local
npm run dev
```
