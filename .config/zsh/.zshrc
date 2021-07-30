# Use powerline
USE_POWERLINE="true"
SAVEHIST=1000
HISTFILE=$XDG_CONFIG_HOME/zsh/.zsh_history

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    cbonsai -lp -t 0.005 -m "Welcome back"
    sleep 2
    startx &>/dev/null
fi

if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
    chmod u+x $HOME/bin/*
fi

export EMACSDIR="$XDG_CONFIG_HOME/emacs"
if [ -d "$XDG_CONFIG_HOME/emacs/bin" ]; then
    export PATH="$XDG_CONFIG_HOME/emacs/bin:$PATH"
fi

autoload -Uz compinit
compinit

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source /usr/share/doc/pkgfile/command-not-found.zsh

alias ls='exa -lh'
alias cat='bat'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'

eval $(thefuck --alias)
eval "$(LC_ALL="en_US.UTF-8" starship init zsh)"
