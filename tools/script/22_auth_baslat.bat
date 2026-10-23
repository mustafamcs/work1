@echo off
title work1 - auth baslat
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_acik.ps1" 30001 >nul 2>&1
if %errorlevel%==0 ( echo [OK] auth zaten calisiyor & exit /b 0 )

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_acik.ps1" 30000 >nul 2>&1
if not %errorlevel%==0 ( echo [UYARI] db kapali, once 20_db_baslat calistiriliyor... & call "%~dp020_db_baslat.bat" )
if not %errorlevel%==0 ( echo [HATA] db acilamadi, auth baslatilmadi & exit /b 1 )

cscript //nologo "%~dp0_gizli_baslat.vbs" "%SRV%\auth" "%SRV%\auth\game.exe" >nul

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_bekle.ps1" 30001 15 >nul 2>&1
if not errorlevel 1 ( echo [OK] port 30001 acik & exit /b 0 )
echo [HATA] auth 30001 portunu acamadi - %SRV%\auth\syserr.txt
exit /b 1
