@echo off
title work1 - core1.1 durdur
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-NetTCPConnection -State Listen -LocalPort 30003 -ErrorAction SilentlyContinue; if($c){ $c | Select-Object -Expand OwningProcess -Unique | ForEach-Object { Stop-Process -Id $_ -Force } } else { exit 1 }" >nul 2>&1
if errorlevel 1 ( echo [OK] core1.1 zaten kapali & exit /b 0 )
echo [OK] core1.1 durduruldu :30003
