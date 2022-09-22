parse_git_branch() {
	__git_ps1 "(%s)"
}

disp_colors() {
    for fg_color in {0..7}; do
        set_foreground=$(tput setaf $fg_color)
        for bg_color in {0..7}; do
            set_background=$(tput setab $bg_color)
            echo -n $set_background$set_foreground
            printf ' F:%s B:%s ' $fg_color $bg_color
        done
        echo $(tput sgr0)
    done
}

RESET=$(tput sgr0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
PURPLE=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BLACK=$(tput setaf 8)

RED_BG=$(tput setab 1)
GREEN_BG=$(tput setab 2)
YELLOW_BG=$(tput setab 3)
BLUE_BG=$(tput setab 4)
PURPLE_BG=$(tput setab 5)
CYAN_BG=$(tput setab 6)
WHITE_BG=$(tput setab 7)
BLACK_BG=$(tput setab 8)

oldps1='[\u@\h \W]\$' 

ellaps1=$'$CYAN\u@\h$PURPLE\u2764$RESET'

newps1=$'$(tput dim)${PURPLE}\u2554${GREEN}\u@\h${BLUE} \w ${YELLOW}$(parse_git_branch)${RED}$(changes_in_branch)\n$(tput dim)${PURPLE}\u255A${BLUE}\$\u29D0 ${RESET}'

newerps1=$'\n${GREEN}\u@\h${BLUE} \w ${YELLOW}$(parse_git_branch)${RED}$(changes_in_branch)${BLUE}${RESET}\n\$ '

PS1=$newerps1

