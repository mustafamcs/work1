@echo off
title work1 - core1.1 baslat
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

netstat -ano | findstr ":30003 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [OK] core1.1 zaten calisiyor & exit /b 0 )

netstat -ano | findstr ":30000 " | findstr LISTENING >nul
if not %errorlevel%==0 ( echo [UYARI] db kapali, once 20_db_baslat calistiriliyor... & call "%~dp020_db_baslat.bat" )
if not %errorlevel%==0 ( echo [HATA] db acilamadi, core baslatilmadi & exit /b 1 )

cscript //nologo "%~dp0_gizli_baslat.vbs" "%SRV%\channel1\core1" "%SRV%\channel1\core1\game.exe" >nul

set N=0
:bekele
ping -n 2 127.0.0.1 >nul
netstat -ano | findstr ":30003 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [OK] core1.1 calisiyor :30003 & exit /b 0 )
set /a N+=1
if %N% LSS 15 goto bekele
echo [HATA] core1.1 30003 portunu acamadi - %SRV%\channel1\core1\syserr.txt
exit /b 1
