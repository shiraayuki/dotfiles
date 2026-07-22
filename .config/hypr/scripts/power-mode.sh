#!/usr/bin/env bash
# Rofi picker for power-profiles-daemon.
# performance / balanced / power-saver -> Performance / Normal / Energy Saver.

cur=$(powerprofilesctl get 2>/dev/null)

chosen=$(printf '󰓅  Performance\n󰾅  Normal\n󰌪  Energy Saver' \
    | rofi -dmenu -p "󱐋 Power  (now: $cur)" -theme-str 'listview { lines: 3; }')

case "$chosen" in
    *Performance)    powerprofilesctl set performance ;;
    *Normal)         powerprofilesctl set balanced ;;
    *"Energy Saver") powerprofilesctl set power-saver ;;
    *) exit 0 ;;
esac

# refresh the waybar battery module
pkill -RTMIN+8 waybar
