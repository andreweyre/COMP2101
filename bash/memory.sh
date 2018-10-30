#!/bin/bash
# this script enumerates our interfaces and
#   displays their configured IPV4 and IPV6 addresses and names
#   or informs us they don't have one if appropriate
#   displays their interface speeds

#############
# VARIABLES #
#############
Total_RAM=$(free -m | awk '/^Mem:/{print $2}')
Free_RAM=$(free -m | awk '/^Mem:/{print $4}')
Used_RAM=$(free -m | awk '/^Mem:/{print $3}')
Cached_RAM=$(free -m | awk '/^Mem:/{print $6}')
Available_RAM=$(free -m | awk '/^Mem:/{print $7}')
Shared_RAM=$(free -m | awk '/^Mem:/{print $5}')

echo "Total RAM: $Total_RAM MB"
echo "Free RAM: $Free_RAM MB"
echo "Used RAM + Cached RAM: $((Used_RAM + Cached_RAM)) MB"
echo "Available RAM - Free RAM: $((Available_RAM - Free_RAM)) MB"
echo "Shared RAM/Used RAM: $(awk "BEGIN{printf \"%.2f\", ($Shared_RAM/$Used_RAM)*100}")%"
echo "Used RAM/Total RAM: $(awk "BEGIN{printf \"%.2f\", ($Used_RAM/$Total_RAM)*100}")%"
echo "Cached RAM/Total RAM: $(awk "BEGIN{printf \"%.2f\", ($Cached_RAM/$Total_RAM)*100}")%"

cat <<EOF
-----------------------
| MEMORY USAGE REPORT |
-----------------------
Total RAM:
  $((Total_RAM))MB
Free RAM:
  $((Free_RAM))MB
Used RAM & Cached RAM:
  $((Used_RAM + Cached_RAM))MB
Available RAM minus Free RAM:
  $((Available_RAM - Free_RAM))MB
Shared RAM/Used RAM:
  $(awk "BEGIN{printf \"%.2f\",($Shared_RAM/$Used_RAM)*100}")%
Used RAM/Total RAM:
  $(awk "BEGIN{printf \"%.2f\", ($Used_RAM/$Total_RAM)*100}")%
Cached RAM/Total RAM:
  $(awk "BEGIN{printf \"%.2f\", ($Cached_RAM/$Total_RAM)*100}")%

EOF
