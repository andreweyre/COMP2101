#!/bin/bash
#
# this script creates a Pictures directory and puts
#   some image files into it, unless they are there already
# it makes assumptions that the Pictures directory exists and that it was empty before we started
#

# assumption that we have a Pictures directory in our home directory, hardcoded **********
cd ~/Pictures

# assumes you are online, hardcoded *********
wget -q http://zonzorp.net/pics.zip

# unpack the downloaded archive and delete the archive
# assumes we retrieved a zip file, hardcoded ***********
unzip -q pics.zip
rm pics.zip

# Sample output:
#   Found 95 regular files using 7.1M of storage in the ~/Pictures directory

echo -n "Found "
find . -type f|wc -l
echo -n " regular files using "
du -sh .|awk '{print $1}'
echo " of storage in the ~/Pictures directory"
