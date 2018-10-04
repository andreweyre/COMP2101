#!/bin/bash
# this script demonstrates using a case statement to process the command line

debug=0
while [ $# -gt 0 ]; do
	[ $# -gt 1 ] && echo "$# args left to process"
	[ $# -eq 1 ] && echo "1 arg left to process"
	case "$1" in
	-h | --help )
		echo "Usage: $0 [-d level] [-h]"
		exit 0
		;;
	-d | --debug )
		if [[ "$2" =~ ^[1-9]$ ]]; then
			debug="$2"
			shift
			echo "Debug mode ON, level $debug"
		else
			echo "Cannot set debug without a debug level from 1 to 9"
			exit 2
		fi
		;;
	* )
		echo "Usage: $0 [-d level] [-h]"
		echo "Argument '$1' not recognized"
		exit 2
		;;
	esac
	shift
done
