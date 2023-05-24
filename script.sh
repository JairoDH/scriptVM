#!/bin/bash

#Descripción: Script para gestionar las máquinas creadas en VM.
#Autor: Jairo Domínguez Hidalgo
#Descripción: Con este Script se gestiona máquinas virtuales mediante comandos. Con permisos privilegiados, hay que ejecutar el script (./script.sh) desde el directorio dónde se encuentre el fichero
#para usar las opciones hay que pasarlo como parámetro del comando (./script.sh listar) y para seleccionar la máquina como argumento (./script.sh info <nombre_máquina>)

. ./funciones.sh


# Comprobar si virsh está instalado
comando="virsh"

if ! f_esta_instalado "$comando"; then
    echo "El comando '$comando' no está instalado."
    exit 1
fi

echo "Bienvenido al script para gestionar tus máquinas del software V"
# listar todas las opciones
f_mostraropciones

usuario_opcion=0

while [[ $usuario_opcion != "$OPCION_SALIR" ]]; do
echo -n "introduce una opcion: "
read -r usuario_opcion
    #Lista todas las máquinas
    if [ "$usuario_opcion" = "$OPCION_LISTAR" ]; then
        f_listarmaquinas
        f_mostraropciones
    #información de la máquina elegida.    
    elif [ "$usuario_opcion" = "$OPCION_INFO" ]; then
        echo "Introduce el nombre de la máquina: "
        read -r nombre_maquina
        if [ "$nombre_maquina" != "" ]; then
            echo "info de la maquina: " "$nombre_maquina" 
            f_infomaquinas "$nombre_maquina"
            f_mostraropciones
        else
            echo "Tienes que elegir la máquina que deseas ver: "
            f_listarmaquinas
            f_mostraropciones
        fi
    #Inicia una máquina elegida.
    elif [ "$usuario_opcion" = "$OPCION_INICIAR" ]; then
        echo "Introduce el nombre de la máquina: "
        read -r nombre_maquina
        if [ "$nombre_maquina" != "" ]; then
            echo "iniciando la maquina: " "$nombre_maquina" 
            f_iniciarmaquina "$nombre_maquina"
            f_mostraropciones
        else
            echo "Tienes que elegir una maquina para iniciar: "
            f_listarmaquinas
            f_mostraropciones
        fi
    elif [ "$usuario_opcion" = "$OPCION_PAUSAR" ]; then
        echo "Introduce el nombre de la máquina: "
        read -r nombre_maquina
        if [ "$nombre_maquina" != "" ]; then
            echo "Pausando la maquina: " "$nombre_maquina"
            f_pausarmaquina "$nombre_maquina"
            f_mostraropciones
        else
            echo "Tienes que elegir la maquina que deseas pausar."
            f_listarmaquinas
            f_mostraropciones
        fi
    elif [ "$usuario_opcion" = "$OPCION_REANUDAR" ]; then
        echo "Introduce el nombre de la máquina: "
        read -r nombre_maquina
        if [ "$nombre_maquina" != "" ]; then
            echo "Reanudando la maquina: " "$nombre_maquina"
            f_reanudarmaquina "$nombre_maquina"
            f_mostraropciones
        else
            echo "Tienes que elegir la maquina que deseas reanudar."
            f_listarmaquinas
            f_mostraropciones
        fi
    elif [ "$usuario_opcion" = "$OPCION_APAGAR" ]; then
        echo "Introduce el nombre de la máquina: "
        read -r nombre_maquina
        if [ "$nombre_maquina" != "" ]; then
            echo "apagando la maquina: " "$nombre_maquina" 
            f_apagarmaquina "$nombre_maquina"
            f_mostraropciones
        else
            echo "Tienes que elegir la maquina que deseas apagar."
            f_listarmaquinas
            f_mostraropciones
        fi
    elif [ "$usuario_opcion" = "$OPCION_REINICIAR" ]; then
        echo "Introduce el nombre de la máquina: "
        read -r nombre_maquina
        if [ "$nombre_maquina" != "" ]; then
            echo "Reiniciando la máquina: " "$nombre_maquina"
            f_reinicarmaquina "$nombre_maquina"
            f_mostraropciones
        else    
            echo "Tienes que elegir la máquina que deseas reniciar."
            f_listarmaquinas
            f_mostraropciones
        fi
    else
        echo "opción no válida."
    fi
done
# Errores al intentar borrar la máquina.

#elif [ "$1" = "borrar" ]; then
#    clear 
#    if [ "$2" != "" ]; then
#        echo "Borrando máquina: " "$2"
#        f_borrarmaquina "$2"
#    else
#        echo "Tienes que elegir la máquina que deseas borrar."
#    fi
