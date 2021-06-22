#!/bin/bash
opc=0
#Menu 
while [ "$opc" -ne "3" ]; do 
	
	clear
	opc=$(dialog  --title "FUNCIONES ESPECIALES" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "busqueda de directorio"\
	        2 "busqueda de archivo" \
		3 "Regresar")

	if [ $? != 0 ]; then
		opc=3
	fi
	case "$opc" in 
1)
clear
login=$(dialog  --stdout --title "LOGIN" --inputbox "Dame el nombre del usuario" 0 0 )
egrep "^$login" /etc/passwd >/dev/null #busca el login en passwd 
if [ $? != 0  ]; then
dialog --title "Información" --msgbox "El usuario no existe!" 0 0 
else

carpeta=$(dialog  --stdout --title "LOGIN" --inputbox "Dame el nombre de la carpeta" 0 0 )
	if [ ${#carpeta} = 0  ]; then #validacion
				dialog --title "Información" --msgbox "No se realizó la operacion con exito, ruta vacia" 0 0
	else	
	string="$(find /home/$login -type d -name $carpeta)" #find con el parametro type d para buscar directorios 
	if [ ${#string} != 0 ]; then #validacion
    find /home/$login -type d -name $carpeta >temp
    dialog --stdout --title "Información - resultados busqueda" --textbox ./temp 0 0	
    rm temp
else 
	dialog --title "Información - resultados busqueda" --msgbox "No se encontraron coincidencias " 0 0
	fi
	fi
	fi
	;;

2) 
clear
login=$(dialog  --stdout --title "LOGIN" --inputbox "Dame el nombre del usuario" 0 0 )
egrep "^$login" /etc/passwd >/dev/null #egrep para buscar el login en paswwd
if [ $? != 0  ]; then #validacion
dialog --title "Información" --msgbox "El usuario no existe!" 0 0 
else
archivo=$(dialog  --stdout --title "LOGIN" --inputbox "cual es el nombre y formato del archivo" 0 0 )
if [ ${#archivo} = 0  ]; then #validacion
				dialog --title "Información" --msgbox "No se realizó la operacion con exito, ruta vacia" 0 0
	else	
	salida="$(find /home/$login -name $archivo)" #fin para buscar el archivo en el directorio del usuario
	if [ ${#salida} != 0 ]; then  #validacion
      find /home/$login -name $archivo >temp
	  dialog --stdout --title "Información - resultados busqueda archivos" --textbox ./temp 0 0	
      rm temp
	else 
	dialog --title "Información" --msgbox "No se encontro el archivo en la ruta especificada " 0 0
	fi
	fi
	fi
	;;

3)    
	;;
	esac
	
done
