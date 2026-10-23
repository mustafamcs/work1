@echo off
title work1 - db baslat
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_acik.ps1" 30000 >nul 2>&1
if %errorlevel%==0 ( echo [OK] db zaten calisiyor & exit /b 0 )

rem db, mysql olmadan portu acmaz
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_acik.ps1" 3306 >nul 2>&1
if not %errorlevel%==0 ( echo [UYARI] mariadb kapali, once 10_mariadb_baslat calistiriliyor... & call "%~dp010_mariadb_baslat.bat" )
if not %errorlevel%==0 ( echo [HATA] mariadb acilamadi, db baslatilmadi & exit /b 1 )

cscript //nologo "%~dp0_gizli_baslat.vbs" "%SRV%\db" "%SRV%\db\db.exe" >nul

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_bekle.ps1" 30000 15 >nul 2>&1
if not errorlevel 1 ( echo [OK] port 30000 acik & exit /b 0 )
echo [HATA] db 30000 portunu acamadi - %SRV%\db\syserr.txt
exit /b 1
