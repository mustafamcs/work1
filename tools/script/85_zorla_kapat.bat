@echo off
title work1 - zorla kapat (tum surecler)
call "%~dp0_ayar.bat"
rem Betiklerin yakalayamadigi durumlarda ilgili tum surecleri
rem imaj adindan zorla kapatir.

for %%P in (metin2client.exe db.exe game.exe qc.exe mariadbd.exe PackMakerLite.exe) do (
  taskkill /IM %%P /F >nul 2>&1
)
echo [OK] zorla kapatma gonderildi
call "%~dp033_durum.bat"
exit /b 0
