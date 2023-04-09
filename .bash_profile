#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"

# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

# if [ -n "$DESKTOP_SESSION" ];then
#     eval $(gnome-keyring-daemon --start)
#     export SSH_AUTH_SOCK
# fi

export TERMINAL=/usr/bin/alacritty;

export EDITOR='nvim'
export VISUAL='nvim'

export STACK_XDG="YES";
export GHCUP_USE_XDG_DIRS="YES";
export PATH="$HOME/.config/ghcup/bin:$PATH";

export PATH="$HOME/.local/bin:$PATH"
# Added by Toolbox App
export PATH="$PATH:/home/neo/.local/share/JetBrains/Toolbox/scripts"
