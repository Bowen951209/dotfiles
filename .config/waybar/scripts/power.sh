#!/usr/bin/env bash

# Present options with wofi dmenu style
chosen=$(printf " Lock\n Logout\n Reboot\n Poweroff\n󰒲 Suspend\n󰤄 Hibernate\n󰒱 Skip Suspend" \
    | wofi --dmenu --prompt "Power Menu" --hide-scroll --width 200 --height 200 --insensitive)

case "$chosen" in
    " Lock")
        loginctl lock-session
        ;;
    " Logout")
        swaymsg exit
        ;;
    " Reboot")
        systemctl reboot
        ;;
    " Poweroff")
        systemctl poweroff
        ;;
    "󰒲 Suspend")
        systemctl suspend
        ;;
    "󰤄 Hibernate")
        systemctl hibernate
        ;;
    "󰒱 Skip Suspend")
        ~/.local/bin/touch_skip_suspend.sh
        ;;
esac
