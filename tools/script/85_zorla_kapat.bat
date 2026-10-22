@echo off
title work1 - zorla kapat (tum surecler)
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
rem Betiklerin yakalayamadigi durumlarda ilgili tum surecleri
rem imaj adindan zorla kapatir.

for %%P in (metin2client.exe db.exe game.exe qc.exe mariadbd.exe PackMakerLite.exe) do (
  taskkill /IM %%P /F >nul 2>&1
)
echo [OK] zorla kapatma gonderildi
call "%~dp0_artik_kapat.bat"
call "%~dp033_durum.bat"
exit /b 0
