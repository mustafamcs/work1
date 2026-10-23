@echo off
title work1 - hepsini yeniden

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
call "%~dp031_hepsini_durdur.bat"
powershell -NoProfile -Command "Start-Sleep -Milliseconds 800" >nul 2>&1
call "%~dp030_hepsini_baslat.bat"
