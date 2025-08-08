#!/bin/bash

set -euo pipefail

proverka_arg() {
if [ "$#" -ne 1 ]; then
	return 1
else
	return 0
fi
}

main() {
local username="$1"
local url="https://api.github.com/users/${username}"
local get_zapros=$(curl -s "${url}")

local name=$(echo "${get_zapros}" | jq '.name')
local company=$(echo "${get_zapros}" | jq '.company')
local location=$(echo "${get_zapros}" | jq '.location')
local public_repos=$(echo "${get_zapros}" | jq '.public_repos')
local followers=$(echo "${get_zapros}" | jq '.followers')

if proverka_arg "$@"; then
	echo "--- GitHub User Report ---:"
	sleep 1
	echo "Username:     ${username}"
	echo "Full Name:    ${name}"
	echo "Company:      ${company}"
	echo "Location:     ${location}"
	echo "Public Repos: ${public_repos}"
	echo "Followers:    ${followers}"
	echo "----------------------------"
else
	echo "Usage: <$0> <username>"
fi
}

main "$@"

