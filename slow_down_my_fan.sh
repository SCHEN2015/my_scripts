#!/bin/bash

# Description:
# When system fan goes its maximum speed, run this script to slow down the fan speed.

# Enable the fan control
# $ echo -e "\noptions thinkpad_acpi fan_control=1" >>/etc/modprobe.d/thinkpad_acpi.conf
# $ modprobe -c | grep ^options | grep thinkpad_acpi
# options thinkpad_acpi fan_control=1
# $ modprobe -r thinkpad_acpi
# $ modprobe thinkpad_acpi

[ -z $1 ] && lv=1 || lv=$1

cat /proc/acpi/ibm/fan
echo '----------'
echo 'SETTING...'
sudo bash -c "echo level $lv > /proc/acpi/ibm/fan"
echo '----------'
cat /proc/acpi/ibm/fan

