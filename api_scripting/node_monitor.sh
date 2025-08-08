#!/bin/bash

set -euo pipefail

proverka_arg() {
if [ "$#" -ne 1 ]; then
	return 1
else
	return 0
fi
}

check_eth_height() {
local url="https://cloudflare-eth.com"
local result=$(curl -s -X POST "${url}" -H "Content-Type: application/json" -d '{"jsonrpc": "2.0", "method": "eth_blockNumber", "params": [], "id": result}' | jq '.result')

echo "${result}"
}

check_doge_height() {
local url="https://doge.atomicwallet.io/api/v2/status"
local result=$(curl -s -X GET "${url}" | jq '.blockbook.bestHeight')
echo "${result}"
}

main() {
local type="$@"

if proverka_arg "${type}"; then
	if [ "${type}" == "eth" ]; then
		local eth_height=$(check_eth_height)
		echo "Current Ethereum block height: ${eth_height}"
	elif [ "${type}" == "doge" ]; then
		local doge_height=$(check_doge_height)
		echo "Current Dogecoing block height: ${doge_height}"
	else
		echo "Invalid argument. Use 'eth' or 'doge'"
	fi
else
	echo "Usage: <$0> <{eth | doge}>"
fi
}

main "$@"
