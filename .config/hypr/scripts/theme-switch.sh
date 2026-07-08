#!/usr/bin/env bash
# Theme switcher — switches Hyprland, Waybar, Kitty, Rofi, swaync,
# Hyprlock and the wallpaper in one go.
# Usage: theme-switch.sh [theme-dir]   (no argument: Rofi menu)
set -uo pipefail

THEMES_DIR="$HOME/.config/themes"
current="$(basename "$(readlink -f "$THEMES_DIR/current")")"

# Collect available themes (dirs with a name file, minus the current symlink)
slugs=() names=()
for dir in "$THEMES_DIR"/*/; do
    slug="$(basename "$dir")"
    [ "$slug" = "current" ] && continue
    [ -f "$dir/name" ] || continue
    slugs+=("$slug")
    names+=("$(<"$dir/name")")
done

if [ $# -ge 1 ]; then
    choice="$1"
else
    menu=""
    for i in "${!slugs[@]}"; do
        if [ "${slugs[$i]}" = "$current" ]; then
            menu+="󰸞 ${names[$i]}\n"
        else
            menu+="  ${names[$i]}\n"
        fi
    done
    sel="$(echo -en "$menu" | rofi -dmenu -p "󰏘 Theme" -l "${#slugs[@]}")" || exit 0
    sel="${sel#󰸞 }"
    sel="${sel#  }"
    choice=""
    for i in "${!slugs[@]}"; do
        if [ "${names[$i]}" = "$sel" ]; then
            choice="${slugs[$i]}"
            break
        fi
    done
fi

if [ -z "$choice" ] || [ "$choice" = "current" ] || [ ! -d "$THEMES_DIR/$choice" ]; then
    notify-send -a Theme "Theme switcher" "Unknown theme: ${choice:-?}"
    exit 1
fi

[ "$choice" = "$current" ] && exit 0

# Relative link so the dotfiles repo works on any system
ln -sfn "$choice" "$THEMES_DIR/current"

hyprctl reload >/dev/null
if pgrep -x waybar >/dev/null; then
    pkill -SIGUSR2 waybar    # Waybar: reload style
else
    hyprctl dispatch exec waybar >/dev/null   # revive waybar if it crashed
fi
pkill -SIGUSR1 -x kitty      # Kitty: reload config (recolors open terminals)
swaync-client -rs >/dev/null 2>&1
# hyprpaper >= 0.8: "wallpaper" loads on its own; preload/reload are gone.
# Pass the resolved path so the current symlink does not get cached.
hyprctl hyprpaper wallpaper ", $THEMES_DIR/$choice/wallpaper.png" >/dev/null 2>&1

notify-send -a Theme "Theme switched" "$(<"$THEMES_DIR/current/name") is now active"
