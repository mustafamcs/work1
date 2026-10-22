@echo off
title work1 - ch99 baslat
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

netstat -ano | findstr ":30901 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [OK] ch99 zaten calisiyor & exit /b 0 )

netstat -ano | findstr ":30000 " | findstr LISTENING >nul
if not %errorlevel%==0 ( echo [UYARI] db kapali, once 20_db_baslat calistiriliyor... & call "%~dp020_db_baslat.bat" )
if not %errorlevel%==0 ( echo [HATA] db acilamadi, ch99 baslatilmadi & exit /b 1 )

cscript //nologo "%~dp0_gizli_baslat.vbs" "%SRV%\channel99" "%SRV%\channel99\game.exe" >nul

set N=0
:bekele
ping -n 2 127.0.0.1 >nul
netstat -ano | findstr ":30901 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [OK] ch99 calisiyor :30901 & exit /b 0 )
set /a N+=1
if %N% LSS 15 goto bekele
echo [HATA] ch99 30901 portunu acamadi - %SRV%\channel99\syserr.txt
exit /b 1
