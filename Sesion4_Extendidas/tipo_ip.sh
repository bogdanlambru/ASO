#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <direccion_ip>"
    exit 1
fi

ip="$1"
re_loop='^127\.'
re_priv='^(10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[01])\.)'

if [[ $ip =~$re_loop ]]; then
    echo "$ip es una dirección loopback"
elif [[ $ip =~$re_priv ]]; then
    echo "$ip es una dirección privada"
else
    echo "$ip es una dirección pública"
fi

# El rango de 172.16 a 172.31 no se puede escribir con una sola clase. ¿Cómo lo has resuelto?
# agrupando el rango con alternativas: `1[6-9]` (16-19), `2[0-9]` (20-29) y `3[01]` (30-31).