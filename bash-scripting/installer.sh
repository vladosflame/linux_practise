#!/bin/bash

# -e для завершения кода при ошибке; -u завершение если исп. несуществующую переменную; -o при ошибке в пайпе
set -euo pipefail

# Функция для проверки установлены ли пакеты
is_package_installed() {
local package="$1"
if dpkg -s "${package}" &> /dev/null; then
	return 0
else
	return 1
fi
}

# Функция для установки пакета
install_package() {

local package="$1"
echo "Пытаюсь скачать ${package}.."
sudo apt install -y "${package}"

}

main() {


if [ $# -eq 0 ]; then
	echo "Usage: <$0> <пакет> <пакет> ... "
	exit 1
fi

for package in "$@"; do
	if is_package_installed "${package}"; then
		echo "Пакет ${package} уже установлен."
	else
		install_package "${package}"
		if is_package_installed "${package}"; then
			echo "Отлично! Пакет ${package} установился!"
		else
			echo "Что-то пошло не так! :("
		fi
	fi
done

}

main "$@"
