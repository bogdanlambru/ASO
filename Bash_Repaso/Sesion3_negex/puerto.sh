#!/bin/bash

read -p "Introduce un número de puerto como parámetro. " numpuerto

re='^[0-9]*$'
if [[ $numpuerto =~ $re && $numpuerto -le 65535 && $numpuerto -ge 1 ]]; then
    echo "Es un parámetro válido."
elif [[ $numpuerto =~ [a-zA-Z]+ ]]; then
    echo "Solo puede tener dígitos, parámetro inválido."
else
    echo "Parámetro inválido o no introducido."
fi