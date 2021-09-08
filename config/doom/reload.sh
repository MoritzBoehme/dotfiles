#!/bin/sh
DOOM="$HOME/.emacs.d"
if [ ! -d "$DOOM" ]; then
	git clone https://github.com/hlissner/doom-emacs.git "$DOOM"
	sleep 0.5
	"$DOOM/bin/doom -y install"
fi

"$DOOM/bin/doom sync"
