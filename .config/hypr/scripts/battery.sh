#!/usr/bin/env bash
# Waybar custom module: battery + power profile.
# No battery (desktop) -> static icon. Left-click -> power-mode.sh picker.
# JSON output; refresh with `pkill -RTMIN+8 waybar`.

# --- current power profile (power-profiles-daemon) ---
profile=$(powerprofilesctl get 2>/dev/null)
case "$profile" in
    performance) pmark="󰓅 Performance" ;;
    balanced)    pmark="󰾅 Normal" ;;
    power-saver) pmark="󰌪 Energy Saver" ;;
    *)           pmark="${profile:-unknown}" ;;
esac

# --- find a battery ---
bat=$(ls /sys/class/power_supply/ 2>/dev/null | grep -m1 '^BAT')

if [ -z "$bat" ]; then
    # Desktop / no battery -> plug icon, profile in tooltip.
    printf '{"text":"󰚥","tooltip":"Power profile: %s","class":"desktop"}\n' "$pmark"
    exit 0
fi

cap=$(cat "/sys/class/power_supply/$bat/capacity" 2>/dev/null)
status=$(cat "/sys/class/power_supply/$bat/status" 2>/dev/null)
[ -z "$cap" ] && cap=0

# discharge icons by 10% steps (nerd font)
icons=(󰂎 󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹)
idx=$(( cap / 10 ))
[ "$idx" -gt 10 ] && idx=10

if [ "$status" = "Charging" ] || [ "$status" = "Full" ]; then
    icon="󰂄"
    class="charging"
elif [ "$cap" -le 15 ]; then
    icon="${icons[$idx]}"; class="critical"
elif [ "$cap" -le 30 ]; then
    icon="${icons[$idx]}"; class="warning"
else
    icon="${icons[$idx]}"; class="normal"
fi

printf '{"text":"%s %d%%","tooltip":"Battery: %d%% (%s)\\nProfile: %s","class":"%s"}\n' \
    "$icon" "$cap" "$cap" "$status" "$pmark" "$class"
