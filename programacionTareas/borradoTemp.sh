#!/bin/bash
m="*"
h="*"
dd="*"
d="*"
mm="*"
dias=""
comando=""
user=`whoami`
exec 3>&1
#constrimos un formulario, recuperaremos los datos para programar el borrado de temporales
dialog --separate-widget $'\n' --ok-label "Programar" \
          --title "Borrado de temporales" \
          --form "Ingrese los datos correspondientes" \
15 80 0 \
        "Minuto (0-59/*):" 1 1 "$m"         1 30 40 0 \
        "Hora (0-24/*):"    2 1 "$h"        2 30 40 0 \
        "Día del mes:"    3 1 "$d"       3 30 40 0 \
        "Mes (1-12/*):"     4 1 "$mm"         4 30 40 10 \
        "Día de la semana (0-6/*):"     5 1 "$dd"         5 30 40 0 \
        "Días sin modificacines:"     7 1 "$dias"         7 30 40 0 \
2>&1 1>&3 | {
  #leemos los datos del formulario
  read -r m
  read -r h
  read -r d
  read -r mm
  read -r dd
  read -r dias
 if [ $? != 0 ]; then #en caso de que exista un codigo de salida diferente de 0, significa que se ha cancelado la operacion.
	    dialog --title "Información" --msgbox "Programación de borrado de temporales cancelada" 0 0
        clear
  else
        if [ ${#dias} != 0 ] #si el numero de días es diferente de 0, procedemos con la programación. Si se quedase en 0 podría causar problemas
        then
            #el script borradoP recibe como parametro el numero de días.
            comando=`echo /proyecto/programacionTareas/borradoP.sh $dias`
            clear
            #realizamos la modificacion del crontab para la programación del borrado de temporales.
            (crontab -u $user -l 2>/dev/null; echo "$m $h $d $mm $dd $comando" ) | crontab -u $user -
            dialog --title "Información" --msgbox "Se programó el borrado de temporales con exito" 0 0
            clear
        else #en caso de que se haya dejado vacio el numero de días, se muestra un mensaje de error.
            dialog --title "Información" --msgbox "Error, numero de días no puede estar vacio; programación cancelada" 10 30
        fi
  fi

    

}
exec 3>&-
