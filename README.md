# dotfiles

Personal zsh setup for macOS.

## What's tracked

| File | Destination | Notes |
|------|-------------|-------|
| `.zshrc` | `~/.zshrc` | Main shell config |
| `.zsh_plugins.txt` | `~/.zsh_plugins.txt` | Antidote plugin list |
| `starship.toml` | `~/.config/starship.toml` | Prompt config |
| `.zshenv.template` | reference only | Variable list with placeholders |

## What's NOT tracked

- **`~/.zshenv`** — contains real tokens and passwords. Transfer it securely
  (e.g. send to yourself via Slack DM, or store in 1Password / macOS Keychain).

## Setup on a new machine

```zsh
# 1. Clone
git clone <this-repo-url> ~/dotfiles

# 2. Symlink
cd ~/dotfiles && ./install.sh

# 3. Install tools
brew install antidote fzf fnm starship

# 4. Restore secrets
# Copy ~/.zshenv from your Slack DM / secure store
# Use .zshenv.template as a reference
```

## Installed tools

- **antidote** — zsh plugin manager (`brew install antidote`)
- **fzf** — fuzzy finder
- **fnm** — fast Node version manager
- **starship** — cross-shell prompt
- **miniconda** — Python env (optional)
