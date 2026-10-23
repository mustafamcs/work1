@echo off
title work1 - auth durdur
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-NetTCPConnection -State Listen -LocalPort 30001 -ErrorAction SilentlyContinue; if($c){ $c | Select-Object -Expand OwningProcess -Unique | ForEach-Object { Stop-Process -Id $_ -Force } } else { exit 1 }" >nul 2>&1
if errorlevel 1 ( echo [OK] auth zaten kapali & exit /b 0 )
echo [OK] auth durduruldu :30001
