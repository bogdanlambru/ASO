#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <contraseña>"
    exit 1
fi

pass="$1"
segura=true

re_len='.{12,}'
if [[ $pass =~ $re_len ]]; then
    echo "Tiene al menos 12 caracteres: sí"
else
    echo "Tiene al menos 12 caracteres: no"
    segura=false
fi

re_dig='[0-9]'
if [[ $pass =~ $re_dig ]]; then
    echo "Contiene algún dígito: sí"
else
    echo "Contiene algún dígito: no"
    segura=false
fi

re_may='[A-Z]'
if [[ $pass =~ $re_may ]]; then
    echo "Contiene alguna mayúscula: sí"
else
    echo "Contiene alguna mayúscula: no"
    segura=false
fi

re_sim='[^a-zA-Z0-9]'
if [[ $pass =~ $re_sim ]]; then
    echo "Contiene algún símbolo: sí"
else
    echo "Contiene algún símbolo: no"
    segura=false
fi

dict_file="/usr/share/dict/spanish"
if [ -f "$dict_file" ] && grep -qxi "$pass" "$dict_file"; then
    echo "No es una palabra del diccionario: no"
    segura=false
else
    echo "No es una palabra del diccionario: sí"
fi

if $segura; then
    echo "La contraseña es segura"
else
    echo "La contraseña no es segura"
fi

# Caminas2026! cumple todas las condiciones. ¿Te parece realmente una contraseña segura? ¿Por qué?
# No, ya que incluye el nombre del centro y el año actual.