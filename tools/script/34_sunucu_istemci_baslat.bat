@echo off
title work1 - sunucu + istemci baslat
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

call "%~dp030_hepsini_baslat.bat"
if errorlevel 1 ( echo [HATA] sunucu acilmadi, istemci baslatilmiyor & exit /b 1 )

call "%~dp070_istemci_baslat.bat"
exit /b 0
