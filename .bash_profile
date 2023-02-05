#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

export TERMINAL=/usr/bin/alacritty;

export EDITOR='nvim'
export VISUAL='nvim'

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

export STACK_XDG="YES";
export GHCUP_USE_XDG_DIRS="YES";
export PATH="$HOME/.config/ghcup/bin:$PATH";

# Added by Toolbox App
export PATH="$PATH:/home/neo/.local/share/JetBrains/Toolbox/scripts"
