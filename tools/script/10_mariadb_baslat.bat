@echo off
title work1 - mariadb baslat
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

netstat -ano | findstr ":3306 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [OK] mariadb zaten calisiyor & exit /b 0 )

if not exist "%MARIADB_EXE%" ( echo [HATA] mariadbd.exe yok: %MARIADB_EXE% & exit /b 1 )

cscript //nologo "%~dp0_gizli_baslat.vbs" "%KOK%" "%MARIADB_EXE%" "--defaults-file=%MARIADB_INI%" >nul

set N=0
:bekele
ping -n 2 127.0.0.1 >nul
netstat -ano | findstr ":3306 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [OK] mariadb calisiyor :3306 & exit /b 0 )
set /a N+=1
if %N% LSS 20 goto bekele
echo [HATA] mariadb 3306 portunu acamadi
exit /b 1
