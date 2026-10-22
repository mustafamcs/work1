@echo off
title work1 - build qc
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

rem cikti aciksa kapat
taskkill /IM qc.exe /F >nul 2>&1

"%MSBUILD%" "%SLN%" /t:qc /p:Configuration=Release /p:Platform=Win32 /m /nr:false /v:m /nologo
if errorlevel 1 ( echo [HATA] qc derleme basarisiz & exit /b 1 )

copy /y "%KOK%\out\qc\Release\qc.exe" "%QUESTDIR%\qc.exe" >nul
copy /y "%KOK%\out\qc\Release\qc.exe" "%SRV%\share\bin\qc.exe" >nul
echo [OK] qc derlendi -^> quest + share\bin

call "%~dp0_artik_kapat.bat"
