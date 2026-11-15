#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: $0 <carpeta_remota>"
    exit 1
fi

CARPETA_REMOTA="$1"
DESTINO_DIR="$HOME/backups/espejo"
LOG_FILE="$HOME/backups/backup.log"

mkdir -p "$DESTINO_DIR"

if ! ssh -o BatchMode=yes servidor true 2>/dev/null; then
    echo "Error: El servidor no responde o requiere contraseña (comprueba el alias 'servidor' o las claves SSH)."
    exit 1
fi


realizar_sincronizacion() {
    echo "Iniciando sincronización mediante rsync..."
    if rsync -av servidor:"${CARPETA_REMOTA}"/ "${DESTINO_DIR}/"; then
        echo "$(date +'%Y-%m-%d %H:%M:%S') - Sincronización rsync de ${CARPETA_REMOTA} realizada con éxito." >> "$LOG_FILE"
        echo "¡Sincronización completada con éxito en: $DESTINO_DIR!"
    else
        echo "$(date +'%Y-%m-%d %H:%M:%S') - ERROR en rsync de ${CARPETA_REMOTA}." >> "$LOG_FILE"
        echo "Error durante la sincronización."
        exit 1
    fi
}

realizar_sincronizacion