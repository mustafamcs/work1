@echo off
title work1 - zorla kapat (tum surecler)
call "%~dp0_ayar.bat"
net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-Process metin2client,db,game,qc,mariadbd,PackMakerLite -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue"
echo [OK] zorla kapatma gonderildi
call "%~dp0_artik_kapat.bat"
call "%~dp033_durum.bat"
exit /b 0
