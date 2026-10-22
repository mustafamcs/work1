@echo off
title work1 - build game
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

rem cikti aciksa kapat (auth + core1 + ch99)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":30001 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":30003 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":30901 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1

"%MSBUILD%" "%SLN%" /t:game /p:Configuration=Release /p:Platform=Win32 /m /nr:false /v:m /nologo
if errorlevel 1 ( echo [HATA] game derleme basarisiz & exit /b 1 )

copy /y "%KOK%\out\game\Release\game.exe" "%SRV%\auth\game.exe" >nul
copy /y "%KOK%\out\game\Release\game.exe" "%SRV%\channel1\core1\game.exe" >nul
copy /y "%KOK%\out\game\Release\game.exe" "%SRV%\channel99\game.exe" >nul
copy /y "%KOK%\out\game\Release\game.exe" "%SRV%\share\bin\game.exe" >nul
echo [OK] game derlendi -^> auth + channel1\core1 + channel99 + share\bin

call "%~dp0_artik_kapat.bat"
