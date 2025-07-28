#!/bin/bash

set -u

echo "Привет, ${NONEXISTENT_VAR}!"
echo "Эта строка выполнится, если set -u включен"
