#!/usr/bin/env bash

for m in "$(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1)"; do
    MONITOR=$m polybar --reload bottom &
done
