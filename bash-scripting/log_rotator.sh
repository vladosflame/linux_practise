#!/bin/bash

set -euo pipefail

proverka_arg() {
if [ $# -ne 1 ]; then
	return 1
fi
}

proverka_file() {
if [ ! -s "$1" ]; then
	return 1
fi
}

main () {

file="$1"

local current_date=$(date +"%Y-%m-%d")
local new_filename=${file}.${current_date}

if proverka_arg "$@" && proverka_file "$@"; then
	echo "Файл найден и не пуст. Копируем ${file} и приводим его к формату file.log.date..."
	if sudo cp "${file}" "${new_filename}"; then
		echo "Файл ${new_filename} успешно создан!"
		echo "Очищаем файл ${file}"
        	if sudo echo "" > "${file}"; then
			echo "Файл ${file} успешно очищен!"
		else
			echo "Файл ${file} не был очищен."
		fi
	else
		echo "Файл ${new_filename} не был создан. Остановка процесса."
		exit 1
	fi
else
	echo "Аргумент с путем файла должен быть одним и не пустым!"
fi
}

main "$@"
echo "Скрипт завершен!"


