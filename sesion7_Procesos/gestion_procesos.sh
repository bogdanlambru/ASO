#!/bin/bash

listar_usuario(){
    ps -u boglam -o pid,stat,%cpu,%mem,cmd
}

buscar_proyecto(){
    read -p "Introduce el proceso que quieres listar. " proceso 
    ps -C $proceso -o pid,user,%cpu,cmd
}

top_cpu(){
    $N="5"
    ps -C -o pid,stat,%cpu,%mem,cmd --sort=%cpu
}



echo "===== GESTIÓN DE PROCESOS ====="
echo "1) Listar los procesos de un usuario"
echo "2) Buscar un proceso por nombre"
echo "3) Mostrar los N procesos que más CPU consumen"
echo "4) Cambiar la prioridad de un proceso"
echo "5) Finalizar un proceso"
echo "6) Salir"

read -p "Opción: " opcion

while [[ $opcion -ne 6 ]]; do 
    case "$opcion" in
        1)
            listar_usuario
            exit 1
        ;;
        2)
            buscar_proyecto
            exit 1
        ;;
        3)

        ;;
        4)

        ;;
        5)

        ;;
    esac
done 