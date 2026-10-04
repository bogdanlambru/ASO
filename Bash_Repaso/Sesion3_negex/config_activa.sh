#!/bin/bash

fichero="${1:-/etc/login.defs}"

if [[ ! -f "$fichero" ]]; then
    echo "Error: El fichero no existe."
    exit 
fi

grep -v -E '^\s*#|^\s*$' "$fichero"

echo "Líneas totales: $(wc -l < "$fichero")"
echo "Líneas útiles:  $(grep -v -E '^\s*#|^\s*$' "$fichero" | wc -l)"