#!/bin/bash
clear
#inicializamos variables y limpiamos pantalla
rutaorigen=0
logname=0

#tomamos el usuario en la variable logname y mostramos un inputbox que lo pida
logname=$(dialog --stdout --title "Usuario" --inputbox "Ingrese el usuario:" 8 40)
#tomamos el usuario en la variable rutaorigen y mostramos un inputbox que lo pida
rutaorigen=$( dialog --stdout --title "Carpeta" --inputbox "Ingrese la carpeta que se respaldará" 0 0)
#validamos que los campos no esten vacios
if [ ${#logname} = 0 ] || [ ${#rutaorigen} = 0 ]
then
    dialog --title "Información" --msgbox "No se realizó la operacion con exito, uno o más campos se dejaron vacios" 0 0
else
    #validamos que el usuario exista
    getent passwd $logname > /dev/null

    if [ $? -eq 0 ]; 
    then
        #modificamos el archivo .profile para generar el backup cuando el usuario haga login
        archivo="/home/$logname/.profile"
        echo "/proyecto/Apartado3/backup.sh $rutaorigen /respaldos" >> $archivo
        dialog --title "Creado con exito" --msgbox "Se ha programado el respaldo para el siguiente inicio de sesion" 0 0
    else
        dialog --title "Usuario inexistente $logname" --msgbox "\nEl usuario $logname no existe" 22 70
    fi
fi