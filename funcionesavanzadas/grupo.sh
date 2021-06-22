#!/bin/bash
opc=0
while [ "$opc" -ne "3" ]; do
	
	clear
	opc=$(dialog  --title "ALTA DE GRUPO" --menu --stdout  "QUE QUIERE HACER?" 0 0 0 \
		1 "CREAR GRUPO"\
	       2 "AÑADIR USUARIO A GRUPO" \
		3 "Regresar")
	if [ $? != 0 ]; then
		opc=3
	fi
	
	case "$opc" in 
	
1)
grupo=$(dialog --stdout --title "GRUPO" --inputbox "nombre del grupo que quieres crear " 0 0)
if [ ${#grupo} = 0  ]; then #validacion
				dialog --title "Información" --msgbox "No se realizó la operacion con exito, grupo vacio" 0 0
				else
    groupadd $grupo #groupadd crea un grupo nuevo
    dialog --title "Información" --msgbox "Se realizó la operacion con exito " 0 0
    fi
    ;;
2)
grupo=$(dialog --stdout --title "GRUPO" --inputbox "nombre del grupo al que vas a añadir al usuario " 0 0)
login=$(dialog --stdout --title "LOGIN" --inputbox "Dame el nombre de usuario " 0 0)
    			if [ ${#login} = 0 ] || [ ${#grupo} = 0 ] #validacion
			then
				 dialog --title "Información" --msgbox "No se realizó la operacion con exito, uno o más campos se dejaron vacios" 0 0
			else
				 egrep "^$login" /etc/passwd >/dev/null #egrep busca el login en passwd
				 if [ $? -eq 0 ]
				 then 
				 egrep "^$grupo" /etc/group >/dev/null  #egrep busca el login en group
				 if [ $? -eq 0 ]
				 then
				 usermod -a -G $grupo $login #usermod modifica el usuario con los parametros dados añade el usuario al grupo
					    dialog --title "Información" --msgbox " Se realizó la operacion con exito" 0 0	
					    						    					 	  
				 else 
					    dialog --title "Información" --msgbox "No se realizó la operacion con exito" 0 0
					    

					
		fi	
	fi
	fi				    
    ;;
3)
;;
esac
done

#groupadd $grupo
#usermod -a -G $grupo $login
