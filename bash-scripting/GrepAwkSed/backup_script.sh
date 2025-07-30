#!/bin/bash

set -euo pipefail

proverka_dir() {
if [ -d "$1" ]; then
	return 0
else
	return 1
fi
}

proverka_backup_dir() {
local backup_dir="/mnt/backups"
if [ -d "${backup_dir}" ]; then
	return 0
else
	echo "Директория ${backup_dir} отсутствует. Создаю."
	mkdir -p "${backup_dir}"
	if [ ! -w "${backup_dir}" ]; then
		echo "Ошибка: нет прав на запись в ${backup_dir}"
		return 1
	fi
	return 0
fi
}

proverka_args() {
if [ $# -ne 1 ]; then
	return 1
else;
	return 0
fi
}

gen_backup_filename() {

local source_name="$1"
local data=$(date +"%Y-%m-%d_%H_%M_%S")
newfilename="${source_name}_backup_${data}.tar.gz"
echo "${newfilename}"
}

create_archive() {
local source_path="$1"
local archive_path="$2"

echo "Создание архива: ${archive_path}"

tar -czf "${archive_path}" -C "$(dirname "${source_path}")" "$(basename "${source_path}")"
}

main() {

local backup_dir=/mnt/backups
local path="$1"
local basename=$(basename "${path}")
local backup_filename=$(gen_backup_filename "${basename}")
local full_archive_path="/mnt/backups/${backup_filename}"


if proverka_args "$@" && proverka_dir "$path"; then
	echo "[INFO] Отлично, аргумент передан верно и папка существует."
	echo "[INFO] Проверяю существует ли директория для бэкапа."
	if proverka_backup_dir; then
		echo "[INFO] Директория для бэкапа существует, продолжаем."
		echo "[INFO] Бэкап будет называться ${backup_filename}"
		if create_archive "${path}" "${full_archive_path}"; then
			echo "[OK] Бэкап ${backup_filename} был успешно сохранен в ${backup_dir}"
		else
			echo "[ERROR] Бэкап ${backup_filename} не был создан по пути ${backup_dir}"
			return 1
		fi
	else
		echo "[ERROR] Папка для бэкапа не существует по пути ${backup_dir}"
		return 1
	fi
else
	echo "Введено неверное количество аргументов или указанная директория не существует"
	return 1
fi
}

main "$@"
