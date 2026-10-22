#!/bin/bash

if [ ! -d $dir_destino ];then
    echo "Error: introduce un directorio."
    exit 1
fi

if [[ "$2" =~ ^[0-9]+$ ]] && [ "$2" -gt 0 ]; then
    echo "Número válido."
else
    echo "Error: Introduce un número mayor que 0."
    exit 1
fi

fecha=$(date +%Y/%m/%d-%H:%M:%S)
tar -czf "etc-$fecha.tar.gz" /etc

num_copias=$(ls $dir_destino | grep -cE '^/etc-.+\.tar.\gz')

if [[ $num_copias -gt 7 ]]; then
    echo "Error: hay más copias que el máximo recomendado."
    exit 1
fi

registrar() {
    local mensaje=$()
    
}





logger -t aso-backup "Copia creada: etc-20261014-211317.tar.gz"
journalctl -t aso-backup