#!/usr/bin/env bash
# Rofi power menu

chosen=$(printf '󰌾  Lock\n󰗽  Log out\n󰜉  Reboot\n󰐥  Shutdown' \
    | rofi -dmenu -p "󰐥 Power" -theme-str 'listview { lines: 4; }')

case "$chosen" in
    *Lock)       hyprlock ;;
    *"Log out")  hyprctl dispatch exit ;;
    *Reboot)     systemctl reboot ;;
    *Shutdown)   systemctl poweroff ;;
esac
