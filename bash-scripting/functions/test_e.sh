#!/bin/bash

set -e

echo "Шаг 1: начинаем"

ls /nonexistent_directory
echo "Шаг 2: Этот текст не должен появиться, если set -e включен"
