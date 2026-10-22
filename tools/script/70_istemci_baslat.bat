@echo off
title work1 - istemci baslat
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

if exist "%CLIENTDIR%\metin2client.exe" (
  start "metin2" /D "%CLIENTDIR%" metin2client.exe
  echo [OK] metin2client.exe baslatildi
  exit /b 0
)
echo [HATA] %CLIENTDIR%\metin2client.exe bulunamadi
exit /b 1
