@echo off
title work1 - git durum
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
cd /d "%KOK%"

echo == calisma agaci ==
git status --short
echo.
echo == son commitler ==
git log --oneline -5
echo.
echo == uzak ile fark ==
git fetch origin >nul 2>&1
git status --branch --porcelain=v2 2>nul | findstr /c:"branch.ab"
echo.
exit /b 0
