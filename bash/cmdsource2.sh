#!/bin/bash
#script to find source of command names entered
#

#############
# VARIABLES #
#############
cmd_name="$1" #assigns variable cmd_name to command line input

#############
# Functions #
#############
#displays help options for user input
function displayHelp {
  echo "Usage: $(basename $0) [-h|--help]. Enter a command name to lookup source software package"
}

###########################
# Command line processing #
###########################

#if command line input is blank prompts user to enter a command name
if [ -z "$cmd_name" ]; then
	read -p "You didn't give me a command name on the command line, please enter one now: " cmd_name
fi

#if command line entry is -h or --help displays help options from function displayHelp
case "$1" in
-h|--help)
		displayHelp
		exit 0
		;;
*)
esac
shift

########
# Main #
########
while [ "$cmd_name" != "" ]; do # loop around until the "enter" key is pressed
echo "The source software package is "
dpkg -S $(which $cmd_name) | awk '{print $1;}' #inserts filepath of command entered and processes dpkg -S to find source package. Prints only source name
read -p "Enter a command name to find source software package: " cmd_name

if [ -e $cmd_name ]; then
  echo "The source software package is "
  dpkg -S $(which $cmd_name) | awk '{print $1;}' #inserts filepath of command entered and processes dpkg -S to find source package. Prints only source name
fi
done
