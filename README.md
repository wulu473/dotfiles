# Dotfiles

Personal configuration for the command line tools I use day-to-day.
Used on macOS as the daily driver and on Linux purely over SSH.
The repository is deployed into `$HOME` as a set of dotfile symlinks by the [`dotfiles`](https://pypi.org/project/dotfiles/) Python tool.

## Install / sync

Fresh checkout, or any other time:

```
./sync
```

`sync` is a single Python file (~130 lines, no third-party dependencies).
It is idempotent, makes no prompts, and is safe to run as often as you like.

For every entry of the repo (minus the `IGNORE` set at the top of `sync`) it computes the target as `~/.<entry>` and:

- already a correct symlink: skip silently.
- wrong symlink: replace.
- missing: create.
- real file/dir: rename to `~/.<entry>-YYYY-MM-DD.bkp` (with `.2.bkp`, `.3.bkp`, ... if the day's first slot is taken), then symlink. Log loudly.

Two special cases live in `sync` as small constants:

- `PACKAGES`: directories whose **contents** get linked into an existing `$HOME` directory rather than the directory itself. Used for `ssh/` so that `ssh/config` becomes `~/.ssh/config` without disturbing keys, `known_hosts`, etc.
- `EXTERNALS`: arbitrary repo paths mapped to arbitrary destinations outside `$HOME`. Used on macOS for VS Code (`vscode/{settings,keybindings}.json` -> `~/Library/Application Support/Code/User/...`).

The "back up and link" behaviour means an OS-introduced conflict (e.g. macOS auto-creating a fresh `~/.zshrc` skeleton during an OS upgrade) is handled automatically next time you run `sync`. The backup file is dated and never gets sourced or read by anything: pull anything you want from it, then delete it.

## Repository layout

### Shell startup

The shell startup chain is split so that machine-specific or OS-specific overrides can be layered on top of the shared configuration.

The order is the same in every entry point: **`rc` -> `<shell>-<os>` -> `<shell>-local`**. Local always wins.

| File | Symlinked as | Purpose |
| --- | --- | --- |
| `rc` | `~/.rc` | Cross-platform interactive-shell defaults: `USR_OPT`, `PATH` additions for `~/bin` and `~/.local/bin`, `ghcup` env. Sourced by `bashrc`, `zshrc`, and `profile`. |
| `profile` | `~/.profile` | Login-shell entry point. |
| `profile-macos` | `~/.profile-macos` | macOS login extras: `CLICOLOR=1`, `PDF_READER=open`. |
| `bashrc` | `~/.bashrc` | Interactive bash entry point. |
| `bashrc-macos` | `~/.bashrc-macos` | macOS bash extras (currently empty). |
| `zshrc` | `~/.zshrc` | Interactive zsh entry point. Bootstraps oh-my-zsh. |
| `zshrc-macos` | `~/.zshrc-macos` | macOS zsh extras: `/usr/local/bin` and `/opt/bin` on PATH, `PDFREADER=open`. |

Machine-specific files that are NOT tracked in the repo:

- `~/.bashrc-local`
- `~/.zshrc-local`
- `~/.profile-local`

Third-party installer lines (uv, Antigravity, conda, etc.) belong in the `*-local` files, not in the tracked ones.

### Tooling configuration

| File / dir | Symlinked as | Purpose |
| --- | --- | --- |
| `gitconfig` | `~/.gitconfig` | Shared git config: aliases, colour, diff/merge, push/pull defaults, LFS, OAuth credential helper. Identity is provided via `includeIf` (see "Git identity" below). |
| `gitconfig-personal` | `~/.gitconfig-personal` | Personal identity (used by default for repos under `~/`). |
| `gitconfig-work` | `~/.gitconfig-work` | Work identity (used for repos under `~/work/`). Overrides personal. |
| `gitignore_global` | `~/.gitignore_global` | Global gitignore: OS junk, editor noise, `__pycache__`, etc. |
| `tmux.conf` | `~/.tmux.conf` | Tmux configuration: `C-j` prefix, vi copy-mode, status bar theme. Uses tmux >= 2.9 syntax. |
| `aerospace.toml` | `~/.aerospace.toml` | [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling window manager config (macOS). |
| `ssh/config` | `~/.ssh/config` | SSH client config (file-level symlink, leaves the rest of `~/.ssh/` untouched). |
| `vscode/` | (handled by `sync`) | VS Code user settings and keybindings, symlinked into `~/Library/Application Support/Code/User/` on macOS. |

### Git identity

Identity is committed to the repo, in two files that get symlinked into `$HOME`:

- `gitconfig-personal` -> `~/.gitconfig-personal`. Default identity, used for repos under `~/`.
- `gitconfig-work` -> `~/.gitconfig-work`. Override, used for repos under `~/work/`.

The split is wired up by `includeIf` in [gitconfig](gitconfig):

```ini
[includeIf "gitdir:~/"]
	path = ~/.gitconfig-personal
[includeIf "gitdir:~/work/"]
	path = ~/.gitconfig-work
```

The more specific match wins, so cloning a work repo into `~/work/something` automatically uses the work identity.
To change either identity, just edit the file in the repo (the symlink resolves there) and commit.

`gitconfig` also sets some global defaults:

- `init.defaultBranch = main`
- `pull.ff = only`
- `push.autoSetupRemote = true`
- `rerere.enabled = true`
- `diff.algorithm = histogram`, `diff.colorMoved = zebra`
- `merge.conflictStyle = zdiff3`
- `core.excludesfile = ~/.gitignore_global`

### Deployment metadata

| File | Purpose |
| --- | --- |
| `sync` | Single-file Python script that deploys the repo to `$HOME`. Idempotent. No deps beyond Python 3 stdlib. |
| `.gitignore` | Ignores SSH keys and OS junk. |

## Conventions

- **No prompts in sync.** All preferences live in tracked files. If sync would ever need to ask, the answer should be encoded in the repo instead.
- **Cross-platform first.** Anything common goes in `rc`, `bashrc`, `zshrc`, `profile`, etc. macOS-specific bits go in the matching `*-macos` file. There are no `*-linux` files: Linux is SSH-only and has no GUI/desktop config in this repo.
- **Machine-specific things stay out of the repo.** Use `~/.bashrc-local`, `~/.zshrc-local`, `~/.profile-local`. If `sync` finds a real (non-symlink) `~/.<file>` in the way, it backs it up to `~/.<file>-YYYY-MM-DD.bkp` and links the tracked version in. Backups are never sourced or otherwise read; they're just there for you to grep through if you want.
- **Sourcing order is uniform.** `rc` first (cross-platform), then platform, then local. Local always wins.
- **Secrets never go in the repo.** SSH private keys live under `~/.ssh/` (not the repo's `ssh/` directory: that one only holds the `config` file, which sync symlinks in).
