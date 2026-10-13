#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <correos_dominio>"
    exit 1
fi

sed -E 's/@gmail.com/@alu.edu.gva.es/; s/@hotmail.com/@alu.edu.gva.es/' $1