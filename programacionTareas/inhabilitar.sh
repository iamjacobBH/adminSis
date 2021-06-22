#!/bin/bash
m=""
h=""
d=""
mm=""
m2=""
h2=""
d2=""
mm2=""
user=""
a=""
a2=""
exec 3>&1
#Con el siguiente formulario pediremos los datos para la inhabilitación del usuario y su posterior habilitacion.
dialog --separate-widget $'\n' --ok-label "Programar" \
          --title "Programación de inhabilitación de usuario" \
          --form "Ingrese la fecha y el usuario al que se inhabilitará, después la fecha de habilitación" \
0 0 0 \
        "Minuto (0-59):" 1 1 "$m"         1 30 40 0 \
        "Hora (0-24):"    2 1 "$h"        2 30 40 0 \
        "Día del mes:"    3 1 "$d"       3 30 40 0 \
        "Mes (1-12):"     4 1 "$mm"         4 30 40 10 \
        "Año:"            5 1 "$a"          5 30 40 10 \
        "Usuario:"     6 1 "$user"         6 30 40 0 \
        "Minuto (0-59):"     8 1 "$m2"         8 30 40 0 \
        "Hora (0-24):"    9 1 "$h2"        9 30 40 0 \
        "Día del mes:"    10 1 "$d2"       10 30 40 0 \
        "Mes (1-12):"     11 1 "$mm2"         11 30 40 10 \
        "Año:"            12 1 "$a2"          12 30 40 10 \
2>&1 1>&3 | {
  read -r m
  read -r h
  read -r d
  read -r mm
  read -r a
  read -r user
  read -r m2
  read -r h2
  read -r d2
  read -r mm2
  read -r a2
  if [ $? != 0 ]; then #en caso de que se haya cancelado la operación, informamos sobre ello.
	    dialog --title "Información" --msgbox "programación de inhabilitación de usuario cancelada" 0 0
        clear
  else
        if [ ${#user} != 0 ] #comprobamos que nos hayan dado el nombre de un usuario.
        then
            clear
            #programamos con AT la deshabilitacion con los datos obtenidos en el formulario
            echo  "sudo usermod -L  $user"  | at  "$h:$m $a-$mm-$d" 2> h.txt 
            #programamos con AT la habilitación con los datos obtenidos en el formulario (parte2)
            echo  "sudo usermod -U  $user"  | at  "$h2:$m2 $a2-$mm2-$d2" 2>>h.txt
            dialog --title "Información" --msgbox "Se programó la inhabilitación con exito" 0 0
            clear
        else
            #en caso de que nos hayan dejado el nombre del usuario vacio, informamos que no se realizará la inhabilitación.
            dialog --title "Información" --msgbox "programación de inhabilitación no realizada, no puede dejar campos vacios" 0 0
        fi
  fi

    

}
exec 3>&-
