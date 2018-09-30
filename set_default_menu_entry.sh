#!/bin/bash

# Description:
# Set the default menu entry for Linux.

# Support:
# Red Hat distros

# History:
# v1.0    2018-09-30  charles.shih  Init version
# v1.0.1  2018-09-30  charles.shih  Bug fix for no permission


# Try to find the entries
file=$(mktemp)
sudo grep -P "submenu|^menuentry" /boot/grub2/grub.cfg | cut -d "'" -f 2 > $file
max_entry=$(wc -l $file | cut -d " " -f 1)
: ${max_entry:=0}

# Cancel the setup if no entry was found
[ $max_entry -eq 0 ] && {
	echo "No entry was found, setup cancelled."; rm $file; exit 1
}

# Show the entries found
echo "No: Title of the entry"
echo "========================================"
n=0
while read line; do
	echo " $n: $line"
	let n=n+1
done < $file

# No need to setup if only one entry was found
[ $max_entry -eq 1 ] && {
	echo -e "\nOnly one entry was found. No need setup."; rm $file; exit 0
}

# Ask user to specify an entry to setup
echo; read -p "Number of entry to be set as default (0~$((max_entry-1))): " number

# Cancel the setup if got bad inputs
[ -z "$number" -o -n "$(echo $number | tr -d '[:digit:]')" ] && {
	echo -e "\nInvalid inputs, setup cancelled."; rm $file; exit 1 
}

[ $number -ge $max_entry ] && {
	echo -e "\nBad range, setup cancelled."; rm $file; exit 1
}

# Do setup the default entry
echo -e "\nSet No.$number as default entry..."
sudo grub2-set-default $number
sudo grub2-editenv list
rm $file; exit 0

