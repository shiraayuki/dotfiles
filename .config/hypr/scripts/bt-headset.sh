#!/usr/bin/env bash
# Klick aufs Waybar-Bluetooth-Icon: soundcore Space One verbinden/trennen.
MAC="F4:9D:8A:A5:13:D0"
NAME="soundcore Space One"

if bluetoothctl info "$MAC" 2>/dev/null | grep -q "Connected: yes"; then
    bluetoothctl disconnect "$MAC" >/dev/null \
        && notify-send -a Bluetooth "󰂲 Getrennt" "$NAME"
else
    bluetoothctl power on >/dev/null
    if bluetoothctl connect "$MAC" >/dev/null; then
        notify-send -a Bluetooth "󰂱 Verbunden" "$NAME"
    else
        notify-send -u critical -a Bluetooth "Verbindung fehlgeschlagen" "$NAME einschalten und nochmal klicken"
    fi
fi
