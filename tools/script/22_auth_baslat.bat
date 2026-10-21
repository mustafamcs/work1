@echo off
title work1 - auth baslat
call "%~dp0_ayar.bat"

netstat -ano | findstr ":30001 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [OK] auth zaten calisiyor & exit /b 0 )

netstat -ano | findstr ":30000 " | findstr LISTENING >nul
if not %errorlevel%==0 ( echo [UYARI] db kapali, once 20_db_baslat calistiriliyor... & call "%~dp020_db_baslat.bat" )
if not %errorlevel%==0 ( echo [HATA] db acilamadi, auth baslatilmadi & exit /b 1 )

cscript //nologo "%~dp0_gizli_baslat.vbs" "%SRV%\auth" "%SRV%\auth\game.exe" >nul

set N=0
:bekele
ping -n 2 127.0.0.1 >nul
netstat -ano | findstr ":30001 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [OK] auth calisiyor :30001 & exit /b 0 )
set /a N+=1
if %N% LSS 15 goto bekele
echo [HATA] auth 30001 portunu acamadi - %SRV%\auth\syserr.txt
exit /b 1
