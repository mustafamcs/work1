@echo off
title work1 - hepsini durdur
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

echo == ch99 ==      & call "%~dp027_ch99_durdur.bat"
echo == core1.1 ==   & call "%~dp025_core_durdur.bat"
echo == auth ==      & call "%~dp023_auth_durdur.bat"
echo == db ==        & call "%~dp021_db_durdur.bat"
echo == mariadb ==   & call "%~dp011_mariadb_durdur.bat"

echo.
echo [OK] hepsi durduruldu
call "%~dp033_durum.bat"
