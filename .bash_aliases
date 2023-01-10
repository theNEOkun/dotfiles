alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'

alias java11='$HOME/.local/bin/jdk-11.0.2/bin/java'
alias java16='$HOME/.local/bin/jdk-16.0.1/bin/java'

alias drg=dragon-drop

alias disas="objdump -drwCS -Mintel"

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -la'
alias l='lsd -l'

alias vim='nvim'
alias hx='helix'

alias gdbt='gdb --tui'
alias rgdbt='rust-gdb --tui'
