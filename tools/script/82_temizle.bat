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

echo == log/syserr temizligi ==
for %%F in (syserr.txt syserr syslog.txt syslog stdout.txt stdout PTS.txt usage.txt) do (
  for /r "%SRV%" %%X in (%%F) do ( del /f "%%X" >nul 2>&1 )
  del /f "%CLIENTDIR%\%%F" >nul 2>&1
)
if exist "%SRV%\logs" rd /s /q "%SRV%\logs" >nul 2>&1
if exist "%CLIENTDIR%\logs" (
  for %%X in ("%CLIENTDIR%\logs\*") do del /f "%%X" >nul 2>&1
)
if exist "%~dp0log" (
  for %%X in ("%~dp0log\*") do del /f "%%X" >nul 2>&1
)
for /r "%KOK%" %%X in (*.log) do ( del /f "%%X" >nul 2>&1 )

echo == yedek/gecici dizinler ==
for /d /r "%KOK%" %%D in (_yedek) do ( rd /s /q "%%D" >nul 2>&1 )
for /d /r "%KOK%" %%D in (.pre_qc) do ( rd /s /q "%%D" >nul 2>&1 )
for /d /r "%KOK%" %%D in (__pycache__) do ( rd /s /q "%%D" >nul 2>&1 )

echo == editor artiklari ==
for /r "%KOK%" %%X in (*.bak *.orig *.tmp *~ *.py~ Thumbs.db desktop.ini) do (
  del /f "%%X" >nul 2>&1
)

echo.
echo [OK] temizlik bitti
exit /b 0
