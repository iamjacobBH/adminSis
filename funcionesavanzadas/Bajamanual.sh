#!/bin/bash
 
			clear
			login=$(dialog --stdout --title "Login" --inputbox "Ingresa el login del usuario a borrar" 0 0)
			if [ ${#login} = 0 ] #validacion
			then
				 dialog --title "Información" --msgbox "No se realizó la operacion con exito se dejo el login vacio" 0 0
			else
				egrep "^$login" /etc/passwd >/dev/null #egrep busca el usuario en el archivo passwd
					if [ $? -eq 0 ]; then
						userdel -r $login #userdel elmina el usuario y todos sus directorios
						dialog --title "Información" --msgbox "Baja realizada con exito" 0 0	
					else
						
						dialog --title "Información" --msgbox "El usuario no existe!" 0 0
					fi
			fi
		
