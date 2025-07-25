#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: $0 <file>"
	exit 1
fi

FILENAME=$1

if [ -f ${FILENAME} ]; then
	echo "File '${FILENAME}' found. Archiving..."
	BASENAME=$(basename "${FILENAME}")
	gzip -cv ${FILENAME} > ${BASENAME}.gz
	echo "Archive ${BASENAME}.gz is created in this directory!"
else
	echo "${FILENAME} is not a file or doesn't exist"
	exit 1
fi

echo "Script finished!"
