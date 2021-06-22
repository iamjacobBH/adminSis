#!/bin/bash

#inicializamos variables
opcion=0

#loop de menu si la opcion es 5 salir
while [ "$opcion" -ne "5" ]; do
	
	clear
	#tomamos la opcion de menu en la variable opcion y mostramos el menu
	opcion=$(dialog --stderr --title "PROGRAMAR TAREAS EN BASE AL INICIO DE SESION DE UN USUARIO" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "Respaldo de carpetas al iniciar sesion de un usuario"\
		2 "Monitoreo de aplicaciones ejecutadas por el usuario"\
		3 "Tiempos de sesion"\
		4 "Comandos ejecutados por un usuario"\
		5 "Salir")
	if [ $? != 0 ]; then
		opcion=5
	fi
	#validamos opcion
	case "$opcion" in 
		1)
			bash /proyecto/Apartado3/respaldo.sh 
			;;
		2) 
			bash /proyecto/Apartado3/programas.sh 
			;;

		3)    
			bash /proyecto/Apartado3/tiempos.sh 
			;;
		4)
			bash /proyecto/Apartado3/comandos.sh
			;;
		5)	
			break;;
	esac
 
done
