@echo off
title work1 - butunluk dogrulama
call "%~dp0_ayar.bat"

rem sadece okuma/port kontrolu yaptigi icin admin gerektirmez
setlocal enabledelayedexpansion
set /a ERR=0

echo == binary kontrolu ==
for %%F in (
  "%SRV%\db\db.exe"
  "%SRV%\auth\game.exe"
  "%SRV%\channel1\core1\game.exe"
  "%SRV%\channel99\game.exe"
  "%SRV%\share\bin\db.exe"
  "%SRV%\share\bin\game.exe"
  "%QUESTDIR%\qc.exe"
  "%CLIENTDIR%\metin2client.exe"
  "%PACKDIR%\PackMakerLite.exe"
) do (
  if exist "%%~F" ( echo   [OK] %%~F ) else ( echo   [EKSIK] %%~F & set /a ERR+=1 )
)

echo.
echo == aktif profil / MAP_ALLOW uyumu ==
if not exist "%KOK%\active_profile" ( echo   [EKSIK] active_profile & set /a ERR+=1 & goto dil )
set /p PROF=<"%KOK%\active_profile"
echo   aktif profil: %PROF%

if "%PROF%"=="99" (
  set "EK_CORE=" & set "EK_99="
) else if "%PROF%"=="105" (
  set "EK_CORE=217 301 302 303 304" & set "EK_99=216 351 352 364 367"
) else if "%PROF%"=="120" (
  set "EK_CORE=217 301 302 303 304" & set "EK_99=216 351 352 364 367 210 212 355 356 358"
) else (
  echo   [HATA] bilinmeyen profil: %PROF & set /a ERR+=1
)
for %%M in (!EK_CORE!) do (
  findstr /r /c:"MAP_ALLOW:.*\>%%M\>" "%SRV%\channel1\core1\CONFIG" >nul || ( echo   [HATA] core1 MAP_ALLOW icinde %%M yok & set /a ERR+=1 )
)
for %%M in (!EK_99!) do (
  findstr /r /c:"MAP_ALLOW:.*\>%%M\>" "%SRV%\channel99\CONFIG" >nul || ( echo   [HATA] ch99 MAP_ALLOW icinde %%M yok & set /a ERR+=1 )
)
if !ERR!==0 echo   MAP_ALLOW harita listeleri profil ile uyumlu

:dil
echo.
echo == dil dizinleri (sadece en/tr/common olmali) ==
for /d %%P in ("%SRCSPACK%\*") do (
  if exist "%%P\locale" (
    for /d %%L in ("%%P\locale\*") do call :dilchk "%%L" "%%~nxP"
    if exist "%%P\locale\locale" (
      for /d %%L in ("%%P\locale\locale\*") do call :dilchk "%%L" "%%~nxP"
    )
  )
)
goto port

:dilchk
set "AD=%~nx1"
if /i "%AD%"=="en" exit /b 0
if /i "%AD%"=="tr" exit /b 0
if /i "%AD%"=="common" exit /b 0
echo   [HATA] yabanci dil dizini: %~2\... \%AD%  --  81_dil_temizle.bat calistir
set /a ERR+=1
exit /b 0

:port
echo.
echo == port durumu ==
call "%~dp033_durum.bat"

echo.
if %ERR%==0 ( echo [SONUC] dogrulama temiz ) else ( echo [SONUC] %ERR% sorun bulundu )
exit /b %ERR%
