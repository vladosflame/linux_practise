#!/bin/bash


if [[ -z "$@" && "$#" -ne 1 ]]; then
	echo "Usage: "$0" <username>"
	exit 1
fi

USER_NAME=$1

if grep -q "^${USER_NAME}:" /etc/passwd; then
	echo "User ${USER_NAME} exist."
	exit  0
else
	read -p "User ${USER_NAME} doesn't exist. Do u want to create it? (y/n)" ANSWER

	if [[ ${ANSWER} == "y" || ${ANSWER} == "Y" ]]; then
		echo "Creating user ${USER_NAME}..."
		sudo useradd -m -s /bin/bash ${USER_NAME}
	else
		echo "Aborting"
	fi
fi



