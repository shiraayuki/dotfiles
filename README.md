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
| `.inputrc` | Readline (Ctrl+Backspace/Del word deletion in bash etc.) |
| `.clang-format` | Global fallback C/C++ style |
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

## Manual system steps (not covered by install.sh)

These are system-level and have to be done once per machine:

```sh
# Locale: uncomment en_US.UTF-8 (and de_DE.UTF-8) in /etc/locale.gen, then:
sudo locale-gen
sudo localectl set-locale LANG=en_US.UTF-8
# CAREFUL: rofi dies silently if the locale set in locale.conf is not generated!

# Keyboard (console + X11):
sudo localectl set-keymap de
sudo localectl set-x11-keymap de

# Login shell:
chsh -s /usr/bin/zsh

# Services:
sudo systemctl enable --now bluetooth sddm
```

SDDM theme: `/usr/share/sddm/themes/catppuccin-mocha` + `/etc/sddm.conf.d/10-theme.conf`
are not part of this repo — without them SDDM just uses its default theme.

## Notes

- The monitor setup in `hypr/hyprland.conf` is tailored to DP-3 / 240 Hz. Other
  hardware is caught by the `preferred` fallback line — on HiDPI displays
  (e.g. Surface) raise the scale there, e.g. `monitor = , preferred, auto, 1.5`.
- On Microsoft Surface devices the [linux-surface](https://github.com/linux-surface/linux-surface)
  kernel is recommended (touch, Wi-Fi, cameras).
- The BT headset script (`hypr/scripts/bt-headset.sh`) has the soundcore Space One
  MAC hardcoded — pair it once per machine (`bluetoothctl`) before the waybar
  click works.
- Font: CaskaydiaCove Nerd Font (included in packages.txt).
