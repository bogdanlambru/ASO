#!/bin/bash

sumar() {
    echo $(($1 + $2))
}

restar() {
    echo $(($1 - $2))
}

multiplicacion() {
    echo $(($1 * $2))
}

dividir() {
    if [ $2 -eq 0 ]; then
        echo "Error: División por cero"
    else
        echo $(($1 / $2))
    fi
}

menu() {
    echo "***CALCULADORA***"
    echo "1 - SUMAR"
    echo "2 - RESTAR"
    echo "3 - MULTIPLICAR"
    echo "4 - DIVIDIR"
    echo "5 - SALIR"
    echo "*****************"
}

while true; do
    menu
    read -p "Elige una opción: " opcion

    if [[ $opcion -eq 5 ]]; then
        echo "Saliendo de la calculadora..."
        exit
    fi

    if [[ ! $opcion =~ ^[1-4]$ ]]; then
        echo "Opción no válida. Inténtalo de nuevo."
        continue
    fi

    read -p "Introduce el primer número: " num1
    read -p "Introduce el segundo número: " num2

    case $opcion in
        1) resultado=$(sumar "$num1" "$num2") ;;
        2) resultado=$(restar "$num1" "$num2") ;;
        3) resultado=$(multiplicacion "$num1" "$num2") ;;
        4) resultado=$(dividir "$num1" "$num2") ;;
    esac

    echo "El resultado de la operación es: $resultado."
    echo ""
done