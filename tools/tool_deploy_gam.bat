@echo off
setlocal

REM Ir a la raiz del repositorio, un nivel arriba de tools.
cd /d "%~dp0.."

set "SERVICE=backend-gam"

echo Deteniendo el servicio y sus dependencias...
docker compose stop %SERVICE%
if errorlevel 1 goto :error

echo Eliminando el contenedor del servicio...
docker compose rm -f %SERVICE%
if errorlevel 1 goto :error

echo Eliminando la imagen del servicio...
docker compose build --no-cache %SERVICE%
if errorlevel 1 goto :error

echo Iniciando el servicio en segundo plano...
docker compose up -d %SERVICE%
if errorlevel 1 goto :error

echo Mostrando logs en tiempo real. Presiona Ctrl+C para salir.
docker compose logs -f %SERVICE%
goto :end

:error
echo.
echo Error al ejecutar el despliegue. Revisa que Docker este iniciado y que exista docker-compose.yml en la raiz.
exit /b 1

:end
endlocal
