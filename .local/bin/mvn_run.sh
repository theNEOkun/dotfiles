#!/bin/bash

function mvn_gen() {
	local group="";
	local artifact="";
	if [ "$#" == 0 ]; then
		group="com.mycompany.app";
		artifact="my-app";
	else
		group=$( [ "$1" == "-" ] && echo "com.mycompany.app" || echo "$1" );
		artifact=$( [ "$2" == "-" ] && echo "my-app" || echo "$2" );
	fi
	mvn archetype:generate -DgroupId=${group} -DartifactId=${artifact} -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
}

function alt_mvn_run() {
	local home=$HOME;

	local file=$(fd pom.xml . -d 1);
	if [[ $file == "" ]]; then
		echo "Not a maven project";
		return 0;
	fi

	local dependencies=$(get_copy "dependency" $(get_part "dependencies" $file));
	local allDeps=()
	local counter=0;
	local thing="";
	local jarName="";
	for each in $dependencies; do
		if [[ $each == *"groupId"* ]]; then
			local groupId=$(echo $each | sed s-\<groupId\>--g | sed s-\<\/groupId\>--g);
			thing+=$(echo $groupId | sed s-\\.-\/-g)"/";
			counter=$(( $counter + 1 ));
		fi
		if [[ $each == *"artifactId"* ]]; then
			local artifactId=$(echo $each | sed s-\<artifactId\>--g | sed s-\<\/artifactId\>--g);
			thing+=$artifactId"/";
			jarName+=$artifactId"-"
			counter=$(( $counter + 1 ));
		fi
		if [[ $each == *"version"* ]]; then
			local version=$(echo $each | sed s-\<version\>--g | sed s-\<\/version\>--g);
			thing+=$version"/";
			jarName+=$version;
			counter=$(( $counter + 1 ));
		fi
		if [[ $counter == 3 ]]; then
			jarName+=".jar"
			allDeps+="$home/.m2/repository/"$thing$jarName":";
			thing="";
			jarName="";
			counter=0;
		fi
	done
	java -cp target/classes:$allDeps "$1"
}

# Function to run a maven project
function mvn_run() {
	local file=$(fd pom.xml . -d 1);
	if [[ $file == "" ]]; then
		echo "Not a maven project";
		return 0;
	fi
	if [[ ! -d ./target ]]; then
		echo "No built jar-file";
		return 0;
	fi
	local jar=false;
	for each in $(get_value_from_file 'build/_:plugins/_:plugin/_:artifactId' $file); do
		if [[ $each == 'maven-jar-plugin' ]]; then
			jar=true;
		fi
	done
	local parent=$(get_part "parent" $file )
	local pgroupId=$(get_value "groupId" ${parent});
	if [[ $pgroupId != "" ]]; then
		pgroupId="${pgroupId}."
	fi
	local partifactId=$(get_value "artifactId" ${parent} )
	echo $pgroupId '-' $partifactId
	local groupId=$(get_value_from_file "groupId" $file);
	if [[ $groupId == "" ]]; then
		groupId=$(get_value_from_file "artifactId" $file);
	fi
	local groupId="${groupId}."
	local artifactId=$(get_value_from_file "artifactId" $file);
	local version=$(get_value_from_file "version" ${file});
	if [[ $version == "" ]]; then
		version=$(get_value "version" $parent);
	fi

	if [[ $jar = true ]]; then
		java -jar target/${artifactId}-${version}.jar
	else
		java -cp target/${artifactId}-${version}.jar ${pgroupId}${groupId}"$1"
	fi
}

#Used to get a value from the project-part of a file
# * $1 - The token to get from the file 
#	example: build/_:plugins/_:plugin/_:artifactId
# * $2 - The file to get the token from
function get_value_from_file() {
	local token="$1";
	local file="$2";
	echo $(xml sel -t -v '/_:project/_:'$token $file);
}

#Used to get a value from anywhere within a file
# * $1 - The token to get from the file 
#	example: build/_:plugins/_:plugin/_:artifactId
# * $2 - The file to get the token from
function get_from_anywhere() {
	local token="$1";
	local file="$2";
	echo $(xml sel -t -v '//_:'$token $file);
}

#Used to get a value from a given array
# * $1 - The token to get from the file 
#	example: build/_:plugins/_:plugin/_:artifactId
# * $@ - The array to get information from
function get_value() {
	local token="$1"
	shift
	local arr="$@"
	echo $(echo $arr | xml sel -t -v '//_:'$token);
}

#Used to get a value from a given array
# * $1 - The token to get from the file 
#	example: build/_:plugins/_:plugin/_:artifactId
# * $@ - The array to get information from
function get_copy() {
	local token="$1"
	shift
	local arr="$@"
	echo $(echo $arr | xml sel -t -c '//_:'$token);
}

function get_part() {
	local token="$1"
	local file="$2"
	echo $( xml sel -b -t -c '_:project/_:'$token $file ) 
}
