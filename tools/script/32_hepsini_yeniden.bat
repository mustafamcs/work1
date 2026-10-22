@echo off
title work1 - hepsini yeniden

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
call "%~dp031_hepsini_durdur.bat"
ping -n 3 127.0.0.1 >nul
call "%~dp030_hepsini_baslat.bat"
