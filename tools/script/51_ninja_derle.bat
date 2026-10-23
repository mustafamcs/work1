@echo off
title work1 - ninja derleme (server+client paralel, sccache'li)
call "%~dp0_ayar.bat"
net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
call "%~dp0_ninja_ic.bat" %*
exit /b %errorlevel%
