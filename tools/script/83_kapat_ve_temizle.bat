@echo off
title work1 - hepsini kapat + temizle
call "%~dp0_ayar.bat"

call "%~dp031_hepsini_durdur.bat"
taskkill /IM metin2client.exe /F >nul 2>&1
echo.
call "%~dp082_temizle.bat"
exit /b 0
