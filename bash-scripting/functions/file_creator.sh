#!/bin/bash

create_file_with_content() {
local filename=$1
local text_to_write=$2

if [ $# -ne 2 ]; then
	echo "Func err: неверное количество аргументов"
else
	echo "Creating file ${filename}"
	echo "${text_to_write}" > "${filename}"
	echo "Done"
}

create_file_with_content "report.txt" "This is the daily report."
create_file_with_content "users.list" "admin,guest,user"
