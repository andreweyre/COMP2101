#!/bin/bash
#
# this script produces the dynamic welcome message from the presentation
# it should look like
#   Welcome to planet hostname, title name!
#   Today is weekday.

###############
# Variables   #
###############
title="Professor"
myname="Dennis"
hostname=$(hostname)
today=$(date +%A)

###############
# Main        #
###############
cat <<EOF

Welcome to planet $hostname, "$title $myname!"
Today is $today.

EOF
