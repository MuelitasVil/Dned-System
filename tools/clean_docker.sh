#!/usr/bin/env bash
set -Eeuo pipefail

echo "Limpiando contenedores detenidos..."
docker container prune -f

echo "Limpiando redes sin uso..."
docker network prune -f

echo "Limpiando imágenes no utilizadas..."
docker image prune -a -f

echo "Limpiando caché de construcción..."
docker builder prune -a -f

echo "Limpieza terminada. No se eliminaron volúmenes."
