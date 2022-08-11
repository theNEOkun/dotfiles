#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

export TERMINAL=/usr/bin/kitty;

export EDITOR='nvim'
export VISUAL='nvim'

eval lesspipe.sh

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

export PATH="$HOME/.local/bin:$PATH"



# Added by Toolbox App
export PATH="$PATH:/home/sven/.local/share/JetBrains/Toolbox/scripts"