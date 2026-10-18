#!/bin/bash

if [[ ! $1 =~ ^[0-9]{1,3}$ ]]; then
    echo "Error: ${1:-} no es un número de días válido"
    exit 1
fi

fichero="login.defs"

if [[ ! -f "$fichero" ]]; then
    echo "Error: El fichero $fichero no existe."
    exit 1
fi

anterior=$(grep "^PASS_MAX_DAYS" "$fichero")
nuevo=$(grep "^PASS_MAX_DAYS" "$fichero")

cp "$fichero" "${fichero}.bak"

sed -i "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS $1/" "$fichero"

echo "Antes:   $anterior"
echo "Después: $nuevo"