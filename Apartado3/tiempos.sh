#!/bin/bash

#inicializamos variables
string=0
logname=0

#tomamos el usuario en la variable logname y mostramos un inputbox que lo pida
logname=$(dialog --stdout --title "Usuario" --inputbox "Ingrese el usuario:" 8 40)
#validamos que los campos no esten vacios
if [ ${#logname} = 0 ]
then
    dialog --title "Información" --msgbox "No se realizó la operacion con exito, uno o más campos se dejaron vacios" 0 0
else
    #validamos que el usuario exista
    getent passwd $logname > /dev/null

    if [ $? -eq 0 ]; 
    then
        #mostramos los tiempos entre sesiones del usuario
        string="$(last $logname | awk '{print $(NF)}')"
    	dialog --title "Tiempos entre sesiones del usuario $logname (HH:MM)" --msgbox "$string" 22 70
    else
        dialog --title "Tiempos entre sesiones del usuario $logname" --msgbox "\nEl usuario $logname no existe" 22 70
    fi
fi