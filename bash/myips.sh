#!/bin/bash
#
# this script accomplishes the task in lab 1 to disply ip addresses for interfaces
# this version is specifically allowed to hardcode the interface names and list
#
# It uses the commands suggested in the exercise instructions
# Sample output:
#   ens33: 1.2.3.4
#   External IP: 8.8.8.8
#

# interface name is ens33, hardcoded *************
echo -n "ens33: "

# this gets any ip addresses from our ifconfig output, hardcoded interface name ***********
ifconfig ens33|grep inet|sed -e 's/.*addr: //' -e 's/.*addr://' -e 's/ .*//'|grep [[:print:]]
echo -n "External IP: "

# relies on curl being installed and relies on live internet connection
curl icanhazip.com
