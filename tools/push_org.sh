#!/bin/bash
set -e

# Ir a la raíz del monorepo (un nivel arriba de tools/)
cd "$(dirname "$0")/.."

echo "=========================================="
echo "[1/3] Actualizando Backend Organizacional"
echo "=========================================="
read -p "Ingresa el mensaje del commit: " commit_msg

if [ -z "$commit_msg" ]; then
    echo "[ERROR] El mensaje del commit no puede estar vacío."
    exit 1
fi

git add system/BackEnd-DNED-Organization
git commit -m "$commit_msg"

echo "[2/3] Enviando cambios al repositorio unitario (Organization)..."
git subtree push --prefix=system/BackEnd-DNED-Organization https://github.com/MuelitasVil/BackEnd-DNED-Organization.git main

echo "[3/3] Sincronizando cambios en el Monorepo principal..."
git push origin main

echo "=========================================="
echo "¡Proceso completado con éxito!"
echo "=========================================="
