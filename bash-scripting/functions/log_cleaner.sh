#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: "$0" <path_to_dir_with_logs> <numb_old_days_to_archive>"
	exit 1
else
	if [ -d "$1" ]; then
		echo "The dir is excist"
		for i in $(find -type f -name "*.log" -mtime +"$2")
		do
			echo "Archiving and deleting: ${i}"
			if gzip -cvf ${i}; then
				echo "Completed!"
			else
				echo "ERROR: Couldn't made an archive."
			fi
	else
		echo "$1 is not a directory!"
		exit 1
	fi
fi
echo "The script is done! :)"
