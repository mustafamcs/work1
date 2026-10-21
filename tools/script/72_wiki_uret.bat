@echo off
title work1 - wiki uret
call "%~dp0_ayar.bat"

if not exist "%KOK%\tools\wiki-uret\uret.py" ( echo [HATA] uret.py yok & exit /b 1 )
where python >nul 2>&1 && ( python "%KOK%\tools\wiki-uret\uret.py" & goto son )
where py >nul 2>&1 && ( py -3 "%KOK%\tools\wiki-uret\uret.py" & goto son )
echo [HATA] python bulunamadi & exit /b 1
:son
if errorlevel 1 ( echo [HATA] wiki uretimi basarisiz & exit /b 1 )
echo [OK] wiki uretildi
