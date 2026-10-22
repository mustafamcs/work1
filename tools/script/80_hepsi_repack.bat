@echo off
title work1 - tum paketleri repack
call "%~dp0_ayar.bat"
rem Srcs\Pack altindaki tum paket dizinlerini sirayla repack eder.
rem Uzun surebilir - buyuk paketler (yw_pc, yw_zone, sound) yavas paketlenir.

if not exist "%PACKDIR%\PackMakerLite.exe" ( echo [HATA] PackMakerLite.exe yok: %PACKDIR% & exit /b 1 )

rem istemci aciksa kapat (pack dosyalari kilitlidir)
taskkill /IM metin2client.exe /F >nul 2>&1

set /a OK=0 & set /a ERR=0
for /d %%P in ("%SRCSPACK%\*") do (
  echo.
  echo === repack: %%~nxP ===
  call "%~dp071_paket_repack.bat" "%%~nxP"
  if errorlevel 1 ( set /a ERR+=1 ) else ( set /a OK+=1 )
)
echo.
echo [BITTI] repack: %OK% ok, %ERR% hata
if %ERR% gtr 0 exit /b 1
call "%~dp0_artik_kapat.bat"
exit /b 0
