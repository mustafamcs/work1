@echo off
title work1 - durum
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

set "PROFIL="
for /f %%p in ('type "%KOK%\active_profile" 2^>nul') do set "PROFIL=%%p"
echo aktif profil: %PROFIL%
echo ------------------------------------------
call :durum mariadb    3306
call :durum db         30000
call :durum auth       30001
call :durum core1.1    30003
call :durum ch99       30901
echo ------------------------------------------
exit /b 0

:durum
netstat -ano | findstr ":%~2 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo   %~1 [:%~2] calisiyor ) else ( echo   %~1 [:%~2] KAPALI )
exit /b 0
