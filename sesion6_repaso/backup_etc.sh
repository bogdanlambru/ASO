#!/bin/bash

dir_destino="${1:-/var/backups}"
max_copias="${2:-7}"

registrar() {
    local mensaje="$1"
    local timestamp
    timestamp=$(date '+%H:%M:%S')
    echo "$timestamp $mensaje"
    logger -t asobackup "$mensaje"
}

if [ ! -d "$dir_destino" ];then
    echo "Error: introduce un directorio."
    exit 1
fi

if ! [[ "$max_copias" =~ ^[0-9]+$ ]]; then
    registrar "Error: $max_copias no es un número"
    exit 1
fi

if [ "$max_copias" -le 0 ]; then
    registrar "Error: el número máximo de copias debe ser mayor que 0"
    exit 1
fi

fecha=$(date +%Y/%m/%d-%H:%M:%S)
fichero_destino="$dir_destino/etc-$fecha.tar.gz"

if tar -czf "$fichero_destino" -C /etc . 2>/dev/null; then
    registrar "Copia creada: $fichero_destino"
else
    registrar "Error al crear la copia de /etc"
    exit 1
fi

num_copias=0
for fichero in "$dir_destino"/etc-????????-??????.tar.gz; do
    if [ -f "$fichero" ]; then
        nombre_base=$(basename "$fichero")
        if [[ "$nombre_base" =~ ^etc-[0-9]{8}-[0-9]{6}\.tar\.gz$ ]]; then
            ((num_copias++))
        fi
    fi
done

if [[ "$num_copias" -gt "$max_copias" ]]; then
    echo "Error: hay más copias que el máximo recomendado."
    exit 1
fi

