#!/bin/bash
# this script gets information about 2 interfaces and
#   displays their configured IPV4 addresses
#   as well as the default gateway from the route table

# Get configured interfaces' names and print a count of them
interfaces=(`ifconfig |egrep -o '^\w+'`)
echo "We have ${#interfaces[@]} interfaces"

# Gather data for first 2 interfaces
v4ip[0]=`ip a s ${interfaces[0]}|grep "inet "|awk '{print $2}'|sed 's,/.*,,'`
v4name[0]=$(getent hosts ${v4ip[0]}|sed -e 's/.*  *//')
v4ip[1]=`ip a s ${interfaces[1]}|grep "inet "|awk '{print $2}'|sed 's,/.*,,'`
v4name[1]=$(getent hosts ${v4ip[1]}|sed -e 's/.*  *//')
v6ip[0]=`ip a s ${interfaces[0]}|grep "inet6 "|awk '{print $2}'|sed 's,/.*,,'`
v6name[0]=$(getent hosts ${v6ip[0]}|sed -e 's/.*  *//')
v6ip[1]=`ip a s ${interfaces[1]}|grep "inet6 "|awk '{print $2}'|sed 's,/.*,,'`
v6name[1]=$(getent hosts ${v6ip[1]}|sed -e 's/.*  *//')
ifspeeds[0]=$(ethtool ${interfaces[0]} | grep Speed: | awk '{print $2}')
ifspeeds[1]=$(ethtool ${interfaces[1]} | grep Speed: | awk '{print $2}')

# Find IP address of default gateway
v4gwip=$(route -n|grep '^0.0.0.0'|awk '{print $2}')
v4gwname=$(getent hosts $v4gwip|sed -e 's/.*  *//')

# Get info about our internet address
extip=$(curl -s icanhazip.com)
extname=$(getent hosts $extip|sed -e 's/.*  *//')

#Produce the report
cat <<EOF
${interfaces[0]} ${ifspeeds[0]}:
  ${v4ip[0]} ${v4name[0]}
  ${v6ip[0]} ${v6name[0]}

${interfaces[1]} ${ifspeeds[1]}:
  ${v4ip[1]} ${v4name[1]}
  ${v6ip[1]} ${v6name[0]}

Default Route:
  $v4gwip $v4gwname

Internet Identity:
  $extip $extname
EOF
