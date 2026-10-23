@echo off
title work1 - cryptlib rebuild
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
rem Srcs\Extern\cryptopp kaynagindan cryptlib.lib uretir ve Extern\lib\cryptlib-Release.lib'e kopyalar.
rem Onemsiz: hazir lib bozuktu (DH2 Prepare crash) - bu script ile kaynaktan derlenir.

set "CRDIR=%KOK%\Srcs\Extern\cryptopp"
if not exist "%CRDIR%\cryptest.nmake" ( echo [HATA] cryptopp kaynagi yok & exit /b 1 )

call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars32.bat" >nul
pushd "%CRDIR%"
nmake /f cryptest.nmake cryptlib.lib
if errorlevel 1 ( popd & echo [HATA] nmake basarisiz & exit /b 1 )
popd

copy /y "%CRDIR%\cryptlib.lib" "%KOK%\Srcs\Extern\lib\cryptlib-Release.lib" >nul
echo [OK] cryptlib-Release.lib kaynaktan uretildi
exit /b 0
