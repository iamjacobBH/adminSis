#!/bin/bash

opcion=0 #<-Inicializa Variable de opcion
while [ "$opcion" -ne "5" ]; do
#<-Se inicia el menu mediante un dialog 
	opcion=$(dialog --stderr --title "TAREAS DE MANTENIMIENTO" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "CHEQUEO"\
       	2 "DESMONTAR VOLUMEN" \
		3 "CORREGIR ERRORES"\
		4 "MOSTRAR VOLUMENES"\
		5 "REGRESAR")
	if [ $? != 0 ]; then
		opcion=5
	fi
	#<-Dependiendo de que opcion sea seleccionada se ejecutara los comandos correspondientes
	case "$opcion" in 
		1)
		ruta=0	
        #<- Ruta obtenida por un inputbox dada por el usuario
		ruta=$(dialog --title "carpeta" --stdout --inputbox "Dame 			la particion que deseas Chequear (para comprobar errores 			desmontalo primero)" 0 0);
		clear
		fsck "$ruta" #<-Comprueba la particion dada por el usuario
		sleep 5	 	#<- espera de 5 segundos
		;;
		2) ruta1=0	
	
		ruta1=$(dialog --title "carpeta" --stdout --inputbox "Dame 			la particion que deseas desmontar" 0 0);
		clear
		umount "$ruta1"  #<-Desmonta la particion dada por el usuario 
		(dialog --title "Información" --msgbox "Disco desmontado" 0 0);  #<-Informa la realización de la tarea
		;;	
				
		3)ruta2=0	
	
		ruta2=$(dialog --title "carpeta" --stdout --inputbox "Dame 			la particion que deseas corregir" 0 0);
		clear
		fsck -y "$ruta1"  #<-Corrige errores(si existen) de la particion dada por el usuario
		(dialog --title "Información" --msgbox "Disco corregido (en caso de haber sido necesario)" 0 0); #<-Informa la realización de la tarea
			
			;;
		4)
		  clear
		  df -l > temp
          dialog --stdout --title "Lista particiones" --textbox ./temp 0 0 #<-Muestra la lista de particiones
          rm temp		 
          # sleep 8	
           
			;;
		5)	
			;;
						
		esac
done
