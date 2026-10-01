#!/bin/bash

contlin=0

while read -r linea; do
    if [[ $linea =~ bash ]]; then
        usuario="${linea%%:*}"
        echo "$usuario"
        ((contlin++))
    fi
done < /etc/passwd 

echo "Usuarios con bash: $contlin "