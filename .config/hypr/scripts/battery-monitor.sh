#!/usr/bin/env bash
# Surface battery watchdog. Runs as a loop (exec-once in hyprland.conf).
#  - Low/critical: notify + auto-switch power-profiles-daemon to power-saver.
#  - Near full while charging: remind to unplug (soft battery-health limit;
#    this Surface has no writable charge_control_end_threshold in sysfs).

BAT=$(ls /sys/class/power_supply/ 2>/dev/null | grep -m1 '^BAT')
[ -z "$BAT" ] && exit 0   # no battery -> nothing to watch

LOW=20      # warn + power-saver
CRIT=10     # urgent warn
FULL=90     # unplug reminder

warned_low=0
warned_crit=0
reminded_full=0

set_saver() { powerprofilesctl set power-saver 2>/dev/null; pkill -RTMIN+8 waybar; }

while true; do
    cap=$(cat "/sys/class/power_supply/$BAT/capacity" 2>/dev/null)
    status=$(cat "/sys/class/power_supply/$BAT/status" 2>/dev/null)
    [ -z "$cap" ] && { sleep 60; continue; }

    if [ "$status" = "Discharging" ]; then
        reminded_full=0
        if [ "$cap" -le "$CRIT" ]; then
            if [ "$warned_crit" -eq 0 ]; then
                set_saver
                notify-send -u critical -i battery-caution-symbolic \
                    "Battery critical: ${cap}%" "Switched to Energy Saver. Plug in now."
                warned_crit=1
            fi
        elif [ "$cap" -le "$LOW" ]; then
            if [ "$warned_low" -eq 0 ]; then
                set_saver
                notify-send -u normal -i battery-low-symbolic \
                    "Battery low: ${cap}%" "Switched to Energy Saver."
                warned_low=1
            fi
        else
            warned_low=0
            warned_crit=0
        fi
    else
        # charging / full / not-charging
        warned_low=0
        warned_crit=0
        if [ "$cap" -ge "$FULL" ] && [ "$reminded_full" -eq 0 ]; then
            notify-send -u normal -i battery-full-charged-symbolic \
                "Battery at ${cap}%" "Unplug to preserve battery health."
            reminded_full=1
        fi
        [ "$cap" -lt "$FULL" ] && reminded_full=0
    fi

    sleep 60
done
