#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "=========================================="
echo "[1/3] Actualizando Front-End (Front-Dned)"
echo "=========================================="
read -p "Ingresa el mensaje del commit: " commit_msg

if [ -z "$commit_msg" ]; then
    echo "[ERROR] El mensaje del commit no puede estar vacío."
    exit 1
fi

git add system/Front-Dned
git commit -m "$commit_msg"

echo "[2/3] Enviando cambios al repositorio unitario (Front-Dned)..."
git subtree push --prefix=system/Front-Dned https://github.com/MuelitasVil/Front-Dned.git main

echo "[3/3] Sincronizando cambios en el Monorepo principal..."
git push origin main

echo "=========================================="
echo "¡Proceso completado con éxito!"
echo "=========================================="