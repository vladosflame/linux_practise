#!/bin/bash

for i in ./*.txt; do
	if [ -n ${i} ]; then
		continue
	else
		echo "${i}"
	fi
done
