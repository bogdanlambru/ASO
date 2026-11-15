#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: $0 <carpeta_remota>"
    exit 1
fi

if ! ssh -o BatchMode=yes servidor true; then
    echo "Error: El servidor no responde o requiere contraseña."
    exit 1
fi

CARPETA_REMOTA="$1"
FECHA=$(date +%F_%H-%M)
DESTINO_DIR="$HOME/backups"
DESTINO="$DESTINO_DIR/datos_${FECHA}"
LOG_FILE="$DESTINO_DIR/backup.log"

mkdir -p "$DESTINO_DIR"

realizar_copia() {
    if scp -r "servidor:${CARPETA_REMOTA}" "$DESTINO"; then
        echo "$(date +'%Y-%m-%d %H:%M:%S') - Copia de ${CARPETA_REMOTA} realizada con éxito en ${DESTINO}." >> "$LOG_FILE"
        echo "Copia completada con éxito."
    else
        echo "$(date +'%Y-%m-%d %H:%M:%S') - ERROR al copiar ${CARPETA_REMOTA}." >> "$LOG_FILE"
        echo "Error durante el proceso de copia."
        exit 1
    fi
}

realizar_copia