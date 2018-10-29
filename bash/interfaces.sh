#!/bin/bash
ifconf | grep '^[a-z]' #shows network interfaces beginning with a-z
ifconfig | grep '^[a-z]' | sed 's/:.*//' #shows network interfaces beginning with a-z then cuts all other info off
arrayvar=($(ifconfig | grep '^[a-z]' | sed 's/:.*//')) #creates variable arrayvar
echo"{arrayvar[@]} shows the results"

sudo ethtool enp0s3 #display interface information
sudo ethtool enp0s3 | grep Speed: #displays the Speed only from the interface details

ip a show enp0s3
ip a show enps03 | grep inet
ip a show enps03 | grep 'inet '
ip a show enps03 | grep 'inet ' |awk '{print $2}'
ip a show enps03 | grep 'inet 6' |awk '{print $2}'
