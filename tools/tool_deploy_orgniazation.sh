#!/usr/bin/env bash
set -e

# Ejecutar desde tools, aunque el usuario esté ubicado en otra carpeta.
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

SERVICE="backend-organization"

echo "Deteniendo el servicio y sus dependencias..."
docker compose stop "$SERVICE"

echo "Eliminando el contenedor del servicio..."
docker compose rm -f "$SERVICE"

echo "Creando la imagen del servicio..."
docker compose build --no-cache "$SERVICE"

echo "Iniciando el servicio en segundo plano..."
docker compose up -d "$SERVICE"

echo "Mostrando logs en tiempo real. Presiona Ctrl+C para salir."
docker compose logs -f "$SERVICE"
