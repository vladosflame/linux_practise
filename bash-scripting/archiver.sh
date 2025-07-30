#!/bin/bash

proverka_file() {
if [ -s "$1" ]; then
	return 0
else
	return 1
fi
}

proverka_file_put_in() {
if [ -f "$1" ]; then
	return 0
else
	return 1
fi
}

main() {

local files_spisok=("$@")
local real_files=()

for args in "${files_spisok}"; do
	if proverka_file "${args}"; then
		while read -r paths1; do
			if proverka_file_put_in "${paths1}"; then
				echo "${paths1} - существует. Добавляем в массив"
				real_files+=("${paths1}")
			else
				echo "Файл ${paths1} не существует, пропуск."
			fi
		done < ${args}
	else
		echo "Файл со списком файлов не существует."
	fi
done

if [ "${#real_files[@]}" -eq 0 ]; then
	echo "Валидных файлов не найдено - массив файлов пуст. Окончание программы."
else
	echo "Создаю архив всех валидных файлов: $real_files"
	local archive_name="backup_$(date +"%Y-%m-%d").tar.gz"
	tar -czvf "${archive_name}" "${real_files[@]}"
fi
}

main "$@"
