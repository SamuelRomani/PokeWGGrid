@echo off
setlocal
title PokeWGGrid - Atualizando

rem IMPORTANTE: este script roda a partir de uma COPIA em pasta temporaria (o main.js cuida
rem disso), nunca direto da pasta do app. Motivo: git pull e a copia do ZIP escrevem um
rem atualizar.bat novo por cima do que esta rodando, e o cmd.exe le o .bat do disco por posicao
rem de byte enquanto executa -- se o arquivo muda no meio, ele passa a ler lixo do arquivo novo
rem e trava com erros sem sentido tipo ". foi inesperado neste momento.". Por isso a pasta de
rem destino vem por parametro (%1), nunca por %~dp0 (que aqui seria a pasta temporaria, nao a
rem pasta real do PokeWGGrid).
if "%~1"=="" (
    echo Uso: atualizar.bat "caminho da pasta do PokeWGGrid"
    pause
    exit /b 1
)
set "PASTA=%~1"
cd /d "%PASTA%"

echo ========================================
echo   POKEWGGRID - Atualizando
echo ========================================
echo.

if exist ".git" goto viagit
goto viazip

:viagit
echo Pasta veio de "git clone": atualizando com git pull...
git pull origin main
if errorlevel 1 goto erropull
goto npm

:erropull
echo.
echo Nao consegui atualizar sozinho (provavelmente voce editou algum
echo arquivo na mao e o git nao quer sobrescrever). Nada foi mudado,
echo o PokeWGGrid antigo continua funcionando normalmente.
echo.
pause
exit /b 1

:viazip
echo Pasta veio do ZIP: baixando a versao mais nova do GitHub...
call :baixarzip
if errorlevel 1 goto errozip
goto npm

:errozip
echo.
echo Nao consegui baixar a atualizacao (confira sua internet). Nada
echo foi mudado, o PokeWGGrid antigo continua funcionando normalmente.
echo.
pause
exit /b 1

:npm
echo.
echo Conferindo dependencias...
call npm install --no-fund --no-audit
if errorlevel 1 goto erronpm
goto reabrir

:erronpm
echo.
echo O download/pull terminou, mas "npm install" falhou. Tente abrir o
echo PokeWGGrid normalmente mesmo assim -- geralmente ainda funciona.
echo.
pause
exit /b 1

:reabrir
echo.
echo Atualizado. Reabrindo o PokeWGGrid...
ping -n 3 127.0.0.1 >nul
start "" "%PASTA%\Abrir PokeWGGrid.vbs"
exit /b 0

:baixarzip
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; Invoke-WebRequest -Uri 'https://github.com/SamuelRomani/PokeWGGrid/archive/refs/heads/main.zip' -OutFile 'pokewggrid-update.zip'; Expand-Archive -Path 'pokewggrid-update.zip' -DestinationPath 'pokewggrid-update-tmp' -Force; Copy-Item -Path 'pokewggrid-update-tmp\PokeWGGrid-main\*' -Destination '.' -Recurse -Force; Remove-Item 'pokewggrid-update.zip' -Force; Remove-Item 'pokewggrid-update-tmp' -Recurse -Force"
exit /b %errorlevel%
