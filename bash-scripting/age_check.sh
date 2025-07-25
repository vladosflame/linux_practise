#!/bin/bash

read -p "How old are you? " AGE

if [ ${AGE} -gt 18 ]
then
	echo "Welcome. You are old enough!"
else
	echo "Sorry, you are too young."
fi
