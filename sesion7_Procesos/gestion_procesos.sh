#!/bin/bash

listar_usuario(){
    ps -u boglam -o pid,stat,%cpu,%mem,cmd
}

buscar_proyecto(){
    read -p "Introduce el proceso que quieres listar. " proceso 
    ps -C $proceso -o pid,user,%cpu,cmd
}

top_cpu(){
    read -p "Introduce cuántos procesos se quieren listar; aparecerán los que más CPU consuman. " N
    if [[ $N =~ ^[0-9]+$ ]]; then
        echo "El número seleccionado es $N."
    else
        N=5
        echo "Se utilizará el valor por defecto: $N."
    fi
    ps -o pid,stat,%cpu,%mem,cmd --sort=%cpu | head -n "$N"
    exit 1 
}

finalizar_proceso() {
    read -p "Introduce un PID: " pid
    read -p "¿Confirmas que quieres detener el proceso? (s/n): " respuesta

    if [[ $respuesta == "s" ]]; then
        if kill -15 "$pid" 2>/dev/null; then
            sleep 3

            if kill -9 "$pid" 2>/dev/null; then
                echo "Proceso $pid finalizado con SIGKILL."
            else
                echo "Proceso $pid finalizado con SIGTERM."
            fi
        else
            echo "No se pudo enviar SIGTERM al proceso $pid."
        fi
    else
        echo "Operación cancelada."
    fi
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
        ;;
        2)
            buscar_proyecto
        ;;
        3)
            top_cpu
        ;;
        4)
            cambiar_prioridad
        ;;
        5)
            finalizar_proceso
        ;;
        6)
            echo "Saliendo del menú..."
    esac
    
done 