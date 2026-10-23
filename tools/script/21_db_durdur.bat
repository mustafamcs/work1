@echo off
title work1 - db durdur
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-NetTCPConnection -State Listen -LocalPort 30000 -ErrorAction SilentlyContinue; if($c){ $c | Select-Object -Expand OwningProcess -Unique | ForEach-Object { Stop-Process -Id $_ -Force } } else { exit 1 }" >nul 2>&1
if errorlevel 1 ( echo [OK] db zaten kapali & exit /b 0 )
echo [OK] db durduruldu :30000
