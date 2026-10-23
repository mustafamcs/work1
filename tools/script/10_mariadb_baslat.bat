@echo off
title work1 - mariadb baslat
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_acik.ps1" 3306 >nul 2>&1
if %errorlevel%==0 ( echo [OK] mariadb zaten calisiyor & exit /b 0 )

if not exist "%MARIADB_EXE%" ( echo [HATA] mariadbd.exe yok: %MARIADB_EXE% & exit /b 1 )

cscript //nologo "%~dp0_gizli_baslat.vbs" "%KOK%" "%MARIADB_EXE%" "--defaults-file=%MARIADB_INI%" >nul

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_bekle.ps1" 3306 20 >nul 2>&1
if not errorlevel 1 ( echo [OK] port 3306 acik & exit /b 0 )
echo [HATA] mariadb 3306 portunu acamadi
exit /b 1
