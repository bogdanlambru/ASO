#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <cuentas.sh>"
    exit 1
fi

if [[ $1 =~ ^(/bin)(bash|sh|zsh) ]]
    echo "Shell aceptada."
else
    $1 ="/bin/bash"
fi

while IFS=':'

done > /etc/passwd

echo "Cuentas listadas: "

