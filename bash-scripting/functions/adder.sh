#!/bin/bash

add() {

local arg1="$1"
local arg2="$2"

summ=$(($arg1 + $arg2))
echo "Сумма: ${summ}"
}

add "$1" "$2"

