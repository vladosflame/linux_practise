#!/bin/bash

# Идеальная функция. 10/10
validate_number() {
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    return 0
  else
    return 1
  fi
}

# Идеальная функция. 10/10
add() {
  local num1="$1"
  local num2="$2"
  echo $((num1 + num2))
}

if validate_number "$1" && validate_number "$2"; then
  summ=$(add "$1" "$2")
  echo "The sum is: ${summ}"
else
  echo "Для работы скрипта введите 2 целых числа!"
  return 1 # return можно использовать только внутри функций
fi
