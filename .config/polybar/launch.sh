#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
for m in $(polybar --list-monitors | cut -d":" -f1); do
    # MONITOR=$m polybar --reload top -c ~/.config/polybar/config.ini &
    MONITOR=$m polybar --reload bottom -c ~/.config/polybar/config.ini &
done

echo "Polybar launched..."
