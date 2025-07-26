#!/bin/bash

TASK="./tasks.txt"

if [ -f "${TASK}" ]; then
	echo "Starting..."
else
	echo "The file doesn't exist"
	exit 1
fi

while read -r FILE
do
	echo "Processing task: creating file ${FILE}..."
	touch ${FILE}
	if [ -f ${FILE} ]; then
		echo "SUCCESS: File ${FILE} created!"
	else
		echo "ERROR: Failed to create ${FILE}"
	fi
	sleep 1
done < "${TASK}"
