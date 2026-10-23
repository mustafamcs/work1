@echo off
title work1 - ch99 durdur
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-NetTCPConnection -State Listen -LocalPort 30901 -ErrorAction SilentlyContinue; if($c){ $c | Select-Object -Expand OwningProcess -Unique | ForEach-Object { Stop-Process -Id $_ -Force } } else { exit 1 }" >nul 2>&1
if errorlevel 1 ( echo [OK] ch99 zaten kapali & exit /b 0 )
echo [OK] ch99 durduruldu :30901
