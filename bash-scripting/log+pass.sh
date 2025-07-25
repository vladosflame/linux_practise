#!/bin/bash

read -p "Username: " USER_NAME
read -sp "Password: " USER_PASSWORD # -s дает вводить символы без отображения
echo

echo "Trying to log in with user ${USER_NAME}..."
sleep 5
echo "The password is correct. Logging in, Welcome ${USER_NAME}!"
