#!/bin/bash

Use=$(($1 * 100 / $2))

if [[ $Use -lt 70 ]]; 
then
    echo "OK"
elif [[ $Use -ge 70 && $Use -le 89 ]];
then
    echo "AVISO"
elif [[ $Use -ge 90 ]];
then
    echo "CRÍTICO"
fi