#!/usr/bin/env bash

# Present options with wofi dmenu style
chosen=$(printf " Lock\n Logout\n Reboot\n Poweroff\n󰒲 Suspend\n󰤄 Hibernate\nSkip Suspend\nSkip Lock\nClear Skip Suspend\nClear Skip Lock" \
    | wofi --dmenu --prompt "Power Menu" --hide-scroll --width 200 --height 300 --insensitive)

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
    "Skip Suspend")
        touch /tmp/skip_suspend
        ;;
    "Skip Lock")
        touch /tmp/skip_lock
        ;;
    "Clear Skip Suspend")
        rm -f /tmp/skip_suspend
        ;;
    "Clear Skip Lock")
        rm -f /tmp/skip_lock
        ;;
esac
