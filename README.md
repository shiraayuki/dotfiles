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
| `packages.txt` | Explizit installierte Pakete (`pacman -Qqe`) |

## Installation auf einem neuen System

```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh                                   # verlinkt alles, sichert Vorhandenes
sudo pacman -S --needed - < packages.txt       # Pakete (AUR-Pakete schlagen fehl -> mit yay nachziehen)
```

Das Script legt Symlinks von `~/.config/...` auf dieses Repo. Änderungen an den Configs landen damit direkt im Repo — einfach committen.

## Hinweise

- Monitor-Setup in `hypr/hyprland.conf` ist auf DP-3 / 240 Hz zugeschnitten — auf anderer Hardware anpassen.
- Font: CaskaydiaCove Nerd Font (in packages.txt enthalten).
