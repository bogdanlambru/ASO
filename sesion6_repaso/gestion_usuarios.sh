#!/bin/bash

mostrar_error() {
    echo "Error: $1"
    echo "Uso: $0 alta | baja identificador"
    exit 1
}

generar_identificador() {
    local nom="$1"
    local ap1="$2"
    local ap2="$3"

    local l1=$(echo "$nom" | cut -c1-2 | tr 'A-Z' 'a-z')
    local l2=$(echo "$ap1" | cut -c1-2 | tr 'A-Z' 'a-z')
    local l3=$(echo "$ap2" | cut -c1 | tr 'A-Z' 'a-z')

    echo "alu${l1}${l2}${l3}"
}

if [ $# -eq 0 ]; then
    mostrar_error "falta la acción"
fi

accion="$1"

case "$accion" in
    alta)
        read -p "Nombre: " nombre
        read -p "Apellidos: " apellidos

        if ! [[ "$nombre" =~ ^[a-zA-Z]+$ ]]; then
            mostrar_error "el nombre debe ser una sola palabra formada por letras"
        fi

        if ! [[ "$apellidos" =~ ^[a-zA-Z]+\ [a-zA-Z]+$ ]]; then
            mostrar_error "escribe los dos apellidos separados por un espacio"
        fi

        primer_ape=$(echo "$apellidos" | cut -d' ' -f1)
        segundo_ape=$(echo "$apellidos" | cut -d' ' -f2)

        id_gen=$(generar_identificador "$nombre" "$primer_ape" "$segundo_ape")
        echo "Identificador generado: $id_gen"

        if id "$id_gen" &>/dev/null; then
            echo "Error: el usuario $id_gen ya existe"
            exit 1
        fi

        echo "Para crearlo: sudo useradd -m -s /bin/bash -c \"$nombre $apellidos\" $id_gen"
        ;;

    baja)
        if [ -z "$2" ]; then
            mostrar_error "falta el identificador"
        fi

        identificador="$2"

        if ! [[ "$identificador" =~ ^alu[a-zA-Z]{5}$ ]]; then
            echo "Error: $identificador no tiene el formato aluXXYYZ"
            echo "Uso: $0 alta | baja identificador"
            exit 1
        fi

        if ! id "$identificador" &>/dev/null; then
            echo "Error: el usuario $identificador no existe"
            exit 1
        fi

        echo "Para eliminarlo: sudo userdel $identificador"
        ;;

    *)
        mostrar_error "la acción $accion no es válida"
        ;;
esac