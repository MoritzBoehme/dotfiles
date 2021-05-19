#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Automatic brightness controll
[[ $(uname -n) == *"laptop"* ]] && clight &

# Set cursor
xsetroot -cursor_name left_ptr

[[ $(uname -n) == *"desktop"* ]] && xrandr --output HDMI-0 --primary --output HDMI-1 --left-of HDMI-0

exec bspwm
