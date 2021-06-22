#!/bin/bash

opc=0

#MENU PRINCIAL
#se ejecuta hasta que la opcion seleccionada sea la 5
while [ "$opc" -ne "5" ]; do 	
	clear
#mostramos el menu y recuperamos la opcion en la variable opc
	opc=$(dialog  --title "PROGRAMACIÓN DE TAREAS" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "Programación de tareas manual"\
	       	2 "Respaldo programado" \
		3 "Borrado de temporales programado"\
		4 "Inhabilitación de usuarios"\
		5 "Regresar")
    #preguntamos si existe un codigo de salida diferente de 0, si sí se procede a salir del programa.
	if [ $? != 0 ]; then
		opc=5
	fi
	
	case "$opc" in 
		1) 
            #procedemos con la ejecución del script de la opcion1
			/proyecto/programacionTareas/progTar.sh
			;;
		2) 
			clear
            #procedemos con la ejecución del script de la opcion2
			/proyecto/programacionTareas/respaldoProgr.sh
			;;
		3)
			clear
            #procedemos con la ejecución del script de la opcion3
            /proyecto/programacionTareas/borradoTemp.sh
			;;
        4)
            #procedemos con la ejecución del script de la opcion4
            /proyecto/programacionTareas/inhabilitar.sh
			;;

		5)  #regresamos
            ;;			
		esac
 
done

