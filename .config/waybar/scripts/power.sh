#!/usr/bin/env bash

# Present options with wofi dmenu style
chosen=$(printf " Lock\n Logout\n Reboot\n Poweroff" \
    | wofi --dmenu --prompt "Power Menu" --hide-scroll --width 200 --height 100 --insensitive)

case "$chosen" in
    " Lock")
        swaylock
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
esac
