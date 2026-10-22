@echo off
title work1 - dil temizle (sadece tr + en)
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
rem Srcs\Pack altindaki locale dizinlerinde tr/en/common disindaki
rem dil klasorlerini siler, sonra degisen paketleri repack eder.

set "DEGISEN=%TEMP%\work1_dil_%RANDOM%.txt"
if exist "%DEGISEN%" del /f "%DEGISEN%"

for /d %%P in ("%SRCSPACK%\*") do (
  if exist "%%P\locale" (
    for /d %%L in ("%%P\locale\*") do call :kontrol "%%L" "%%~nxP"
    if exist "%%P\locale\locale" (
      for /d %%L in ("%%P\locale\locale\*") do call :kontrol "%%L" "%%~nxP"
    )
  )
)
goto rapor

:kontrol
set "AD=%~nx1"
if /i "%AD%"=="en" exit /b 0
if /i "%AD%"=="tr" exit /b 0
if /i "%AD%"=="common" exit /b 0
echo [SIL] %~1
rd /s /q "%~1"
echo %~2>> "%DEGISEN%"
exit /b 0

:rapor
if not exist "%DEGISEN%" ( echo [OK] temiz - silinecek dil dizini yok & exit /b 0 )

echo.
echo === degisen paketler repack ediliyor ===
sort "%DEGISEN%" /o "%DEGISEN%"
set "SON="
for /f %%N in (%DEGISEN%) do (
  if /i not "%%N"=="%SON%" (
    set "SON=%%N"
    call "%~dp071_paket_repack.bat" "%%N"
  )
)
del /f "%DEGISEN%" >nul 2>&1
echo.
echo [OK] dil temizligi + repack bitti
call "%~dp0_artik_kapat.bat"
exit /b 0
