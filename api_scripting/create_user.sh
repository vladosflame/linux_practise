#!/bin/bash

proverka_args() {
if [ $# -ne 2 ]; then
	return 1
else
	return 0
fi
}

main() {
local username="$1"
local email="$2"
local json_data="{\"name\": \"$username\", \"email\": \"$email\"}"

if proverka_args "$@"; then
	echo "Формирую POST JSON запрос..."
	sleep 1
	curl -X POST -H "Content-Type: application/JSON" -d "${json_data}"
else
	echo "Usage: <$0> <username> <email>"
fi
}

main "$@"

