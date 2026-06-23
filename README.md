# .files

Personal config files for macOS — shell, git, vim, and related tools.

## What's tracked

| File | Destination | Notes |
|------|-------------|-------|
| `.zshrc` | `~/.zshrc` | Main shell config |
| `.zsh_plugins.txt` | `~/.zsh_plugins.txt` | Antidote plugin list |
| `starship.toml` | `~/.config/starship.toml` | Prompt config |
| `.gitconfig` | `~/.gitconfig` | Git config (delta pager, etc.) |
| `.vimrc` | `~/.vimrc` | Vim config |
| `.zshenv.template` | reference only | Variable list with placeholders |

## What's NOT tracked

- **`~/.zshenv`** — contains real tokens and passwords. Transfer it securely
  (e.g. send to yourself via Slack DM, or store in 1Password / macOS Keychain).

## Setup on a new machine

```zsh
# 1. Clone
git clone https://github.com/sergeyt/.files.git ~/dotfiles

# 2. Symlink
cd ~/dotfiles && ./install.sh

# 3. Install tools
brew install antidote fzf forgit fnm starship git-delta

# 4. Restore secrets
# Copy ~/.zshenv from your secure store
# Use .zshenv.template as a reference
```

## Installed tools

- **antidote** — zsh plugin manager (`brew install antidote`)
- **fzf** — fuzzy finder
- **forgit** — interactive git commands via fzf (`gcb`, `ga`, `gd`, `glo`, …)
- **fnm** — fast Node version manager
- **starship** — cross-shell prompt
- **git-delta** — syntax-highlighting pager for git diffs
