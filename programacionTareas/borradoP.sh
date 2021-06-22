#!/bin/bash
if [ $# == 0 ] #verificamos que se nos hayan pasado parametros
then
    dialog --title "borrado de temporales abortado" --msgbox "Operación cancelada, se necesita como parametro el numero de días" 0 0
    exit 1 #si no nos pasan parametros, cerramos con error.
fi
dias=$1
#borramos los archivos temporales en el directorio /tmp que lleven $dias sin modificaciones
cd /tmp && { find . -type f -mtime +$dias -exec rm -rf -- {} \; ; } >errores.txt  
#borramos los archivos temporales en el directorio /var/tmp que lleven $dias sin modificaciones
cd /var/tmp && { find . -type f -mtime +$dias -exec rm -rf -- {} \; ; } >errores.txt
#en caso de que exista algun error, lo podremos ver en el archivo errores.txt
echo "borrado compleatado"

