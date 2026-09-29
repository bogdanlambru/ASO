#!/bin/bash

existe_usuario() {
    usuario=$1
    if id "$usuario" &>/dev/null; then
        echo "El usuario $usuario existe en el sistema."
    else
        echo "El usuario $usuario no existe en el sistema."
    fi
}

existe_usuario root
existe_usuario noexisto