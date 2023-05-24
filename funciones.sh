#!/bin/bash

#Listado de las opciones

OPCION_LISTAR=1
OPCION_INFO=2
OPCION_INICIAR=3
OPCION_REINICIAR=4
OPCION_PAUSAR=5
OPCION_REANUDAR=6
OPCION_APAGAR=7
OPCION_SALIR=8

menu_opcion=(
    [$OPCION_LISTAR]="Mostrar las máquinas."
    [$OPCION_INFO]="Mostrar con detalles la información de una máquina."
    [$OPCION_INICIAR]="Iniciar una máquina"
    [$OPCION_REINICIAR]="Reiniciar una máquina"
    [$OPCION_PAUSAR]="Pausar una máquina"
    [$OPCION_REANUDAR]="Reanudar una máquina"
    [$OPCION_APAGAR]="Apagar una máquina"
    [$OPCION_SALIR]="Salir"
)

function f_mostraropciones {
    echo "Menú principal:"
    for opcion in "${!menu_opcion[@]}"; do
    echo "$opcion: ${menu_opcion[$opcion]}"
    done
}

# Funcion para comprobar si el paquete está instalado.
function f_esta_instalado {
    if dpkg -S "$1" >/dev/null 2>&1
		then
			return 0
		else
			return 1
	fi
}



# Funcion que lista las maquinas del VM, verifica si hay máquina activa y excluye las lineas vacías. 
function f_listarmaquinas {
    if virsh list --all --name | grep -q -v "^$"
    then
        printf "Listando maquinas...\n\n"
        virsh list --all
    else
        echo "No tienes máquinas disponibles."
    fi
}

#Función para comprobar si existe la máquina
function f_check_maquina  {
    if virsh dominfo "$1" > /dev/null 2>&1; then 
        return 0
    else
        return 1
    fi
}

# Función para proporciona información sobre la máquina seleccionada.
function f_infomaquinas {
    if f_check_maquina "$1"; then
        virsh dominfo "$1"
    else
        echo "La máquina no existe"
    fi
}
#Función para encender una máquina.
function f_iniciarmaquina {
    if f_check_maquina "$1"; then
        virsh start "$1"
    else
        echo "La máquina no existe"
    fi
}

#Función para apagar la máquina seleccionada.
function f_apagarmaquina {
    if f_check_maquina "$1"; then
        virsh shutdown "$1"
    else
        echo "La máquina no existe"
    fi
}
#Función para pausar una máquina elegida.
function f_pausarmaquina {
    if f_check_maquina "$1"; then
        virsh suspend "$1"
    else
        echo "La máquina no existe"
    fi
}

#Función para reanudar una máquina seleccionada.
function f_reanudarmaquina {
    if f_check_maquina "$1"; then
        virsh resume "$1"
    else
        echo "La maquina no existe"
    fi
}

#Función para reiniciar una máquina seleccionada.
function f_reinicarmaquina {
    if f_check_maquina "$1"; then
        virsh reboot "$1"
    else
        echo "la maquina no existe"
    fi 
}

#function f_borrarmaquina {
#    if f_check_maquina "$1"; then 
#        virsh undefine --remove-all-storage "$1"
#    else 
#        echo "La maquina no existe."
#    fi 
#}

