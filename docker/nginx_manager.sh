#!/bin/bash

proverka_arg() {
  # Должен быть ровно 1 аргумент
  [ "$#" -eq 1 ]
}

proverka_process() {
  # Проверяет: контейнер ЗАПУЩЕН?
  local process="$1"
  docker ps --format '{{.Names}}' | grep -Fxq "$process"
}

proverka_container() {
  # Проверяет: контейнер СУЩЕСТВУЕТ (включая остановленный)?
  local process="$1"
  docker ps -a --format '{{.Names}}' | grep -Fxq "$process"
}

main() {
  local arg="$1"
  local container="my-super-nginx"

  if proverka_arg "$@"; then
    if proverka_container "$container"; then
      # Контейнер существует (может быть запущен/остановлен)
      if proverka_process "$container"; then
        # Контейнер запущен
        if [ "$arg" = "start" ]; then
          echo "Контейнер ${container} уже запущен."
        elif [ "$arg" = "stop" ]; then
          echo "Останавливаю и удаляю контейнер ${container}"
          if docker stop "$container" && docker rm "$container"; then
            echo "Контейнер ${container} успешно остановлен и удален"
          else
            echo "Контейнер ${container} не был остановлен или удален"
          fi
        elif [ "$arg" = "logs" ]; then
          echo "Показываю логи контейнера ${container}"
          docker logs -f "$container"
        elif [ "$arg" = "restart" ]; then
          echo "Перезапускаю контейнер ${container}"
          docker restart "$container"
        elif [ "$arg" = "shell" ]; then
          echo "Запускаю контейнер в оболочке shell.."
          docker exec -it "$container" sh
        else
          echo "Неизвестная команда: $arg"
          echo "Args: start / stop / restart / logs / shell."
          exit 1
        fi
      else
        # Контейнер существует, но НЕ запущен
        if [ "$arg" = "start" ]; then
          echo "Контейнер ${container} существует, но не запущен — запускаю."
          if docker start "$container"; then
            echo "Успех!"
          else
            echo "Не удалось запустить контейнер."
          fi
        elif [ "$arg" = "stop" ]; then
          echo "Контейнер ${container} остановлен — удаляю."
          if docker rm "$container"; then
            echo "Контейнер ${container} удален."
          else
            echo "Не удалось удалить контейнер."
          fi
        elif [ "$arg" = "logs" ]; then
          echo "Контейнер ${container} остановлен — показываю последние логи."
          docker logs "$container"
        elif [ "$arg" = "restart" ]; then
          echo "Перезапускаю контейнер ${container} (запущу, если остановлен)"
          docker restart "$container"
        elif [ "$arg" = "shell" ]; then
          echo "Контейнер ${container} остановлен — запускаю и открываю shell."
          if docker start "$container"; then
            docker exec -it "$container" sh
          else
            echo "Не удалось запустить контейнер для shell."
          fi
        else
          echo "Неизвестная команда: $arg"
          echo "Args: start / stop / restart / logs / shell."
          exit 1
        fi
      fi
    else
      # Контейнер не существует
      if [ "$arg" = "start" ]; then
        echo "Контейнер ${container} не существует — создаю и запускаю."
        if docker run --name "$container" -d -p 8080:80 nginx; then
          echo "Успех!"
        else
          echo "Не удалось запустить контейнер."
        fi
      elif [ "$arg" = "stop" ] || [ "$arg" = "logs" ] || [ "$arg" = "restart" ] || [ "$arg" = "shell" ]; then
        echo "Контейнер ${container} не существует. Сначала запусти: $0 start"
      else
        echo "Неизвестная команда: $arg"
        echo "Args: start / stop / restart / logs / shell."
        exit 1
      fi
    fi
  else
    echo "Usage: $0 <arg>"
    echo "Args: start / stop / restart / logs / shell."
    exit 1
  fi
}

main "$@"
