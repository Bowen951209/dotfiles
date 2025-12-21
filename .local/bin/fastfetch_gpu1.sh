#!/bin/bash

fastfetch -c ~/.config/fastfetch/only_gpu.jsonc | head -n 1 | \
sed "s/\$/ ($(cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status | tr -d '\n'))/"
