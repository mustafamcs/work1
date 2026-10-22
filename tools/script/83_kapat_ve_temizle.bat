@echo off
title work1 - hepsini kapat + temizle
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

call "%~dp031_hepsini_durdur.bat"
taskkill /IM metin2client.exe /F >nul 2>&1
echo.
call "%~dp082_temizle.bat"
exit /b 0
