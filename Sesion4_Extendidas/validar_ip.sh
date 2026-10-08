#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <direccion_ip>"
    exit 1
fi

ip="$1"

re='^([0-9]{1,3}\.){3}[0-9]{1,3}$'

if [[ $ip =~ $re ]]; then
    echo "$ip tiene formato de IP"
else
    echo "$ip no tiene formato de IP"
fi

# ¿Qué responde tu script con 999.999.999.999? ¿Es una IP válida?
# Responde que sí tiene formato de IP, aunque no sea una IP válida real.