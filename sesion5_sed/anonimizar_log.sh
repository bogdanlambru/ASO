#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <anonimizar_logs>"
    exit 1
fi

sed -E 's/' $1