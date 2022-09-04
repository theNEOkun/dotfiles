#!/bin/bash

md() {
    #pandoc --extract-media=. -t plain `find . -maxdepth 1 -iname "${1:-readme.md}"` | less
    glow `find . -maxdepth 1 -iname "${1:-readme.md}"` -p
}

mkpdf() {
	pandoc --pdf-engine-opt=--enable-local-file-access $1.md -f markdown -t html5 -s -o $1.pdf
}

ext() {
	if [[ -f "$1" ]] ; then
		case "$1" in
			*.t*) tar xf "$1" ;;
			*.zip) unzip "$1" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

comp() {
	if [[ -f "$1" ]] ; then
		case "$2" in
			tar) tar cf "$1" ;;
			zip) zip "$1" ;;
		esac
	elif [[ -d "$2" ]] ; then
		case "$2" in
			tar) tar -czvf "$1.tar.gz" "$1" ;;
			zip) zip -r "$1.zip" "$1" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

alias yeet="paru -Rsc"

keys() {
	xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

source $HOME'/Programmering/bash/mvn_run/.bash_code.sh'
