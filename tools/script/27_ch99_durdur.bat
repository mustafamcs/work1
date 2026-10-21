@echo off
title work1 - ch99 durdur
call "%~dp0_ayar.bat"

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":30901 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1
netstat -ano | findstr ":30901 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [HATA] ch99 kapatilamadi & exit /b 1 )
echo [OK] ch99 durduruldu
