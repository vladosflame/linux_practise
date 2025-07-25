#!/bin/bash

if [ -z "$1" ]
then
	echo "Usage: $0 <path>"
	exit 1
fi

TARGET_PATH=$1
if [ -f "${TARGET_PATH}" ]
then
	echo "${TARGET_PATH} is a regular file."
elif [ -d "${TARGET_PATH}" ]
then
	echo "${TARGET_PATH} is a directory."
else
	echo "${TARGET_PATH} is smth else, or doesn't exist"
fi
