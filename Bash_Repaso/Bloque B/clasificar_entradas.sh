#!/bin/bash

for entrada in /home/boglam/prueba_bash/*; do
    nombre=$(basename "$entrada")
    if [[ -d $entrada ]]; then
        echo "$nombre: directorio"
    elif [[ -f $entrada]]; then
        echo "$nombre: fichero"
    fi
done 