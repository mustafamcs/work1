@echo off
title work1 - wolfman/lycan temizleme
call "%~dp0_ayar.bat"

rem Wolfman/lycan kalintilarini Srcs (cpp/h), Pack (skilltable/skilldesc)
rem ve sql/ dumplarindan temizler. %1 olarak --dry verilirse sadece raporlar.

python "%~dp0wolfman_temizle.py" %*
if errorlevel 1 ( echo [HATA] wolfman temizleme basarisiz & exit /b 1 )
exit /b 0
