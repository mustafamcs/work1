@echo off
title work1 - db baslat
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

netstat -ano | findstr ":30000 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [OK] db zaten calisiyor & exit /b 0 )

rem db, mysql olmadan portu acmaz
netstat -ano | findstr ":3306 " | findstr LISTENING >nul
if not %errorlevel%==0 ( echo [UYARI] mariadb kapali, once 10_mariadb_baslat calistiriliyor... & call "%~dp010_mariadb_baslat.bat" )
if not %errorlevel%==0 ( echo [HATA] mariadb acilamadi, db baslatilmadi & exit /b 1 )

cscript //nologo "%~dp0_gizli_baslat.vbs" "%SRV%\db" "%SRV%\db\db.exe" >nul

set N=0
:bekele
ping -n 2 127.0.0.1 >nul
netstat -ano | findstr ":30000 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [OK] db calisiyor :30000 & exit /b 0 )
set /a N+=1
if %N% LSS 15 goto bekele
echo [HATA] db 30000 portunu acamadi - %SRV%\db\syserr.txt
exit /b 1
