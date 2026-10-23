@echo off
title work1 - derin temizlik
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

rem Calisma-ani artiklarini temizler: syserr/syslog/log, editor
rem yedekleri, _yedek, .pre_qc, __pycache__, Thumbs.db vb.

rem == 1/3 runtime loglari (ps - aninda) ==
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_temizle.ps1" -kok "%KOK%" -scriptdir "%~dp0"

rem == 2/3 editor/gecici artiklari (yerel del - hizli) ==
for %%E in (*.bak *.orig *.tmp *~ *.py~ Thumbs.db desktop.ini) do (
  del /s /q "%KOK%\%%E" >nul 2>&1
)

rem == 3/3 gecici dizinler ==
for /d %%D in ("%KOK%\*") do (
  if exist "%%D\_yedek" rd /s /q "%%D\_yedek" >nul 2>&1
  if exist "%%D\.pre_qc" rd /s /q "%%D\.pre_qc" >nul 2>&1
)
del /s /q "%KOK%\*.log" >nul 2>&1

echo [OK] temizlik bitti
exit /b 0
