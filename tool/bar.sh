#!/bin/bash

declare -a idata
declare -a vdata

index=1
value=2
char=' '

while [[ "$#" -gt 0 ]]
do 
	case $1 in
		-h|--help)
			cat <<- 'HEREDOC'
			Usage: ./bar [OPTION]... < log file
			Count and list ip in log file
			Options:
			-h | --help 	Show this help messages
			-i [index] 	Assign index (default 1)
			-v [value]	Assign value (default 2)
			-d [char]	cut by [char] (default ' ')
			HEREDOC
			exit 0
		;;
		-i)
			index=$2
			shift
			shift
		;;
		-v)
			value=$2
			shift
			shift
		;;
		-d)
			chat=$2
			shift
			shift
		;;
		*)
			echo "Unknown parameter passed: $1"
			exit 1
		;;
	esac
done

biggest=0
scale=1
width=$(tput cols)

while read -r line
do
	a=$(echo $line | cut -d"$char" -f$index)
	b=$(echo $line | cut -d"$char" -f$value)
	if [[ $biggest < $b ]]
	then
		biggest=$b
	fi
	idata+=($a)
	vdata+=($b)
done 

# decide scale
# if (( b))

for i in $(seq 0 1 $((${#idata[@]} - 1)))
do
	echo -n "${idata[$i]}	"
	for j in $(seq 1 1 ${vdata[$i]})
	do 
		echo -n "#"
	done
	echo
done
