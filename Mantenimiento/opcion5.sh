#!/bin/bash
opcion=0  #<-Inicializa Variable de opcion
	opcion=$(dialog --stderr --title "TAREAS DE MANTENIMIENTO" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "CREAR "\
       	2 "FORMATEAR" \
		3 "MONTAR"\
		4 "REGRESAR")
		
	if [ $? != 0 ]; then
		opcion=4
	fi
	#<-Dependiendo de que opcion sea seleccionada se ejecutara los comandos correspondientes
	case "$opcion" in 
		1)
		tam=0
		(dialog --title "Creado de particion" --msgbox "Se hara la 			particion automatica" 0 0);
        #se recibe el nombre del disco a particionar /dev/sdX
        nombre=$(dialog --title "nombre" --stdout --inputbox "Ingresa el nombre del disco a particionar:" 0 0);
        #Se recibe el numero de particion a realizar n (para tener -> /dev/sdXn)
        numero=$(dialog --title "Número de partición" --stdout --inputbox "Ingresa el número de partición:" 0 0);
        #<-Se recibe el tamaño de la particion dada por el usuario
		tam=$(dialog --title "tamaño" --stdout --inputbox "Pon el 			tamaño de la particion:" 0 0);
#<-Ejecuta todo el proceso de creacion de una particion como si estuvieramos en terminal las \n son saltos de lineas, n new particion , p partition primary, $tam el tamaño de la particion, w guardar particiones.
		echo -e "\nn\np\n$numero\n\n$tam\nw" | fdisk $nombre > archivox.txt
        sudo partprobe >>archivox.txt
		(dialog --title "creado" --msgbox "Creacion exitosa" 0 0);
			
			;;
		2) driver=0
		driver=$(dialog --title "nombre" --stdout --inputbox "Pon la ruta de la particion:" 0 0);
		argumento1="$driver" #<-Obtenemos la ruta de la particion
		clear
		mkfs.ext4 "$argumento1" #<-Formateamos la particion en archivos ext4 porque son los de uso comun
		(dialog --title "Formateo" --msgbox "Completado" 0 0);
			;;
		
		3)carpeta=0
		ruta=0	
		ruta=$(dialog --title "carpeta" --stdout --inputbox "Dame la particion a montar" 0 0);
			if ! grep -q "$ruta" /etc/fstab ; then #en caso de que no se encuentre en fstab, se añadirá la configuracion en el archivo
                carpeta=$(dialog --title "carpeta" --stdout --inputbox "Dame una carpeta en donde montaras el volumen (se creara)" 0 0);
		        mkdir "$carpeta" #<-Se crea carpeta en donde montaremos la particion y posteriormente pedimos la particion para agregarla al archivo /etc/fstab para completar el montaje
    			echo "$ruta $carpeta ext4 defaults 0 0" >> /etc/fstab
            fi
            mount $ruta
	(dialog --title "Montado" --msgbox "Completado" 0 0);
			;;
		4)
			clear
			;;			
		esac
 


