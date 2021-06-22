#!/bin/bash
opcion=0

#MENU PRINCIAL
while [ "$opcion" -ne "6" ]; do
	
	clear
	opcion=$(dialog  --title "FUNCIONES AVANZADAS" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "Baja masiva de usuarios"\
	        2 "Baja manual de usuarios" \
		3 "Busqueda de archivos o carpeta del usuario"\
		4 "Modificar permisos de archivos o carpetas del usuario"\
		5 "Alta de grupos manual"\
		6 "Regresar")
	if [ $? != 0 ]; then
		opcion=6
	fi
	
	case "$opcion" in 
		1) 
			clear
			bash /proyecto/funcionesavanzadas/baja.sh	
			;;		
		2) 	
			clear	
			bash /proyecto/funcionesavanzadas/Bajamanual.sh
			;;	
		3)
			clear
			bash /proyecto/funcionesavanzadas/Busq.sh
			;; 
       	4)
       		clear
       		bash /proyecto/funcionesavanzadas/chpr.sh
       		;;
		5) 
			clear
			bash /proyecto/funcionesavanzadas/grupo.sh
			;;
		6)	
			 ;;			
		esac
		done

