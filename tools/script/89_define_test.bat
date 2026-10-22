@echo off
title work1 - define kapali derleme testi
call "%~dp0_ayar.bat"

rem Kullanim:
rem   89_define_test.bat --off      Controls.h'daki tum define'leri kapatir
rem   89_define_test.bat --restore  Controls.h'i geri yukler

python "%~dp0define_kapat_test.py" %*
if errorlevel 1 ( echo [HATA] define test araci basarisiz & exit /b 1 )
exit /b 0
