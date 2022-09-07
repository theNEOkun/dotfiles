#!/bin/bash

md() {
    #pandoc --extract-media=. -t plain `find . -maxdepth 1 -iname "${1:-readme.md}"` | less
    glow `find . -maxdepth 1 -iname "${1:-readme.md}"` -p
}

mkpdf() {
	pandoc --pdf-engine-opt=--enable-local-file-access $1.md -f markdown -t html5 -s -o $1.pdf
}

mkpdfcite() {
	if [[ ! -f $1'.md' ]]; then
		return 0;
	fi
	local csl=$(fd -d 1 --glob *.csl .);
	if [[ -z $csl ]]; then
		csl=${HOME}'/library/ieee.csl';
	fi
	csl=' --csl='$csl;
	local meta='';
	if [[ -f './meta.yaml' ]]; then
		meta='meta.yaml'
	fi
	local template='';
	if [[ -f './template.tex' ]]; then
		template=' --template=template.tex'
	fi
	pandoc -s -F pandoc-crossref -F pandoc-fignos --toc \
		$meta$template --bibliography='references.bib' $csl --citeproc \
		-N $1.md -f markdown -t latex+raw_tex -o $1.tex
	pdflatex -interaction=nonstopmode $1.tex &> /dev/null
	bibtex $1 &> /dev/null
	pdflatex -interaction=nonstopmode $1.tex &> /dev/null
	pdflatex -interaction=nonstopmode $1.tex &> /dev/null
	rm $1.t* $1.aux $1.b* $1.log
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