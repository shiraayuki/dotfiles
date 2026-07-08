# Dotfiles

Arch Linux + Hyprland Setup (Catppuccin Mocha u. a. Themes, umschaltbar mit SUPER+SHIFT+T).

## Enthalten

| Pfad | Was |
|---|---|
| `.config/hypr` | Hyprland, hyprlock, hypridle, hyprpaper + Scripts (Theme-Switcher, Powermenu, BT-Headset) |
| `.config/waybar` | Statusbar |
| `.config/kitty` | Terminal |
| `.config/nvim` | Neovim |
| `.config/rofi` | Launcher |
| `.config/swaync` | Notifications |
| `.config/themes` | Farbschemata (catppuccin-mocha, everforest, tokyonight-day) inkl. Wallpaper; `current` ist ein relativer Symlink aufs aktive Theme |
| `.config/btop`, `fastfetch`, `lazygit`, `starship.toml` | Tools |
| `.zshrc` | Zsh |
| `packages.txt` | Repo-Pakete (`pacman -Qqen`) |
| `packages-aur.txt` | AUR-Pakete (`pacman -Qqem`) |

## Installation auf einem neuen System

```sh
git clone <repo-url> ~/dotfiles
~/dotfiles/install.sh
```

Das Script installiert alle Pakete (Repo via pacman, AUR via yay — yay wird bei
Bedarf selbst aus dem AUR gebaut) und verlinkt dann die Configs; Vorhandenes wird
nach `~/.config-backup-<datum>/` gesichert. Nur Symlinks, keine Pakete:
`./install.sh --links-only`.

Das Script legt Symlinks von `~/.config/...` auf dieses Repo. Änderungen an den Configs landen damit direkt im Repo — einfach committen.

## Hinweise

- Monitor-Setup in `hypr/hyprland.conf` ist auf DP-3 / 240 Hz zugeschnitten — auf anderer Hardware anpassen.
- Font: CaskaydiaCove Nerd Font (in packages.txt enthalten).
