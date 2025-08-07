#!/bin/bash

proverka_arg() {
if [ "$#" -ne 1 ]; then
	return 1
else
	return 0
fi
}

main() {
local ip_addr="$1"
local ipinfo_token="330d68dc84ba07"
local zapros=$(curl -s -H "Authorization: Bearer ${ipinfo_token}" ipinfo.io/"${ip_addr}")
local city=$(echo "${zapros}" | jq '.city')
local region=$(echo "${zapros}" | jq '.region')
local country=$(echo "${zapros}" | jq '.country')


if proverka_arg "$@"; then
	echo "Вывожу поля город/регион/страна у адреса ${ip_addr}"
	sleep 1
	echo "${city}"
	sleep 1
	echo "${region}"
	sleep 1
	echo "${country}"
	sleep 1
	echo "Скрипт завершен!"
else
	echo "Usage: <$0> <ip_addr>"
fi
}

main "$@"


