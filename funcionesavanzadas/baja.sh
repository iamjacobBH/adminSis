#!/bin/bash
baja () {

while read line; do #lee solo el login del archivo

	login=`echo $line | cut -d: -f1`
	userdel -r $login #userdel -r elimina el usuario y todos sus directorios
done < $ruta
}
ruta=$(dialog --stdout --title "ruta" --inputbox "ruta del archivo de donde se tomarán los usuarios" 0 0)
			if [ ${#ruta} = 0  ]; then #validacion 
				dialog --title "Información" --msgbox "No se realizó la operacion con exito, ruta vacia" 0 0
			else
				if [ -f "$ruta" ] #validacion
				then
					baja
					dialog --title "Información" --msgbox "bajas realizadas con exito" 0 0
				else
					dialog --title "Error" --msgbox "No se realizó la operacion con exito, archivo inexistente" 0 0
				fi
			fi

