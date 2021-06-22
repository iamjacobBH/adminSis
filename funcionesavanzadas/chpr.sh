#!/bin/bash
opc=0
while [ "$opc" -ne "5" ]; do
	
	clear
	opc=$(dialog  --title "CAMBIO DE PERMISOS" --menu --stdout  "QUE PERMISOS QUIERE OTORGAR" 0 0 0 		1 "TODOS LOS PERMISOS"	        2 "LECTURA Y ESCRITURA"		3 "LECTURA Y EJECUCION"		4 "LECTURA ESCRITURA Y EJECUCION"							5 "Regresar")
	if [ $? != 0 ]; then
		opc=5
	fi	
	case "$opc" in 	
1)
clear
ruta=$(dialog --stdout --title "RUTA" --inputbox "ruta de la carpeta o archivo que quieres modificar los permisos " 0 0)
if [ ${#ruta} = 0  ]; then #validacion de ruta
				dialog --title "Información" --msgbox "No se realizó la operacion con exito, ruta vacia" 0 0
	else
    chmod 777 $ruta #777 da todos los permisos
    if [ $? -eq 0 ]; then
    dialog --title "Información" --msgbox "Se cambiaron los permisos" 0 0
    else 
    dialog --title "Información" --msgbox "No se cambiaron los permisos" 0 0
    fi
    fi
    ;;
2)
clear
ruta=$(dialog --stdout --title "RUTA" --inputbox "ruta de la carpeta o archivo que quieres modificar los permisos " 0 0)
if [ ${#ruta} = 0  ]; then
				dialog --title "Información" --msgbox "No se realizó la operacion con exito, ruta vacia" 0 0
	else
    chmod 666 $ruta #666 da permisos de lectura y escritura
        if [ $? -eq 0 ]; then #validacion
    dialog --title "Información" --msgbox "Se cambiaron los permisos" 0 0
    else 
    dialog --title "Información" --msgbox "No se cambiaron los permisos" 0 0
    fi
    fi
    ;;
3)
clear
ruta=$(dialog --stdout --title "RUTA" --inputbox "ruta de la carpeta o archivo que quieres modificar los permisos " 0 0)
if [ ${#ruta} = 0  ]; then #validacion ruta
				dialog --title "Información" --msgbox "No se realizó la operacion con exito, ruta vacia" 0 0
	else	
    chmod 755 $ruta #lectura y ejecucion 755
        if [ $? -eq 0 ]; then
    dialog --title "Información" --msgbox "Se cambiaron los permisos" 0 0
    else 
    dialog --title "Información" --msgbox "No se cambiaron los permisos" 0 0
    fi
    fi
    ;;
4)
clear
ruta=$(dialog --stdout --title "RUTA" --inputbox "ruta de la carpeta o archivo que quieres modificar los permisos " 0 0)
if [ ${#ruta} = 0  ]; then #validacion
				dialog --title "Información" --msgbox "No se realizó la operacion con exito, ruta vacia" 0 0
	else	
    chmod 700 $ruta #700 lectura escritura y ejecucion
        if [ $? -eq 0 ]; then #validacion
    dialog --title "Información" --msgbox "Se cambiaron los permisos" 0 0
    else 
    dialog --title "Información" --msgbox "No se cambiaron los permisos" 0 0
    fi
    fi 
    ;;
5)    
;;
esac
done
