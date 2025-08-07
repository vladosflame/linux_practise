#!/bin/bash

set -euo pipefail

proverka_kolvo() {
if [ $# -ne 1 ]; then
	return 1
fi
}

main() {
site="$1"
if proverka_kolvo "$@"; then
	curl -s -i "${site}" | grep "HTTP/" | awk '{ print $2 }'
	curl -s -i "${site}" | grep -i "Content-Type: "
else
	echo "Usage: <$0> <site>"
fi
}

main "$@"
