#!/bin/bash
#<-Se muestra un mensaje mediante dialog que advierte al usuario que tiene determinado tiempo para evitar la ejecucion del init
(dialog --title "MONOUSUARIO" --msgbox "LA COMPUTADORA PASARA A MODO MONOUSUARIOS DENTRO DE 120 SEGUNDOS, SI DESEA CANCELAR PRESIONE CRTL+C" 0 0)
echo "Estimados usuarios, se haran tareas de mantenimiento en 120 segundos" | wall #<-iformamos a los demás usuarios sobre las tareas de mantenimiento
sleep 120  #<-Retardo de 120 segundos para seguir con la ejecucion del bash
		init 1 #<-comando para el Nivel de arranque 1
