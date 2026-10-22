@echo off
title work1 - olu define taramasi
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
rem Kullanim:
rem   96_define_tara.bat          tam rapor (kullanim yerleri ile)
rem   96_define_tara.bat --dead   sadece olu bayraklari listele

python "%~dp0olu_define_tara.py" %*
if errorlevel 1 ( echo [HATA] define tarama araci basarisiz & exit /b 1 )
exit /b 0
