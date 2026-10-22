@echo off
title work1 - istemci baslat
call "%~dp0_ayar.bat"

if exist "%CLIENTDIR%\metin2client.exe" (
  start "metin2" /D "%CLIENTDIR%" metin2client.exe
  echo [OK] metin2client.exe baslatildi
  exit /b 0
)
echo [HATA] %CLIENTDIR%\metin2client.exe bulunamadi
exit /b 1
