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
    ps -o pid,stat,%cpu,%mem,cmd --sort=%cpu | head -n $((N + 1))
    exit 1 
}

cambiar_prioridad() {
    read -p "PID: " pid

    if ! validar_pid "$pid"; then
        echo "Error: El PID '$pid' no es válido o el proceso no existe."
        return 1
    fi

    read -p "Nuevo valor nice: " nice_val

    if ! [[ "$nice_val" =~ ^-?[0-9]+$ ]]; then
        echo "Error: El valor nice debe ser un número entero."
        return 1
    fi

    if [[ $EUID -ne 0 ]]; then
        if [[ $nice_val -lt 0 || $nice_val -gt 19 ]]; then
            echo "Error: el valor debe estar entre 0 y 19"
            return 1
        fi
    else
        if [[ $nice_val -lt -20 || $nice_val -gt 19 ]]; then
            echo "Error: el valor nice debe estar entre -20 y 19."
            return 1
        fi
    fi

    local comando
    comando=$(ps -p "$pid" -o comm=)

    if renice "$nice_val" -p "$pid" &>/dev/null; then
        echo "Prioridad del proceso $pid cambiada correctamente a $nice_val."
        echo "$(date '+%Y-%m-%d %H:%M:%S') - renice $nice_val - $pid - $comando" >> "$LOG_FILE"
    else
        echo "Error al intentar cambiar la prioridad del proceso $pid."
    fi
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

opcion=0
while [[ $opcion -ne 6 ]]; do 
    echo "===== GESTIÓN DE PROCESOS ====="
    echo "1) Listar los procesos de un usuario"
    echo "2) Buscar un proceso por nombre"
    echo "3) Mostrar los N procesos que más CPU consumen"
    echo "4) Cambiar la prioridad de un proceso"
    echo "5) Finalizar un proceso"
    echo "6) Salir"

    read -p "Opción: " opcion

    if ! [[ "$opcion" =~ ^[0-9]+$ ]]; then
        echo "Error: Opción no válida. Introduce un número del 1 al 6."
        continue
    fi

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
        ;;
        *)
            echo "Error: Opción fuera del rango permitido."
        ;;
    esac 
done 