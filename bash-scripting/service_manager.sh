#!/bin/bash

clear
while true
do
	echo "1 (проверить статус) | 2 (запустить) | 3 (остановить) | 4 (перезапустить) | q (выйти)"
	read -p "Введите значение: " CHOICE
	if [[ "${CHOICE}" ==  "1" || "${CHOICE}" == "2" || "${CHOICE}" == "3" || "${CHOICE}" == "4" ]]; then
		echo "Введите имя службы (например, nginx)"
		read -p "Имя службы: " SLUZHBA
		if [ "$CHOICE" == 1 ]; then
			sudo systemctl status "${SLUZHBA}"
			read -p "Стереть запись? (y/n): " CLEANER
		        if [[ "${CLEANER}" == "y" || "${CLEANER}" == "Y" ]]; then
                		clear
       			elif [[ "${CLEANER}" == "n" || "${CLEANER}" == "N" ]]; then
               			echo ""
        		else
                		read -p "Стереть запись? (y/n): " CLEANER
			fi

		elif [ "$CHOICE" == "2" ]; then
                        sudo systemctl start "${SLUZHBA}"
                        read -p "Стереть запись? (y/n): " CLEANER
                        if [[ "${CLEANER}" == "y" || "${CLEANER}" == "Y" ]]; then
                                clear
                        elif [[ "${CLEANER}" == "n" || "${CLEANER}" == "N" ]]; then
                                echo ""
                        else
                                read -p "Стереть запись? (y/n): " CLEANER
			fi

		elif [ "$CHOICE" == "3" ]; then
                        sudo systemctl stop "${SLUZHBA}"
                        read -p "Стереть запись? (y/n): " CLEANER
                        if [[ "${CLEANER}" == "y" || "${CLEANER}" == "Y" ]]; then
                                clear
                        elif [[ "${CLEANER}" == "n" || "${CLEANER}" == "N" ]]; then
                                echo ""
                        else
                                read -p "Стереть запись? (y/n): " CLEANER
			fi

		else
                        sudo systemctl restart "${SLUZHBA}"
                        read -p "Стереть запись? (y/n): " CLEANER
                        if [[ "${CLEANER}" == "y" || "${CLEANER}" == "Y" ]]; then
                                clear
                        elif [[ "${CLEANER}" == "n" || "${CLEANER}" == "N" ]]; then
                                echo ""
                        else
                                read -p "Стереть запись? (y/n): " CLEANER
			fi
		fi
	elif [[ "${CHOICE}" == "q" || "${CHOICE}" == "Q" ]]; then
		echo "Всего доброго!"
		sleep 1
		break
	else
		echo "Введено неверное значение, пожалуйста, введите 1/2/3/4/q"
		sleep 2
	fi
done
clear
