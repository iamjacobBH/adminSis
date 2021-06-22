#!/bin/bash

#usamos esta funcion para la alta masiva de usuarios.
alta () {
#realizamos el ciclo mientras exista lineas en el archivo $ruta
while read line; do 
    #obtenemos el login del archivo
	login=`echo $line | cut -d: -f1`
    #utilizamos el comando useradd para agregar el usuario y -m para que nos cree el directorio home
	useradd -m $login 
    #recuperamos la contraseña del archivo
	passwd=`echo $line | cut -d: -f2`
    #cambiamos la contraseña con chpasswd
	echo "$line" | chpasswd 

done < $ruta
}
#utilizamos esta funcion para realizar el cambio de contraseñas
cambioPassword () {
#mientras existan lineas, hacemos lo dicho en el ciclo
while read line; do 
    #dado a que el formato del archivo es "user:pasword" solo es necesario pasarla al comando chpasswd
	echo "$line" | chpasswd 
done < $ruta
}
opc=0

#MENU PRINCIAL
#mostramos menu y ejecutamos script hasta que la opcion seleccionada sea la 5
while [ "$opc" -ne "5" ]; do
	
	clear
    #recuperamos la opcion en la variable "opc"
	opc=$(dialog  --title "ADMINISTRADOR DE USUARIOS" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "Alta masiva de usuarios"\
	       	2 "Alta manual de usuarios" \
		3 "Cambio masivo de contraseña"\
		4 "Cambio manual de contraseña"\
		5 "Regresar")
    #en caso de que exista una salida, seleccionamos la opcion 5
	if [ $? != 0 ]; then
		opc=5
	fi
	#casos para el valor de opc
	case "$opc" in 
		1) 
            #recuperamos con un dialogo de entrada la ruta del archivo que contiene los usuarios a dar de alta
			ruta=$(dialog --stdout --title "ruta" --inputbox "ruta del archivo de donde se tomarán los usuarios" 0 0)
			if [ ${#ruta} = 0  ]; then #comprobamos que nos hayan dado una ruta
				dialog --title "Información" --msgbox "No se realizó la operacion con exito, ruta vacia" 0 0
			else
				if [ -f "$ruta" ] #comprobamos que el archivo exista
				then
					alta #vamos a la funcion altas
					dialog --title "Información" --msgbox "Altas realizadas con exito" 0 0
				else #en caso de no existir el archivo, mostramos el mensaje
					dialog --title "Error" --msgbox "No se realizó la operacion con exito, archivo inexistente" 0 0
				fi
			fi
			;;
		2)  #opcion alta usuario manual
			clear
            #recuperamos login y contraseña
			login=$(dialog --stdout --title "Login" --inputbox "Ingresa el login del usuario" 0 0)
			password=$( dialog --stdout --title "Contraseña" --passwordbox "Pon tu contraseña:" 0 0)
			if [ ${#login} = 0 ] || [ ${#password} = 0 ] #confirmamos que no esten vacios los campos
			then
				 dialog --title "Información" --msgbox "No se realizó la operacion con exito, uno o más campos se dejaron vacios" 0 0
			else
				egrep "^$login" /etc/passwd >/dev/null #comprobamos que no exista el usuario
					if [ $? -eq 0 ]; then
						dialog --title "Información" --msgbox "El usuario ya existe!" 0 0
					else
						useradd -m $login #creamos usuario
						echo "$login:$password" | chpasswd #cambiamos su contraseña
						dialog --title "Información" --msgbox "Alta realizada con exito" 0 0	
					fi
			fi
			;;
		3) #cambio masivo de contraseñas
			clear
            #pedimos ruta del archivo que contiene las contraseñas
            		ruta=$(dialog --stdout --title "ruta" --inputbox "ruta del archivo de donde se tomarán las contraseñas" 0 0)
			if [ ${#ruta} = 0  ]; then #validamos que nos hayan dado una ruta
				dialog --title "Información" --msgbox "No se realizó la operacion con exito, ruta vacia" 0 0
			else
				if [ -f "$ruta" ] #comprobamos que el archivo exista
				then
					cambioPassword #vamos a la funcion cambioPassword
					dialog --title "Información" --msgbox "cambio de contraseñas realizado con exito" 0 0
				else
					dialog --title "Error" --msgbox "No se realizó la operacion con exito, archivo inexistente" 0 0
				fi
			fi
			;;
        4)  #cambio manual de contraseñas
            clear
            #recuperamos el login y la nueva contraeña
			login=$(dialog --stdout --title "Login" --inputbox "Ingresa el login del usuario" 0 0)
			password=$( dialog --stdout --title "Nueva contraseña" --passwordbox "Ingrese la nueva contraseña:" 0 0)
			if [ ${#login} = 0 ] || [ ${#password} = 0 ] #comprobamos que no nos hayan dejado campos vacios
			then
				 dialog --title "Información" --msgbox "No se realizó la operacion con exito, uno o más campos se dejaron vacios" 0 0
			else
				egrep "^$login" /etc/passwd >/dev/null #comprobamos que el usuario exista.
					if [ $? -eq 0 ]; then #cambiamos la contraseña
					        echo "$login:$password" | chpasswd
						dialog --title "Información" --msgbox "Cambio realizado con exito" 0 0	
					else      #en caso de que no se encuentre el usuario lo dejamos saber
                			        dialog --title "Información" --msgbox "El usuario ingresado no existe!" 0 0
					fi
			fi
			;;

		5)  ;;			#regresamos
		esac
 
done

