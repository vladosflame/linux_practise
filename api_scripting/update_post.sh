#!/bin/bash

set -euo pipefail
proverka_arg() {
if [ $# -ne 1 ]; then
	return 1
else
	return 0
fi
}

main () {

local id_post="$1"
local url=https://jsonplaceholder.typicode.com/posts/"${id_post}"

local id=$(curl -X GET "${url}"|jq '.id')
local title=$(curl -X GET "${url}"|jq '.title')
local body=$(curl -X GET "${url}"|jq '.body')
local userId=$(curl -X GET "${url}"|jq '.userId')

local new_title="${title} (UPDATED)"

if proverka_arg "$@"; then
	echo "Делаю запрос к ${url}"
	sleep 1
	echo "Поле \"title\" имеет значение: ${title}"
	sleep 1
	echo "Делаю PUT запрос к ${url}"
	curl -X PUT -H "Content-Type: application/json" -d "{\"id\": ${id}, \"title\": \"${new_title}\", \"body\": \"${body}\", \"userId\": \"${userId}\"}" "${url}"
	echo "Скрипт завершен, данные успешно переданы!"
else
	echo "Usage: <$0> <id>"
	exit 1
fi
}

main "$@"
