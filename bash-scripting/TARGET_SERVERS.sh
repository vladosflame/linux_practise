#!/bin/bash

TARGET_SERVERS=("server1.lab.local" "server2.lab.local" "web.lab.local" "8.8.8.8" "1.1.1.1" "192.168.100.99")

for i in "${TARGET_SERVERS[@]}"
do
	echo "Pinging ${i}"

	if ping -c 2 -W 3 "${i}" &> /dev/null; then
		echo " [ OK ] ${i} is up.."
	else
		echo " [ FAIL ] ${i} is DOWN.."
	fi
	echo ""
done


