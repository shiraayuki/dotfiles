# Dotfiles

Arch Linux + Hyprland setup (Catppuccin Mocha and other themes, switchable with SUPER+SHIFT+T).

## What's inside

| Path | What |
|---|---|
| `.config/hypr` | Hyprland, hyprlock, hypridle, hyprpaper + scripts (theme switcher, power menu, BT headset) |
| `.config/waybar` | Status bar |
| `.config/kitty` | Terminal |
| `.config/nvim` | Neovim |
| `.config/rofi` | Launcher |
| `.config/swaync` | Notifications |
| `.config/themes` | Color schemes (catppuccin-mocha, everforest, tokyonight-day) incl. wallpapers; `current` is a relative symlink to the active theme |
| `.config/btop`, `fastfetch`, `lazygit`, `starship.toml` | Tools |
| `.zshrc` | Zsh |
| `packages.txt` | Repo packages (`pacman -Qqen`) |
| `packages-aur.txt` | AUR packages (`pacman -Qqem`) |

## Installation on a new system

```sh
git clone <repo-url> ~/dotfiles
~/dotfiles/install.sh
```

The script installs all packages (repo via pacman, AUR via yay — yay is built
from the AUR itself if missing) and then symlinks the configs; anything already
present is backed up to `~/.config-backup-<date>/`. Symlinks only, no packages:
`./install.sh --links-only`.

The configs are symlinked from `~/.config/...` into this repo, so any change you
make lands directly in the repo — just commit it.

## Notes

- The monitor setup in `hypr/hyprland.conf` is tailored to DP-3 / 240 Hz — adjust on other hardware.
- Font: CaskaydiaCove Nerd Font (included in packages.txt).
