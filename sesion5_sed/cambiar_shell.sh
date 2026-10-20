#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Uso: $0 <usuario> <shell>"
    exit 1
fi

usuario="$1"
shell="$2"
fichero="passwd"

if [[ ! -f "$fichero" ]]; then
    echo "Error: El fichero $fichero no existe."
    exit 1
fi

if ! grep -q "^${usuario}:" "$fichero"; then
    echo "Error: el usuario $usuario no existe"
    exit 1
fi

if [[ ! $shell =~ ^/bin/(bash|sh|zsh)$ ]]; then
    echo "Error: la shell debe ser /bin/bash, /bin/sh o /bin/zsh"
    exit 1
fi

cp "$fichero" "${fichero}.bak"

sed -i -E "s/^(${usuario}:.*:).*/\1${shell}/" "$fichero"

grep "^${usuario}:" "$fichero"

# ¿En un sistema real, se cambiaría la shell editando /etc/passwd con sed?
# No, ya que hay riesgo de corromper el fichero.
# ¿Qué comando se usa normalmente?
# usermod -s <shell> <usuario>