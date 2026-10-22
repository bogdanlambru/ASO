#!/bin/bash

if [ $# -gt 1 ]; then
    echo "Error: demasiados parámetros."
    echo "Uso: $0 [shell]"
    exit 1
fi

if [[ $1 =~ ^(/bin)(bash|sh|zsh) ]]
    echo "Shell aceptada."
else
    $1 ="/bin/bash"
fi

re = '^(/[a-z/]+)+$'

total=0
uid_altos=0

while IFS=':' read -r usuario x uid gid desc home shell; do

done < /etc/passwd

echo "Cuentas listadas: "

