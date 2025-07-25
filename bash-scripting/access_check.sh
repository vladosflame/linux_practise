#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: $0 <file>"
	exit 1
fi

FILENAME="$1"
COUNTER=0

if [ ! -e ${FILENAME} ]; then
	echo "'${FILENAME}' doesn't exist"
	exit 1
else
	if [ -r ${FILENAME} ]; then
		echo "Read access: Yes"
	else
		echo "Read access: No"
	fi

	if [ -w ${FILENAME} ]; then
                echo "Write access: Yes"
        	COUNTER=$((COUNTER+1))
	else
                echo "Write access: No"
        fi

	if [ -x ${FILENAME} ]; then
                echo "Execute access: Yes"
        else
                echo "Execute access: No"
        fi
fi

if [ $COUNTER -eq 1 ]; then
	read -p "The file is writable. Do you want to protect it by removing write permissions? (y/n)" DECISION
		if [[ ${DECISION} == "y" || ${DECISION} == "Y" ]]; then
			echo "Ok. Starting!..."
			chmod -w ${FILENAME}
			echo "Operation is completed!"
		else
			echo "Aborting."
		fi
else
	echo "The script is done!"

fi

