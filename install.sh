#!/usr/bin/env bash
# Dotfiles-Installer — verlinkt alle Configs aus diesem Repo ins Home-Verzeichnis.
# Vorhandene Dateien werden nach ~/.config-backup-<datum>/ gesichert.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP=~/.config-backup-$(date +%Y%m%d-%H%M%S)

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
echo "==> Fertig."
echo "    Pakete installieren (Arch):"
echo "      sudo pacman -S --needed - < $DOTFILES/packages.txt"
echo "    (AUR-Pakete ggf. mit yay nachinstallieren)"
