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

alias java11="$HOME/.local/bin/jdk-11.0.2/bin/java"
alias java16="$HOME/.local/bin/jdk-16.0.1/bin/java"

export EDITOR='nvim'
export VISUAL='nvim'
