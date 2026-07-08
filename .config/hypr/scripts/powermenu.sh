#!/usr/bin/env bash
# Rofi power menu

chosen=$(printf '󰌾  Sperren\n󰗽  Abmelden\n󰜉  Neustart\n󰐥  Herunterfahren' \
    | rofi -dmenu -p "󰐥 Power" -theme-str 'listview { lines: 4; }')

case "$chosen" in
    *Sperren)        hyprlock ;;
    *Abmelden)       hyprctl dispatch exit ;;
    *Neustart)       systemctl reboot ;;
    *Herunterfahren) systemctl poweroff ;;
esac
