@echo off
title work1 - build db
call "%~dp0_ayar.bat"

rem cikti aciksa kapat
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":30000 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1

"%MSBUILD%" "%SLN%" /t:db /p:Configuration=Release /p:Platform=Win32 /m /nr:false /v:m /nologo
if errorlevel 1 ( echo [HATA] db derleme basarisiz & exit /b 1 )

copy /y "%KOK%\out\db\Release\db.exe" "%SRV%\db\db.exe" >nul
copy /y "%KOK%\out\db\Release\db.exe" "%SRV%\share\bin\db.exe" >nul
echo [OK] db derlendi -^> server\db + share\bin

call "%~dp0_artik_kapat.bat"
