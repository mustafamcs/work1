@echo off
title work1 - build client
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

rem istemci aciksa kapat
taskkill /IM metin2client.exe /F >nul 2>&1

if not exist "%KOK%\Srcs\Client\UserInterface.vcxproj" ( echo [HATA] istemci projesi yok & exit /b 1 )
"%MSBUILD%" "%KOK%\Srcs\Client\UserInterface.vcxproj" /p:Configuration=Release /p:Platform=Win32 /m /nr:false /v:m /nologo
if errorlevel 1 ( echo [HATA] istemci derleme basarisiz & exit /b 1 )

rem vcxproj post-build adimi zaten client\ altina kopyalar; yine de garanti olsun
if exist "%KOK%\out\client\UserInterface\Release\bin\metin2client.exe" copy /y "%KOK%\out\client\UserInterface\Release\bin\metin2client.exe" "%CLIENTDIR%\metin2client.exe" >nul
echo [OK] istemci derlendi -^> client\metin2client.exe

call "%~dp0_artik_kapat.bat"
