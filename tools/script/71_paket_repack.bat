@echo off
title work1 - paket repack
call "%~dp0_ayar.bat"

rem Kullanim: 71_paket_repack.bat <paket_adi>
rem Ornek:    71_paket_repack.bat root

if "%~1"=="" ( echo Kullanim: %~n0 ^<paket_adi^>  - Srcs\Pack altindaki bir klasor adi & exit /b 1 )
if not exist "%SRCSPACK%\%~1" ( echo [HATA] paket dizini yok: %SRCSPACK%\%~1 & exit /b 1 )
if not exist "%PACKDIR%\PackMakerLite.exe" ( echo [HATA] PackMakerLite.exe yok: %PACKDIR% & exit /b 1 )

rem istemci aciksa kapat (pack dosyalari kilitlidir)
rem ayni oturumdaki proses icin admin gerekmez; kapatamazsak yukselt
taskkill /IM metin2client.exe /F >nul 2>&1
tasklist /FI "IMAGENAME eq metin2client.exe" 2>nul | %SystemRoot%\System32\find.exe /I "metin2client.exe" >nul
if %errorlevel% equ 0 (
  net session >nul 2>&1
  if errorlevel 1 (
    cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
    exit /b
  )
)

cd /d "%SRCSPACK%"
"%PACKDIR%\PackMakerLite.exe" --nolog --parallel -p %~1
if errorlevel 1 ( echo [HATA] repack basarisiz & exit /b 1 )

move /y "%~1.eix" "%PACKDIR%\" >nul
move /y "%~1.epk" "%PACKDIR%\" >nul
rem artakalan varsa temizle
if exist "%~1.eix" del /f "%~1.eix" >nul 2>&1
if exist "%~1.epk" del /f "%~1.epk" >nul 2>&1
echo [OK] %~1.eix/epk -^> client\pack\

call "%~dp0_artik_kapat.bat"
