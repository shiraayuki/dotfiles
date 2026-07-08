#!/usr/bin/env bash
# Dotfiles-Installer — installiert Pakete und verlinkt alle Configs ins Home.
# Vorhandene Dateien werden nach ~/.config-backup-<datum>/ gesichert.
#
#   ./install.sh               alles: Pakete + Symlinks
#   ./install.sh --links-only  nur Symlinks, keine Pakete
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP=~/.config-backup-$(date +%Y%m%d-%H%M%S)

# ─── Pakete ────────────────────────────────────────────────────
if [ "${1:-}" != "--links-only" ]; then
    if ! command -v pacman >/dev/null; then
        echo "==> Kein pacman gefunden — überspringe Paketinstallation."
    else
        echo "==> Installiere Repo-Pakete (pacman)"
        sudo pacman -S --needed --noconfirm - < "$DOTFILES/packages.txt"

        # yay bootstrappen, falls nicht vorhanden
        if ! command -v yay >/dev/null; then
            echo "==> yay fehlt — baue es aus dem AUR"
            sudo pacman -S --needed --noconfirm base-devel git
            builddir="$(mktemp -d)"
            git clone https://aur.archlinux.org/yay-bin.git "$builddir/yay-bin"
            (cd "$builddir/yay-bin" && makepkg -si --noconfirm)
            rm -rf "$builddir"
        fi

        echo "==> Installiere AUR-Pakete (yay)"
        yay -S --needed --noconfirm - < "$DOTFILES/packages-aur.txt"
    fi
fi

# ─── Symlinks ──────────────────────────────────────────────────
link() {
    local src="$1" dst="$2"
    # Zeigt der Link schon hierher? Dann nichts tun.
    if [ -L "$dst" ] && [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then
        echo "  ok      $dst"
        return
    fi
    # Existierendes wegsichern
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP"
        mv "$dst" "$BACKUP/"
        echo "  backup  $dst -> $BACKUP/"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo "  link    $dst"
}

echo "==> Verlinke Configs aus $DOTFILES"

for item in "$DOTFILES"/.config/*; do
    link "$item" ~/.config/"$(basename "$item")"
done
link "$DOTFILES/.zshrc" ~/.zshrc

echo
echo "==> Fertig. Abmelden/neu einloggen bzw. Hyprland starten."
