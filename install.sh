#!/usr/bin/env bash
# Dotfiles installer — installs packages and symlinks all configs into $HOME.
# Existing files are backed up to ~/.config-backup-<date>/.
#
#   ./install.sh               everything: packages + symlinks
#   ./install.sh --links-only  symlinks only, no packages
set -euo pipefail

# Run as your normal user — the script calls sudo itself where needed.
# As root, $HOME would be /root and all symlinks would end up there.
if [ "$(id -u)" -eq 0 ]; then
    echo "ERROR: don't run this with sudo/as root." >&2
    exit 1
fi

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP=~/.config-backup-$(date +%Y%m%d-%H%M%S)

# ─── Packages ──────────────────────────────────────────────────
if [ "${1:-}" != "--links-only" ]; then
    if ! command -v pacman >/dev/null; then
        echo "==> No pacman found — skipping package installation."
    else
        echo "==> Full system upgrade + repo packages (pacman)"
        # -Syu in the same transaction: plain -S on an outdated system is a
        # partial upgrade and aborts with "would break dependency" errors.
        sudo pacman -Syu --needed --noconfirm - < "$DOTFILES/packages.txt"

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

    # ─── SDDM theme (system-wide) ──────────────────────────────
    echo "==> Installing SDDM theme"
    sudo mkdir -p /usr/share/sddm/themes /etc/sddm.conf.d
    sudo cp -r "$DOTFILES/sddm/catppuccin-mocha" /usr/share/sddm/themes/
    sudo cp "$DOTFILES/sddm/10-theme.conf" /etc/sddm.conf.d/
    # /etc/sddm.conf (main file) wins over conf.d on this system's sddm
    # build, so a stray Current= line there (e.g. from an AUR theme's
    # postinstall) silently shadows our conf.d override. Patch it too.
    if [ -f /etc/sddm.conf ] && grep -q '^Current=' /etc/sddm.conf; then
        sudo sed -i 's/^Current=.*/Current=catppuccin-mocha/' /etc/sddm.conf
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
for item in .zshrc .inputrc .clang-format; do
    link "$DOTFILES/$item" ~/"$item"
done

mkdir -p ~/Pictures/Screenshots   # screenshot keybinds save here

echo
echo "==> Done. See README.md for the manual system steps"
echo "    (locale, login shell, services), then log out/in or start Hyprland."
