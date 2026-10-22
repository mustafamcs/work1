@echo off
rem ============================================================
rem  94_data_kur.bat - sunucu data/ dizinlerini kurar.
rem  share/data tek kopyadir; her core'a junction acilir.
rem  share/data yoksa kaynak sunucudan kopyalanir.
rem ============================================================
title work1 - data dizinleri kur
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

set "KAYNAK_DATA=C:\Works\work1-kaynak\1\2-Server\main\srv1\share\data"

if not exist "%SRV%\share\data" (
  if exist "%KAYNAK_DATA%" (
    echo [INFO] share\data yok - kaynaktan kopyalaniyor...
    xcopy "%KAYNAK_DATA%" "%SRV%\share\data\" /E /I /Q >nul
    if exist "%SRV%\share\data" ( echo [OK] share\data kopyalandi ) else ( echo [HATA] kopyalama basarisiz & exit /b 1 )
  ) else (
    echo [HATA] %SRV%\share\data yok ve kaynak bulunamadi: %KAYNAK_DATA%
    exit /b 1
  )
) else (
  echo [OK] share\data zaten var
)

rem her core dizinine data junction'i
for %%D in (auth channel1\core1 channel99) do (
  if exist "%SRV%\%%D\data" (
    echo [OK] %%D\data zaten var
  ) else (
    mklink /J "%SRV%\%%D\data" "%SRV%\share\data" >nul
    if exist "%SRV%\%%D\data" ( echo [OK] %%D\data junction olusturuldu ) else ( echo [HATA] %%D\data junction olusturulamadi )
  )
)
exit /b 0
