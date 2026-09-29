#!/bin/bash

contlin=0

while read -r linea; do
    if [[ linea =~ ^.*\.bash$ ]]; then
        echo "$linea"
        ((contlin++))
    fi
done < /etc/passwd 

echo "Usuarios con bash: $contlin "