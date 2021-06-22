#!/bin/bash
opcion=0 #<-Inicializa Variable de opcion

while [ "$opcion" -ne "7" ]; do
#<-Se inicia el menu mediante un dialog 
	opcion=$(dialog --stderr --title "TAREAS DE MANTENIMIENTO" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "MODO 0 APAGADO"\
       	2 "MODO 6 REINICIO" \
		3 "MODO 1 MONOUSUARIO"\
		4 "MODO 2 MULTIUSUARIO SIN RED"\
		5 "MODO 5 CON GRAFICOS"\
		6 "MODO 3 MULTIUSUARIO SIN RED"\
		7 "REGRESAR" ) 
		
	if [ $? != 0 ]; then
		opcion=7
	fi
	#<-Dependiendo de que opcion sea seleccionada se ejecutara los comandos correspondientes para el nivel de arranque
	case "$opcion" in 
		1)
        #<-Mensaje de advertencia para el usuario
		(dialog --title "Apagado" --msgbox "Se APAGARA la 	    			computadora" 0 0)
		init 0 #<-Nivel de arranque 0 (apagado)
		;;
		2)
        #<-Mensaje de advertencia para el usuario
		(dialog --title "REINICIO" --msgbox "Se REINICIARA la 	    			computadora" 0 0);	
		init 6 #<-Nivel de arranque 6 (reinicio)
		;;
		3)
        #<-Mensaje de advertencia para el usuario
		(dialog --title "MONOUSUARIO" --msgbox "Se INICIARA EN 				MODO MONOUSUARIO la computadora" 0 0)
		init 1 #<-Nivel de arranque 1
		;;	
		4)
        #<-Mensaje de advertencia para el usuario
		(dialog --title "MULTIUSUARIO" --msgbox "Se INICIARA EN 			MODO MULTIUSUARIO SIN RED la computadora" 0 0)		
		init 2 #<-Nivel de arranque 2
		;;  
		5) 
        #<-Mensaje de advertencia para el usuario
		(dialog --title "GRAFICO" --msgbox "Se INICIARA EN 				MODO GRAFICO la computadora" 0 0)	  
		init 5 #<-Nivel de arranque 5
		;;
		6)  
        #<-Mensaje de advertencia para el usuario
		(dialog --title "MULTIUSUARIO" --msgbox "Se INICIARA EN 				MODO MULTIUSUARIO CON RED la computadora" 0 0) 
		init 3 #<-Nivel de arranque 3
		;;
		
		7)
			
			clear
			;;		
						
		esac
done
