@echo off
title work1 - ch99 baslat
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_acik.ps1" 30901 >nul 2>&1
if %errorlevel%==0 ( echo [OK] ch99 zaten calisiyor & exit /b 0 )

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_acik.ps1" 30000 >nul 2>&1
if not %errorlevel%==0 ( echo [UYARI] db kapali, once 20_db_baslat calistiriliyor... & call "%~dp020_db_baslat.bat" )
if not %errorlevel%==0 ( echo [HATA] db acilamadi, ch99 baslatilmadi & exit /b 1 )

cscript //nologo "%~dp0_gizli_baslat.vbs" "%SRV%\channel99" "%SRV%\channel99\game.exe" >nul

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_bekle.ps1" 30901 15 >nul 2>&1
if not errorlevel 1 ( echo [OK] port 30901 acik & exit /b 0 )
echo [HATA] ch99 30901 portunu acamadi - %SRV%\channel99\syserr.txt
exit /b 1
