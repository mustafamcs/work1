@echo off
title work1 - build hepsi
call "%~dp0_ayar.bat"

rem cikti aciksa kapat (db + auth + core1 + ch99 + qc)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":30000 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":30001 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":30003 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":30901 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1
taskkill /IM qc.exe /F >nul 2>&1

"%MSBUILD%" "%SLN%" /t:db;game;qc /p:Configuration=Release /p:Platform=Win32 /m /nr:false /v:m /nologo
if errorlevel 1 ( echo [HATA] derleme basarisiz & exit /b 1 )

copy /y "%KOK%\out\db\Release\db.exe"     "%SRV%\db\db.exe" >nul
copy /y "%KOK%\out\db\Release\db.exe"     "%SRV%\share\bin\db.exe" >nul
copy /y "%KOK%\out\game\Release\game.exe" "%SRV%\auth\game.exe" >nul
copy /y "%KOK%\out\game\Release\game.exe" "%SRV%\channel1\core1\game.exe" >nul
copy /y "%KOK%\out\game\Release\game.exe" "%SRV%\channel99\game.exe" >nul
copy /y "%KOK%\out\game\Release\game.exe" "%SRV%\share\bin\game.exe" >nul
copy /y "%KOK%\out\qc\Release\qc.exe"     "%QUESTDIR%\qc.exe" >nul
copy /y "%KOK%\out\qc\Release\qc.exe"     "%SRV%\share\bin\qc.exe" >nul
echo [OK] db + game + qc derlendi ve dagitildi

call "%~dp0_artik_kapat.bat"
