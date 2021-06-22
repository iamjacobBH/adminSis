#!/bin/bash

opcion=0
if [[ $EUID -ne 0 ]]; then
   dialog --title "Información" --msgbox "Este programa debe ser ejecutado con permisos de administrador" 0 0
   clear
   exit 1
fi
while [ "$opcion" -ne "6" ]; do
	
	clear
	opcion=$(dialog --stderr --title "ADMINISTRADOR DE SISTEMA" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "Administración de usuarios"\
       		2 "Programación de tareas" \
		3 "Tareas de mantenimiento y niveles de arranque"\
		4 "Tareas sobre usuarios en sesión"\
		5 "Funciones extendidas/avanzadas"\
		6 "Salir")
	if [ $? != 0 ]; then
		opcion=6
	fi
	
	case "$opcion" in 
		1)
			/proyecto/administracionUsuarios/adminUsuarios.sh 2>  archivo1.txt
			;;
		2) 
			/proyecto/programacionTareas/programacionTar.sh 2> archivo2.txt	
			;;
		3)	
            /proyecto/Mantenimiento/menuMantenimiento.sh 2>  archivo3.txt
			;;
        4)      
            /proyecto/Apartado3/menu.sh 2> archivo4.txt
            ;;
        5)
            /proyecto/funcionesavanzadas/funcionesavanzadas.sh 2> archivo5.txt
            ;;          
		6)    
			dialog --title "Cerrando sistema" --msgbox "Gracias por usar el sistema de reportes" 0 0
			clear			
		esac
 
done
