@echo off
title work1 - sunucu + istemci baslat
call "%~dp0_ayar.bat"

call "%~dp030_hepsini_baslat.bat"
if errorlevel 1 ( echo [HATA] sunucu acilmadi, istemci baslatilmiyor & exit /b 1 )

call "%~dp070_istemci_baslat.bat"
exit /b 0
