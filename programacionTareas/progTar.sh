#!/bin/bash
m="*"
h="*"
dd="*"
d="*"
mm="*"
user=`whoami`
comando=""
exec 3>&1
#mostramos formulario para recuperar los datos de la programación de tarea
dialog --separate-widget $'\n' --ok-label "Programar" \
          --title "Programación de tarea manual" \
          --form "Ingrese los datos correspondientes" \
15 80 0 \
        "Minuto (0-59/*):" 1 1 "$m"         1 30 40 0 \
        "Hora (0-24/*):"    2 1 "$h"        2 30 40 0 \
        "Día del mes:"    3 1 "$d"       3 30 40 0 \
        "Mes (1-12/*):"     4 1 "$mm"         4 30 40 10 \
        "Día de la semana (0-6/*):"     5 1 "$dd"         5 30 40 0 \
        "Usuario:"     6 1 "$user"         6 30 40 0 \
        "Script (ruta absoluta):"     7 1 "$comando"         7 30 40 0 \
2>&1 1>&3 | {
 #leemos en las variables los datos obtenidos con el formulario
  read -r m
  read -r h
  read -r d
  read -r mm
  read -r dd
  read -r user
  read -r comando
  #en caso de haber existido un codigo de salido diferente de 1, se procede a mostrar el mensaje de operacion cancelada
  if [ $? != 0 ]; then
	    dialog --title "Información" --msgbox "programación de tarea cancelada" 0 0
        clear
  else
        #comprobamos que no nos haya dejado el campo de "comando" vacio.
        if [ ${#comando} != 0 ] 
        then
            clear
            #procedemos a colocar en el crontab del usuario correspondiente la linea con la configuracion obtenida.
            (crontab -u $user -l 2>/dev/null; echo "$m $h $d $mm $dd $comando" ) | crontab -u $user -
            dialog --title "Información" --msgbox "Se programó la tarea con exito" 0 0
            clear
        else
            #informamos que se ha dejado un campo vacio.
            dialog --title "Información" --msgbox "programación de tarea no realizada, no puede dejar el campo SCRIPT vacio" 0 0
        fi
  fi

    

}
exec 3>&-
