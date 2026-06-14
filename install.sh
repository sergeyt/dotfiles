#!/usr/bin/env zsh
# install.sh — symlink dotfiles into ~
# Run once on a new machine after cloning this repo.

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

_link() {
  local src="$1"
  local dst="$2"
  local dir
  dir="$(dirname "$dst")"

  [[ -d "$dir" ]] || mkdir -p "$dir"

  if [[ -e "$dst" && ! -L "$dst" ]]; then
    echo "  backing up $dst → $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
  fi

  ln -sfn "$src" "$dst"
  echo "  linked $dst"
}

echo "==> Linking dotfiles from $DOTFILES"

_link "$DOTFILES/.zshrc"          "$HOME/.zshrc"
_link "$DOTFILES/.zsh_plugins.txt" "$HOME/.zsh_plugins.txt"
_link "$DOTFILES/starship.toml"    "$HOME/.config/starship.toml"

echo ""
echo "==> Done."
echo ""
echo "Next steps on a new machine:"
echo "  1. Install Homebrew: https://brew.sh"
echo "  2. brew install antidote fzf fnm starship"
echo "  3. Paste your ~/.zshenv from Slack DM (or decrypt from secure store)"
echo "     → Use .zshenv.template as a reference for required variables."
