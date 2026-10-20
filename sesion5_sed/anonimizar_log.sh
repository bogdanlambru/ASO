#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <fichero_log>"
    exit 1
fi

fichero="$1"

if [[ ! -f $fichero ]]; then
    echo "Error: El fichero no existe."
    exit 1
fi

fichero_salida="${fichero}.anonimo"

sed -E 's/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/X.X.X.X/g' "$fichero" > "$fichero_salida"

echo "Fichero anonimizado: $fichero_salida"

