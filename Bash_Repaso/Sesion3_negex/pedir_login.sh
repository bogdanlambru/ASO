#!/bin/bash

cond="^[a-z][a-z0-9]$"

while true; do
    read -p "Introduce un nombre de usuario. " nombre 

    if [[ nombre =~ $cond ]]; then
        if grep "^$login:" /etc/passwd; then
            echo "El usuario $login ya existe."
    else
            echo "Para crearlo: sudo useradd -m -s"
        fi
    else
        echo "No es válido. Debe empezar por minúscula y tener solo minúsculas o dígitos."
    fi
done

