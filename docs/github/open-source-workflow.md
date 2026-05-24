# Open-source workflow & repo security

How to use GitHub as an open-source developer and **prevent unwanted pushes** to your code.

---

## Who can push to your repo?

| Repo type | Default push access |
|-----------|---------------------|
| **Public** | Only you and collaborators you invite |
| **Private** | Only you and collaborators |
| **Random strangers** | **Cannot push to main** unless you gave them write access |

Strangers can:
- **Fork** your repo (copy to their account)
- **Open Pull Requests** (propose changes for you to review)
- **Open Issues**

They **cannot** directly push to your `main` unless they are a collaborator with write access.

---

## Protect `main` — branch protection rules

**Settings → Branches → Add branch ruleset** (or "Branch protection rule") for `main`:

Recommended for public repos:

| Rule | Why |
|------|-----|
| **Require a pull request before merging** | No direct push to main |
| **Require approvals (1+)** | Someone must review (you can self-approve on solo projects) |
| **Require status checks to pass** | CI must be green before merge |
| **Require conversation resolution** | All PR comments addressed |
| **Do not allow bypassing** | Even admins follow rules |
| **Restrict who can push** | Only specific people/teams |
| **Block force pushes** | Prevents history rewrite on main |

After this, even **you** should use branches + PRs to change `main` (good habit).

### Solo developer on public repo

Minimum protection:
- Block force pushes to `main`
- Require PR for merging (optional but recommended)

You can approve your own PRs — still gives you a review checkpoint.

---

## Collaboration roles

**Settings → Collaborators and teams**

| Role | Can push to main | Can change settings |
|------|------------------|---------------------|
| **Read** | No | No |
| **Triage** | No | Issues/PRs only |
| **Write** | Yes (unless branch protected) | No |
| **Maintain** | Yes + some settings | Partial |
| **Admin** | Yes | Yes |

For open source: give **Write** only to trusted maintainers; everyone else contributes via **fork + PR**.

---

## Fork → PR workflow (how outsiders contribute safely)

```
Your repo (johnboscocjt/jbubuntu)
        ↑
   Pull Request (you review & merge)
        ↑
Contributor's fork (their-copy/jbubuntu)
        ↑
   They push to their fork only
```

1. Contributor forks your repo on GitHub
2. Clones **their fork**: `git clone https://github.com/their-user/jbubuntu.git`
3. Creates branch, commits, pushes to **their fork**
4. Opens PR to **your** repo
5. **You review** — approve, request changes, or close
6. **You merge** — code enters your repo only when you accept

They never get direct push access unless you invite them.

---

## CODEOWNERS (auto-request reviewers)

Create `.github/CODEOWNERS`:

```
# Default owner for everything
* @johnboscocjt

# Specific paths
/docs/ @johnboscocjt
/setup.sh @johnboscocjt
```

When someone opens a PR touching those paths, GitHub automatically requests your review.

---

## Security hygiene

| Practice | How |
|----------|-----|
| **Never commit secrets** | No `.env`, SSH keys, API tokens — use `.gitignore` |
| **Use `gh auth login`** | Not passwords in URLs |
| **Enable 2FA** on GitHub account | Settings → Password and authentication |
| **Review Dependabot alerts** | Security → Dependabot |
| **Sign commits** (optional) | GPG signing for verified commits |
| **Audit collaborators** | Remove inactive write access |

Your `jbubuntu` repo already excludes secrets in `.gitignore`.

---

## Issues & discussions

| Tool | Use for |
|------|---------|
| **Issues** | Bug reports, feature requests, tasks |
| **Discussions** | Q&A, ideas, community chat |
| **Projects** | Kanban boards for roadmap |

Templates in `.github/ISSUE_TEMPLATE/` standardize bug reports.

---

## Releases & tags

```bash
git tag -a v1.0.0 -m "First stable restore script"
git push origin v1.0.0
gh release create v1.0.0 --title "v1.0.0" --notes "Initial release"
```

Tags mark stable points; releases attach binaries/notes for users.
