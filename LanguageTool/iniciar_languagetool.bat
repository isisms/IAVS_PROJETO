@echo off
setlocal ENABLEDELAYEDEXPANSION

:: === Caminho até a pasta do LanguageTool ===
cd /d "C:\Users\isisi\Documents\IAVS_PROJETO\LanguageTool"

:: === Começar pela porta 8081 ===
set PORTA=8081

:verifica_porta
:: Tenta se conectar à porta usando PowerShell
powershell -Command "(New-Object Net.Sockets.TcpClient).Connect('localhost', !PORTA!)" >nul 2>&1

:: Se sucesso (porta ocupada), tenta próxima porta
if !errorlevel! EQU 0 (
    echo ⚠️ Porta !PORTA! em uso. Tentando a próxima...
    set /a PORTA+=1
    goto verifica_porta
)

:: Salvar a porta encontrada em arquivo
echo !PORTA! > porta_languagetool.txt

:: Iniciar o servidor
echo ✅ Porta livre encontrada: !PORTA!
echo 🚀 Iniciando LanguageTool na porta !PORTA!...
start java -jar languagetool-server.jar --port !PORTA!

exit /b
