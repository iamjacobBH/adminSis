#!/bin/bash
case $# in #comprobamos que nos hayan pasado parametros.
	0) 	dialog --title "Información" --msgbox "Se necesita como parametro la carpeta a respaldar y la carpeta de respaldos" 0 0
		exit 1;;
esac
    aux=`tr '[;%"#$&//)*:]'  '_' <<< $1` "transformamos cualquier caracter dado (de los que estan entre corchetes) por "_""
	archivo="resp$aux$( date +'%d_%m_%y_%H_%M' )"
	carpeta=$1
    #realizamos el respaldo de la carpeta dada
	tar -czvf "${archivo}.tar.gz" $carpeta
    #movemos el archivo de respaldo a la carpeta de respaldos 
	mv "${archivo}.tar.gz" $2
	echo "Respaldo terminado"
