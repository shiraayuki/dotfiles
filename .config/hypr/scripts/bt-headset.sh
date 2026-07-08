#!/usr/bin/env bash
# Click on the waybar bluetooth icon: connect/disconnect soundcore Space One.
MAC="F4:9D:8A:A5:13:D0"
NAME="soundcore Space One"

if bluetoothctl info "$MAC" 2>/dev/null | grep -q "Connected: yes"; then
    bluetoothctl disconnect "$MAC" >/dev/null \
        && notify-send -a Bluetooth "󰂲 Disconnected" "$NAME"
else
    bluetoothctl power on >/dev/null
    if bluetoothctl connect "$MAC" >/dev/null; then
        notify-send -a Bluetooth "󰂱 Connected" "$NAME"
    else
        notify-send -u critical -a Bluetooth "Connection failed" "Turn on $NAME and click again"
    fi
fi
