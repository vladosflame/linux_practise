#!/bin/bash

main() {

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <path_to_log_file>"
	exit 1
fi

local log_file="$1"

if [[ ! -f "${log_file}" || ! -r "${log_file}" ]]; then
	echo "Error: File '${log_file}' not found or is not readable"
	exit 1
else
	local awk_result=$(awk '{ print $1 }' "${log_file}" | sort | uniq -c | sort -nr | head -n 5)
	schet=1
	echo "--- TOP 5 IP Adresses ---"
	echo "${awk_result}" | while read -r count ip; do
		echo "${schet}. Requests: ${count}, IP: ${ip}"
		schet=$((schet + 1))
	done
fi
}

main "$@"

