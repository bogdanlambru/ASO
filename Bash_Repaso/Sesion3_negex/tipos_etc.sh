#!/bin/bash

cont=0
conts=0

for fichero in /etc/*; do 
    if [[ $fichero =~ ^.*\.conf$ ]]; then
        echo "$fichero"
        ((cont++))
    elif [[ $fichero =~ ^.*\.bak$ ]]; then
        echo "$fichero"
        ((conts++))
    fi
done

echo "Configuración: $cont "
echo "Copias de seguridad: $conts "
