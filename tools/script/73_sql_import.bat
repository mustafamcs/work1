@echo off
title work1 - sql import
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

if not exist "%MYSQL_BIN%" ( echo [HATA] mysql.exe yok: %MYSQL_BIN% & exit /b 1 )
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_acik.ps1" 3306 >nul 2>&1
if not %errorlevel%==0 ( echo [HATA] mariadb kapali - once 10_mariadb_baslat.bat & exit /b 1 )

call "%KOK%\sql\import-windows.bat" %MYSQL_USER% 127.0.0.1 3306 "%MYSQL_BIN%"
