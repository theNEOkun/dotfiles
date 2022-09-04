#!/bin/bash
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
	file=$(fd pom.xml . -d 1);
	if [[ $file == "" ]]; then
		echo "Not a maven project";
		return 0;
	fi
	if [[ ! -d ./target ]]; then
		echo "No built jar-file";
		return 0;
	fi
	jar=false;
	for each in $(get_value_from_file 'build/_:plugins/_:plugin/_:artifactId' $file); do
		if [[ $each == 'maven-jar-plugin' ]]; then
			jar=true;
		fi
	done
	parent=$(get_part "parent" $file )
	pgroupId=$(get_value "groupId" ${parent});
	if [[ $pgroupId != "" ]]; then
		pgroupId="${pgroupId}."
	fi
	partifactId=$(get_value "artifactId" ${parent} )
	echo $pgroupId '-' $partifactId
	groupId=$(get_value_from_file "groupId" $file);
	if [[ $groupId == "" ]]; then
		groupId=$(get_value_from_file "artifactId" $file);
	fi
	groupId="${groupId}."
	artifactId=$(get_value_from_file "artifactId" $file);
	version=$(get_value_from_file "version" ${file});
	if [[ $version == "" ]]; then
		version=$(get_value "version" $parent);
	fi

	if [[ $jar = true ]]; then
		java -jar target/${artifactId}-${version}.jar
	else
		java -cp target/${artifactId}-${version}.jar ${pgroupId}${groupId}"$1"
	fi
}

function get_value_from_file() {
	local token="$1";
	local file="$2";
	echo $(xml sel -t -v '/_:project/_:'$token $file);
}

function get_from_anywhere() {
	local token="$1";
	local file="$2";
	echo $(xml sel -t -v '//_:'$token $file);
}

function get_value() {
	token="$1"
	shift
	arr="$@"
	echo $(echo $arr | xml sel -t -v '//_:'$token);
}

function get_part() {
	token="$1"
	file="$2"
	echo $( xml sel -t -c '_:project/_:'$token $file ) 
}
