#!/bin/bash

safe_divide() {

local var="$1"
if [[ "$var" =~ ^[0-9]+$ ]]; then
	return 0
else
	echo "${var} - не целое чисто. Пожалуйста, введите целое :)"
	return 1
fi
}

divide() {

local delim=$1
local delit=$2

delenie=$((${delim} / ${delit}))
echo "The divide of ${delim} and ${delit} is: ${delenie}"
}

if [ "$2" -ne "0" ] && safe_divide "$1" && safe_divide "$2"; then
	divide "$1" "$2"
else
	echo "Делить на ноль нельзя :)"
	exit 1
fi

