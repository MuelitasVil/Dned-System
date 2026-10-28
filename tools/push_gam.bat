@echo off
setlocal
cd /d "%~dp0.."

echo ==========================================
echo [1/3] Actualizando Backend GAM
echo ==========================================
set /p commit_msg="Ingresa el mensaje del commit: "

if "%commit_msg%"=="" (
    echo [ERROR] El mensaje del commit no puede estar vacio.
    pause
    exit /b 1
)

git add system/BackEnd-DNED-GAM
git commit -m "%commit_msg%"

echo [2/3] Enviando cambios al repositorio unitario (GAM)...
git subtree push --prefix=system/BackEnd-DNED-GAM https://github.com/MuelitasVil/BackEnd-DNED-GAM.git main

echo [3/3] Sincronizando cambios en el Monorepo principal...
git push origin main

echo ==========================================
echo ¡Proceso completado con exito!
echo ==========================================
pause
