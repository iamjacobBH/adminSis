#!/bin/bash

opcion=0 #<-Inicializa Variable de opcion
#<-Se inicia el menu mediante un dialog para una interfaz mas grafica y amigable

while [ "$opcion" -ne "6" ]; do #<-Mientras se ejecute un numero diferente a 6 se mostrara el menu
	opcion=$(dialog --stderr --title "TAREAS DE MANTENIMIENTO" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "HABILITAR / INHABILITAR CHEQUEO EN VOLUMENES"\
       	2 "ARRANQUE EN MODO MANTENIMIENTO" \
		3 "ARRANQUE MANUAL"\
		4 "CHEQUEO DE VOLUMENES"\
		5 "CREACION,FORMATO Y MONTAJE DE VOLUMENES"\
		6 "REGRESAR")
	if [ $? != 0 ]; then
		opcion=6
	fi
	#<-Dependiendo de que opcion sea seleccionada se ejecutara el bash de cada opcion
	case "$opcion" in 
		1)	/proyecto/Mantenimiento/opcion1.sh 2> archivo1.txt
			
			;;
		2) 	/proyecto/Mantenimiento/opcion2.sh 2> archivo1.txt
				
			;;
		3)	/proyecto/Mantenimiento/opcion3.sh 2> archivo1.txt
			
			;;
		4)	/proyecto/Mantenimiento/opcion4.sh 2> archivo1.txt
			;;
			
		5)      /proyecto/Mantenimiento/opcion5.sh 2> archivo1.txt
			;;

		6)    
			
			clear
			;;		
						
		esac
done
