#!/bin/bash

contar_por_extension() {
    carpeta=$1
    ext=$2
    find "$carpeta" -maxdepth 1 -type f -name "*.$ext" | wc -l
}

for ext in log txt csv; do
    total=$(contar_por_extension ~/prueba_bash/datos "$ext")
    echo "$ext → $total"
done
