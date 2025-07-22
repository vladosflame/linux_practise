#!/bin/bash

echo "========================================"
echo "       System Information Report"
echo "========================================"

my_hostname=$(hostname)
echo "Hostname:		$my_hostname"

current_date=$(date)
echo "Report generated: $current_date"

user_name=$(whoami)
echo "Executed by:	$user_name"

ip_addr=$(ip a show ens37 | grep "inet " | awk '{print $2}')
echo "Internal IP:	$ip_addr"

diskinf=$(df -h /)
echo "Filesystem:	$diskinf"
