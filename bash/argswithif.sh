#!/bin/bash

debug=0
while [ $# -gt 0 ]; do
	[ $# -gt 1 ] && echo "$# args left to process"
	[ $# -eq 1 ] && echo "1 arg left to process"
	if [ "$1" == "-h" ]; then
		echo "Usage: $0 [-d level] [-h]"
		exit 0
	elif [ "$1" == "-d" ]; then
		if [[ "$2" =~ ^[1-9]$ ]]; then
			debug="$2"
			echo "Debug mode ON, level $debug"
			shift
		else
			echo "Cannot set debug without a level from 1 to 9"
			exit 2
		fi
	else
		echo "Usage: $0 [-d level] [-h]"
		echo "Argument '$1' not recognized"
		exit 2
	fi
	shift
done
