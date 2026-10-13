#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <fichero_config>"
    exit 1
fi

fichero="$1"

if [[ ! -f $fichero ]]; then
    echo "Error: El fichero no existe."
    exit 1
fi

sed '/^#/d; /^$/d' $1