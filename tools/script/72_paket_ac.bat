@echo off
title work1 - paket ac (dogrulama)
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
rem Kullanim: 72_paket_ac.bat <paket_adi>
rem client\pack\<ad>.eix/epk dosyasini tools\script\unpacked\<ad>\ altina acar.

if "%~1"=="" ( echo Kullanim: %~n0 ^<paket_adi^> & exit /b 1 )
if not exist "%PACKDIR%\%~1.epk" ( echo [HATA] %PACKDIR%\%~1.epk yok & exit /b 1 )
if not exist "%PACKDIR%\%~1.eix" ( echo [HATA] %PACKDIR%\%~1.eix yok & exit /b 1 )

set "HEDEF=%~dp0unpacked\%~1"
if exist "%HEDEF%" rmdir /s /q "%HEDEF%"
mkdir "%HEDEF%" >nul 2>&1

copy /y "%PACKDIR%\%~1.eix" "%HEDEF%\" >nul
copy /y "%PACKDIR%\%~1.epk" "%HEDEF%\" >nul

cd /d "%HEDEF%"
"%PACKDIR%\PackMakerLite.exe" --nolog --parallel -u %~1
if errorlevel 1 ( echo [HATA] unpack basarisiz: %~1 & exit /b 1 )

rem acilan icerik <ad>\ altina cikar; eix/epk artakalanlarini temizle
del /f /q "%HEDEF%\%~1.eix" "%HEDEF%\%~1.epk" >nul 2>&1
echo [OK] %~1 acildi -^> %HEDEF%
exit /b 0
