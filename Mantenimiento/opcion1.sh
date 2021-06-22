#!/bin/bash

opcion=0 #<-Inicializa Variable de opcion

	
	clear #<-Limpiamos pantalla por si queda algo en la terminal que intefiera a la presentacion del dialog
	#<-Se inicia el menu mediante un dialog 
	opcion=$(dialog --stderr --title "TAREAS DE MANTENIMIENTO" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "HABILITAR "\
       	2 "INHABILITAR" \
		3 "REGRESAR")
	if [ $? != 0 ]; then
		opcion=3
	fi
	#<-Dependiendo de que opcion sea seleccionada se ejecutara los comandos correspondientes para habilitar o deshabilitar el chequeo de particiones al arranque
	case "$opcion" in 
		1) 
		ruta=0	
		ruta=$(dialog --title "carpeta" --stdout --inputbox "Dame 			la particion que deseas Habilitar" 0 0);
        #<- Si la particion existe se habilitara el chequeo al arranque
		if grep -q "$ruta" /etc/fstab ; then
            nLinea=$(grep -n $ruta /etc/fstab | cut -d: -f1)
            linea=$(grep  $ruta /etc/fstab | sed  's/0 0/0 1/g')
            if [ ${#linea} = 0 ]; then
                linea=$(grep  /dev/sdb4 /etc/fstab | sed  's/0       0/0       1/g')
            fi
    		#echo "$ruta $carpeta ext4 defaults 0 1" 		>> /etc/fstab
            sed -i "$nLinea d" /etc/fstab
            echo $linea >> /etc/fstab	
        fi
			
			;;
		2) 
		ruta=0	
		ruta=$(dialog --title "carpeta" --stdout --inputbox "Dame 			la particion que deseas Inhabilitar" 0 0);
        #<- Si la particion existe se Inhabilitara el chequeo al arranque
		if grep -q "$ruta" /etc/fstab ; then
             nLinea=$(grep -n $ruta /etc/fstab | cut -d: -f1)
             linea=$(grep  $ruta /etc/fstab | sed  's/0 1/0 0/g')
             sed -i "$nLinea d" /etc/fstab
             echo $linea >> /etc/fstab	
		fi	
				
			;;
		3)	#<-Regresamos al menu mantenimiento
					clear		
			;;
			
		esac
 
