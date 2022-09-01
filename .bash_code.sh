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

mvn_gen() {
	if [ "$#" == 0 ]; then
		group="com.mycompany.app";
		artifact="my-app";
	else
		group=$( [ "$1" == "-" ] && echo "com.mycompany.app" || echo "$1" );
		artifact=$( [ "$2" == "-" ] && echo "my-app" || echo "$2" );
	fi
	mvn archetype:generate -DgroupId=${group} -DartifactId=${artifact} -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
}

# Function to run a maven project
mvn_run() {
	file=$(fd pom.xml .);
	groupId=$(strip ${file} "groupId");
	artifactId=$(strip ${file} "artifactId");
	version=$(strip ${file} "version");
	java -cp target/${artifactId}-${version}.jar ${groupId}."$1"
}

# Function to split the content from the given file and toke, used by mvn_run
function strip() {
	token="$2"
	echo $(bat "$1" | egrep '<'${token}'>' | head -1 | sed 's-<'${token}'>--g' | sed 's-</'${token}'>--g')
}
