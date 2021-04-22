#!/bin/bash

function show_ip(){
        local nics=$(route -n | grep ^0.0.0.0 | awk '{print $8}')
        for nic in $nics
        do
                local ip=$(ip addr show $nic | grep -w inet | awk '{print $2}')
                echo "[$nic] $ip"
        done
}

function send_mail(){
	echo
}

# Prepare
fd=/tmp/ip_monitor && mkdir -p $fd && cd $fd
touch ip_D200101T000000.log

# Write IP status
show_ip | sort > $fd/ip_$(date +D%y%m%dT%H%M%S).log

# Check difference
last2=$(ls $fd/ip_*.log | tail -n 2)
if (diff -q $last2); then
	echo SAME: $last2
else
	echo DIFF: $last2
	#grep ^ $last2
	diff -y $last2
fi

