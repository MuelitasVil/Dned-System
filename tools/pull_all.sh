#!/bin/bash
set -e

# Ir a la raíz del monorepo
cd "$(dirname "$0")/.."

echo "========================================================"
echo "[1/3] Sincronizando: BackEnd-DNED-Organization..."
echo "========================================================"
git subtree pull --prefix=system/BackEnd-DNED-Organization https://github.com/MuelitasVil/BackEnd-DNED-Organization.git main --squash

echo ""
echo "========================================================"
echo "[2/3] Sincronizando: BackEnd-DNED-GAM..."
echo "========================================================"
git subtree pull --prefix=system/BackEnd-DNED-GAM https://github.com/MuelitasVil/BackEnd-DNED-GAM.git main --squash

echo ""
echo "========================================================"
echo "[3/3] Sincronizando: Front-Dned..."
echo "========================================================"
git subtree pull --prefix=system/Front-Dned https://github.com/MuelitasVil/Front-Dned.git main --squash

echo ""
echo "========================================================"
echo "[4/4] Enviando cambios consolidados al Monorepo principal..."
echo "========================================================"
git push origin main

echo ""
echo "========================================================"
echo "¡Todos los módulos han sido actualizados y sincronizados!"
echo "========================================================"
