#!/bin/sh
# https://unix.stackexchange.com/a/473789

date_formatted=$(date "+%a %F %H:%M:%S%z")
battery_status=$(cat /sys/class/power_supply/BAT0/status)
battery_power=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk -F ': *' '/percentage/{print $2}')

# https://unix.stackexchange.com/a/230533
volume=$(pactl list sinks | grep '^[[:space:]]Volume:' |     head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')%
brightness=$(brightnessctl | awk '-F[()]' '/Current brightness/{print $2}')

# Emojis and characters for the status bar
# 💎 💻 💡 🔌 ⚡ 📁 \|
echo 🔊 $volume 💡 $brightness 🔋 $battery_status $battery_power 📅 $date_formatted
