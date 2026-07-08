#!/usr/bin/env bash
# Theme-Switcher — schaltet Hyprland, Waybar, Kitty, Rofi, swaync,
# Hyprlock und Wallpaper in einem Rutsch um.
# Aufruf: theme-switch.sh [theme-ordner]   (ohne Argument: Rofi-Menü)
set -uo pipefail

THEMES_DIR="$HOME/.config/themes"
current="$(basename "$(readlink -f "$THEMES_DIR/current")")"

# Verfügbare Themes einsammeln (Ordner mit name-Datei, ohne current-Symlink)
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
    notify-send -a Theme "Theme-Switcher" "Unbekanntes Theme: ${choice:-?}"
    exit 1
fi

[ "$choice" = "$current" ] && exit 0

# Relativer Link, damit das Dotfiles-Repo auf jedem System funktioniert
ln -sfn "$choice" "$THEMES_DIR/current"

hyprctl reload >/dev/null
if pgrep -x waybar >/dev/null; then
    pkill -SIGUSR2 waybar    # Waybar: Style neu laden
else
    hyprctl dispatch exec waybar >/dev/null   # Waybar wiederbeleben, falls abgestürzt
fi
pkill -SIGUSR1 -x kitty      # Kitty: Config neu laden (färbt offene Terminals um)
swaync-client -rs >/dev/null 2>&1
# hyprpaper >= 0.8: "wallpaper" lädt selbst nach, preload/reload gibt es nicht mehr.
# Aufgelösten Pfad übergeben, damit nicht der current-Symlink gecacht wird.
hyprctl hyprpaper wallpaper ", $THEMES_DIR/$choice/wallpaper.png" >/dev/null 2>&1

notify-send -a Theme "Theme gewechselt" "$(<"$THEMES_DIR/current/name") ist jetzt aktiv"
