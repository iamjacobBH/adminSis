#!/bin/bash

opcion=0
#loop de menu si la opcion es 3 salir
while [ "$opcion" -ne "3" ]; do
	
	clear
	#tomamos la opcion de menu en la variable opcion y mostramos el menu
	opcion=$(dialog --stderr --title "TAREAS SOBRE USUARIOS EN SESION" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "Monitorear los inicios/termino de sesion de un usuario"\
		2 "Programar tareas en base al inicio de sesion de un usuario"\
		3 "Salir")
	if [ $? != 0 ]; then
		opcion=3
	fi
	#validamos opcion
	case "$opcion" in 
		1)
			clear
			bash /proyecto/Apartado3/op1.sh 
			;;
		2) 
			bash /proyecto/Apartado3/submenu.sh
			;;

		3)    
			break;;		
		esac
done
