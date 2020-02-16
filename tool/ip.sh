#!/bin/bash

status=""
sort="n"

while [[ "$#" -gt 0 ]]
do 
	case $1 in
		-h|--help)
			cat <<- 'HEREDOC'
			Usage: ./ip [OPTION]... < log file
			Count and list ip in log file
			Options:
			-h | --help	Show this help messages
			-s | --status	Specify status code
			-S | --sort	Sort the result by times from small to big
			-r | --reverse	Sort the result by times from big to small
			HEREDOC
			exit 0
		;;
		-s|--status)
			status="$2"
			shift
			shift
		;;
		-S|--sort)
			sort="y"
			shift
		;;
		-r|--reverse)
			sort="r"
			shift
		;;
		*)
			echo "Unknown parameter passed: $1"
			exit 1
		;;
	esac
done

function getip(){
	if [[ -z $status ]]
	then
		cut -d' ' -f1 | ./count.sh
	else
		awk "\$9 == $status {print \$1}" | ./count.sh
	fi
}
if [[ $sort == "n" ]]
then
	getip
elif [[ $sort == "y" ]]
then
	getip | sort -nk2
elif [[ $sort == "r" ]]
then
	getip | sort -nrk2

fi
exit 0
