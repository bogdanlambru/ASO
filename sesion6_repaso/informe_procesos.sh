#!/bin/bash

ps -u "$USER" -o pid,pcpu,pmem,comm --sort=-pcpu > procesos.txt

total_procesos=$(($(wc -l < procesos.txt) - 1))

if [ -n "$1" ]; then
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Error: $1 no es un número válido"
        exit 1
    fi
    
    if [ "$1" -le 0 ]; then
        echo "Error: el número máximo de procesos debe ser mayor que 0"
        exit 1
    fi
    
    head -n "$(($1 + 1))" procesos.txt
    echo "----"
else
    cat procesos.txt
    echo "----"
fi

echo "Procesos de $USER: $total_procesos"