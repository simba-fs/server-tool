#!/bin/bash

status=""
precision=""

while [[ "$#" -gt 0 ]]
do 
	case $1 in
		-h|--help)
			cat <<- 'HEREDOC'
			Usage: ./time [OPTION]... < log file
			Get time and count from log file
			Options:
			-h | --help	Show this help messages
			-s | --status	Specify status code
			-S | --second	Count to second (default)
			-M | --minute	Count to minute
			-H | --hour	Count to hour
			-D | --day	Count to day
			HEREDOC
			exit 0
		;;
		-s|--status)
			status="$2"
			shift
			shift
		;;
		-S|--second)
			precision=''
			shift
		;;
		-M|--minute)
			precision='s/:..$//'
			shift
		;;
		-H|--hour)
			precision='s/:..:..$//'
			shift
		;;
		-D|--day)
			precision='s/:..:..:..$//'
			shift
		;;
		*)
			echo "Unknown parameter passed: $1"
			exit 1
		;;
	esac
done

function getTime(){
	if [[ -z $status ]]
	then
		cut -d' ' -f4 
	else
		awk "\$9 == $status {print \$4}"
	fi
}

if [[ -z $precision ]]
then 
	getTime | sed 's/\[//' | ./count.sh | sort
else
	getTime | sed 's/\[//' | sed $precision | ./count.sh | sort
fi
