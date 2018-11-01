#!/bin/bash
# this script produces a memory usage report by utilizing the free command

#############
# VARIABLES #
#############
Total_RAM=$(free -m | awk '/^Mem:/{print $2}') #sets variable that extracts Total RAM in MB using the free command
Free_RAM=$(free -m | awk '/^Mem:/{print $4}') #sets variable that extracts the Free RAM in MB using the free command
Used_RAM=$(free -m | awk '/^Mem:/{print $3}') #sets variable that extracts the Used RAM in MB using the free command
Cached_RAM=$(free -m | awk '/^Mem:/{print $6}') #sets variable that extracts the Cached RAM in MB using the free command
Available_RAM=$(free -m | awk '/^Mem:/{print $7}') #sets variable that extracts the Available RAM in MB using the free command
Shared_RAM=$(free -m | awk '/^Mem:/{print $5}') #sets variable that extracts the Shared RAM in MB using the free command

########
# MAIN #
########

#Produce the report
cat <<EOF
-----------------------
| MEMORY USAGE REPORT |
-----------------------
Total RAM:
  $((Total_RAM))MB
Free RAM:
  $((Free_RAM))MB
Used RAM plus Cached RAM:
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

#-----------------------
#| MEMORY USAGE REPORT | ----> Title for report
#-----------------------

# $((Total_RAM))MB ----> Total RAM in MB

# $((Free_RAM))MB ----> Free RAM in MB

# $((Used_RAM + Cached_RAM))MB ----> Used RAM added to Cached RAM shown in MB

# $((Available_RAM - Free_RAM))MB ----> Available RAM minus Free RAM shown in MB

# $(awk "BEGIN{printf \"%.2f\",($Shared_RAM/$Used_RAM)*100}")% -----> Shared RAM divided by Used RAM displayed as a percentage

# $(awk "BEGIN{printf \"%.2f\", ($Used_RAM/$Total_RAM)*100}")% -----> Used RAM divided by Total RAM displayed as a percentage

# $(awk "BEGIN{printf \"%.2f\", ($Cached_RAM/$Total_RAM)*100}")% ----> Cached RAM divided by Total RAM displayed as a percentage
