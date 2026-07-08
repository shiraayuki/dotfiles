#!/usr/bin/env bash
# Dotfiles installer — installs packages and symlinks all configs into $HOME.
# Existing files are backed up to ~/.config-backup-<date>/.
#
#   ./install.sh               everything: packages + symlinks
#   ./install.sh --links-only  symlinks only, no packages
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP=~/.config-backup-$(date +%Y%m%d-%H%M%S)

# ─── Packages ──────────────────────────────────────────────────
if [ "${1:-}" != "--links-only" ]; then
    if ! command -v pacman >/dev/null; then
        echo "==> No pacman found — skipping package installation."
    else
        echo "==> Installing repo packages (pacman)"
        sudo pacman -S --needed --noconfirm - < "$DOTFILES/packages.txt"

        # Bootstrap yay if it's missing
        if ! command -v yay >/dev/null; then
            echo "==> yay missing — building it from the AUR"
            sudo pacman -S --needed --noconfirm base-devel git
            builddir="$(mktemp -d)"
            git clone https://aur.archlinux.org/yay-bin.git "$builddir/yay-bin"
            (cd "$builddir/yay-bin" && makepkg -si --noconfirm)
            rm -rf "$builddir"
        fi

        echo "==> Installing AUR packages (yay)"
        yay -S --needed --noconfirm - < "$DOTFILES/packages-aur.txt"
    fi
fi

# ─── Symlinks ──────────────────────────────────────────────────
link() {
    local src="$1" dst="$2"
    # Already pointing here? Nothing to do.
    if [ -L "$dst" ] && [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then
        echo "  ok      $dst"
        return
    fi
    # Back up anything that exists
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP"
        mv "$dst" "$BACKUP/"
        echo "  backup  $dst -> $BACKUP/"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo "  link    $dst"
}

echo "==> Linking configs from $DOTFILES"

for item in "$DOTFILES"/.config/*; do
    link "$item" ~/.config/"$(basename "$item")"
done
link "$DOTFILES/.zshrc" ~/.zshrc

echo
echo "==> Done. Log out/in again or start Hyprland."
