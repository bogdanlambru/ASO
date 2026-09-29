#!/bin/bash

clasificar_http() {
    error=$1
    if [[ $error -ge 200 && $error -le 299 ]]; then
        echo "Éxito"
    elif [[ $error -ge 300 && $error -le 399 ]]; then
        echo "Redirección"
    elif [[ $error -ge 400 && $error -le 499 ]]; then
        echo "Error del cliente"
    elif [[ $error -ge 500 && $error -le 599 ]]; then
        echo "Érror del servidor"
    fi
}

clasificar_http 200
clasificar_http 301
clasificar_http 404
clasificar_http 500
