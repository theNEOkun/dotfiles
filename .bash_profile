#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

eval lesspipe.sh

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

export PATH="$HOME/.local/bin:$PATH"

export EDITOR='nvim'
export VISUAL='nvim'

alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
