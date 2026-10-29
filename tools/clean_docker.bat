@echo off
setlocal

echo Limpiando contenedores detenidos...
docker container prune -f
if errorlevel 1 goto :error

echo Limpiando redes sin uso...
docker network prune -f
if errorlevel 1 goto :error

echo Limpiando imagenes no utilizadas...
docker image prune -a -f
if errorlevel 1 goto :error

echo Limpiando cache de construccion...
docker builder prune -a -f
if errorlevel 1 goto :error

echo Limpieza terminada. No se ejecutaron comandos para eliminar volumenes.
goto :end

:error
echo.
echo Ocurrio un error. Revisa que Docker este iniciado y tengas permisos.
exit /b 1

:end
endlocal
