@echo off
title work1 - core1.1 durdur
call "%~dp0_ayar.bat"

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":30003 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1
netstat -ano | findstr ":30003 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [HATA] core1.1 kapatilamadi & exit /b 1 )
echo [OK] core1.1 durduruldu
