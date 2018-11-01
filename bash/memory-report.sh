#!/bin/bash
# this script enumerates our interfaces and
#   displays their configured IPV4 and IPV6 addresses and names
#   or informs us they don't have one if appropriate
#   displays their interface speeds

#############
# VARIABLES #
#############
memory=(`free -m |grep '^"Mem:"'|awk '{print $1}'|sed 's/:$//'`)
#memory=(`free -m |grep '^"Mem:"'|awk '{print $1}'|sed 's/:$//'`)
echo "${memory[@]}"
#####awk '{print}'|sed 's/:$//'`) # an array of interface names configured on this machine
declare -A Total_RAM # will be a hash with ipv4 addresses, keyed using interface name
declare -A Free_RAM # will be a hash with ipv4 hostnames, keyed using interface name
declare -A Used_RAM # will be a hash with ipv6 addresses, keyed using interface name
declare -A Cached_RAM # will be a hash with ipv6 hostnames, keyed using interface name
declare -A Available_RAM # will be a hash with interface speeds, keyed using interface name
declare -A Shared_RAM # will be a hash with interface speeds, keyed using interface name

########
# MAIN #
########
# iterate over the interfaces array, gathering data into
for detail in "${memory[@]}"; do
# extract the assigned ip address(es) using ifconfig and store that in the ips hash
  #Total_RAM[$detail]=`ip a s $|grep "inet "|awk '{print $2}'|sed 's,/.*,,'`
  #v4name[$interface]=$(getent hosts ${v4ip[$interface]}|sed -e 's/.*  *//')
  Total_RAM[$detail]=$(free -m | awk '/^Mem:/{print $2}')
  Free_RAM[$detail]=$(free -m ${Free_RAM[$detail]}| awk '/^Mem:/{print $4}')
  Used_RAM[$detail]=$(free -m ${Used_RAM[$detail]}| awk '/^Mem:/{print $3}')
  Cached_RAM[$detail]=$(free -m ${Cached_RAM[$detail]}| awk '/^Mem:/{print $6}')
  Available_RAM[$detail]=$(free -m ${Available_RAM[$detail]}| awk '/^Mem:/{print $7}')
  Shared_RAM[$detail]=$(free -m ${Shared_RAM[$detail]}| awk '/^Mem:/{print $5}')
done
#Produce the report
  cat <<EOF
-----------------------
| MEMORY USAGE REPORT |
-----------------------
Total RAM:
  ${Total_RAM[$detail]}
Free RAM:
  $Free_RAM
Used RAM & Cached RAM:
  $((Used_RAM + Cached_RAM))MB
Available RAM minus Free RAM:
  $((Available_RAM - Free_RAM))MB
Shared RAM/Used RAM:
  $((BEGIN{printf \"%.2f\", ($Shared_RAM/$Used_RAM)*100}"))%
Used RAM/Total RAM:
  $((BEGIN{printf \"%.2f\", ($Used_RAM/$Total_RAM)*100}"))%
Cached RAM/Total RAM:
  $((BEGIN{printf \"%.2f\", ($Cached_RAM/$Total_RAM)*100}"))%
EOF
