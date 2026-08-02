#!/bin/bash

# If internal screen is disabled,
# enable internal screen and disable external screen.
#
# Else if internal screen is enabled,
# disable internal screen and enable external screen.

# use --pretty option, or the output would be JSON format.
# JSON is hard to parse.
if swaymsg -t get_outputs --pretty | grep -q "Output eDP-1.*\(disabled\)"; then
    # eDP-1 is disanled
    swaymsg output eDP-1 enable scale 1.5
    swaymsg output HDMI-A-1 disable
else
    # eDP-1 is enabled
    swaymsg output HDMI-A-1 enable scale 3
    swaymsg output eDP-1 disable
fi
