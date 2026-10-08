#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <direccion_correo>"
    exit 1
fi

correo="$1"
re='^[a-z0-9._-]+@(alu\.)?edu\.gva\.es$'

if [[ $correo =~ $re ]]; then
    re_prof='@edu\.gva\.es$'
    if [[ $correo =~ $re_prof ]]; then
        echo "$correo es una cuenta de profesorado"
    else
        echo "$correo es una cuenta de alumnado"
    fi
else
    echo "$correo no es una cuenta educativa"
fi