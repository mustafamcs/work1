@echo off
title work1 - gitignore ile yoksayilanlar
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
rem Git'in yoksaydigi dosyalari listeler - derleme ciktisi, log,
rem calisma-ani dosyalari burada gorunmeli.
cd /d "%KOK%"

git status --ignored --short | findstr "^!!"
echo.
exit /b 0
