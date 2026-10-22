@echo off
title work1 - auth durdur
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":30001 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1
netstat -ano | findstr ":30001 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [HATA] auth kapatilamadi & exit /b 1 )
echo [OK] auth durduruldu
